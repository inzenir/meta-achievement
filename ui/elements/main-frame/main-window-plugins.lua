--[[
  Bottom tab bar on the main journal window. On Mainline uses Blizzard TabSystem
  (TabSystemOwnerMixin + TabSystemTemplate), matching PlayerSpells / Professions / Bank.
  Falls back to PanelTemplates tabs when TabSystem is unavailable.
]]

MetaAchievementMainWindowPlugins = MetaAchievementMainWindowPlugins or {}

local JOURNAL_TAB_ID = "__journal__"
local CONTENT_TOP = -60
local CONTENT_BOTTOM_INSET = 25

local frameRef = nil

local function canUseTabSystem()
    return TabSystemOwnerMixin ~= nil and TabSystemMixin ~= nil
end

local function getPluginSpec(tabId)
    if tabId == JOURNAL_TAB_ID then
        return nil
    end
    if MetaAchievementPlugins and type(MetaAchievementPlugins.Get) == "function" then
        return MetaAchievementPlugins.Get(tabId)
    end
    return nil
end

local function applyPluginContentInsets(frame)
    if not frame or not frame.PluginContentHost then
        return
    end
    local bottom = frame._contentBottomInset or CONTENT_BOTTOM_INSET
    frame.PluginContentHost:ClearAllPoints()
    frame.PluginContentHost:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, CONTENT_TOP)
    frame.PluginContentHost:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -6, bottom)
end

local function setJournalWidgetsVisible(frame, visible)
    if not frame then
        return
    end
    frame._journalTabActive = visible
    if not visible then
        if frame.Breadcrumbs then
            frame.Breadcrumbs:Hide()
        end
        if frame.JournalList then
            frame.JournalList:Hide()
        end
        if frame.EmptyStatePanel then
            frame.EmptyStatePanel:Hide()
        end
        if frame.MapInset then
            frame.MapInset:Hide()
        end
        return
    end
    if frame.Breadcrumbs then
        frame.Breadcrumbs:Show()
    end
    if MetaAchievementMainFrameMgr and type(MetaAchievementMainFrameMgr.UpdateListVisibility) == "function" then
        MetaAchievementMainFrameMgr:UpdateListVisibility(frame)
    end
end

local function activateJournalTab(frame)
    frame._activeMainTabId = JOURNAL_TAB_ID
    if frame.PluginContentHost then
        frame.PluginContentHost:Hide()
    end
    setJournalWidgetsVisible(frame, true)
    if MetaAchievementMainFrameMgr and type(MetaAchievementMainFrameMgr.RefreshBreadcrumbs) == "function" then
        MetaAchievementMainFrameMgr:RefreshBreadcrumbs(frame)
    end
end

local function activatePluginTab(frame, pluginId)
    frame._activeMainTabId = pluginId
    setJournalWidgetsVisible(frame, false)
    if frame.PluginContentHost then
        frame.PluginContentHost:Show()
    end
    local spec = getPluginSpec(pluginId)
    if spec and type(spec.onShow) == "function" then
        pcall(spec.onShow, frame, frame.PluginContentHost)
    end
end

local function hideActivePluginTab(frame)
    if not frame or frame._activeMainTabId == JOURNAL_TAB_ID then
        return
    end
    local spec = getPluginSpec(frame._activeMainTabId)
    if spec and type(spec.onHide) == "function" then
        pcall(spec.onHide, frame, frame.PluginContentHost)
    end
end

-- ---------------------------------------------------------------------------
-- TabSystem (Mainline): same pattern as PlayerSpellsFrame / BankFrame
-- ---------------------------------------------------------------------------

local function initTabSystemOwner(frame)
    if frame._tabSystemOwnerReady then
        return
    end
    if Mixin and TabSystemOwnerMixin then
        Mixin(frame, TabSystemOwnerMixin)
    end
    TabSystemOwnerMixin.OnLoad(frame)
    frame._tabSystemOwnerReady = true
end

local function destroyTabSystemWidget(frame)
    if frame.TabSystem then
        frame.TabSystem:Hide()
        frame.TabSystem:SetParent(nil)
        frame.TabSystem = nil
    end
    frame._journalTabID = nil
    frame._pluginTabIdByKey = nil
end

local function createTabSystemWidget(frame)
    local tabSystem = CreateFrame("Frame", frame:GetName() .. "TabSystem", frame, "TabSystemTemplate")
    tabSystem:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 22, 2)
    tabSystem.minTabWidth = 72
    tabSystem.maxTabWidth = 120
    return tabSystem
end

