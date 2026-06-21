-- Addon-only virtual criteria types use negative IDs so they never clash with WoW API criteria types.

VirtualCriteriaTypes = VirtualCriteriaTypes or {}

--- Progress bar: counts completed rows in the achievement `criteria` table vs optional reqQuantity.
VirtualCriteriaTypes.ProgressBar = -1

--- World quest tracker: addon-only row with `worldQuest` for map scan notifications (not a WoW API criterion).
VirtualCriteriaTypes.WorldQuest = -2

function VirtualCriteriaTypes.IsVirtual(criteriaType)
    return type(criteriaType) == "number" and criteriaType < 0
end

--- When true on a virtualCriteria row, omit from requirements UI (world-quest scan and other logic still see the row).
function VirtualCriteriaTypes.IsHidden(criterion)
    return type(criterion) == "table" and criterion.hidden == true
end

--- When combineVirtualAndRegularCriteria is set, these virtual rows render before API criteria.
function VirtualCriteriaTypes.PrependWhenCombined(criteriaType)
    return criteriaType == VirtualCriteriaTypes.ProgressBar
end

--- @param entry table Requirement row being built
--- @param ctx table { achievementId, criterion, criteriaTable, countCompleted function(achievementId, criteriaTable) -> completed, total }
--- @return boolean handled
function VirtualCriteriaTypes.ApplyToRequirementEntry(entry, ctx)
    local criterion = ctx.criterion
    if type(criterion) ~= "table" then
        return false
    end
    local criteriaType = criterion.criteriaType
    if criteriaType == VirtualCriteriaTypes.ProgressBar then
        local countFn = ctx.countCompleted
        local criteriaTable = ctx.criteriaTable
        local achievementId = ctx.achievementId
        if type(countFn) ~= "function" or type(criteriaTable) ~= "table" then
            return false
        end
        local quantity, total = countFn(achievementId, criteriaTable)
        local reqQuantity = criterion.reqQuantity
        if type(reqQuantity) ~= "number" or reqQuantity <= 0 then
            reqQuantity = total
        end
        entry.quantity = quantity
        entry.reqQuantity = reqQuantity
        entry.quantityString = string.format("%d / %d", quantity, reqQuantity)
        entry.completed = reqQuantity > 0 and quantity >= reqQuantity
        entry.isPinnedSummary = true
        return true
    end
    if criteriaType == VirtualCriteriaTypes.WorldQuest then
        local achievementId = ctx.achievementId
        entry.completed = false
        if type(achievementId) == "number" and type(GetAchievementInfo) == "function" then
            local ok, _, _, _, completed = pcall(GetAchievementInfo, achievementId)
            if ok and completed == true then
                entry.completed = true
            end
        end
        if type(criterion.text) == "string" and criterion.text ~= "" then
            entry.text = criterion.text
        elseif type(criterion.name) == "string" and criterion.name ~= "" then
            entry.text = criterion.name
        end
        return true
    end
    return false
end
