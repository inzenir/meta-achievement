-- Waypoint button template: map-pin icon, yellow diamond highlight, nudge-on-press.
-- Use inherits="MetaAchievementWaypointButtonTemplate" and set Anchors on the instance.

function MetaAchievementWaypointButton_OnLoad(self)
    local icon = _G[self:GetName() .. "Icon"]
    local highlight = self.GetHighlightTexture and self:GetHighlightTexture()
    if not icon then return end

    local nudge = 1
    local function nudgeDown()
        if icon and icon.ClearAllPoints and icon.SetPoint then
            icon:ClearAllPoints()
            icon:SetPoint("TOPLEFT", self, "TOPLEFT", nudge, -nudge)
            icon:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", nudge, -nudge)
        end
        if highlight and highlight.ClearAllPoints and highlight.SetPoint then
            highlight:ClearAllPoints()
            highlight:SetPoint("TOPLEFT", self, "TOPLEFT", nudge, -nudge)
            highlight:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", nudge, -nudge)
        end
    end

    local function resetNudge()
        if icon and icon.ClearAllPoints and icon.SetPoint then
            icon:ClearAllPoints()
            icon:SetPoint("TOPLEFT", self, "TOPLEFT")
            icon:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT")
        end
        if highlight and highlight.ClearAllPoints and highlight.SetPoint then
            highlight:ClearAllPoints()
            highlight:SetPoint("TOPLEFT", self, "TOPLEFT")
            highlight:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT")
        end
    end

    self:SetScript("OnMouseDown", nudgeDown)
    self:SetScript("OnMouseUp", resetNudge)
    self:SetScript("OnLeave", resetNudge)
    self._waypointButtonOnLeave = resetNudge
end

--- Set optional hover tooltip text. Call after the button is created.
--- @param button frame The waypoint button frame
--- @param text string|nil Tooltip text; nil to remove tooltip
function MetaAchievementWaypointButton_SetTooltip(button, text)
    if not button then return end
    if not text or text == "" then
        button:SetScript("OnEnter", nil)
        button:SetScript("OnLeave", button._waypointButtonOnLeave)
        return
    end
    local baseOnLeave = button._waypointButtonOnLeave or button:GetScript("OnLeave")
    button:SetScript("OnEnter", function()
        GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
        GameTooltip:SetText(text, nil, nil, nil, nil, true)
        GameTooltip:Show()
    end)
    button:SetScript("OnLeave", function()
        if baseOnLeave then baseOnLeave() end
        GameTooltip:Hide()
    end)
end
