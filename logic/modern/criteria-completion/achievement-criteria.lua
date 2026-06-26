local CRITERIA_TYPE_ACHIEVEMENT = 8

--- Type 8 (sub-achievement) criteria: use parent achievement criteria completion, not GetAchievementInfo(assetID).
local function IsSubAchievementCriteriaCompleted(achievementId, criteriaId)
    if type(GetAchievementCriteriaInfoByID) == "function" then
        local ok, _, criteriaType, completed = pcall(GetAchievementCriteriaInfoByID, achievementId, criteriaId)
        if ok and criteriaType == CRITERIA_TYPE_ACHIEVEMENT then
            return completed == true
        end
    end
    if type(MetaAchievementMapCriterionIsCompleted) == "function" then
        return MetaAchievementMapCriterionIsCompleted(achievementId, criteriaId)
    end
    return false
end

RegisterCriteriaCompletionHandler(CRITERIA_TYPE_ACHIEVEMENT, IsSubAchievementCriteriaCompleted)
