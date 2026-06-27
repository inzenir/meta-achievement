--[[
  World quest activity notifications: scan AchievementData-registered waypoints for
  criteria or virtualCriteria rows with worldQuest { mapId, questId }, probe those maps
  via task/map POI APIs, and notify when the quest is active and tracking is still relevant.

  Legacy quest-achievement-registry rows are no longer required for this path; new data
  only needs RegisterDataSource + criteria.worldQuest or virtualCriteria.worldQuest.
]]

local function isCriteriaIncompleteById(achievementId, criteriaId)
    if type(achievementId) ~= "number" or type(criteriaId) ~= "number" then
        return false
    end
    if type(GetAchievementCriteriaInfoByID) == "function" then
        local ok, _criteriaString, _criteriaType, completed = pcall(GetAchievementCriteriaInfoByID, achievementId, criteriaId)
        if ok and completed ~= nil then
            return completed ~= true
        end
    end
    if type(GetAchievementNumCriteria) ~= "function" or type(GetAchievementCriteriaInfo) ~= "function" then
        return false
    end
    local num = GetAchievementNumCriteria(achievementId) or 0
    for idx = 1, num do
        local _, _, completed, _, _, _, _, _, _, cid = GetAchievementCriteriaInfo(achievementId, idx)
        if cid == criteriaId then
            return completed ~= true
        end
    end
    return false
end

local function getTaskQuestPoisForMap(uiMapID)
    if not C_TaskQuest then
        return nil
    end
    -- 11.0.5+: GetQuestsForPlayerByMapID was replaced by GetQuestsOnMap (same return shape).
    if type(C_TaskQuest.GetQuestsOnMap) == "function" then
        return C_TaskQuest.GetQuestsOnMap(uiMapID)
    end
    if type(C_TaskQuest.GetQuestsForPlayerByMapID) == "function" then
        return C_TaskQuest.GetQuestsForPlayerByMapID(uiMapID)
    end
    return nil
end

local function collectActiveQuestIdsForMap(uiMapID)
    local seen = {}

    local function addPoiList(pois)
        if type(pois) ~= "table" then
            return
        end
        for i = 1, #pois do
            local row = pois[i]
            if type(row) == "table" then
                local qid = row.questID
                if type(qid) == "number" then
                    seen[qid] = true
                end
            end
        end
    end

    addPoiList(getTaskQuestPoisForMap(uiMapID))

    if C_QuestLog and type(C_QuestLog.GetQuestsOnMap) == "function" then
        addPoiList(C_QuestLog.GetQuestsOnMap(uiMapID))
    end

    return seen
end

local function isFactionAllowedForPlayer(requiredFaction)
    if type(requiredFaction) ~= "string" then
        return true
    end
    local playerFaction = UnitFactionGroup("player")
    return playerFaction == requiredFaction
end

local function getWorldQuestFaction(cinfo)
    if type(cinfo) ~= "table" then
        return nil
    end
    if type(cinfo.faction) == "string" then
        return cinfo.faction
    end
    local wq = cinfo.worldQuest
    if type(wq) == "table" and type(wq.faction) == "string" then
        return wq.faction
    end
    return nil
end

local function normalizeWorldQuest(cinfo)
    if type(cinfo) ~= "table" then
        return nil
    end
    local wq = cinfo.worldQuest
    if type(wq) ~= "table" then
        return nil
    end
    local mapId = wq.mapId
    local questId = wq.questId
    if type(mapId) ~= "number" or type(questId) ~= "number" then
        return nil
    end
    return mapId, questId
end

local function isAchievementIncomplete(achievementId)
    if type(achievementId) ~= "number" or type(GetAchievementInfo) ~= "function" then
        return false
    end
    local ok, _, _, _, completed = pcall(GetAchievementInfo, achievementId)
    return ok and completed ~= true
end

local function isWatchRowIncomplete(row)
    if row.isVirtual then
        return isAchievementIncomplete(row.achievementId)
    end
    return isCriteriaIncompleteById(row.achievementId, row.criteriaId)
