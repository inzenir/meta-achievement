
MapIntegrationBase = {}
MapIntegrationBase.__index = MapIntegrationBase
MapIntegrationBase._registrationCallbacks = {}
MapIntegrationBase._map_integration_instance = nil
MapIntegrationBase._default_integration = "native"
--- Staggered deferred prune+notify scheduled from PLAYER_ENTERING_WORLD (see Init).
MapIntegrationBase._deferredPruneNotifyScheduled = false
--- Seconds after first PEW: `GetAchievementCriteriaInfo` often lags the journal for many seconds after /reload.
local DEFERRED_PRUNE_DELAYS_SEC = { 1.5, 4, 8, 15, 30 }

--- True if a and b denote the same criterion id (handles string vs number from SavedVariables vs API).
local function achievementCriteriaIdsMatch(a, b)
    if a == nil or b == nil then
        return false
    end
    if a == b then
        return true
    end
    local na, nb = tonumber(a), tonumber(b)
    if na ~= nil and nb ~= nil and na == nb then
        return true
    end
    return false
end

--- Shared with map-detail UI: whether a criterion row is completed (matches API index or criteriaID).
function MetaAchievementMapCriterionIsCompleted(achievementId, criteriaId)
    if not achievementId or not criteriaId then
        return false
    end
    if type(GetAchievementNumCriteria) ~= "function" or type(GetAchievementCriteriaInfo) ~= "function" then
        return false
    end
    local num = GetAchievementNumCriteria(achievementId) or 0
    for i = 1, num do
        local _, _, completed, _, _, _, _, _, _, cid = GetAchievementCriteriaInfo(achievementId, i)
        if achievementCriteriaIdsMatch(cid, criteriaId) or achievementCriteriaIdsMatch(i, criteriaId) then
            return completed == true
        end
    end
    return false
end

--- Stored waypoints may include `criteriaType` (e.g. virtual quest criteria); otherwise use API criteria lookup only.
function MetaAchievementIsWaypointCriterionCompleted(achievementId, wp)
    if not achievementId or not wp or type(wp) ~= "table" then
        return false
    end
    local critId = wp.criteriaId
    if not critId then
        return false
    end
    if type(wp.criteriaType) == "number" and type(IsAchievementCriteriaCompleted) == "function" then
        local viaType = IsAchievementCriteriaCompleted(achievementId, critId, wp.criteriaType)
        if viaType ~= nil then
            return viaType == true
        end
    end
    if type(MetaAchievementMapCriterionIsCompleted) == "function" then
        return MetaAchievementMapCriterionIsCompleted(achievementId, critId)
    end
    return false
end

