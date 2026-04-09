--[[
  Map quest/task POIs intersected with registry; drives activity notifications (DEV-021).
]]

local function collectQuestIdsForMap(uiMapID)
    local seen = {}
    local order = {}

    local function addPoiList(pois)
        if type(pois) ~= "table" then
            return
        end
        for i = 1, #pois do
            local row = pois[i]
            if type(row) == "table" then
                local qid = row.questID
                if type(qid) == "number" and not seen[qid] then
                    seen[qid] = true
                    order[#order + 1] = qid
                end
            end
        end
    end

    if C_TaskQuest and type(C_TaskQuest.GetQuestsForPlayerByMapID) == "function" then
        addPoiList(C_TaskQuest.GetQuestsForPlayerByMapID(uiMapID))
    end
    if C_QuestLog and type(C_QuestLog.GetQuestsOnMap) == "function" then
        addPoiList(C_QuestLog.GetQuestsOnMap(uiMapID))
    end

    return order
end

function MetaAchievementWorldQuestScan_TryRefresh()
    if not C_Map or type(C_Map.GetBestMapForUnit) ~= "function" then
        return
    end
    if not MetaAchievementQuestRegistry or not MetaAchievementActivityNotify then
        return
    end

    local m = C_Map.GetBestMapForUnit("player")
    if not m then
        return
    end

    local questIds = collectQuestIdsForMap(m)
    if type(MetaAchievementActivityNotify.BeginNotificationBurst) == "function" then
        MetaAchievementActivityNotify.BeginNotificationBurst()
    end
    for i = 1, #questIds do
        local qid = questIds[i]
        local achis = MetaAchievementQuestRegistry.GetAchievementIdsForQuest(qid)
        if achis then
            for j = 1, #achis do
                local aid = achis[j]
                MetaAchievementActivityNotify.TryNotify({
                    feature = "worldQuest",
                    achievementId = aid,
                    questId = qid,
                    dedupeKey = tostring(qid) .. ":" .. tostring(aid),
                })
            end
        end
    end
    if type(MetaAchievementActivityNotify.EndNotificationBurst) == "function" then
        MetaAchievementActivityNotify.EndNotificationBurst()
    end
end
