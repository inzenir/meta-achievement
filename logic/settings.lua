function DefaultSettings()
    return {
        hideCompleted = false,
        colouredHightlight = false,
        removeCompletedWaypoints = true,
        addWaypointsOnlyForUncompletedAchievementParts = true,
        mapIntegration = {}
    }
end

function UpdateSettings()
    for key, value in pairs(DefaultSettings()) do
        if not MetaAchievementConfigurationDB[key] then
            MetaAchievementConfigurationDB[key] = value
        end
    end
end