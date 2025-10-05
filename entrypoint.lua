MetaAchievementConfigurationDB = MetaAchievementConfigurationDB or DefaultSettings()
MetaAchievementTitle = "Meta Achievement Tracker"

MetaAchievementDB = {
    mapIntegration = nil,
    achievementLists = {
        worldSoulSearching = {
            data = DataList:new(WorldSoulSearchingAchievements),
            treeView = {}
        }
    }
}

WindowTabs = {
    worldSoulSearching = "worldSoulSearching",
    settings = "settings"
}


local mainFrame = MainFrame:new()
MetaAchievementDB.mapIntegration = MapIntegrationBase:new()

function EntryPoint()
    print("entry point")
    if TomTom then
        MetaAchievementDB.mapIntegration:RegisterMapIntegration(MapIntegrationOptions.tomtom, TomTomMap:new())
        MetaAchievementDB.mapIntegration:SetActiveIntegration(MapIntegrationOptions.tomtom)
    end

    local settingsFrame = SettingsFrame:new(mainFrame:getFrame())
    MetaAchievementDB.achievementLists.worldSoulSearching.treeView = TreeView:new(mainFrame:getFrame(), MetaAchievementDB.achievementLists.worldSoulSearching.data, "Worldsoul Searching")
    MetaAchievementDB.achievementLists.worldSoulSearching.treeView:draw()

    mainFrame:addScrollChild(WindowTabs.worldSoulSearching, MetaAchievementDB.achievementLists.worldSoulSearching.treeView)
    mainFrame:addScrollChild(WindowTabs.settings, settingsFrame)

    mainFrame:drawScrollContent(WindowTabs.worldSoulSearching)


end


