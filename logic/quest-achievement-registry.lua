--[[
  Curated quest ID / quest line ID -> achievement IDs for activity notifications (DEV-019).
  Add rows from Wowhead or patch notes when tying world quests or delve quest lines to metas.
  Empty tables are valid until data is curated.
]]

MetaAchievementQuestRegistry = MetaAchievementQuestRegistry or {}

local QUEST_TO_ACHIEVEMENTS = {}
local QUEST_LINE_TO_ACHIEVEMENTS = {}

local function copyIdList(src)
    if type(src) ~= "table" then
        return nil
    end
    local out = {}
    local n = 0
    for i = 1, #src do
        local id = src[i]
        if type(id) == "number" then
            n = n + 1
            out[n] = id
        end
    end
    if n == 0 then
        return nil
    end
    return out
end

--- @return table|nil array of achievement ids, or nil if unregistered
function MetaAchievementQuestRegistry.GetAchievementIdsForQuest(questId)
    if type(questId) ~= "number" then
        return nil
    end
    return copyIdList(QUEST_TO_ACHIEVEMENTS[questId])
end

--- @return table|nil array of achievement ids, or nil if unregistered
function MetaAchievementQuestRegistry.GetAchievementIdsForQuestLine(questLineId)
    if type(questLineId) ~= "number" then
        return nil
    end
    return copyIdList(QUEST_LINE_TO_ACHIEVEMENTS[questLineId])
end

--- True if the achievement exists and is not completed for the player.
function MetaAchievementQuestRegistry.IsAchievementIncompleteForPlayer(achievementId)
    if type(achievementId) ~= "number" or not GetAchievementInfo then
        return false
    end
    local id, _, _, completed = GetAchievementInfo(achievementId)
    if not id then
        return false
    end
    return not completed
end
