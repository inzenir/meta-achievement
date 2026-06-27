--[[
  Named completion checks for virtualCriteria rows (`criteriaCheck` field).
  Use when virtual key / criteriaId does not match WoW API criteria lookup (e.g. type 0 with criteriaID 0).
]]

CriteriaChecks = CriteriaChecks or {}

--- @param virtualKey number virtualCriteria table key (often 1-based API criteria index)
--- @param criterion table virtualCriteria row
--- @return number API criteria index for GetAchievementCriteriaInfo
function CriteriaChecks.GetApiCriteriaIndex(virtualKey, criterion)
    if type(criterion) == "table" and type(criterion.index) == "number" then
        return criterion.index
    end
    return virtualKey
end

--- Read completed flag from GetAchievementCriteriaInfo by index (virtual key or criterion.index).
function CriteriaChecks.checkByIndex(achievementId, virtualKey, criterion)
    if type(achievementId) ~= "number" or type(virtualKey) ~= "number" then
        return false
    end
    if type(GetAchievementCriteriaInfo) ~= "function" then
        return false
    end
    local index = CriteriaChecks.GetApiCriteriaIndex(virtualKey, criterion)
    local ok, _, _, completed = pcall(GetAchievementCriteriaInfo, achievementId, index)
    return ok and completed == true
end

--- @return boolean|nil completed when criteriaCheck is set; nil when no check configured
function MetaAchievementResolveCriteriaCheck(achievementId, virtualKey, criterion)
    if type(criterion) ~= "table" then
        return nil
    end
    local check = criterion.criteriaCheck
    local fn
    if type(check) == "function" then
        fn = check
    elseif type(check) == "string" and type(CriteriaChecks[check]) == "function" then
        fn = CriteriaChecks[check]
    end
    if not fn then
        return nil
    end
    return fn(achievementId, virtualKey, criterion) == true
end
