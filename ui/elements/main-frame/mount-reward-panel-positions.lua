-- Position and facing for the mount 3D model in the mount-reward-panel.
-- Used by mount-reward-panel.lua. Override per mountId if a mount needs different placement.

local defaults = {
    x = -1,
    y = 0,
    z = -0.25,
    facingDegrees = 20, -- degrees; positive = turn right (clockwise from front)
}

-- Optional per-mount overrides: [mountId] = { x = ..., y = ..., z = ..., facingDegrees = ... }
-- Only list mounts that need different values; others use defaults.
-- x: depth
-- y: width
-- z: height
local perMount = {
    -- [12345] = { x = -1.2, y = 0, z = -0.3, facingDegrees = 25 },
    [1825] = { x = -4, z = -0.5 },   -- taivan
    [2114] = { x = -1, z = -0.4 },  -- zovaal's
    [2802] = { x = -1, z = -0.1 },  -- worldsoul-searching
    [267] = { x = 0.5 },  -- violet proto drake
    [2339] = { x = 0.5 },  -- jani's trahspile
    [2707] = { x = -3.5, z = -0.6 }  -- brilliant petalwing
}

function MetaAchievementMountRewardPanel_GetPosition(mountId)
    local over = mountId and perMount[mountId]
    if over then
        return {
            x = over.x ~= nil and over.x or defaults.x,
            y = over.y ~= nil and over.y or defaults.y,
            z = over.z ~= nil and over.z or defaults.z,
            facingDegrees = over.facingDegrees ~= nil and over.facingDegrees or defaults.facingDegrees,
        }
    end
    return {
        x = defaults.x,
        y = defaults.y,
        z = defaults.z,
        facingDegrees = defaults.facingDegrees,
    }
end
