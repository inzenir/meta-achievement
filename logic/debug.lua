--[[
    Optional dev logging. Nothing references this yet; TOC expects the file to exist.
    Use MetaAchievementDebug:Print(...) when enabled, or enable via saved flag later.
]]

MetaAchievementDebug = MetaAchievementDebug or {}

function MetaAchievementDebug:IsEnabled()
    return false
end

function MetaAchievementDebug:Print(...)
    if not self:IsEnabled() then
        return
    end
    print("|cff888888[Worldsoul Searching]|r", ...)
end
