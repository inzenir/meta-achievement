TomTomMap = setmetatable({}, { __index = MapIntegrationBase })
TomTomMap.__index = TomTomMap

TOMTOM_INTEGRATION_NAME = "tomtom"

function TomTomMap:new()
    local obj = setmetatable({}, self)

    -- stored waypoints that are TomTom waypoints. They are stored in the TomTom waypoints table.
    obj.storedWaypoints = {}

    return obj
end

function TomTomMap:OnLoaded()
end

function TomTomMap:OnTomTomLoaded()
end

--- Sync TomTom to the entire waypoint list. waypointsByAchievement: { [achievementId] = { waypoint1, waypoint2, ... }, ... }
function TomTomMap:UpdateWaypoints(waypointsByAchievement)
    if not waypointsByAchievement or type(waypointsByAchievement) ~= "table" then

        return
    end

    for _, wp in pairs(self.storedWaypoints) do
        TomTom:RemoveWaypoint(wp)
    end
    self.storedWaypoints = {}
    
    for _, waypoints in pairs(waypointsByAchievement) do
        if waypoints and type(waypoints) == "table" and #waypoints > 0 then
            for _, wp in pairs(waypoints) do
                self.storedWaypoints[#self.storedWaypoints + 1] = TomTom:AddWaypoint(
                    TomTomWaypoint:createFromWaypoint(wp):toArgs()
                )
            end
        end
    end
end

MapIntegrationBase.RequestIntegration(function(mi)
    if not TomTom then return end
    mi:RegisterMapIntegration(TOMTOM_INTEGRATION_NAME, "TomTom", TomTomMap:new())
end)
