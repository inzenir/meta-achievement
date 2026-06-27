local function isAchievementCriteriaId(achievementId, criteriaId)
    if type(GetAchievementNumCriteria) ~= "function" or type(GetAchievementCriteriaInfo) ~= "function" then
        return false
    end
    local num = GetAchievementNumCriteria(achievementId) or 0
    for idx = 1, num do
        local _, _, _, _, _, _, _, _, _, cid = GetAchievementCriteriaInfo(achievementId, idx)
        if cid == criteriaId then
            return true
        end
    end
    return false
end

function IsQuestCriteriaCompleted(achievementId, criteriaId)
    -- Real WoW criteria IDs: use API completion. Quest-keyed virtual rows (criteriaId = questId): quest log.
    if isAchievementCriteriaId(achievementId, criteriaId) then
        if type(GetAchievementCriteriaInfoByID) == "function" then
            local ok, _, _, completed = pcall(GetAchievementCriteriaInfoByID, achievementId, criteriaId)
            if ok then
                return completed == true
            end
        end
        if type(MetaAchievementMapCriterionIsCompleted) == "function" then
            return MetaAchievementMapCriterionIsCompleted(achievementId, criteriaId)
        end
        return false
    end
    if C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted then
        return C_QuestLog.IsQuestFlaggedCompleted(criteriaId) == true
    end
    return false
end

RegisterCriteriaCompletionHandler(AchievementCriteriaTypes.CompletingAQuest, IsQuestCriteriaCompleted)