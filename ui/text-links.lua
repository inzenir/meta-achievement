--[[
  Expand {achievement:id} and {item:id} tokens into WoW hyperlinks for FontString text.
  Parent frames must call InstallHyperlinkFrame so links render and respond to mouse.
]]

MetaAchievementTextLinks = MetaAchievementTextLinks or {}

local TOKEN_PATTERN = "{(%l+):(%d+)(%l*)}"

local refreshers = setmetatable({}, { __mode = "k" })
local pendingItemLoads = {}
local loadedItems = {}
local notifyDepth = 0

local function getItemInfo(itemId)
    if C_Item and C_Item.GetItemInfo then
        return C_Item.GetItemInfo(itemId)
    end
    if GetItemInfo then
        return GetItemInfo(itemId)
    end
end

local function getItemIcon(itemId)
    if C_Item and C_Item.GetItemInfoInstant then
        local _, _, _, _, icon = C_Item.GetItemInfoInstant(itemId)
        return icon
    end
    local _, _, _, _, _, _, _, _, _, icon = getItemInfo(itemId)
    return icon
end

local function isItemDataReady(itemId)
    if loadedItems[itemId] then
        return true
    end
    local _, link = getItemInfo(itemId)
    if link and link ~= "" then
        loadedItems[itemId] = true
        pendingItemLoads[itemId] = nil
        return true
    end
    return false
end

local function requestItemData(itemId)
    if not itemId or isItemDataReady(itemId) or pendingItemLoads[itemId] then
        return
    end
    pendingItemLoads[itemId] = true
    if C_Item and C_Item.RequestLoadItemDataByID then
        C_Item.RequestLoadItemDataByID(itemId)
    end
end

local function formatItemLink(itemId)
    local name, link, _, _, _, _, _, _, _, icon = getItemInfo(itemId)
    icon = icon or getItemIcon(itemId)
    if link then
        if icon then
            return "|T" .. icon .. ":0|t " .. link
        end
        return link
    end
    if name and name ~= "" then
        return name
    end
    return "[Item #" .. tostring(itemId) .. "]"
end

local function textReferencesItem(text, itemId)
    if type(text) ~= "string" or not itemId then
        return false
    end
    return text:find("{item:" .. tostring(itemId) .. "}", 1, true) ~= nil
end

--- Prime async item cache for any {item:id} tokens in text.
function MetaAchievementTextLinks.Prepare(text)
    if type(text) ~= "string" or text == "" then
        return
    end
    for tokenType, idStr in text:gmatch(TOKEN_PATTERN) do
        if tokenType == "item" then
            requestItemData(tonumber(idStr))
        end
    end
end

--- Replace supported tokens with clickable hyperlink markup.
function MetaAchievementTextLinks.Render(text)
    if type(text) ~= "string" or text == "" then
        return text or ""
    end

    return (text:gsub(TOKEN_PATTERN, function(tokenType, idStr, suffix)
        local id = tonumber(idStr)
        if not id then
            return "{" .. tokenType .. ":" .. idStr .. (suffix or "") .. "}"
        end

        if tokenType == "achievement" then
            if GetAchievementLink then
                local link = GetAchievementLink(id)
                if link then
                    return link
                end
            end
            if GetAchievementInfo then
                local _, name = GetAchievementInfo(id)
                if name then
                    return name
                end
            end
            return "[Achievement #" .. id .. "]"
        end

        if tokenType == "item" then
            return formatItemLink(id)
        end

        return "{" .. tokenType .. ":" .. idStr .. (suffix or "") .. "}"
    end))
end

function MetaAchievementTextLinks.InstallHyperlinkFrame(frame)
    if not frame or frame._metaHyperlinksInstalled then
        return
    end
    frame._metaHyperlinksInstalled = true

    if frame.EnableMouse then
        frame:EnableMouse(true)
    end
    if frame.SetHyperlinksEnabled then
        frame:SetHyperlinksEnabled(true)
    end

    frame:SetScript("OnHyperlinkEnter", function(_, link)
        if not GameTooltip or not GameTooltip.SetHyperlink then
            return
        end
        GameTooltip:SetOwner(frame, "ANCHOR_CURSOR")
        GameTooltip:SetHyperlink(link)
        GameTooltip:Show()
    end)

    frame:SetScript("OnHyperlinkLeave", function()
        if GameTooltip then
            GameTooltip:Hide()
        end
    end)

    frame:SetScript("OnHyperlinkClick", function(_, link, linkText, button)
        if SetItemRef then
            SetItemRef(link, linkText, button)
        end
    end)
end

--- Re-render text when item data finishes loading (weak-keyed; frame GC removes entry).
function MetaAchievementTextLinks.WatchFrame(frame, onRefresh)
    if not frame or type(onRefresh) ~= "function" then
        return
    end
    refreshers[frame] = onRefresh
end

function MetaAchievementTextLinks.NotifyItemLoaded(itemId)
    if notifyDepth > 0 then
        return
    end
    notifyDepth = notifyDepth + 1
    for frame, onRefresh in pairs(refreshers) do
        if frame and type(onRefresh) == "function" then
            local visible = (frame.IsVisible and frame:IsVisible())
                or (frame.IsShown and frame:IsShown())
            if visible and (
                not itemId
                or textReferencesItem(frame._currentHelpText, itemId)
                or textReferencesItem(frame._currentCriteriaInfoText, itemId)
                or textReferencesItem(frame._currentRewardText, itemId)
            ) then
                onRefresh()
            end
        end
    end
    notifyDepth = notifyDepth - 1
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ITEM_DATA_LOAD_RESULT")
eventFrame:SetScript("OnEvent", function(_, _, itemId, success)
    if success == false or not itemId then
        pendingItemLoads[itemId] = nil
        return
    end
    loadedItems[itemId] = true
    pendingItemLoads[itemId] = nil
    MetaAchievementTextLinks.NotifyItemLoaded(itemId)
end)
