-- Waypoints and help text for "What a Long, Strange Trip It's Been" achievements
-- Structure: Keyed by achievement ID, with optional criteria-level data
-- Top achievement: 2144. Data is split by event in achi-list\WhatALongStrangeTripItsBeen\
-- This file merges all split waypoint tables.

local function mergeWaypoints(target, source)
    if type(source) ~= "table" then return end
    for k, v in pairs(source) do
        target[k] = v
    end
end

WhatALongStrangeTripItsBeenWaypoints = {}

mergeWaypoints(WhatALongStrangeTripItsBeenWaypoints, WhatALongStrangeTripItsBeen_ToHonorOnesEldersWaypoints)
mergeWaypoints(WhatALongStrangeTripItsBeenWaypoints, WhatALongStrangeTripItsBeen_TheFlameKeeperWaypoints)
mergeWaypoints(WhatALongStrangeTripItsBeenWaypoints, WhatALongStrangeTripItsBeen_MerrymakerWaypoints)
mergeWaypoints(WhatALongStrangeTripItsBeenWaypoints, WhatALongStrangeTripItsBeen_HallowedBeThyNameWaypoints)
mergeWaypoints(WhatALongStrangeTripItsBeenWaypoints, WhatALongStrangeTripItsBeen_FoolForLoveWaypoints)
mergeWaypoints(WhatALongStrangeTripItsBeenWaypoints, WhatALongStrangeTripItsBeen_NobleGardenerWaypoints)
mergeWaypoints(WhatALongStrangeTripItsBeenWaypoints, WhatALongStrangeTripItsBeen_ForTheChildrenWaypoints)
mergeWaypoints(WhatALongStrangeTripItsBeenWaypoints, WhatALongStrangeTripItsBeen_BrewmasterWaypoints)
