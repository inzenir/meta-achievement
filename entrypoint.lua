MetaAchievementConfigurationDB = MetaAchievementConfigurationDB or DefaultSettings()

MetaAchievementDB = {
    mapIntegration = nil,
    achievementLists = {}
}

-- Keybind and primaryWindow call this; must exist as soon as addon is loaded.
function MetaAchievement_ToggleWindowVisibility()
    if MetaAchievementWindowCoordinator and type(MetaAchievementWindowCoordinator.TogglePrimaryWindow) == "function" then
        MetaAchievementWindowCoordinator.TogglePrimaryWindow()
    end
end

-- Primary window: keybind and minimap use coordinator (same rules as controller paths).
MetaAchievementDB.primaryWindow = {
    toggleVisibility = function()
        MetaAchievement_ToggleWindowVisibility()
    end,
    showWindow = function()
        if MetaAchievementWindowCoordinator and type(MetaAchievementWindowCoordinator.ShowMainHideMini) == "function" then
            MetaAchievementWindowCoordinator.ShowMainHideMini()
        end
    end,
    hideWindow = function()
        if MetaAchievementWindowCoordinator and type(MetaAchievementWindowCoordinator.HideMainPanel) == "function" then
            MetaAchievementWindowCoordinator.HideMainPanel()
        end
    end,
}

