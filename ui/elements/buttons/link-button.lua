-- Link button template: dark chain icon, brighter chain on highlight.

function MetaAchievementLinkButton_OnLoad(self)
    local icon = _G[self:GetName() .. "Icon"]
    if icon then
        icon:SetVertexColor(0.45, 0.45, 0.5)
    end
    local highlight = self.GetHighlightTexture and self:GetHighlightTexture()
    if highlight then
        highlight:SetVertexColor(1, 1, 1)
    end
end

function MetaAchievementLinkButton_SetTooltip(button, text)
    if not button then return end
    if not text or text == "" then
        button:SetScript("OnEnter", nil)
        button:SetScript("OnLeave", nil)
        return
    end
    button:SetScript("OnEnter", function()
        GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
        GameTooltip:SetText(text, nil, nil, nil, nil, true)
        GameTooltip:Show()
    end)
    button:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
end
