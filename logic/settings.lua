function DefaultSettings()
    return {
        hideCompleted = false,
        colouredHightlight = false,
        removeCompletedWaypoints = false,
        addWaypointsOnlyForUncompletedAchievementParts = true,
        mapIntegration = {},
        mainFrame = {
            closed = false,
            height = nil,
            width = nil,
            anchor = nil,
            x = nil,
            y = nil
        }
    }
end

function UpdateSettings()
    for key, value in pairs(DefaultSettings()) do
        if not MetaAchievementConfigurationDB[key] then
            MetaAchievementConfigurationDB[key] = value
        end
    end
end