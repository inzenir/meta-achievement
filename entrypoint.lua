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

if TomTom then
    MetaAchievementDB.mapIntegration:RegisterMapIntegration(MapIntegrationOptions.tomtom, TomTomMap:new())
    MetaAchievementDB.mapIntegration:SetActiveIntegration(MapIntegrationOptions.tomtom)
    mainFrame:RegisterOnEventHander(
        "PLAYER_ENTERING_WORLD",
        function()
            local integration = MetaAchievementDB.mapIntegration:GetIntegrationIfActive(MapIntegrationOptions.tomtom)
            if integration ~= nil then
                integration:OnTomTomLoaded()
            end
        end)
end

function EntryPoint()
    MetaAchievementDB.mapIntegration:OnLoaded()

    local settingsFrame = SettingsFrame:new(mainFrame:getFrame())
    MetaAchievementDB.achievementLists.worldSoulSearching.treeView = TreeView:new(mainFrame:getFrame(), MetaAchievementDB.achievementLists.worldSoulSearching.data, "Worldsoul Searching")
    MetaAchievementDB.achievementLists.worldSoulSearching.treeView:draw()

    mainFrame:addScrollChild(WindowTabs.worldSoulSearching, MetaAchievementDB.achievementLists.worldSoulSearching.treeView)
    mainFrame:addScrollChild(WindowTabs.settings, settingsFrame)

    mainFrame:drawScrollContent(WindowTabs.worldSoulSearching)


end


