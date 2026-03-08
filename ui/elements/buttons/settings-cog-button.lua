-- Settings cog button: inherits UIPanelCloseButton (same as frame's red X) so we get Blizzard's border/background; show cog instead of X.

function MetaAchievementSettingsCogButton_OnLoad(self)
    -- Cog on top (OVERLAY) so it draws over the template's X; hide X layer if template has a separate one
    MetaAchievement_SetupCogIcon(self, 4)
    MetaAchievement_SetupCogButtonFromCloseTemplate(self)
end

function MetaAchievementSettingsCogButton_SetTooltip(button, text)
    MetaAchievement_CogButtonSetTooltip(button, text)
end
