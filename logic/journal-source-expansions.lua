--[[
  Expansion grouping for journal achievement-list dropdowns (main + mini).
]]

JournalSourceExpansions = JournalSourceExpansions or {}

local DEFAULT_EXPANSION = "Other"

local EXPANSION_SORT_RANK = {
    ["Midnight"] = 1,
    ["The War Within"] = 2,
    ["Dragonflight"] = 3,
    ["Shadowlands"] = 4,
    ["Battle for Azeroth"] = 5,
    ["Meta"] = 6,
    [DEFAULT_EXPANSION] = 99,
}

local function expansionRank(expansion)
    if type(expansion) ~= "string" or expansion == "" then
        return EXPANSION_SORT_RANK[DEFAULT_EXPANSION]
    end
    return EXPANSION_SORT_RANK[expansion] or EXPANSION_SORT_RANK[DEFAULT_EXPANSION]
end

local function normalizeExpansion(expansion)
    if type(expansion) == "string" and expansion ~= "" then
        return expansion
    end
    return DEFAULT_EXPANSION
end

--- Stable sort: expansion display order, then original registration order.
function JournalSourceExpansions.SortSources(sources)
    if type(sources) ~= "table" then
        return {}
    end
    local wrapped = {}
    for i = 1, #sources do
        local src = sources[i]
        if type(src) == "table" then
            wrapped[#wrapped + 1] = {
                src = src,
                index = i,
                rank = expansionRank(src.expansion),
                expansion = normalizeExpansion(src.expansion),
            }
        end
    end
    table.sort(wrapped, function(a, b)
        if a.rank ~= b.rank then
            return a.rank < b.rank
        end
        return a.index < b.index
    end)
    local out = {}
    for i = 1, #wrapped do
        out[i] = wrapped[i].src
    end
    return out
end

function JournalSourceExpansions.PopulateAchievementListMenu(rootDescription, sources, isSelected, setSelected)
    if not rootDescription or type(isSelected) ~= "function" or type(setSelected) ~= "function" then
        return
    end
    local sorted = JournalSourceExpansions.SortSources(sources)
    local lastExpansion
    for i = 1, #sorted do
        local src = sorted[i]
        local expansion = normalizeExpansion(src and src.expansion)
        if expansion ~= lastExpansion then
            rootDescription:CreateTitle(expansion)
            lastExpansion = expansion
        end
        local key = (src and src.key) or ""
        local label = (src and (src.name or src.key)) or ""
        rootDescription:CreateRadio(label, isSelected, setSelected, key)
    end
end
