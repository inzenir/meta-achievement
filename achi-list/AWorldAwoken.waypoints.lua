-- Waypoints and help text for A World Awoken achievements
-- Structure: Keyed by achievement ID, with optional criteria-level data
-- Note: Waypoints are structured with 'kind' (point/area) and 'coordinates' array

AWorldAwokenWaypoints = {
}

-- Merge chunked waypoint tables
local function MergeWaypoints(target, source)
    for k, v in pairs(source) do
        target[k] = v
    end
end

if AWorldAwokenWaypointsChunks then
    for _, chunk in pairs(AWorldAwokenWaypointsChunks) do
        MergeWaypoints(AWorldAwokenWaypoints, chunk)
    end
end


