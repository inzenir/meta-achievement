-- AchievementData: registry of waypoints data keyed by top achievement (group).
-- Use RegisterWaypoints(topAchievementId, waypointsTable) to register a waypoints
-- file for a group; look up via the registry table.

AchievementData = AchievementData or {}
AchievementData.__index = AchievementData

--- Registry: topAchievementId -> waypoints flat data (achievementId -> { helpText, waypoints, criteria?, virtualCriteria?, combineVirtualAndRegularCriteria?, requirementsBodyOverrideElement? })
--- combineVirtualAndRegularCriteria: optional boolean on the achievement entry OR on the virtualCriteria table; when true, requirements list shows regular WoW API criteria first and appends virtual rows after. Only one placement needed.
AchievementData._registry = AchievementData._registry or {}

--- Register a waypoints table for a group.
--- @param topAchievementId number Top achievement ID of the selected group (e.g. from dropdown).
--- @param waypointsData table Flat data: [achievementId] = { helpText?, waypoints?, criteria?, requirementsBodyOverrideElement? }
function AchievementData:RegisterDataSource(topAchievementId, waypointsData)
    if not topAchievementId or type(waypointsData) ~= "table" then
        return
    end
    self._registry[topAchievementId] = waypointsData
end

--- Get the waypoints/help entry for an achievement from the registered flat table.
--- @param topAchievementId number Top achievement of the group (from dropdown).
--- @param achievementId number The achievement whose info to look up.
--- @return table|nil { helpText?, waypoints?, criteria?, virtualCriteria?, combineVirtualAndRegularCriteria? } or nil if not registered.
function AchievementData:GetInformation(topAchievementId, achievementId)
    if not topAchievementId or not achievementId then
        return nil
    end
    local groupData = self._registry[topAchievementId]
    if type(groupData) ~= "table" then
        return nil
    end
    return groupData[achievementId]
end

--- Iterate every registered top group and each flat achievement entry (waypoints file row).
--- callback(topAchievementId, achievementId, flatEntry). Skip non-table entries (e.g. stray keys).
--- Used for cross-meta scans (delve story notifications, audits) without hardcoding a single waypoints table.
function AchievementData:ForEachRegisteredAchievementEntry(callback)
    if type(callback) ~= "function" then
        return
    end
    for topAchievementId, groupData in pairs(self._registry) do
        if type(topAchievementId) == "number" and type(groupData) == "table" then
            for achievementId, flatEntry in pairs(groupData) do
                if type(achievementId) == "number" and type(flatEntry) == "table" then
                    callback(topAchievementId, achievementId, flatEntry)
                end
            end
        end
    end
end

--- First registered top achievement id whose waypoints table contains this child (for chat lines, WQ scans).
--- @return number|nil
function AchievementData:FindTopAchievementIdForChild(achievementId)
    if type(achievementId) ~= "number" then
        return nil
    end
    for topAchievementId, groupData in pairs(self._registry) do
        if type(topAchievementId) == "number" and type(groupData) == "table" and groupData[achievementId] ~= nil then
            return topAchievementId
        end
    end
    return nil
end
