-- Silver three-part cog button: uses three-part-button-helper + cog-button-helper.

function MetaAchievementSilverCogButton_OnLoad(self)
    -- Three-part silver panel look; size from XML (no height arg = don't override).
    MetaAchievement_SetupSilverThreePartButton(self)
    MetaAchievement_SetupCogIcon(self, 6)
end

function MetaAchievementSilverCogButton_SetTooltip(button, text)
    MetaAchievement_CogButtonSetTooltip(button, text)
end
