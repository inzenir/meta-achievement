TomTomWaypoint = setmetatable({}, { __index = TomTomWaypoint})
TomTomWaypoint.__index = TomTomWaypoint

function TomTomWaypoint:new(mapId, x, y, title)
    local obj = setmetatable({}, TomTomWaypoint)

    obj.mapId = mapId
    obj.x = x
    obj.y = y
    obj.options = {
        title = title,
        persistent = false,
        from = MetaAchievementTitle
    }

    return obj
end

function TomTomWaypoint:createFromWaypoint(waypoint)
    -- Support kind/coordinates format from waypoints files: { kind = "point", coordinates = { { mapId, x, y, title } } }
    local pt = waypoint
    if waypoint.kind == "point" and waypoint.coordinates and waypoint.coordinates[1] then
        pt = waypoint.coordinates[1]
    end
    local title = (pt.title or "") .. (pt.note and (" - " .. pt.note) or "")
    if title == "" then title = "Waypoint" end
    return TomTomWaypoint:new(
        pt.mapId,
        pt.x / 100,
        pt.y / 100,
        title
    )
end

function TomTomWaypoint:createFromTomTomWaypoint(tomtomWaypoint)
    return TomTomWaypoint:new(
        tomtomWaypoint[1],
        tomtomWaypoint[2],
        tomtomWaypoint[3],
        tomtomWaypoint.title
    )
end

function TomTomWaypoint:toArgs()
    return self.mapId, self.x, self.y, self.options
end
