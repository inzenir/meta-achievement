--[[
  Runtime scanner + cache for active delve story variants (Retail 12.x).
  Data source: C_AreaPoiInfo delve POIs + tooltip widget text lines.
  On PLAYER_LOGIN (after a short delay), TryLoginDelveScan runs a full sweep (same map set as
  TryRefresh). Periodic TryRefresh(false) is cooldown-limited but uses the same map list so the
  cache is not replaced by a smaller scan.
]]

MetaAchievementDelveStoryAvailability = MetaAchievementDelveStoryAvailability or {}

local REFRESH_COOLDOWN_SEC = 30
local STALE_AFTER_SEC = 300

local cache = {
    lastRefresh = 0,
    lastAttempt = 0,
    mapIds = {},
    rawLines = {},
    normalizedLines = {},
    blob = "",
}

local function trim(s)
    if type(s) ~= "string" then
        return ""
    end
    return (s:match("^%s*(.-)%s*$") or "")
end

local function normalizeText(s)
    if type(s) ~= "string" then
        return ""
    end
    s = s:gsub("|c%x%x%x%x%x%x%x%x", "")
    s = s:gsub("|r", "")
    s = s:gsub("\r", "\n")
    s = s:gsub("\n+", " ")
    -- Underscores vs spaces in different sources (e.g. data vs UI).
    s = s:gsub("_", " ")
    s = s:gsub("[%p]+", " ")
    s = s:gsub("%s+", " ")
    s = trim(s):lower()
    return s
end

