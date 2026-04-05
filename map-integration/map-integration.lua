MapIntegration = {}
MapIntegration.__index = MapIntegration

--- @param achievementId number|any
--- @return boolean
local function achievementIsComplete(achievementId)
    if not achievementId or not GetAchievementInfo then
        return false
    end
    local id = tonumber(achievementId) or achievementId
    local ok, _, _, _, completed = pcall(GetAchievementInfo, id)
    return ok and completed == true
end

--- Skip storing/toggling pins when option is on and the achievement is already completed (DEV-014).
local function shouldSkipAchievementWaypoints(achievementId)
    if not MetaAchievementSettings or not MetaAchievementSettings:Get("removeCompletedWaypoints") then
        return false
    end
    return achievementIsComplete(achievementId)
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
    if shouldSkipAchievementWaypoints(id) then
        return
    end

    if self.waypointsByAchievement[id] and type(self.waypointsByAchievement[id]) == "table" then
        -- existing waypoints

        -- check if all waypoints are present
        local allPresent = true
        for _, wp in ipairs(waypoints) do
            local present = false
            for _, existingWp in ipairs(self.waypointsByAchievement[id]) do
                if WaypointIdentity.getKey(existingWp) == WaypointIdentity.getKey(wp) then
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
    if shouldSkipAchievementWaypoints(id) then
        return
    end
    if not self.waypointsByAchievement[id] or type(self.waypointsByAchievement[id]) ~= "table" then
        self.waypointsByAchievement[id] = {}
    end

    for i, wp in ipairs(waypoints) do
        local insert = true
        for j, existingWp in ipairs(self.waypointsByAchievement[id]) do
            if WaypointIdentity.getKey(existingWp) == WaypointIdentity.getKey(wp) then
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

-- Remove waypoints for an achievement. When waypoints is a list, removes only matching
-- stored pins; other stored pins for this achievement id are kept.
function MapIntegration:RemoveWaypointsForAchievement(id, waypoints)
    if not waypoints or type(waypoints) ~= "table" then
        -- we remove all waypoints for achievement as no list is specified
        self.waypointsByAchievement[id] = nil
    else
        local existing = self.waypointsByAchievement[id]
        if not existing or type(existing) ~= "table" then
            self:NotifyWaypointsUpdate()
            self:PreserveWaypoints()
            return
        end
        local tmpWaypoints = {}
        for _, existingWp in ipairs(existing) do
            local remove = false
            for _, wp in ipairs(waypoints) do
                if WaypointIdentity.getKey(existingWp) == WaypointIdentity.getKey(wp) then
                    remove = true
                    break
                end
            end
            if not remove then
                tmpWaypoints[#tmpWaypoints + 1] = existingWp
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

--- Remove stored pins for an achievement id (e.g. on ACHIEVEMENT_EARNED when removeCompletedWaypoints is on).
function MapIntegration:RemoveStoredWaypointsForEarnedAchievement(achievementId)
    if not MetaAchievementSettings or not MetaAchievementSettings:Get("removeCompletedWaypoints") then
        return
    end
    local id = tonumber(achievementId) or achievementId
    if not id or not self.waypointsByAchievement[id] then
        return
    end
    self.waypointsByAchievement[id] = nil
    self:NotifyWaypointsUpdate()
    self:PreserveWaypoints()
end

--- Keys in `waypointsByAchievement` are achievement ids loaded from persisted SavedVariables. On enter world and
--- after criteria updates we re-walk that table against the completion APIs, then integrations get `UpdateWaypoints`.
function MapIntegration:ResyncPersistedWaypointsAgainstCompletionApi()
    self:PruneAllCompletedWaypointsFromStorage()
end

--- Drop all stored pins whose achievement is completed, or individual criteria pins when that criterion is done.
function MapIntegration:PruneAllCompletedWaypointsFromStorage()
    if not MetaAchievementSettings or not MetaAchievementSettings:Get("removeCompletedWaypoints") then
        return
    end
    local changed = false
    for achId, wps in pairs(self.waypointsByAchievement) do
        local id = tonumber(achId) or achId
        if achievementIsComplete(id) then
            self.waypointsByAchievement[id] = nil
            changed = true
        elseif type(wps) == "table" then
            local newList = {}
            for _, wp in ipairs(wps) do
                local critId = type(wp) == "table" and wp.criteriaId
                if critId and type(MetaAchievementIsWaypointCriterionCompleted) == "function" and MetaAchievementIsWaypointCriterionCompleted(id, wp) then
                    changed = true
                else
                    newList[#newList + 1] = wp
                end
            end
            if #newList == 0 then
                self.waypointsByAchievement[id] = nil
                changed = true
            elseif #newList ~= #wps then
                self.waypointsByAchievement[id] = newList
                changed = true
            end
        end
    end
    if changed then
        self:NotifyWaypointsUpdate()
        self:PreserveWaypoints()
    end
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
