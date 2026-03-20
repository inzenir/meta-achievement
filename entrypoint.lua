MetaAchievementConfigurationDB = MetaAchievementConfigurationDB or DefaultSettings()
MetaAchievementTitle = "Meta Achievement Tracker"

MetaAchievementDB = {
    mapIntegration = nil,
    achievementLists = {}
}

-- Keybind and primaryWindow call this; must exist as soon as addon is loaded.
-- If mini is visible, use mini toggle (hide it) then show main. Otherwise use main frame toggle.
function MetaAchievement_ToggleWindowVisibility()
    if MetaAchievementSettings and MetaAchievementSettings:Get("lastOpenWindow") == "mini" then
        if type(MetaAchievementMiniFrame_ToggleVisibility) == "function" then
            MetaAchievementMiniFrame_ToggleVisibility()
        end
    else
        if MetaAchievementMainFrameMgr and type(MetaAchievementMainFrameMgr.Toggle) == "function" then
            MetaAchievementMainFrameMgr:Toggle()
        end
    end
end

-- Primary window: keybind and minimap call the helper above.
MetaAchievementDB.primaryWindow = {
    toggleVisibility = function()
        MetaAchievement_ToggleWindowVisibility()
    end,
    showWindow = function()
        if MetaAchievementMainFrameMgr and type(MetaAchievementMainFrameMgr.ShowPanel) == "function" then
            MetaAchievementMainFrameMgr:ShowPanel()
        end
    end,
    hideWindow = function()
        if MetaAchievementMainFrameMgr and type(MetaAchievementMainFrameMgr.HidePanel) == "function" then
            MetaAchievementMainFrameMgr:HidePanel()
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
            MetaAchievement_ToggleWindowVisibility()
        end,
        "Toggle retail-style journal + map UI")

    RegisterSlashCommand("mini",
        function()
            if type(MetaAchievementMiniFrame_Show) == "function" then
                MetaAchievementMiniFrame_Show()
            else
                print("Worldsoul Searching: Mini frame not loaded yet.")
            end
        end,
        "Show the mini (compact) window")


    -- Settings



    AchievementData:RegisterDataSource(61451, WorldSoulSearchingWaypoints)
    AchievementData:RegisterDataSource(62386, LightUpTheNightWaypoints)
    AchievementData:RegisterDataSource(19458, AWorldAwokenWaypoints)
    AchievementData:RegisterDataSource(40953, AFarewellToArmsWaypoints)
    AchievementData:RegisterDataSource(20501, BackFromTheBeyondWaypoints)
    AchievementData:RegisterDataSource(2144, WhatALongStrangeTripItsBeenWaypoints)

    -- Register existing achievement lists as dropdown data sources for the journal+map UI
    if MetaAchievementMainFrameMgr and type(MetaAchievementMainFrameMgr.RegisterDataSource) == "function" then
        local function registerJournalSource(key, displayName, achievementList)
            local data = DataList:new(achievementList)

            MetaAchievementMainFrameMgr:RegisterDataSource(key, displayName, {
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

                    local detailName = "MetaAchievementMainFrameMapDetail"
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

        -- Restore active source/achievement from saved settings
        if ActiveAchievementState and type(ActiveAchievementState.GetInstance) == "function" then
            local state = ActiveAchievementState:GetInstance()
            if type(state.LoadFromSettings) == "function" then
                state:LoadFromSettings()
            end
        end

        -- Restore last open window (mini or main) from saved hidden option.
        local lastOpen = MetaAchievementSettings and MetaAchievementSettings:Get("lastOpenWindow") or "main"
        if lastOpen == "mini" and type(MetaAchievementMiniFrame_Show) == "function" then
            -- Ensure state has an active source when opening mini by default (e.g. no valid saved key).
            local state = ActiveAchievementState and ActiveAchievementState:GetInstance()
            if state and type(state.GetActiveSourceKey) == "function" and not state:GetActiveSourceKey() then
                local sources = state:GetRegisteredSources()
                if type(sources) == "table" and sources[1] and sources[1].key then
                    state:SetActiveSource(sources[1].key)
                end
            end
            if state and type(state.InvalidateList) == "function" then
                state:InvalidateList()
            end
            if MetaAchievementMainFrameMgr and type(MetaAchievementMainFrameMgr.HidePanel) == "function" then
                MetaAchievementMainFrameMgr:HidePanel()
            end
            -- Defer show to next frame so data/layout are ready (achievement APIs, etc.).
            C_Timer.After(0, function()
                if type(MetaAchievementMiniFrame_Show) == "function" then
                    MetaAchievementMiniFrame_Show()
                end
            end)
        else
            if MetaAchievementMainFrameMgr and type(MetaAchievementMainFrameMgr.ShowPanel) == "function" then
                MetaAchievementMainFrameMgr:ShowPanel()
            end
        end

        if RegisterMetaAchievementOptionsPanel then
            RegisterMetaAchievementOptionsPanel()
        end
    end

    if type(MetaAchievement_RegisterMinimapButton) == "function" then
        MetaAchievement_RegisterMinimapButton()
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
