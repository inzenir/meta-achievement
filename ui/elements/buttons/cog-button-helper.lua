--[[
    Shared helpers for cog buttons: compact style (red bg + silver border) and cog icon.
    Used by MetaAchievementSettingsCogButtonTemplate and MetaAchievementSilverCogButtonTemplate.
]]

local COG_ICON_PATH = "Interface\\Buttons\\UI-OptionsButton"

-- Blizzard-style silver border (same family as DialogBox / close button)
local function setSilverBackdrop(frame)
    if frame.SetBackdrop then
        frame:SetBackdrop({
            edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
            edgeSize = 8,
            insets = { left = 2, right = 2, top = 2, bottom = 2 },
        })
        frame:SetBackdropBorderColor(0.7, 0.7, 0.75, 1)
    end
end

--[[
    Apply the compact settings-cog look: red background + silver border.
    Use for small square(ish) cog buttons (e.g. next to close).
]]
function MetaAchievement_SetupCogButtonCompactStyle(frame)
    if not frame or not frame.CreateTexture then return end
    local bg = frame:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints(frame)
    bg:SetColorTexture(0.55, 0.1, 0.1, 1)
    setSilverBackdrop(frame)
end

--[[
    Ensure the button has a cog icon texture. If the button already has $parentIcon (from XML),
    reuses it and re-anchors; otherwise creates one. Returns the texture.
]]
function MetaAchievement_SetupCogIcon(button, insetPx)
    if not button then return nil end
    insetPx = insetPx or 4
    local name = button:GetName()
    local icon = name and _G[name .. "Icon"] or button.Icon
    if not icon and button.CreateTexture then
        icon = button:CreateTexture(nil, "OVERLAY")
        button.Icon = icon
    end
    if icon then
        if icon.SetTexture then icon:SetTexture(COG_ICON_PATH) end
        if icon.SetDrawLayer then icon:SetDrawLayer("OVERLAY") end
        icon:ClearAllPoints()
        icon:SetPoint("TOPLEFT", button, "TOPLEFT", insetPx, -insetPx)
        icon:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -insetPx, insetPx)
    end
    return icon
end

--[[
    When using UIPanelCloseButton (or same template as frame CloseButton): hide the X so only our cog shows.
    The template may draw the X in NormalTexture (red+X in one) or as a separate texture; we try to hide only the X layer.
]]
function MetaAchievement_SetupCogButtonFromCloseTemplate(button)
    if not button then return end
    local name = button:GetName()
    -- Try common Blizzard close-button texture names for the X (so we hide it and keep red/border from NormalTexture)
    for _, suffix in ipairs({ "Icon", "Symbol", "X", "CloseIcon" }) do
        local tex = name and _G[name .. suffix] or nil
        if tex and tex ~= button.Icon and tex.Hide then
            tex:Hide()
            break
        end
    end
end

--[[
    Set tooltip for a cog (or any) button.
]]
function MetaAchievement_CogButtonSetTooltip(button, text)
    if not button then return end
    if not text or text == "" then
        button:SetScript("OnEnter", nil)
        button:SetScript("OnLeave", nil)
        return
    end
    button:SetScript("OnEnter", function()
        GameTooltip:SetOwner(button, "ANCHOR_LEFT")
        GameTooltip:SetText(text, nil, nil, nil, nil, true)
        GameTooltip:Show()
    end)
    button:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
end
