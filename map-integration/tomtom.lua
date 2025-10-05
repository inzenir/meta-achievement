TomTomMap = setmetatable({}, { __index = MapIntegrationBase})
TomTomMap.__index = TomTomMap


function TomTomMap:new()
    local obj = setmetatable(MapIntegrationBase:new(), self)

    MetaAchievementConfigurationDB.mapIntegration.tomtom = MetaAchievementConfigurationDB.mapIntegration.tomtom or {}

    obj.settings = MetaAchievementConfigurationDB.mapIntegration.tomtom;

    obj.settings.waypoints = obj.settings.waypoints or {}

    return obj
end

function TomTomMap:saveMapCoordinates()
    MetaAchievementConfigurationDB.mapIntegration.tomtom = self.settings
end

function TomTomMap:ToggleWaypointsForAchievement(id, waypoints)
    if self.settings.waypoints[id] then
        self:RemoveWaypointsForAchievement(id)
    else
        self:AddWaypointsForAchievement(id, waypoints)
    end
end

function TomTomMap:AddWaypointsForAchievement(id, waypoints)
    waypoints = MapIntegrationBase:FilterWaypoints(id, waypoints)
    local waypointIds = {}

    for _, wp in pairs(waypoints) do
        waypointIds[#waypointIds+1] = TomTom:AddWaypoint(
            wp.mapId,
            wp.x / 100,
            wp.y / 100,
            {
                title = wp.title .. " - " .. (wp.note or "")
            }
        )
    end

    self.settings.waypoints[id] = waypointIds
    self:saveMapCoordinates()
end

function TomTomMap:RemoveWaypointsForAchievement(id)
    if self.settings.waypoints[id] and #self.settings.waypoints[id] > 0 then
        for i, wp in pairs(self.settings.waypoints[id]) do
            TomTom:RemoveWaypoint(wp)
        end
    end

    local tmpWaypoints = {}
    for index, item in pairs(self.settings.waypoints) do
        if index ~= id then
            tmpWaypoints[index] = item
        end
    end

    self.settings.waypoints = tmpWaypoints
    self:saveMapCoordinates()
end

function TomTomMap:RemoveAllWaypoints()
    for index, _ in pairs(self.settings.waypoints) do
        self:RemoveWaypointsForAchievement(index)
    end

    self:saveMapCoordinates()
end