local function uniqueInsert(out, seen, value)
    if type(value) == "string" and value ~= "" and not seen[value] then
        seen[value] = true
        out[#out + 1] = value
    end
end

local function collectWidgetTextsBySetId(setId, out, seen)
    if type(setId) ~= "number" or setId == 0 then
        return
    end
    if not C_UIWidgetManager or type(C_UIWidgetManager.GetAllWidgetsBySetID) ~= "function" then
        return
    end
    local ok, widgets = pcall(function()
        return C_UIWidgetManager.GetAllWidgetsBySetID(setId)
    end)
    if not ok or type(widgets) ~= "table" then
        return
    end
    for _, widget in ipairs(widgets) do
        if type(widget) == "table" and type(widget.widgetID) == "number" then
            local wid = widget.widgetID
            if type(C_UIWidgetManager.GetTextWithStateWidgetVisualizationInfo) == "function" then
                local info = C_UIWidgetManager.GetTextWithStateWidgetVisualizationInfo(wid)
                if info and type(info.text) == "string" then
                    uniqueInsert(out, seen, info.text)
                end
            end
            if type(C_UIWidgetManager.GetIconAndTextWidgetVisualizationInfo) == "function" then
                local info = C_UIWidgetManager.GetIconAndTextWidgetVisualizationInfo(wid)
                if info and type(info.text) == "string" then
                    uniqueInsert(out, seen, info.text)
                end
            end
        end
    end
end

local function getCandidateMapIds()
    local out = {}
    local seen = {}
    local function addMap(mapId)
        if type(mapId) == "number" and mapId > 0 and not seen[mapId] then
            seen[mapId] = true
            out[#out + 1] = mapId
        end
    end

    if C_Map and type(C_Map.GetBestMapForUnit) == "function" then
        local mapId = C_Map.GetBestMapForUnit("player")
        addMap(mapId)
        if mapId and type(C_Map.GetMapInfo) == "function" then
            local ok, info = pcall(function()
                return C_Map.GetMapInfo(mapId)
            end)
            if ok and type(info) == "table" and type(info.parentMapID) == "number" then
                addMap(info.parentMapID)
            end
        end
    end

    local harandarRoot = (MapZones and MapZones.MIDNIGHT_ZONE_Harandar) or 2413
    addMap(harandarRoot)
    return out
end

-- BFS from Midnight zone roots so delve POIs on child/micro maps are included (parent map often has fewer pins).
local MAX_LOGIN_MAP_IDS = 500

local function getMidnightDelveRootMapIds()
    local out = {}
    local seen = {}
    local function addMap(mapId)
        if type(mapId) == "number" and mapId > 0 and not seen[mapId] then
            seen[mapId] = true
            out[#out + 1] = mapId
        end
    end
    if MapZones and type(MapZones) == "table" then
        addMap(MapZones.MIDNIGHT_ZONE_Harandar or 2413)
        addMap(MapZones.MIDNIGHT_ZONE_MidnightSilvermoon)
        addMap(MapZones.MIDNIGHT_ZONE_Eversong_Woods)
        addMap(MapZones.MIDNIGHT_ZONE_Isle_Of_QuelDanas)
        addMap(MapZones.MIDNIGHT_ZONE_Voidstorm)
        addMap(MapZones.MIDNIGHT_ZONE_ZulAman)
        addMap(MapZones.MIDNIGHT_ZONE_Slayers_Rise)
    else
        addMap(2413)
        addMap(2393)
    end
    return out
end

local function bfsExpandMapIds(seedIds, maxMaps)
    maxMaps = maxMaps or MAX_LOGIN_MAP_IDS
    if not C_Map or type(C_Map.GetMapChildrenInfo) ~= "function" or type(seedIds) ~= "table" or #seedIds == 0 then
        return seedIds
    end
    local ordered = {}
    local seen = {}
    local queue = {}
    local function enqueue(id)
        if type(id) ~= "number" or id <= 0 or seen[id] or #ordered >= maxMaps then
            return
        end
        seen[id] = true
        ordered[#ordered + 1] = id
        queue[#queue + 1] = id
    end
    for i = 1, #seedIds do
        enqueue(seedIds[i])
    end
    local qi = 1
    while qi <= #queue and #ordered < maxMaps do
        local id = queue[qi]
        qi = qi + 1
        local ok, children = pcall(function()
            return C_Map.GetMapChildrenInfo(id)
        end)
        if ok and type(children) == "table" then
            for c = 1, #children do
                if #ordered >= maxMaps then
                    break
                end
                local row = children[c]
                if type(row) == "table" and type(row.mapID) == "number" then
                    enqueue(row.mapID)
                end
            end
        end
    end
    return ordered
end

--- Full Midnight sweep: roots + BFS children + player/parent/harandar (login only — see TryLoginDelveScan).
local function getMapIdsForLoginDelveScan()
    local out = {}
    local seen = {}
    local function addMap(mapId)
        if type(mapId) == "number" and mapId > 0 and not seen[mapId] then
            seen[mapId] = true
            out[#out + 1] = mapId
        end
    end

    local expanded = bfsExpandMapIds(getMidnightDelveRootMapIds(), MAX_LOGIN_MAP_IDS)
    for i = 1, #expanded do
        addMap(expanded[i])
    end

    local base = getCandidateMapIds()
    for i = 1, #base do
        addMap(base[i])
    end

    return out
end

local function buildBlob(lines)
    if type(lines) ~= "table" or #lines == 0 then
        return ""
    end
    return "\n" .. table.concat(lines, "\n") .. "\n"
end

local function apisAvailable()
    return C_AreaPoiInfo
        and type(C_AreaPoiInfo.GetDelvesForMap) == "function"
        and type(C_AreaPoiInfo.GetAreaPOIInfo) == "function"
end

--- Scan every delve POI on `mapIds`, merge widget text into `cache` (single blob for matching).
local function runPoiScanForMaps(mapIds, now)
    if not apisAvailable() or type(mapIds) ~= "table" or #mapIds == 0 then
        return false
    end

    local rawLines = {}
    local rawSeen = {}
    local normalizedLines = {}
    local normalizedSeen = {}

    for _, mapId in ipairs(mapIds) do
        local ok, poiIds = pcall(function()
            return C_AreaPoiInfo.GetDelvesForMap(mapId)
        end)
        if ok and type(poiIds) == "table" then
            for _, poiId in ipairs(poiIds) do
                local infoOk, info = pcall(function()
                    return C_AreaPoiInfo.GetAreaPOIInfo(mapId, poiId)
                end)
                if infoOk and type(info) == "table" then
                    if type(info.name) == "string" then
                        uniqueInsert(rawLines, rawSeen, info.name)
                        local normalizedName = normalizeText(info.name)
                        uniqueInsert(normalizedLines, normalizedSeen, normalizedName)
                    end
                    collectWidgetTextsBySetId(info.tooltipWidgetSet, rawLines, rawSeen)
                end
            end
        end
    end

    for _, text in ipairs(rawLines) do
        local normalized = normalizeText(text)
        uniqueInsert(normalizedLines, normalizedSeen, normalized)
    end

    cache.lastRefresh = now
    cache.mapIds = mapIds
    cache.rawLines = rawLines
    cache.normalizedLines = normalizedLines
    cache.blob = buildBlob(normalizedLines)
    return true
end

function MetaAchievementDelveStoryAvailability.TryRefresh(force)
    local now = (GetTime and GetTime()) or 0
    if not force and cache.lastAttempt > 0 and (now - cache.lastAttempt) < REFRESH_COOLDOWN_SEC then
        return false
    end
    cache.lastAttempt = now

    if not apisAvailable() then
        return false
    end

    local mapIds = getMapIdsForLoginDelveScan()
    if #mapIds == 0 then
        return false
    end

    return runPoiScanForMaps(mapIds, now)
end

--- Full Midnight sweep (same as TryRefresh(true)); kept for PLAYER_LOGIN and docs.
function MetaAchievementDelveStoryAvailability.TryLoginDelveScan()
    return MetaAchievementDelveStoryAvailability.TryRefresh(true)
end

local function containsNormalizedTerm(term)
    local t = normalizeText(term)
    if t == "" then
        return false
    end
    if cache.blob ~= "" and cache.blob:find("\n" .. t .. "\n", 1, true) then
        return true
    end
    if cache.blob ~= "" and cache.blob:find(t, 1, true) then
        return true
    end
    return false
end

--- Localized criteria title from the client (matches achievement UI / locale).
local function getLocalizedCriteriaDisplayName(achievementId, criteriaId)
    if type(achievementId) ~= "number" or type(criteriaId) ~= "number" then
        return nil
    end
    if type(GetAchievementCriteriaInfoByID) == "function" then
        local ok, criteriaString = pcall(GetAchievementCriteriaInfoByID, achievementId, criteriaId)
        if ok and type(criteriaString) == "string" and criteriaString ~= "" then
            return criteriaString
        end
    end
    return nil
end

--- True when POI/widget scan text contains the localized name for this criteria (locale-safe).
function MetaAchievementDelveStoryAvailability.IsDelveStoryCriteriaActive(achievementId, criteriaId)
    if cache.lastRefresh <= 0 or #cache.normalizedLines == 0 then
        return false
    end
    local name = getLocalizedCriteriaDisplayName(achievementId, criteriaId)
    if not name then
        return false
    end
    return containsNormalizedTerm(name)
end

function MetaAchievementDelveStoryAvailability.GetAvailabilityStateForCriteria(achievementId, criteriaId)
    local now = (GetTime and GetTime()) or 0
    if cache.lastRefresh <= 0 then
        return "unknown", "availability unknown"
    end
    if #cache.normalizedLines == 0 then
        return "unknown", "availability unknown"
    end
    if not getLocalizedCriteriaDisplayName(achievementId, criteriaId) then
        return "unknown", "availability unknown"
    end
    local stale = (now - cache.lastRefresh) > STALE_AFTER_SEC
    if MetaAchievementDelveStoryAvailability.IsDelveStoryCriteriaActive(achievementId, criteriaId) then
        local text = "active today"
        if stale then
            text = text .. " (scan outdated)"
        end
        return "active_today", text
    end
    local text = "not active today"
    if stale then
        text = text .. " (scan outdated)"
    end
    return "not_active_today", text
end

-- Throttled forced refresh when the journal shows delve story criteria (current map POIs).
local lastMapDetailRefreshAttempt = 0
local MAP_DETAIL_REFRESH_THROTTLE_SEC = 3

function MetaAchievementDelveStoryAvailability.TryRefreshForMapDetail()
    local now = (GetTime and GetTime()) or 0
    if lastMapDetailRefreshAttempt > 0 and (now - lastMapDetailRefreshAttempt) < MAP_DETAIL_REFRESH_THROTTLE_SEC then
        return false
    end
    lastMapDetailRefreshAttempt = now
    return MetaAchievementDelveStoryAvailability.TryRefresh(true)
end

-- After login, rescan all Midnight delve surfaces so the journal matches a fresh POI+widget snapshot.
local LOGIN_DELVE_SCAN_DELAY_SEC = 3
local loginScanFrame = CreateFrame("Frame")
loginScanFrame:RegisterEvent("PLAYER_LOGIN")
loginScanFrame:SetScript("OnEvent", function(_, event)
    if event ~= "PLAYER_LOGIN" then
        return
    end
    if C_Timer and C_Timer.After then
        C_Timer.After(LOGIN_DELVE_SCAN_DELAY_SEC, function()
            if MetaAchievementDelveStoryAvailability.TryLoginDelveScan then
                MetaAchievementDelveStoryAvailability.TryLoginDelveScan()
            end
        end)
    else
        MetaAchievementDelveStoryAvailability.TryLoginDelveScan()
    end
end)
