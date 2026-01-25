MetaAchievementConfigurationDB = MetaAchievementConfigurationDB or DefaultSettings()
MetaAchievementTitle = "Meta Achievement Tracker"

MetaAchievementDB = {
    mapIntegration = nil,
    achievementLists = {}
}

WindowTabs = {
    lightUpTheNight = "lightUpTheNight",
    worldSoulSearching = "worldSoulSearching",
    settings = "settings",
    farewellToArms = "farewellToArms",
    backFromTheBeyond = "backFromTheBeyond",
    aWorldAwoken = "aWorldAwoken",
    whatALongStrangeTripItsBeen = "whatALongStrangeTripItsBeen"
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

local function createAchievementTab(name, tabName, icon, dataSource)
    MetaAchievementDB.achievementLists[tabName] = {
        data = DataList:new(dataSource),
        treeView = nil
    }

    MetaAchievementDB.achievementLists[tabName].treeView = TreeView:new(
        mainFrame:getFrame(),
        MetaAchievementDB.achievementLists[tabName].data,
        name
    )

    mainFrame:addScrollChild(tabName, MetaAchievementDB.achievementLists[tabName].treeView)
    mainFrame:AddAchievementTab(tabName, icon)
end

function EntryPoint()
    SLASH_WORLDSOULSEARCHING1 = "/wss"
    SlashCmdList["WORLDSOULSEARCHING"] = LoadSlashCommands

    MetaAchievementDB.mapIntegration:OnLoaded()

    local settingsFrame = SettingsFrame:new(mainFrame:getFrame())

    RegisterSlashCommand("show",
        function() 
            mainFrame:showWindow()
        end,
        "Show addon window")

    RegisterSlashCommand("hide",
        function()
            mainFrame:hideWindow()
        end,
        "Hide addon window")

    RegisterSlashCommand("reset",
        function() 
            mainFrame:resetFrame()
        end,
        "Reset window position")

    RegisterSlashCommand("journal",
        function()
            if MetaAchievementJournalMap and type(MetaAchievementJournalMap.Toggle) == "function" then
                MetaAchievementJournalMap:Toggle()
            end
        end,
        "Toggle retail-style journal + map UI")


    -- Settings
    mainFrame:addScrollChild(WindowTabs.settings, settingsFrame)

    createAchievementTab(
        "Light Up The Night",
        WindowTabs.lightUpTheNight,
        "Interface\\Icons\\inv_12_dualityphoenix_lightvoid_explosion",
        LightUpTheNightAchievements
    )

    createAchievementTab(
        "Worldsoul Searching",
        WindowTabs.worldSoulSearching,
        "Interface\\Icons\\achievement_zone_isleofdorn",
        WorldSoulSearchingAchievements
    )

    createAchievementTab(
        "A World Awoken",
        WindowTabs.aWorldAwoken, 
        "Interface\\Icons\\ability_evoker_furyoftheaspects",
        AWorldAwokenAchievements
    )

    createAchievementTab(
        "Back From The Beyond",
        WindowTabs.backFromTheBeyond, 
        "Interface\\Icons\\inv_torghast",
        BackFromTheBeyondAchievements
    )

    createAchievementTab(
        "A Farewell To Arms",
        WindowTabs.farewellToArms, 
        "Interface\\Icons\\Inv_radientazeriteheart",
        AFarewellToArmsAchievements
    )

    createAchievementTab(
        "What a Long, Strange Trip It's Been",
        WindowTabs.whatALongStrangeTripItsBeen,
        "Interface\\Icons\\achievement_bg_masterofallbgs",
        WhatALongStrangeTripItsBeenAchievements
    )

    -- Register existing achievement lists as dropdown data sources for the journal+map UI
    if MetaAchievementJournalMap and type(MetaAchievementJournalMap.RegisterDataSource) == "function" then
        local function registerJournalSource(key, displayName, achievementList)
            local data = DataList:new(achievementList)

            MetaAchievementJournalMap:RegisterDataSource(key, displayName, {
                GetList = function()
                    data:rescanData()
                    return data:getFlatData()
                end,
                OnItemSelected = function(_, item)
                    -- Intentionally no-op: selecting in our journal should not open Blizzard's Achievement UI.
                    -- (The right pane uses map-detail to show the info.)
                end,
                RenderMap = function(_, _, content, node)
                    local id = node and node.id or nil
                    if not id then
                        return true
                    end

                    local detailName = "MetaAchievementJournalMapDetail"
                    local detail = _G[detailName]
                    if not detail then
                        detail = CreateFrame("Frame", detailName, content, "MetaAchievementMapDetailTemplate")
                    else
                        detail:SetParent(content)
                    end

                    detail:ClearAllPoints()
                    -- The content frame already has padding; don't add another large inset here.
                    detail:SetPoint("TOPLEFT", content, "TOPLEFT", 0, 0)
                    detail:SetPoint("BOTTOMRIGHT", content, "BOTTOMRIGHT", 0, 0)
                    detail:Show()

                    if type(MetaAchievementMapDetail_SetFromAchievementId) == "function" then
                        MetaAchievementMapDetail_SetFromAchievementId(detail, id, node)
                    end

                    return true
                end
            })
        end

        registerJournalSource(WindowTabs.lightUpTheNight, "Light Up The Night", LightUpTheNightAchievements)
        registerJournalSource(WindowTabs.worldSoulSearching, "Worldsoul Searching", WorldSoulSearchingAchievements)
        registerJournalSource(WindowTabs.aWorldAwoken, "A World Awoken", AWorldAwokenAchievements)
        registerJournalSource(WindowTabs.backFromTheBeyond, "Back From The Beyond", BackFromTheBeyondAchievements)
        registerJournalSource(WindowTabs.farewellToArms, "A Farewell To Arms", AFarewellToArmsAchievements)
        registerJournalSource(WindowTabs.whatALongStrangeTripItsBeen, "What a Long, Strange Trip It's Been", WhatALongStrangeTripItsBeenAchievements)

        MetaAchievementJournalMap:Toggle()
    end

    -- Draw default
    mainFrame:drawScrollContent(WindowTabs.lightUpTheNight)
end
