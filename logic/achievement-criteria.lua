AchievementCriteria = {}
AchievementCriteria.__index = AchievementCriteria

AchievementCriteriaTypes = {
    CompletingAQuest = 27
}

function AchievementCriteria:new(achievementId, entry)
    local obj = setmetatable({}, AchievementCriteria)
    local waypoint = nil
    if entry.waypoint then
        waypoint = Waypoint:new(entry.waypoint)
    end

    obj.achievementId = achievementId
    obj.id = entry.id
    obj.criteriaType = entry.type or AchievementCriteriaTypes.CompletingAQuest
    obj.waypoint = waypoint

    return obj
end

function AchievementCriteria:GetWaypoint()
    return self.waypoint
end

function AchievementCriteria:GetFilteredWaypoint()
    if MetaAchievementConfigurationDB.addWaypointsOnlyForUncompletedAchievementParts then
        local numCriteria = GetAchievementNumCriteria(self.achievementId)

        for i = 1, numCriteria do
            local criteriaString, criteriaType, completed, quantity, reqQuantity, charName, flags, assetID, quantityString, criteriaID, eligible = GetAchievementCriteriaInfo(self.achievementId, i)
            
            if self.id == criteriaID and not completed then
                return self.waypoint
            end
        end

        return nil
    else
        -- no filtering in this case
        return self.waypoint
    end
end