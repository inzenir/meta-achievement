MapIntegrationBase = {}
MapIntegrationBase.__index = MapIntegrationBase

MapIntegrationOptions = {
    tomtom = "tomtom"
}

function PrepareWaypoint(waypoint)
    return { 
        criteriaId = waypoint.criteriaId or nil,
        mapId = waypoint.mapId,
        x = waypoint.x,
        y = waypoint.x,
        title = waypoint.title,
        note = waypoint.note or ''
    }
end

function PrepareWaypoints(waypoints)
    local returnData = {}

    for _, wp in pairs(waypoints) do
        returnData[#returnData+1] = PrepareWaypoint(wp)
    end

    return returnData
end

function MapIntegrationBase:new()
    local obj = setmetatable({}, self)

    obj.integrations = {}
    obj.activeIntegration = nil

    return obj
end

function MapIntegrationBase:FilterWaypoints(achievementId, waypoints)
    waypoints = PrepareWaypoints(waypoints)

    if MetaAchievementConfigurationDB.addWaypointsOnlyForUncompletedAchievementParts then
        local achievement = Achievement:new(achievementId)

        return achievement:filterWaypoints(waypoints)
    end

    return waypoints
end

function MapIntegrationBase:RegisterMapIntegration(name, integration)
    self.integrations[name] = integration
end

function MapIntegrationBase:SetActiveIntegration(name)
    self.activeIntegration = name
end

function MapIntegrationBase:HasActiveIntegration()
    return self.activeIntegration ~= nil
end

function MapIntegrationBase:ToggleWaypointsForAchievement(id, waypoints)
    self.integrations[self.activeIntegration]:ToggleWaypointsForAchievement(id, waypoints)
end

function MapIntegrationBase:AddWaypointsForAchievement(id, waypoints)
    self.integrations[self.activeIntegration]:AddWaypointsForAchievement(id, waypoints)
end

function MapIntegrationBase:RemoveWaypointsForAchievement(id)
    self.integrations[self.activeIntegration]:RemoveWaypointsForAchievement(id)
end

function MapIntegrationBase:RemoveAllWaypoints()
    self.integrations[self.activeIntegration]:RemoveAllWaypoints()
end