-- AchievementData: registry of waypoints data keyed by top achievement (group).
-- Use RegisterWaypoints(topAchievementId, waypointsTable) to register a waypoints
-- file for a group; look up via the registry table.

AchievementData = AchievementData or {}
AchievementData.__index = AchievementData

--- Registry: topAchievementId -> waypoints flat data (achievementId -> { helpText, waypoints, criteria? })
AchievementData._registry = AchievementData._registry or {}

--- Register a waypoints table for a group.
--- @param topAchievementId number Top achievement ID of the selected group (e.g. from dropdown).
--- @param waypointsData table Flat data: [achievementId] = { helpText?, waypoints?, criteria? }
function AchievementData:RegisterDataSource(topAchievementId, waypointsData)
    if not topAchievementId or type(waypointsData) ~= "table" then
        return
    end
    self._registry[topAchievementId] = waypointsData
end

--- Get the waypoints/help entry for an achievement from the registered flat table.
--- @param topAchievementId number Top achievement of the group (from dropdown).
--- @param achievementId number The achievement whose info to look up.
--- @return table|nil { helpText?, waypoints?, criteria? } or nil if not registered.
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
