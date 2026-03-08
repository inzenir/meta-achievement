-- Silver three-part cog button: uses three-part-button-helper + cog-button-helper.

function MetaAchievementSilverCogButton_OnLoad(self)
    -- Three-part silver panel look (left cap, stretch center, right cap)
    MetaAchievement_SetupSilverThreePartButton(self, 24)
    MetaAchievement_SetupCogIcon(self, 6)
end

function MetaAchievementSilverCogButton_SetTooltip(button, text)
    MetaAchievement_CogButtonSetTooltip(button, text)
end