local function rebuildTabSystem(frame)
    initTabSystemOwner(frame)
    destroyTabSystemWidget(frame)
    TabSystemOwnerMixin.OnLoad(frame)

    local hasPlugins = MetaAchievementPlugins
        and type(MetaAchievementPlugins.HasPlugins) == "function"
        and MetaAchievementPlugins.HasPlugins()

    frame._contentBottomInset = CONTENT_BOTTOM_INSET
    applyPluginContentInsets(frame)

    if not hasPlugins then
        activateJournalTab(frame)
        return
    end

    frame.TabSystem = createTabSystemWidget(frame)
    frame:SetTabSystem(frame.TabSystem)
    frame.TabSystem:Show()

    frame._pluginTabIdByKey = {}

    frame._journalTabID = frame:AddNamedTab("Journal")
    frame:SetTabCallback(frame._journalTabID, function()
        activateJournalTab(frame)
    end)
    frame:SetTabDeselectCallback(frame._journalTabID, function()
        setJournalWidgetsVisible(frame, false)
    end)

    local pluginIds = MetaAchievementPlugins.GetOrderedIds()
    for i = 1, #pluginIds do
        local pluginId = pluginIds[i]
        local spec = MetaAchievementPlugins.Get(pluginId)
        local title = (spec and spec.title) or pluginId
        local tabID = frame:AddNamedTab(title, frame.PluginContentHost)
        frame._pluginTabIdByKey[pluginId] = tabID
        frame:SetTabCallback(tabID, function()
            activatePluginTab(frame, pluginId)
        end)
        frame:SetTabDeselectCallback(tabID, function()
            local pluginSpec = getPluginSpec(pluginId)
            if pluginSpec and type(pluginSpec.onHide) == "function" then
                pcall(pluginSpec.onHide, frame, frame.PluginContentHost)
            end
        end)
    end

    local active = frame._activeMainTabId or JOURNAL_TAB_ID
    if active ~= JOURNAL_TAB_ID and not frame._pluginTabIdByKey[active] then
        active = JOURNAL_TAB_ID
    end

    local tabToSelect = frame._journalTabID
    if active ~= JOURNAL_TAB_ID then
        tabToSelect = frame._pluginTabIdByKey[active]
    end

    if tabToSelect then
        frame:SetTab(tabToSelect, false)
    end
end

local function selectTabSystemTab(frame, tabId)
    if not frame._journalTabID then
        if tabId == JOURNAL_TAB_ID then
            activateJournalTab(frame)
        end
        return
    end
    if tabId == JOURNAL_TAB_ID then
        frame:SetTab(frame._journalTabID, false)
    elseif frame._pluginTabIdByKey and frame._pluginTabIdByKey[tabId] then
        frame:SetTab(frame._pluginTabIdByKey[tabId], false)
    end
end

-- ---------------------------------------------------------------------------
-- Legacy PanelTemplates fallback (Classic / no TabSystem)
-- ---------------------------------------------------------------------------

local LEGACY_TAB_TEMPLATE_CANDIDATES = {
    { name = "PanelTabButtonTemplate", firstAnchor = { x = 19, y = -30 }, usePanelAnchor = true },
    { name = "CharacterFrameTabButtonTemplate", firstAnchor = { x = 19, y = 3 }, chain = { point = "LEFT", relativePoint = "RIGHT", x = -16, y = 0 } },
}

local resolvedLegacyTemplate = nil
local legacyCustomTabs = {}

local function safePanelTemplatesCall(fn, ...)
    if type(fn) ~= "function" then
        return false
    end
    return pcall(fn, ...)
end

local function resolveLegacyTemplate()
    if resolvedLegacyTemplate ~= nil then
        return resolvedLegacyTemplate
    end
    for _, entry in ipairs(LEGACY_TAB_TEMPLATE_CANDIDATES) do
        local ok, probe = pcall(CreateFrame, "Button", nil, UIParent, entry.name)
        if ok and probe then
            probe:Hide()
            probe:SetParent(nil)
            resolvedLegacyTemplate = entry
            return entry
        end
    end
    resolvedLegacyTemplate = false
    return false
end

local function clearLegacyTabs(frame)
    local i = 1
    while true do
        local tab = _G[frame:GetName() .. "Tab" .. i]
        if not tab then
            break
        end
        tab:Hide()
        tab:SetParent(nil)
        i = i + 1
    end
    frame.numTabs = nil
    frame.selectedTab = nil
    legacyCustomTabs = {}
end

local function createLegacyTab(frame, tabIndex, label, onClick)
    local entry = resolveLegacyTemplate()
    if not entry then
        return nil
    end
    local tabName = frame:GetName() .. "Tab" .. tabIndex
    local btn = CreateFrame("Button", tabName, frame, entry.name)
    btn:SetID(tabIndex)
    btn:SetText(label or "")
    if tabIndex == 1 or entry.usePanelAnchor then
        local anchor = entry.firstAnchor
        btn:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", anchor.x, anchor.y)
    elseif entry.chain then
        local prev = _G[frame:GetName() .. "Tab" .. (tabIndex - 1)]
        local chain = entry.chain
        if prev then
            btn:SetPoint(chain.point, prev, chain.relativePoint, chain.x, chain.y)
        else
            local anchor = entry.firstAnchor
            btn:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", anchor.x, anchor.y)
        end
    end
    btn:SetFrameLevel(frame:GetFrameLevel() + 20)
    btn:SetScript("OnClick", onClick)
    safePanelTemplatesCall(PanelTemplates_TabResize, btn, 0, nil, 36, frame.maxTabWidth or 120)
    btn:Show()
    return btn
