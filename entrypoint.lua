MetaAchievementConfigurationDB = MetaAchievementConfigurationDB or DefaultSettings()
MetaAchievementTitle = "Meta Achievement Tracker"

MetaAchievementDB = {
    mapIntegration = nil,
    achievementLists = {}
}

-- Primary window: the one toggled by keybinding, slash, and minimap. Always set so bindings work; delegates to journal-map when loaded.
MetaAchievementDB.primaryWindow = {
    toggleVisibility = function()
        if MetaAchievementJournalMap and type(MetaAchievementJournalMap.Toggle) == "function" then
            MetaAchievementJournalMap:Toggle()
        end
    end,
    showWindow = function()
        if MetaAchievementJournalMap and type(MetaAchievementJournalMap.ShowPanel) == "function" then
            MetaAchievementJournalMap:ShowPanel()
        end
    end,
    hideWindow = function()
        if MetaAchievementJournalMap and type(MetaAchievementJournalMap.HidePanel) == "function" then
            MetaAchievementJournalMap:HidePanel()
        end
    end,
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

MetaAchievementDB.mainFrame = nil

function EntryPoint()
    SLASH_WORLDSOULSEARCHING1 = "/wss"
    SlashCmdList["WORLDSOULSEARCHING"] = LoadSlashCommands

    -- Init map integration after SavedVariables are loaded so Get("mapIntegration") sees persisted data.
    MapIntegrationBase.Init(MetaAchievementDB)

    local function primaryOrMain()
        return MetaAchievementDB.primaryWindow
    end

    RegisterSlashCommand("show",
        function()
            primaryOrMain():showWindow()
        end,
        "Show addon window")

    RegisterSlashCommand("hide",
        function()
            primaryOrMain():hideWindow()
        end,
        "Hide addon window")

    RegisterSlashCommand("reset",
        function()
            -- Window position reset removed with legacy main frame; use journal UI.
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



    AchievementData:RegisterDataSource(61451, WorldSoulSearchingWaypoints)
    AchievementData:RegisterDataSource(62386, LightUpTheNightWaypoints)
    AchievementData:RegisterDataSource(19458, AWorldAwokenWaypoints)
    AchievementData:RegisterDataSource(40953, AFarewellToArmsWaypoints)
    AchievementData:RegisterDataSource(20501, BackFromTheBeyondWaypoints)
    AchievementData:RegisterDataSource(2144, WhatALongStrangeTripItsBeenWaypoints)

    -- Register existing achievement lists as dropdown data sources for the journal+map UI
    if MetaAchievementJournalMap and type(MetaAchievementJournalMap.RegisterDataSource) == "function" then
        local function registerJournalSource(key, displayName, achievementList)
            local data = DataList:new(achievementList)

            MetaAchievementJournalMap:RegisterDataSource(key, displayName, {
                topAchievementId = data.topAchievementId,
                topAchievementMountId = (achievementList[1] and achievementList[1].mountId) or nil,
                GetList = function()
                    data:rescanData()
                    return data:getFlatData()
                end,
                ToggleCollapsed = function(_, itemId)
                    data:toggleColapsed(itemId)
                end,
                OnItemSelected = function(_, item)
                    -- Intentionally no-op: selecting in our journal should not open Blizzard's Achievement UI.
                    -- (The right pane uses map-detail to show the info.)
                end,
                RenderMap = function(_, journalFrame, _, content, node)
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
                    detail.journalFrame = journalFrame
                    if journalFrame then
                        journalFrame._currentMapDetail = detail
                    end

                    detail:ClearAllPoints()
                    -- The content frame already has padding; don't add another large inset here.
                    detail:SetPoint("TOPLEFT", content, "TOPLEFT", 0, 0)
                    detail:SetPoint("BOTTOMRIGHT", content, "BOTTOMRIGHT", 0, 0)
                    detail:Show()

                    if type(MetaAchievementMapDetail_SetFromAchievementId) == "function" then
                        MetaAchievementMapDetail_SetFromAchievementId(detail, id, node, data.topAchievementId)
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

        if RegisterMetaAchievementOptionsPanel then
            RegisterMetaAchievementOptionsPanel()
        end
    end
end

-- Run EntryPoint when this addon loads (data sources, slash commands, journal registration).
local ADDON_NAME = "Worldsoul_Searching"
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(_, event, name)
    if event == "ADDON_LOADED" and name == ADDON_NAME then
        frame:UnregisterEvent("ADDON_LOADED")
        EntryPoint()
    end
end)
