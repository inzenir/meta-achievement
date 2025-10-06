Waypoint = {}
Waypoint.__index = Waypoint

function Waypoint:new(waypointData)
    local obj = setmetatable({}, Waypoint)

    obj.mapId = waypointData.mapId
    obj.x = waypointData.x
    obj.y = waypointData.y
    obj.title = waypointData.title
    obj.note = waypointData.note or obj.title

    return obj
end