end

local function getWatchRowQuestName(row)
    local questName
    if not row.isVirtual and type(GetAchievementCriteriaInfoByID) == "function" then
        local ok, label = pcall(GetAchievementCriteriaInfoByID, row.achievementId, row.criteriaId)
        if ok and type(label) == "string" and label ~= "" then
            questName = label
        end
    end
    if not questName and row.cinfo then
        if type(row.cinfo.name) == "string" and row.cinfo.name ~= "" then
            questName = row.cinfo.name
        elseif type(row.cinfo.text) == "string" and row.cinfo.text ~= "" then
            questName = row.cinfo.text
        end
    end
    if not questName then
        questName = tostring(row.questId)
    end
    return questName
end

local function addWorldQuestWatchRows(watchList, mapIdsToScan, mapIdSeen, topAchievementId, achievementId, criteriaTable, isVirtual)
    if type(criteriaTable) ~= "table" then
        return
    end
    for criteriaId, cinfo in pairs(criteriaTable) do
        if type(criteriaId) == "number" and type(cinfo) == "table"
            and isFactionAllowedForPlayer(getWorldQuestFaction(cinfo)) then
            local mapId, questId = normalizeWorldQuest(cinfo)
            if mapId and questId then
                watchList[#watchList + 1] = {
                    topAchievementId = topAchievementId,
                    achievementId = achievementId,
                    criteriaId = criteriaId,
                    cinfo = cinfo,
                    mapId = mapId,
                    questId = questId,
                    isVirtual = isVirtual == true,
                }
                if not mapIdSeen[mapId] then
                    mapIdSeen[mapId] = true
                    mapIdsToScan[#mapIdsToScan + 1] = mapId
                end
            end
        end
    end
end

function MetaAchievementWorldQuestScan_TryRefresh()
    if not AchievementData or type(AchievementData.ForEachRegisteredAchievementEntry) ~= "function" then
        return
    end
    if not MetaAchievementActivityNotify or type(MetaAchievementActivityNotify.TryNotify) ~= "function" then
        return
    end

    local watchList = {}
    local mapIdsToScan = {}
    local mapIdSeen = {}

    AchievementData:ForEachRegisteredAchievementEntry(function(topAchievementId, achievementId, flatEntry)
        if type(flatEntry) ~= "table" then
            return
        end
        addWorldQuestWatchRows(watchList, mapIdsToScan, mapIdSeen, topAchievementId, achievementId, flatEntry.criteria, false)
        addWorldQuestWatchRows(watchList, mapIdsToScan, mapIdSeen, topAchievementId, achievementId, flatEntry.virtualCriteria, true)
    end)

    if #watchList == 0 then
        return
    end

    local activeByMap = {}
    for i = 1, #mapIdsToScan do
        local mapId = mapIdsToScan[i]
        activeByMap[mapId] = collectActiveQuestIdsForMap(mapId)
    end

    if type(MetaAchievementActivityNotify.BeginNotificationBurst) == "function" then
        MetaAchievementActivityNotify.BeginNotificationBurst()
    end

    for i = 1, #watchList do
        local row = watchList[i]
        local activeOnMap = activeByMap[row.mapId]
        if activeOnMap and activeOnMap[row.questId] and isWatchRowIncomplete(row) then
            MetaAchievementActivityNotify.TryNotify({
                feature = "worldQuest",
                achievementId = row.achievementId,
                topAchievementId = row.topAchievementId,
                questId = row.questId,
                cardDescription = string.format("%s: world quest is currently active", getWatchRowQuestName(row)),
                dedupeKey = "wq:"
                    .. tostring(row.topAchievementId)
                    .. ":"
                    .. tostring(row.achievementId)
                    .. ":"
                    .. tostring(row.criteriaId),
            })
        end
    end

    if type(MetaAchievementActivityNotify.EndNotificationBurst) == "function" then
        MetaAchievementActivityNotify.EndNotificationBurst()
    end
end