WindowTabs = {
    lightUpTheNight = "lightUpTheNight",
    gloryOfTheMidnightDelver = "gloryOfTheMidnightDelver",
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
                print((MetaAchievementTitle or "Meta Achievement Tracker") .. ": Mini frame not loaded yet.")
            end
        end,
        "Show the mini (compact) window")


    -- Settings



    AchievementData:RegisterDataSource(61451, WorldSoulSearchingWaypoints)
    AchievementData:RegisterDataSource(62386, LightUpTheNightWaypoints)
    AchievementData:RegisterDataSource(61906, GloryOfTheMidnightDelverWaypoints)
    AchievementData:RegisterDataSource(19458, AWorldAwokenWaypoints)
    AchievementData:RegisterDataSource(40953, AFarewellToArmsWaypoints)
    AchievementData:RegisterDataSource(20501, BackFromTheBeyondWaypoints)
    AchievementData:RegisterDataSource(2144, WhatALongStrangeTripItsBeenWaypoints)

    -- Register existing achievement lists as dropdown data sources for the journal+map UI
    if MetaAchievementMainFrameMgr and type(MetaAchievementMainFrameMgr.RegisterDataSource) == "function" then
        local function registerJournalSource(key, displayName, achievementList)
            local data = DataList:new(achievementList)
            if DataList.RegisterForSourceKey then
                DataList.RegisterForSourceKey(key, data)
            end

            MetaAchievementMainFrameMgr:RegisterDataSource(key, displayName, {
                topAchievementId = data.topAchievementId,
                topAchievementMountId = (achievementList[1] and achievementList[1].mountId) or nil,
                -- Rescanning the tree calls GetAchievementInfo for every node (expensive). Only rescan when the
                -- tree is dirty (collapse change, or ACHIEVEMENT_EARNED); switching meta tabs reuses cached trees.
                GetList = function()
                    if data._treeDirty then
                        data:rescanData()
                    end
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
                    -- Match main-frame.lua: resolve id when list node is missing (defer may run before state sync).
                    -- Returning true with no detail used to skip the default path (rendered ~= nil) and left center empty.
                    local id = node and node.id or nil
                    if not id then
                        local st = ActiveAchievementState and ActiveAchievementState:GetInstance()
                        if st and type(st.GetActiveAchievementId) == "function" then
                            id = st:GetActiveAchievementId()
                        end
                    end
                    if not id and journalFrame and journalFrame._modelItems and journalFrame._selectedIndex then
                        local row = journalFrame._modelItems[journalFrame._selectedIndex]
                        id = row and row.id
                    end
                    if not id then
                        return nil
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
        registerJournalSource(WindowTabs.gloryOfTheMidnightDelver, "Glory of the Midnight Delver", GloryOfTheMidnightDelverAchievements)
        registerJournalSource(WindowTabs.worldSoulSearching, "Worldsoul Searching", WorldSoulSearchingAchievements)
        registerJournalSource(WindowTabs.aWorldAwoken, "A World Awoken", AWorldAwokenAchievements)
        registerJournalSource(WindowTabs.backFromTheBeyond, "Back From The Beyond", BackFromTheBeyondAchievements)
        registerJournalSource(WindowTabs.farewellToArms, "A Farewell To Arms", AFarewellToArmsAchievements)
        registerJournalSource(WindowTabs.whatALongStrangeTripItsBeen, "What a Long, Strange Trip It's Been", WhatALongStrangeTripItsBeenAchievements)

        -- Achievement progress: ACHIEVEMENT_EARNED = full completion; CRITERIA_UPDATE = partial/meta criteria (no payload).
        -- Mini frame previously only invalidated cache when main was hidden â€” it must rebuild list + detail from live APIs.
        do
            local function refreshJournalAfterAchievementProgress()
                if DataList.MarkAllTreesDirty then
                    DataList.MarkAllTreesDirty()
                end
                local main = MetaAchievementMainFrameMgr and MetaAchievementMainFrameMgr.frame
                if main and main:IsShown() and type(MetaAchievementMainFrameMgr.RefreshList) == "function" then
                    MetaAchievementMainFrameMgr:RefreshList(main)
                    return
                end
                local state = ActiveAchievementState and ActiveAchievementState.GetInstance and ActiveAchievementState:GetInstance()
                if state and type(state.InvalidateList) == "function" then
                    state:InvalidateList()
                end
                local mini = _G.MetaAchievementMiniFrame
                if mini and mini:IsShown() and type(MetaAchievementMiniFrame_RefreshContent) == "function" then
                    MetaAchievementMiniFrame_RefreshContent()
                end
            end

            -- CRITERIA_UPDATE can fire many times in a burst (login, combat); coalesce to one refresh.
            local criteriaRefreshCoalesce = 0
            local function scheduleCriteriaRefresh()
                criteriaRefreshCoalesce = criteriaRefreshCoalesce + 1
                local token = criteriaRefreshCoalesce
                C_Timer.After(0.2, function()
                    if token ~= criteriaRefreshCoalesce then
                        return
                    end
                    refreshJournalAfterAchievementProgress()
                    -- Drop completed-criteria pins from storage + re-sync TomTom/native (filter uses criteriaId tags).
                    if MapIntegrationBase and type(MapIntegrationBase.GetInstance) == "function" then
                        local mib = MapIntegrationBase.GetInstance()
                        if mib and type(mib.PruneCompletedWaypointsAndNotify) == "function" then
                            mib:PruneCompletedWaypointsAndNotify()
                        end
                    end
                end)
            end

            local progressFrame = CreateFrame("Frame")
            progressFrame:RegisterEvent("ACHIEVEMENT_EARNED")
            progressFrame:RegisterEvent("CRITERIA_UPDATE")
            pcall(function()
                progressFrame:RegisterEvent("TRACKED_ACHIEVEMENT_UPDATE")
            end)
            progressFrame:SetScript("OnEvent", function(_, event, ...)
                if event == "CRITERIA_UPDATE" or event == "TRACKED_ACHIEVEMENT_UPDATE" then
                    scheduleCriteriaRefresh()
                elseif event == "ACHIEVEMENT_EARNED" then
                    local achievementId = select(1, ...)
                    if MapIntegrationBase and type(MapIntegrationBase.NotifyAchievementEarned) == "function" then
                        MapIntegrationBase.NotifyAchievementEarned(achievementId)
                    end
                    refreshJournalAfterAchievementProgress()
                end
            end)
        end

        -- Restore active source/achievement from saved settings
        if ActiveAchievementState and type(ActiveAchievementState.GetInstance) == "function" then
            local state = ActiveAchievementState:GetInstance()
            if type(state.LoadFromSettings) == "function" then
                state:LoadFromSettings()
            end
        end

        -- Restore last open window (mini or main) from saved hidden option.
        if MetaAchievementWindowCoordinator and type(MetaAchievementWindowCoordinator.RestoreStartupWindowFromSettings) == "function" then
            MetaAchievementWindowCoordinator.RestoreStartupWindowFromSettings()
        end

        if RegisterMetaAchievementOptionsPanel then
            RegisterMetaAchievementOptionsPanel()
        end
    end

    -- World quest + quest-line activity scans (DEV-023); coalesced like CRITERIA_UPDATE.
    do
        local activityCoalesce = 0
        local loginWarmupToken = 0
        local LOGIN_WARMUP_DELAYS_SEC = { 1.5, 4, 8, 15 }
        local function runActivityScans()
            if MetaAchievementDelveStoryAvailability and type(MetaAchievementDelveStoryAvailability.TryRefresh) == "function" then
                MetaAchievementDelveStoryAvailability.TryRefresh(false)
            end
            if MetaAchievementWorldQuestScan_TryRefresh then
                MetaAchievementWorldQuestScan_TryRefresh()
            end
            if MetaAchievementQuestLineScan_TryRefresh then
                MetaAchievementQuestLineScan_TryRefresh()
            end
            if MetaAchievementDelveStoryNotify_TryRefresh then
                MetaAchievementDelveStoryNotify_TryRefresh()
            end
        end
        local function scheduleActivityScan()
            activityCoalesce = activityCoalesce + 1
            local token = activityCoalesce
            C_Timer.After(0.35, function()
                if token ~= activityCoalesce then
                    return
                end
                runActivityScans()
            end)
        end
        local af = CreateFrame("Frame")
        af:RegisterEvent("QUEST_LOG_UPDATE")
        -- WORLD_MAP_UPDATE is not a valid Frame event on Retail 12.x (registration errors).
        af:RegisterEvent("QUESTLINE_UPDATE")
        af:RegisterEvent("ZONE_CHANGED")
        af:RegisterEvent("ZONE_CHANGED_NEW_AREA")
        af:RegisterEvent("PLAYER_ENTERING_WORLD")
        af:SetScript("OnEvent", function(_, event)
            scheduleActivityScan()
            if event == "PLAYER_ENTERING_WORLD" then
                -- Delve POI/widget text can be empty for several seconds after login/reload.
                -- Run forced warmup passes so story notifications can fire at login.
                loginWarmupToken = loginWarmupToken + 1
                local token = loginWarmupToken
                for _, delaySec in ipairs(LOGIN_WARMUP_DELAYS_SEC) do
                    C_Timer.After(delaySec, function()
                        if token ~= loginWarmupToken then
                            return
                        end
                        if MetaAchievementDelveStoryAvailability and type(MetaAchievementDelveStoryAvailability.TryRefresh) == "function" then
                            MetaAchievementDelveStoryAvailability.TryRefresh(true)
                        end
                        if MetaAchievementQuestLineScan_TryRefresh then
                            MetaAchievementQuestLineScan_TryRefresh()
                        end
                        if MetaAchievementDelveStoryNotify_TryRefresh then
                            MetaAchievementDelveStoryNotify_TryRefresh()
                        end
                    end)
                end
            end
        end)
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
