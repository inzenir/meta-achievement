--[[
  Quest lines on the player map intersected with registry; drives activity notifications (DEV-022).
  Delve story POI notifications live in delve-story-notify.lua (registry-wide).
]]

function MetaAchievementQuestLineScan_TryRefresh()
    if not C_Map or type(C_Map.GetBestMapForUnit) ~= "function" then
        return
    end
    if not C_QuestLine or type(C_QuestLine.GetAvailableQuestLines) ~= "function" then
        return
    end
    if not MetaAchievementQuestRegistry or not MetaAchievementActivityNotify then
        return
    end

    local m = C_Map.GetBestMapForUnit("player")
    if not m then
        return
    end

    if type(C_QuestLine.RequestQuestLinesForMap) == "function" then
        pcall(function()
            C_QuestLine.RequestQuestLinesForMap(m)
        end)
    end

    local lines = C_QuestLine.GetAvailableQuestLines(m)
    if type(lines) ~= "table" then
        return
    end

    if type(MetaAchievementActivityNotify.BeginNotificationBurst) == "function" then
        MetaAchievementActivityNotify.BeginNotificationBurst()
    end
    for i = 1, #lines do
        local row = lines[i]
        if type(row) == "table" then
            local qlineId = row.questLineID
            if type(qlineId) == "number" then
                if type(C_QuestLine.IsComplete) == "function" and C_QuestLine.IsComplete(qlineId) then
                    -- skip finished lines
                else
                    local achis = MetaAchievementQuestRegistry.GetAchievementIdsForQuestLine(qlineId)
                    if achis then
                        for j = 1, #achis do
                            local aid = achis[j]
                            MetaAchievementActivityNotify.TryNotify({
                                feature = "questLine",
                                achievementId = aid,
                                questLineId = qlineId,
                                dedupeKey = "line:" .. tostring(qlineId) .. ":" .. tostring(aid),
                            })
                        end
                    end
                end
            end
        end
    end
    if type(MetaAchievementActivityNotify.EndNotificationBurst) == "function" then
        MetaAchievementActivityNotify.EndNotificationBurst()
    end
end
