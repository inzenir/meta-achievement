-- Settings cog button: icon defined in XML. OnLoad only if we need other setup later.
function MetaAchievementSettingsCogButton_OnLoad(self)
    -- Icon is in XML; no texture setup in Lua.
end

function MetaAchievementSettingsCogButton_SetTooltip(button, text)
    MetaAchievement_CogButtonSetTooltip(button, text)
end
