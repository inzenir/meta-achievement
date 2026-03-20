--- Native WoW map integration: uses C_Map.SetUserWaypoint / ClearUserWaypoint (single waypoint, no addon).
NativeMap = setmetatable({}, { __index = MapIntegrationBase })
NativeMap.__index = NativeMap

MapIntegrationOptions = MapIntegrationOptions or {}
MapIntegrationOptions.native = "native"

NATIVE_INTEGRATION_NAME = "native"
NATIVE_INTEGRATION_LABEL = "Game map"

function NativeMap:new()
    local obj = setmetatable({}, self)
    return obj
end

function NativeMap:OnLoaded()
end

--- Extract first coordinate from a waypoint (supports kind/coordinates format).
local function waypointToCoord(wp)
    if not wp or type(wp) ~= "table" then return nil end
    if wp.kind == "point" and wp.coordinates and wp.coordinates[1] then
        local c = wp.coordinates[1]
        if type(c) == "table" and (c.mapId or c[1]) then
            local mapId = c.mapId or c[1]
            local x = (c.x or c[2] or 0) / 100
            local y = (c.y or c[3] or 0) / 100
            return mapId, x, y
        end
    end
    if wp.mapId and (wp.x or wp[2]) then
        local x = (wp.x or wp[2] or 0) / 100
        local y = (wp.y or wp[3] or 0) / 100
        return wp.mapId, x, y
    end
    return nil
end

--- Sync native map to the waypoint list. WoW only supports one user waypoint; we set the first available.
function NativeMap:UpdateWaypoints(waypointsByAchievement)
    if not C_Map or not C_Map.ClearUserWaypoint then
        return
    end

    C_Map.ClearUserWaypoint()

    if not waypointsByAchievement or type(waypointsByAchievement) ~= "table" then
        return
    end

    for _, waypoints in pairs(waypointsByAchievement) do
        if waypoints and type(waypoints) == "table" and #waypoints > 0 then
            for _, wp in ipairs(waypoints) do
                local mapId, x, y = waypointToCoord(wp)
                if mapId and x and y and C_Map.CanSetUserWaypointOnMap and C_Map.CanSetUserWaypointOnMap(mapId) then
                    local pos = CreateVector2D(x, y)
                    local point = UiMapPoint.CreateFromVector2D(mapId, pos)
                    if point and C_Map.SetUserWaypoint then
                        C_Map.SetUserWaypoint(point)
                    end
                    if C_SuperTrack and C_SuperTrack.SetSuperTrackedUserWaypoint then
                        C_SuperTrack.SetSuperTrackedUserWaypoint(true)
                    end
                    return
                end
            end
        end
    end
end

MapIntegrationBase.RequestIntegration(function(mi)
    if not C_Map or not C_Map.SetUserWaypoint then return end
    mi:RegisterMapIntegration(NATIVE_INTEGRATION_NAME, NATIVE_INTEGRATION_LABEL, NativeMap:new())
end)
