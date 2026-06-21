--[[
  Seasonal world event notifications: scan AchievementData for worldEvent { eventId },
  compare against active calendar holidays, notify when the festival is running and the
  linked achievement is still incomplete for the player.
]]

local ACHIEVEMENT_FACTION_BY_ID = {
    [1038] = "Alliance",
    [1039] = "Horde",
}

local function registerFactionRequirements(nodes, inheritedFaction)
    for _, node in ipairs(nodes or {}) do
        local req = node.requires or node.requirements
        local nodeFaction = req and req.faction
        local effectiveFaction = nodeFaction or inheritedFaction
        if effectiveFaction then
            ACHIEVEMENT_FACTION_BY_ID[node.id] = effectiveFaction
        end
        registerFactionRequirements(node.children, effectiveFaction)
    end
end

if type(WhatALongStrangeTripItsBeenAchievements) == "table" then
    registerFactionRequirements(WhatALongStrangeTripItsBeenAchievements)
end

local function normalizeWorldEvent(source)
    if type(source) ~= "table" then
        return nil
    end
    local we = source.worldEvent
    if type(we) ~= "table" then
        return nil
    end
    local eventId = we.eventId
    if type(eventId) ~= "number" then
        return nil
    end
    local name = we.name
    if type(name) ~= "string" or name == "" then
        if MetaAchievementWorldEventCalendar and MetaAchievementWorldEventCalendar.KNOWN_HOLIDAYS then
            name = MetaAchievementWorldEventCalendar.KNOWN_HOLIDAYS[eventId]
        end
    end
    return eventId, name, we.faction
end

local function resolveNotificationFaction(achievementId, worldEventFaction)
    if type(worldEventFaction) == "string" then
        return worldEventFaction
    end
    return ACHIEVEMENT_FACTION_BY_ID[achievementId]
end

local function isFactionAllowedForPlayer(requiredFaction)
    if type(requiredFaction) ~= "string" then
        return true
    end
    local playerFaction = UnitFactionGroup("player")
    return playerFaction == requiredFaction
end

local function isAchievementIncomplete(achievementId)
    if MetaAchievementQuestRegistry and type(MetaAchievementQuestRegistry.IsAchievementIncompleteForPlayer) == "function" then
        return MetaAchievementQuestRegistry.IsAchievementIncompleteForPlayer(achievementId)
    end
    if type(achievementId) ~= "number" or type(GetAchievementInfo) ~= "function" then
        return false
    end
    local ok, _, _, _, completed = pcall(GetAchievementInfo, achievementId)
    return ok and completed ~= true
end

local function buildActiveHolidayById()
    local byId = {}
    if not MetaAchievementWorldEventCalendar or type(MetaAchievementWorldEventCalendar.GetActiveHolidays) ~= "function" then
        return byId
    end
    local active = MetaAchievementWorldEventCalendar.GetActiveHolidays()
    for i = 1, #active do
        local row = active[i]
        if type(row.eventId) == "number" then
            byId[row.eventId] = row.title or ("Holiday #" .. tostring(row.eventId))
        end
    end
    return byId
end

local function addWatchRow(watchList, topAchievementId, achievementId, eventId, eventName, criteriaId, faction)
    watchList[#watchList + 1] = {
        topAchievementId = topAchievementId,
        achievementId = achievementId,
        criteriaId = criteriaId,
        eventId = eventId,
        eventName = eventName,
        faction = faction,
    }
end

local function collectWatchRowsFromCriteriaTable(watchList, topAchievementId, achievementId, criteriaTable, criteriaIdPrefix)
    if type(criteriaTable) ~= "table" then
        return
    end
    for criteriaId, cinfo in pairs(criteriaTable) do
        if type(criteriaId) == "number" and type(cinfo) == "table" then
            local eventId, eventName, faction = normalizeWorldEvent(cinfo)
            if eventId then
                addWatchRow(
                    watchList,
                    topAchievementId,
                    achievementId,
                    eventId,
                    eventName,
                    criteriaIdPrefix or criteriaId,
                    resolveNotificationFaction(achievementId, faction)
                )
            end
        end
    end
end

function MetaAchievementWorldEventScan_TryRefresh()
    if not AchievementData or type(AchievementData.ForEachRegisteredAchievementEntry) ~= "function" then
        return
    end
    if not MetaAchievementActivityNotify or type(MetaAchievementActivityNotify.TryNotify) ~= "function" then
        return
    end
    if not MetaAchievementSettings or MetaAchievementSettings:Get("enableWorldEventNotifications") ~= true then
        return
    end

    local activeById = buildActiveHolidayById()
    if not next(activeById) then
        return
    end

    local watchList = {}
    AchievementData:ForEachRegisteredAchievementEntry(function(topAchievementId, achievementId, flatEntry)
        if type(flatEntry) ~= "table" then
            return
        end
        local eventId, eventName, faction = normalizeWorldEvent(flatEntry)
        if eventId then
            addWatchRow(
                watchList,
                topAchievementId,
                achievementId,
                eventId,
                eventName,
                0,
                resolveNotificationFaction(achievementId, faction)
            )
        end
        collectWatchRowsFromCriteriaTable(watchList, topAchievementId, achievementId, flatEntry.criteria, nil)
        collectWatchRowsFromCriteriaTable(watchList, topAchievementId, achievementId, flatEntry.virtualCriteria, nil)
    end)

    if #watchList == 0 then
        return
    end

    if type(MetaAchievementActivityNotify.BeginNotificationBurst) == "function" then
        MetaAchievementActivityNotify.BeginNotificationBurst()
    end

    for i = 1, #watchList do
        local row = watchList[i]
        local activeName = activeById[row.eventId]
        if activeName
            and isAchievementIncomplete(row.achievementId)
            and isFactionAllowedForPlayer(row.faction)
        then
            local label = row.eventName or activeName
            MetaAchievementActivityNotify.TryNotify({
                feature = "worldEvent",
                achievementId = row.achievementId,
                topAchievementId = row.topAchievementId,
                eventId = row.eventId,
                cardDescription = string.format("%s is currently active", label),
                dedupeKey = "we:"
                    .. tostring(row.topAchievementId)
                    .. ":"
                    .. tostring(row.achievementId)
                    .. ":"
                    .. tostring(row.eventId),
            })
        end
    end

    if type(MetaAchievementActivityNotify.EndNotificationBurst) == "function" then
        MetaAchievementActivityNotify.EndNotificationBurst()
    end
end