end

local function rebuildLegacyTabs(frame)
    local hasPlugins = MetaAchievementPlugins
        and type(MetaAchievementPlugins.HasPlugins) == "function"
        and MetaAchievementPlugins.HasPlugins()

    clearLegacyTabs(frame)
    frame._contentBottomInset = CONTENT_BOTTOM_INSET
    applyPluginContentInsets(frame)

    if not hasPlugins then
        MetaAchievementMainWindowPlugins.SelectTab(frame, JOURNAL_TAB_ID)
        return
    end

    local tabIds = { JOURNAL_TAB_ID }
    local pluginIds = MetaAchievementPlugins.GetOrderedIds()
    for i = 1, #pluginIds do
        tabIds[#tabIds + 1] = pluginIds[i]
    end
    frame._legacyTabIds = tabIds

    local function makeClickHandler(id)
        return function(self)
            if SOUNDKIT and SOUNDKIT.IG_CHARACTER_INFO_TAB then
                PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB)
            end
            safePanelTemplatesCall(PanelTemplates_SetTab, frame, self:GetID())
            MetaAchievementMainWindowPlugins.SelectTab(frame, id)
        end
    end

    for index = 1, #tabIds do
        local tabId = tabIds[index]
        local label = tabId == JOURNAL_TAB_ID and "Journal" or ((MetaAchievementPlugins.Get(tabId) or {}).title or tabId)
        createLegacyTab(frame, index, label, makeClickHandler(tabId))
    end

    safePanelTemplatesCall(PanelTemplates_SetNumTabs, frame, #tabIds)

    local active = frame._activeMainTabId or JOURNAL_TAB_ID
    if active ~= JOURNAL_TAB_ID and not MetaAchievementPlugins.Get(active) then
        active = JOURNAL_TAB_ID
    end
    local activeIndex = 1
    for index, id in ipairs(tabIds) do
        if id == active then
            activeIndex = index
            break
        end
    end
    frame._activeMainTabId = nil
    safePanelTemplatesCall(PanelTemplates_SetTab, frame, activeIndex)
    MetaAchievementMainWindowPlugins.SelectTab(frame, active)
end

local function selectLegacyTab(frame, tabId)
    if frame._legacyTabIds and frame._journalTabID == nil then
        for index, id in ipairs(frame._legacyTabIds) do
            if id == tabId then
                safePanelTemplatesCall(PanelTemplates_SetTab, frame, index)
                break
            end
        end
    end

    local previousId = frame._activeMainTabId
    if previousId == tabId then
        return
    end

    if previousId and previousId ~= JOURNAL_TAB_ID then
        local prevSpec = getPluginSpec(previousId)
        if prevSpec and type(prevSpec.onHide) == "function" then
            pcall(prevSpec.onHide, frame, frame.PluginContentHost)
        end
    end

    if tabId == JOURNAL_TAB_ID then
        activateJournalTab(frame)
    else
        activatePluginTab(frame, tabId)
    end
end

-- ---------------------------------------------------------------------------
-- Public API
-- ---------------------------------------------------------------------------

function MetaAchievementMainWindowPlugins.SelectTab(frame, tabId)
    if not frame or type(tabId) ~= "string" then
        return
    end
    if canUseTabSystem() then
        selectTabSystemTab(frame, tabId)
        return
    end
    selectLegacyTab(frame, tabId)
end

function MetaAchievementMainWindowPlugins.RebuildTabs(frame)
    if not frame then
        return
    end
    if canUseTabSystem() then
        rebuildTabSystem(frame)
        return
    end
    rebuildLegacyTabs(frame)
end

function MetaAchievementMainWindowPlugins.OnPluginRegistryChanged()
    if frameRef then
        MetaAchievementMainWindowPlugins.RebuildTabs(frameRef)
    end
end

function MetaAchievementMainWindowPlugins.OnMainFrameShow(frame)
    if frame then
        MetaAchievementMainWindowPlugins.RebuildTabs(frame)
    end
end

function MetaAchievementMainWindowPlugins.OnMainFrameHide(frame)
    hideActivePluginTab(frame)
end

function MetaAchievementMainWindowPlugins.Init(frame)
    if not frame then
        return
    end
    frameRef = frame
    frame._activeMainTabId = JOURNAL_TAB_ID
    frame._contentBottomInset = CONTENT_BOTTOM_INSET
    frame._journalTabActive = true
    frame.maxTabWidth = 120

    if not frame.PluginContentHost then
        frame.PluginContentHost = CreateFrame("Frame", frame:GetName() .. "PluginContentHost", frame)
        frame.PluginContentHost:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, CONTENT_TOP)
        frame.PluginContentHost:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -6, CONTENT_BOTTOM_INSET)
        frame.PluginContentHost:Hide()
    end

    MetaAchievementMainWindowPlugins.RebuildTabs(frame)
end
