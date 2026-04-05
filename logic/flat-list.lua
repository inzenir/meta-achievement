--[[
    Pure helpers to flatten DataList tree rows for the journal UI.
    Collapse and "hide completed meta" rules only — no WoW API or settings globals here.
]]

MetaAchievementFlatList = MetaAchievementFlatList or {}

--- Flatten a scanned item tree into display order.
--- @param items table[] root rows from DataList (each has colapsed, children, allChildrenCompleted, etc.)
--- @param hideCompleted boolean|nil when true, omit branches where allChildrenCompleted (same as settings "hideCompleted")
--- @return table[] linear list of items
function MetaAchievementFlatList.flatten(items, hideCompleted)
    local out = {}
    local function walk(input)
        for _, item in ipairs(input or {}) do
            if not (item.allChildrenCompleted and hideCompleted) then
                out[#out + 1] = item
                if item.colapsed == false then
                    walk(item.children)
                end
            end
        end
    end
    walk(items)
    return out
end
