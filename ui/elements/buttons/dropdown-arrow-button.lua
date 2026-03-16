-- Dropdown arrow button template: sets arrow and highlight texture rotation (45°).
function MetaAchievementDropdownArrowButton_OnLoad(self)
    local arrow = self.Arrow or _G[self:GetName() .. "Arrow"]
    if arrow and arrow.SetRotation then
        arrow:SetRotation(math.rad(45))
    end
    local highlight = self.Highlight or _G[self:GetName() .. "Highlight"]
    if highlight and highlight.SetRotation then
        highlight:SetRotation(math.rad(45))
    end
end
