-- Preview button template: same icon as waypoint button, tooltip "Preview achievement".
-- Use inherits="MetaAchievementPreviewButtonTemplate" and set Anchors on the instance.

-- Vertex colors for icon: darker (normal) and lighter (hover)
local ICON_COLOR_NORMAL = { 0.72, 0.72, 0.72 }
local ICON_COLOR_HOVER   = { 1, 1, 1 }

function MetaAchievementPreviewButton_OnLoad(self)
    local icon = _G[self:GetName() .. "Icon"]
    if not icon then return end

    self.Icon = icon
    if icon.SetVertexColor then
        icon:SetVertexColor(ICON_COLOR_NORMAL[1], ICON_COLOR_NORMAL[2], ICON_COLOR_NORMAL[3])
    end

    local nudge = 1
    local function nudgeDown()
        if icon and icon.ClearAllPoints and icon.SetPoint then
            icon:ClearAllPoints()
            icon:SetPoint("TOPLEFT", self, "TOPLEFT", nudge, -nudge)
            icon:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", nudge, -nudge)
        end
    end

    local function resetNudge()
        if icon and icon.ClearAllPoints and icon.SetPoint then
            icon:ClearAllPoints()
            icon:SetPoint("TOPLEFT", self, "TOPLEFT")
            icon:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT")
        end
    end

    self:SetScript("OnMouseDown", nudgeDown)
    self:SetScript("OnMouseUp", resetNudge)
    self:SetScript("OnLeave", resetNudge)
    self._previewButtonOnLeave = resetNudge

    -- Wire click: find the top journal window (has _selectedSourceKey) and tell it to show empty state preview
    self:SetScript("OnClick", function(btn)
        local f = btn:GetParent()
        while f do
            if f._selectedSourceKey ~= nil and MetaAchievementMainFrameMgr and type(MetaAchievementMainFrameMgr.ShowEmptyStatePreview) == "function" then
                MetaAchievementMainFrameMgr:ShowEmptyStatePreview(f)
                return
            end
            f = f:GetParent()
        end
    end)

    MetaAchievementPreviewButton_SetTooltip(self, "Preview achievement")
end

local function setIconVertexColor(button, r, g, b)
    local icon = button.Icon or (button and _G[button:GetName() .. "Icon"])
    if icon and icon.SetVertexColor then
        icon:SetVertexColor(r, g, b)
    end
end

--- Set optional hover tooltip text. Call after the button is created to override default.
--- @param button frame The preview button frame
--- @param text string|nil Tooltip text; nil to use default "Preview achievement"
function MetaAchievementPreviewButton_SetTooltip(button, text)
    if not button then return end
    local tip = (text and text ~= "") and text or "Preview achievement"
    local baseOnLeave = button._previewButtonOnLeave or button:GetScript("OnLeave")
    button:SetScript("OnEnter", function()
        setIconVertexColor(button, ICON_COLOR_HOVER[1], ICON_COLOR_HOVER[2], ICON_COLOR_HOVER[3])
        GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
        GameTooltip:SetText(tip, nil, nil, nil, nil, true)
        GameTooltip:Show()
    end)
    button:SetScript("OnLeave", function()
        setIconVertexColor(button, ICON_COLOR_NORMAL[1], ICON_COLOR_NORMAL[2], ICON_COLOR_NORMAL[3])
        if baseOnLeave then baseOnLeave() end
        GameTooltip:Hide()
    end)
end
