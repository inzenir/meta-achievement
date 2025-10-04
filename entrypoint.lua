MetaAchievementConfigurationDB = MetaAchievementConfigurationDB or DefaultSettings()

MetaAchievementDB = {
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

function EntryPoint()
    local settingsFrame = SettingsFrame:new(mainFrame:getFrame())
    MetaAchievementDB.achievementLists.worldSoulSearching.treeView = TreeView:new(mainFrame:getFrame(), MetaAchievementDB.achievementLists.worldSoulSearching.data, "Worldsoul Searching")
    MetaAchievementDB.achievementLists.worldSoulSearching.treeView:draw()

    mainFrame:addScrollChild(WindowTabs.worldSoulSearching, MetaAchievementDB.achievementLists.worldSoulSearching.treeView)
    mainFrame:addScrollChild(WindowTabs.settings, settingsFrame)

    mainFrame:drawScrollContent(WindowTabs.worldSoulSearching)
end