--- When removeCompletedWaypoints is enabled, omit completed achievements and (for tagged pins) completed criteria.
--- Criteria-tagged waypoint tables must set `criteriaId` (set when adding pins from criteria in map-detail).
local function filterWaypointsByCompletionForDisplay(waypointsByAchievement)
    if not waypointsByAchievement or type(waypointsByAchievement) ~= "table" then
        return waypointsByAchievement
    end
    if not MetaAchievementSettings or not MetaAchievementSettings:Get("removeCompletedWaypoints") then
        return waypointsByAchievement
    end
    if not GetAchievementInfo then
        return waypointsByAchievement
    end
    local out = {}
    for achId, wps in pairs(waypointsByAchievement) do
        local id = tonumber(achId) or achId
        local ok, _, _, _, achCompleted = pcall(GetAchievementInfo, id)
        if not ok then
            out[id] = wps
        elseif achCompleted then
            -- whole achievement done: omit all pins for this id
        elseif type(wps) ~= "table" then
            out[id] = wps
        else
            local filtered = {}
            for _, wp in ipairs(wps) do
                local critId = type(wp) == "table" and wp.criteriaId
                if critId then
                    if not MetaAchievementIsWaypointCriterionCompleted(id, wp) then
                        filtered[#filtered + 1] = wp
                    end
                else
                    -- Achievement-level waypoints (no criteria tag): show until meta is complete
                    filtered[#filtered + 1] = wp
                end
            end
            if #filtered > 0 then
                out[id] = filtered
            end
        end
    end
    return out
end

function MapIntegrationBase:new()
    local obj = setmetatable({}, self)

    obj.integrations = {}
    obj.previousIntegration = nil
    obj.activeIntegration = MetaAchievementSettings and MetaAchievementSettings:Get("waypointIntegration") or nil

    obj:SetActiveIntegration(obj.activeIntegration)

    return obj
end


-- changing integrations
function MapIntegrationBase:SetActiveIntegration(name)
    if name == self.activeIntegration then return end
    
    self.previousIntegration = self.activeIntegration
    if self.integrations[self.previousIntegration] then
        self.integrations[self.previousIntegration].integration:UpdateWaypoints({})
    end

    self.activeIntegration = name
    self:NotifyWaypointsUpdate()
end

function MapIntegrationBase:GetActiveIntegration()
    local defaultName = MapIntegrationBase._default_integration
    local defaultEntry = self.integrations and self.integrations[defaultName]
    local returnIntegration = defaultEntry and defaultEntry.integration

    if self.activeIntegration and self.integrations[self.activeIntegration] then
        local entry = self.integrations[self.activeIntegration]
        return entry.integration or returnIntegration
    end
    return returnIntegration
end

-- notifying waypoints update

function MapIntegrationBase:NotifyWaypointsUpdate(clearWaypoints)
    if not MapIntegrationBase._map_integration_instance then return end

    clearWaypoints = clearWaypoints or false

    local passWaypoints = {}
    if not clearWaypoints then
        passWaypoints = MapIntegrationBase._map_integration_instance:GetWaypoints()
        passWaypoints = filterWaypointsByCompletionForDisplay(passWaypoints)
    end

    local activeIntegration = self:GetActiveIntegration()
    if activeIntegration and activeIntegration.UpdateWaypoints then
        activeIntegration:UpdateWaypoints(passWaypoints)
    end
end

-- basic waypoints operations

function MapIntegrationBase.ToggleWaypointsForAchievement(id, waypoints)
    if not MapIntegrationBase._map_integration_instance then return end
    MapIntegrationBase._map_integration_instance:ToggleWaypointsForAchievement(id, waypoints)
end

function MapIntegrationBase.AddWaypointsForAchievement(id, waypoints)
    if not MapIntegrationBase._map_integration_instance then return end
    MapIntegrationBase._map_integration_instance:AddWaypointsForAchievement(id, waypoints)
end

function MapIntegrationBase.RemoveWaypointsForAchievement(id, waypoints)
    if not MapIntegrationBase._map_integration_instance then return end
    MapIntegrationBase._map_integration_instance:RemoveWaypointsForAchievement(id, waypoints)
end

function MapIntegrationBase.RemoveAllWaypoints()
    if not MapIntegrationBase._map_integration_instance then return end
    MapIntegrationBase._map_integration_instance:RemoveAllWaypoints()
end

--- Request integration registration. Callback(mi) will be invoked on PLAYER_ENTERING_WORLD; callback then does proper registration (RegisterMapIntegration, SetActiveIntegration, etc.).
function MapIntegrationBase.RequestIntegration(callback)
    if type(callback) == "function" then
        MapIntegrationBase._registrationCallbacks[#MapIntegrationBase._registrationCallbacks + 1] = callback
    end
end


--- Run registration callbacks so integrations are registered (e.g. for options panel dropdown). Safe to call multiple times.
function MapIntegrationBase.RunRegistrationCallbacks(instance)
    if #MapIntegrationBase._registrationCallbacks == 0 then return end

    local mi = instance or MapIntegrationBase._instance
    if not mi then return end
    for i, cb in ipairs(MapIntegrationBase._registrationCallbacks) do
        pcall(cb, mi)
    end
    MapIntegrationBase._registrationCallbacks = {}

    
end

--- Initialize map integration singleton. Run registration callbacks so integrations (Native, TomTom) are available for the options panel; re-run on PLAYER_ENTERING_WORLD for late loaders.
function MapIntegrationBase.Init()
    local self = MapIntegrationBase:new()
    MapIntegrationBase._instance = self
    MapIntegrationBase._map_integration_instance = MapIntegration:new(self)

    local function runRegistrations()
        MapIntegrationBase.RunRegistrationCallbacks(MapIntegrationBase._instance)
    end

    if MetaAchievementSettings and MetaAchievementSettings.RegisterListener then
        MetaAchievementSettings:RegisterListener("waypointIntegration", function(_, newValue, oldValue)
            if newValue and newValue ~= "_no_integrations_" then
                MapIntegrationBase.GetInstance():SetActiveIntegration(newValue)
            end
        end)
        MetaAchievementSettings:RegisterListener("removeCompletedWaypoints", function(_, newValue)
            local mi = MapIntegrationBase._map_integration_instance
            if not mi then
                return
            end
            if newValue then
                if type(mi.PruneAllCompletedWaypointsFromStorage) == "function" then
                    mi:PruneAllCompletedWaypointsFromStorage()
                end
            else
                MapIntegrationBase.GetInstance():NotifyWaypointsUpdate()
            end
        end)
        -- Clear saved TomTom uids when user turns off preserveWaypoints (see `tomtom.lua`).
        MetaAchievementSettings:RegisterListener("preserveWaypoints", function(_, newValue)
            if newValue then
                return
            end
            local db = MetaAchievementSettings:Get("mapIntegration") or {}
            db.tomTomWaypointHandles = nil
            MetaAchievementSettings:Set("mapIntegration", db)
        end)
    end

    -- Run once now so integrations register even if PLAYER_ENTERING_WORLD already fired before we loaded.
    runRegistrations()

    local frame = CreateFrame("Frame")
    frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    frame:SetScript("OnEvent", function()
        runRegistrations()
        local mib = MapIntegrationBase.GetInstance()
        if mib and type(mib.OnLoaded) == "function" then
            mib:OnLoaded()
        end
        -- Achievement/criteria APIs can lag the journal for a long time after /reload; single short timer is not enough.
        if not MapIntegrationBase._deferredPruneNotifyScheduled then
            MapIntegrationBase._deferredPruneNotifyScheduled = true
            for _, delay in ipairs(DEFERRED_PRUNE_DELAYS_SEC) do
                C_Timer.After(delay, function()
                    local inst = MapIntegrationBase.GetInstance()
                    if inst and type(inst.PruneCompletedWaypointsAndNotify) == "function" then
                        inst:PruneCompletedWaypointsAndNotify()
                    end
                end)
            end
        end
    end)
end

function MapIntegrationBase:GetIntegrationIfActive(integration)
    if integration == self.activeIntegration then
        local entry = self.integrations[integration]
        return entry and entry.integration or nil
    end
    return nil
end

--- Re-scan persisted waypoint DB (`waypointsByAchievement` keys = achievement ids), prune completed rows, then push to TomTom/native.
--- Reused by OnLoaded, CRITERIA_UPDATE coalesce, and deferred post-login run.
function MapIntegrationBase:PruneCompletedWaypointsAndNotify()
    local mi = MapIntegrationBase._map_integration_instance
    if mi and type(mi.ResyncPersistedWaypointsAgainstCompletionApi) == "function" then
        mi:ResyncPersistedWaypointsAgainstCompletionApi()
    elseif mi and type(mi.PruneAllCompletedWaypointsFromStorage) == "function" then
        mi:PruneAllCompletedWaypointsFromStorage()
    end
    local inst = MapIntegrationBase.GetInstance()
    if inst and type(inst.NotifyWaypointsUpdate) == "function" then
        inst:NotifyWaypointsUpdate()
    end
end

function MapIntegrationBase:OnLoaded()
    local name = self:GetWaypointIntegrationName()
    local entry = name and self.integrations and self.integrations[name]
    if entry and entry.integration then
        entry.integration:OnLoaded()
    end
    -- Persisted pins are already in waypointsByAchievement; prune + NotifyWaypointsUpdate refreshes TomTom/native.
    self:PruneCompletedWaypointsAndNotify()
end

function MapIntegrationBase:RegisterMapIntegration(name, label, integration)
    local wasAlreadyRegistered = self.integrations[name] ~= nil
    self.integrations[name] = {
        label = label,
        integration = integration,
    }
    -- Only notify when adding a NEW integration. getOptions() calls RunRegistrationCallbacks every time the dropdown refreshes, so Native/TomTom re-register every time; notifying each time caused an infinite refresh loop.
    if not wasAlreadyRegistered and Settings and Settings.NotifyUpdate then
        C_Timer.After(0, function()
            Settings.NotifyUpdate("waypointIntegration")
            Settings.NotifyUpdate("MetaAchievement_waypointIntegration")
        end)
    end
end


function MapIntegrationBase:GetIntegrationList()
    local list = {}
    local integrations = self.integrations
    if not integrations then return list end
    for name, integration in pairs(integrations) do
        list[#list+1] = {
            name = name,
            label = integration.label,
        }
    end
    return list
end


function MapIntegrationBase:HasActiveIntegration()
    return self.activeIntegration ~= nil
end

--- Integration to use for waypoint operations: follows waypointIntegration setting if set and registered, else activeIntegration.
function MapIntegrationBase:GetWaypointIntegrationName()
    local fromSettings = MetaAchievementSettings and MetaAchievementSettings:Get("waypointIntegration")
    if fromSettings and self.integrations and self.integrations[fromSettings] then
        return fromSettings
    end
    return self.activeIntegration
end

function MapIntegrationBase.GetInstance()
    return MapIntegrationBase._instance
end

--- Called from entrypoint on ACHIEVEMENT_EARNED: drop stored pins for that achievement when option is on.
function MapIntegrationBase.NotifyAchievementEarned(achievementId)
    local mi = MapIntegrationBase._map_integration_instance
    if not mi or type(mi.RemoveStoredWaypointsForEarnedAchievement) ~= "function" then
        return
    end
    mi:RemoveStoredWaypointsForEarnedAchievement(achievementId)
end

--- Exposed for unit tests: same filter as map sync (completed achievement ids removed when setting is on).
function MetaAchievementFilterWaypointsByCompletionForDisplay(waypointsByAchievement)
    return filterWaypointsByCompletionForDisplay(waypointsByAchievement)
end