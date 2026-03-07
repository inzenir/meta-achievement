MapIntegration = {}
MapIntegration.__index = MapIntegration


local function getObjectChecksum(obj)
    local checksum = ""
    for k, v in pairs(obj) do
        if type(v) == "table" then
            checksum = checksum .. getObjectChecksum(v)
        else
            checksum = checksum .. tostring(v)
        end
    end
    return checksum
end

function MapIntegration:new(parent)
    local obj = setmetatable({}, self)

    obj.parent = parent
    obj.waypointsByAchievement = {}

    -- load preserved waypoints
    local db = MetaAchievementSettings and MetaAchievementSettings:Get("mapIntegration")

    if db and db.preservedWaypoints and type(db.preservedWaypoints) == "table" then
        obj.waypointsByAchievement = db.preservedWaypoints
    end

    return obj
end

-- Toggle waypoints for an achievement.
function MapIntegration:ToggleWaypointsForAchievement(id, waypoints)
    if not waypoints or type(waypoints) ~= "table" then return end

    if self.waypointsByAchievement[id] and type(self.waypointsByAchievement[id]) == "table" then
        -- existing waypoints

        -- check if all waypoints are present
        local allPresent = true
        for _, wp in ipairs(waypoints) do
            local present = false
            for _, existingWp in ipairs(self.waypointsByAchievement[id]) do
                if getObjectChecksum(existingWp) == getObjectChecksum(wp) then
                    present = true
                    break
                end
            end
            if not present then
                allPresent = false
                break
            end
        end
        if allPresent then
            -- all waypoints are present, remove them
            self:RemoveWaypointsForAchievement(id, waypoints)
        else
            -- some waypoints are missing, add them
            self:AddWaypointsForAchievement(id, waypoints)
        end

    else
        -- all new waypoints
        self:AddWaypointsForAchievement(id, waypoints)
    end
end

-- Add waypoints for an achievement.
function MapIntegration:AddWaypointsForAchievement(id, waypoints)
    if not waypoints then return end
    if not self.waypointsByAchievement[id] or type(self.waypointsByAchievement[id]) ~= "table" then
        self.waypointsByAchievement[id] = {}
    end
    
    for i, wp in ipairs(waypoints) do
        local insert = true
        for j, existingWp in ipairs(self.waypointsByAchievement[id]) do
            if getObjectChecksum(existingWp) == getObjectChecksum(wp) then
                insert = false
                break
            end
        end
        if insert then
            self.waypointsByAchievement[id][#self.waypointsByAchievement[id] + 1] = wp
        end
    end

    self:NotifyWaypointsUpdate()
    self:PreserveWaypoints()
end

-- Remove waypoints for an achievement.
function MapIntegration:RemoveWaypointsForAchievement(id, waypoints)
    if not waypoints or type(waypoints) ~= "table" then
        -- we remove all waypoints for achievement as no list is specified
        self.waypointsByAchievement[id] = nil
    else
        local tmpWaypoints = {}
        for _, wp in ipairs(waypoints) do
            local remove = false

            for _, existingWp in ipairs(self.waypointsByAchievement[id]) do
                if getObjectChecksum(existingWp) == getObjectChecksum(wp) then
                    remove = true
                    break
                end
            end

            if not remove then
                tmpWaypoints[#tmpWaypoints + 1] = wp
            end

        end
        self.waypointsByAchievement[id] = tmpWaypoints
    end

    self:NotifyWaypointsUpdate()
    self:PreserveWaypoints()
end

-- Remove all waypoints.
function MapIntegration:RemoveAllWaypoints()
    self.waypointsByAchievement = {}

    self:NotifyWaypointsUpdate()
    self:PreserveWaypoints()
end

function MapIntegration:GetWaypoints()
    return self.waypointsByAchievement
end

-- Notify the parent that the waypoints have been updated.
function MapIntegration:NotifyWaypointsUpdate()
    if self.parent and self.parent.NotifyWaypointsUpdate then
        self.parent:NotifyWaypointsUpdate()
    end
end

-- preserve waypoints

function MapIntegration:PreserveWaypoints()
    local pointsToPreserve = {}
    if MetaAchievementSettings and MetaAchievementSettings:Get("preserveWaypoints") then

        pointsToPreserve = self.waypointsByAchievement
    end

    local db = MetaAchievementSettings:Get("mapIntegration") or {}
    db.preservedWaypoints = pointsToPreserve
    MetaAchievementSettings:Set("mapIntegration", db)
end
