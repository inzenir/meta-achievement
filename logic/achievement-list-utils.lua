--[[
  Pure helpers for flat achievement list nodes (id on node or under data.id).
]]

AchievementListUtils = AchievementListUtils or {}

--- Normalize a stored/string id for comparison with list nodes (matches ActiveAchievementState).
function AchievementListUtils.normalizeAchievementId(id)
    if id == nil then
        return nil
    end
    return tonumber(id) or id
end

--- Resolve achievement id from a journal list node (id or nested data.id).
function AchievementListUtils.resolveIdFromNode(node)
    if not node then
        return nil
    end
    if node.id ~= nil then
        return node.id
    end
    if node.data and node.data.id ~= nil then
        return node.data.id
    end
    return nil
end

--- 1-based index of the item matching id, or nil. Matches node.id or node.data.id.
function AchievementListUtils.findIndexForAchievementId(list, id)
    if type(list) ~= "table" then
        return nil
    end
    local wantId = AchievementListUtils.normalizeAchievementId(id)
    if wantId == nil then
        return nil
    end
    for i, n in ipairs(list) do
        if n and ((n.id == wantId) or (n.data and n.data.id == wantId)) then
            return i
        end
    end
    return nil
end
