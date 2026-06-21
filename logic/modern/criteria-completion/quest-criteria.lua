function IsQuestCriteriaCompleted(achievementId, criteriaId)
    -- Real WoW criteria IDs (e.g. 62887 rows): use API completion. Quest-keyed virtual rows (criteriaId = questId): fall back below.
    if type(GetAchievementCriteriaInfoByID) == "function" then
        local ok, _, _, completed = pcall(GetAchievementCriteriaInfoByID, achievementId, criteriaId)
        if ok then
            return completed == true
        end
    end
    return C_QuestLog.IsQuestFlaggedCompleted(criteriaId)
end

RegisterCriteriaCompletionHandler(AchievementCriteriaTypes.CompletingAQuest, IsQuestCriteriaCompleted)