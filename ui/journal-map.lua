-- UI: Quest Journal + Map (Retail-ish) frame
-- Data source dropdown feeds registered sources
-- Journal list is a list (model) rendered by a separate element (the view)

MetaAchievementJournalMap = MetaAchievementJournalMap or {}

local function safeCall(fn, ...)
    if type(fn) == "function" then
        return fn(...)
    end
end

local function clearChildren(parent)
    for _, child in ipairs({ parent:GetChildren() }) do
        child:Hide()
        child:SetParent(nil)
    end
end

local getTopNodeForBreadcrumbs -- forward decl; defined after GetSelectedSource

local function clearRegions(parent)
    for _, region in ipairs({ parent:GetRegions() }) do
        region:Hide()
        pcall(function()
            region:SetParent(nil)
        end)
    end
end

function MetaAchievementJournalMap:RegisterDataSource(key, displayName, provider)
    if type(key) ~= "string" or key == "" then
        return
    end
    if type(displayName) ~= "string" or displayName == "" then
        displayName = key
    end
    if type(provider) ~= "table" then
        provider = {}
    end

    self.dataSources = self.dataSources or {}
    self.dataSourceOrder = self.dataSourceOrder or {}

    -- Preserve registration order (pairs() order is undefined)
    if not self.dataSources[key] then
        self.dataSourceOrder[#self.dataSourceOrder + 1] = key
    end

    self.dataSources[key] = {
        key = key,
        name = displayName,
        provider = provider
    }

    if self.frame and self.frame:IsShown() then
        self:RefreshDropdown(self.frame)
    end
end

function MetaAchievementJournalMap:GetDataSourcesSorted()
    self.dataSources = self.dataSources or {}
    self.dataSourceOrder = self.dataSourceOrder or {}
    local list = {}
    for _, key in ipairs(self.dataSourceOrder) do
        local src = self.dataSources[key]
        if src then
            list[#list + 1] = src
        end
    end
    
    return list
end

function MetaAchievementJournalMap:RefreshDropdown(frame)
    if not frame then
        return
    end

    local sources = self:GetDataSourcesSorted()

    -- Cache sources directly on breadcrumbs so it can access without callbacks.
    if frame.Breadcrumbs and type(MetaAchievementBreadcrumbsDropdown_SetDataSources) == "function" then
        MetaAchievementBreadcrumbsDropdown_SetDataSources(frame.Breadcrumbs, sources)
    elseif frame.Breadcrumbs then
        frame.Breadcrumbs._cachedDataSources = sources
    end

    -- Update breadcrumbs with new source selection
    if frame.Breadcrumbs and type(MetaAchievementBreadcrumbsDropdown_SetDataSourceCallback) == "function" then
        MetaAchievementBreadcrumbsDropdown_SetDataSourceCallback(
            frame.Breadcrumbs,
            function()
                return MetaAchievementJournalMap:GetDataSourcesSorted()
            end,
            function(key)
                MetaAchievementJournalMap:SelectSource(frame, key)
            end,
            frame._selectedSourceKey
        )
    end

    -- Auto-select first source if none selected
    if not frame._selectedSourceKey and sources[1] then
        self:SelectSource(frame, sources[1].key)
    end
end

local function buildModelFromProvider(provider)
    local items = safeCall(provider.GetList, provider) or safeCall(provider.getList, provider) or {}
    if type(items) ~= "table" then
        items = {}
    end
    return items
end

local function findIndexById(items, id)
    if type(items) ~= "table" or not id then
        return nil
    end
    for i, node in ipairs(items) do
        if node and node.id == id then
            return i
        end
    end
    return nil
end

local function setFramePortrait(frame, texturePath)
    if not frame or not texturePath then
        return
    end

    -- Prefer template helper when available
    if type(ButtonFrameTemplate_SetPortraitToTexture) == "function" then
        ButtonFrameTemplate_SetPortraitToTexture(frame, texturePath)
        return
    end

    -- Fallback: resolve the portrait region and set it directly (client-version tolerant)
    local portrait =
        frame.Portrait
        or frame.portrait
        or _G[frame:GetName() .. "Portrait"]
        or (frame.PortraitContainer and (frame.PortraitContainer.portrait or frame.PortraitContainer.Portrait))

    if portrait and portrait.SetTexture then
        portrait:SetTexture(texturePath)
    end
end

local function getTopAchievementIconFromItems(items)
    if type(items) ~= "table" then
        return nil
    end

    local top = items[1]
    if not top then
        return nil
    end

    -- If DataList nodes are returned, the Achievement object is in top.data with an icon field.
    local icon = (top.data and top.data.icon) or top.icon
    if icon then
        return icon
    end

    -- Fallback: query the game API by achievement id
    if top.id and type(GetAchievementInfo) == "function" then
        local ok, _, _, _, _, _, _, _, _, _, apiIcon = pcall(GetAchievementInfo, top.id)
        if ok and apiIcon then
            return apiIcon
        end
    end

    return nil
end

function MetaAchievementJournalMap:SelectSource(frame, key)
    if not frame or not key then
        return
    end

    self.dataSources = self.dataSources or {}
    local src = self.dataSources[key]
    if not src then
        return
    end

    frame._selectedSourceKey = key
    frame._emptyStatePreview = nil
    frame._modelItems = buildModelFromProvider(src.provider)
    frame._selectedIndex = nil

    -- Update breadcrumbs with new source selection
    if frame.Breadcrumbs and type(MetaAchievementBreadcrumbsDropdown_SetDataSourceCallback) == "function" then
        MetaAchievementBreadcrumbsDropdown_SetDataSourceCallback(
            frame.Breadcrumbs,
            function()
                return MetaAchievementJournalMap:GetDataSourcesSorted()
            end,
            function(key)
                MetaAchievementJournalMap:SelectSource(frame, key)
            end,
            frame._selectedSourceKey
        )
    end

    -- Update the ButtonFrameTemplate portrait to the "top achievement" icon for this source.
    local portraitIcon =
        safeCall(src.provider.GetPortraitIcon, src.provider, frame)
        or safeCall(src.provider.getPortraitIcon, src.provider, frame)
        or safeCall(src.provider.GetHeaderIcon, src.provider, frame)
        or safeCall(src.provider.getHeaderIcon, src.provider, frame)
        or getTopAchievementIconFromItems(frame._modelItems)
    if portraitIcon then
        setFramePortrait(frame, portraitIcon)
    end

    if frame.JournalList and type(MetaAchievementJournalList_SetItems) == "function" then
        MetaAchievementJournalList_SetItems(frame.JournalList, frame._modelItems, frame)
    end

    -- Reset breadcrumbs for this source (selection will re-set it).
    if frame.Breadcrumbs and type(MetaAchievementBreadcrumbs_SetSelection) == "function" then
        MetaAchievementBreadcrumbs_SetSelection(frame.Breadcrumbs, frame._modelItems, nil, getTopNodeForBreadcrumbs(frame))
    end

    -- When switching/opening a source, default to the first item so the map is populated immediately.
    if frame._modelItems and frame._modelItems[1] then
        self:SetSelectedIndex(frame, 1)
    else
        self:RenderMap(frame, nil)
    end
    self:UpdateListVisibility(frame)
end

function MetaAchievementJournalMap:GetSelectedSource(frame)
    if not frame or not frame._selectedSourceKey then
        return nil
    end
    self.dataSources = self.dataSources or {}
    return self.dataSources[frame._selectedSourceKey]
end

--- Called when the user clicks "preview" on the map detail. Shows the journal empty state (completed screen + mount).
function MetaAchievementJournalMap:ShowEmptyStatePreview(frame)
    if not frame then
        return
    end
    frame._emptyStatePreview = true
    self:UpdateListVisibility(frame)
end

-- Build { id, name } for the current source's top achievement (for breadcrumbs when "hide completed" filters it out).
function getTopNodeForBreadcrumbs(frame)
    local src = MetaAchievementJournalMap:GetSelectedSource(frame)
    if not src or not src.provider or not src.provider.topAchievementId then
        return nil
    end
    return {
        id = src.provider.topAchievementId,
        name = src.name or nil,
    }
end

local MONTH_NAMES = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" }

local function formatCompletionDate(month, day, year)
    if not month or not day or not year then
        return ""
    end
    local monthName = MONTH_NAMES[month] or tostring(month)
    return ("Completed on %s %d, %d"):format(monthName, day, 2000 + year)
end

local EMPTY_STATE_MSG_COMPLETED = "All achievements in this list are completed."
local EMPTY_STATE_MSG_PENDING   = "This awaits you when you complete this achievement."

local function updateEmptyStatePanel(emptyPanel, topAchievementId, mountId)
    if not emptyPanel or not topAchievementId or type(GetAchievementInfo) ~= "function" then
        return
    end
    local ok, _, name, _, completed, month, day, year, _, _, icon = pcall(GetAchievementInfo, topAchievementId)
    if not ok then
        return
    end
    local message = emptyPanel.Message or _G[emptyPanel:GetName() .. "Message"]
    if message and message.SetText then
        message:SetText(completed and EMPTY_STATE_MSG_COMPLETED or EMPTY_STATE_MSG_PENDING)
    end
    local dateStr = completed and formatCompletionDate(month, day, year) or ""
    local completedDate = emptyPanel.CompletedDate or _G[emptyPanel:GetName() .. "CompletedDate"]
    if completedDate and completedDate.SetText then
        completedDate:SetText(dateStr)
    end
    local achiIcon = emptyPanel.AchiIcon or _G[emptyPanel:GetName() .. "AchiIcon"]
    if achiIcon then
        if icon and achiIcon.SetTexture then
            achiIcon:SetTexture(icon)
            achiIcon:Show()
        else
            achiIcon:Hide()
        end
    end
    local achiName = emptyPanel.AchiName or _G[emptyPanel:GetName() .. "AchiName"]
    if achiName and achiName.SetText then
        achiName:SetText(name and tostring(name) or "")
    end
    if type(MetaAchievementMountRewardPanel_Update) == "function" then
        MetaAchievementMountRewardPanel_Update(emptyPanel.MountPanel or _G[emptyPanel:GetName() .. "MountPanel"], mountId)
    end
end

local function isTopAchievementCompleted(frame)
    local topNode = getTopNodeForBreadcrumbs(frame)
    if not topNode or not topNode.id or type(GetAchievementInfo) ~= "function" then
        return false
    end
    local ok, _, _, _, completed = pcall(GetAchievementInfo, topNode.id)
    return ok and completed
end

-- When there are no achievements to display, show the empty-state panel and hide list/map; otherwise show list + map.
-- Option showCompletedScreenWhenTopDone: show completed screen when top achievement is done regardless of sub-achievements.
function MetaAchievementJournalMap:UpdateListVisibility(frame)
    if not frame or not frame.MapInset then
        return
    end
    local listEmpty = not frame._modelItems or #frame._modelItems == 0
    local showCompletedScreen = (MetaAchievementSettings and MetaAchievementSettings:Get("showCompletedScreenWhenTopDone"))
        and isTopAchievementCompleted(frame)
    local showEmptyState = listEmpty or showCompletedScreen or (frame._emptyStatePreview == true)
    local list = frame.JournalList
    local emptyPanel = frame.EmptyStatePanel
    if list then
        if showEmptyState then
            list:Hide()
        else
            list:Show()
        end
    end
    if emptyPanel then
        if showEmptyState then
            emptyPanel:Show()
            local topNode = getTopNodeForBreadcrumbs(frame)
            local mountId = nil
            local src = MetaAchievementJournalMap:GetSelectedSource(frame)
            if src and src.provider then
                mountId = src.provider.topAchievementMountId
            end
            if topNode and topNode.id then
                updateEmptyStatePanel(emptyPanel, topNode.id, mountId)
            end
            -- Show "Back" button when in preview mode (user clicked preview from map detail)
            local backBtn = emptyPanel.BackButton or _G[emptyPanel:GetName() .. "BackButton"]
            if backBtn then
                if frame._emptyStatePreview then
                    backBtn:Show()
                    backBtn:SetScript("OnClick", function()
                        frame._emptyStatePreview = nil
                        MetaAchievementJournalMap:UpdateListVisibility(frame)
                    end)
                else
                    backBtn:Hide()
                end
            end
            frame.MapInset:Hide()
        else
            emptyPanel:Hide()
            frame.MapInset:Show()
        end
    else
        if not showEmptyState then
            frame.MapInset:Show()
        else
            frame.MapInset:Hide()
        end
    end
    frame.MapInset:ClearAllPoints()
    if showEmptyState then
        -- Empty state panel uses its own full-area anchors from XML; no need to move MapInset (it's hidden).
        return
    end
    -- Normal: right panel starts at list's right edge
    if list then
        frame.MapInset:SetPoint("TOPLEFT", list, "TOPRIGHT", 0, 0)
    else
        frame.MapInset:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, -60)
    end
    frame.MapInset:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -6, 25)
end

-- Rebuild list after expand/collapse; keeps current selection by index if still valid.
function MetaAchievementJournalMap:RefreshList(frame)
    if not frame or not frame._selectedSourceKey then return end
    local src = self:GetSelectedSource(frame)
    if not src or not src.provider then return end
    local prevIndex = frame._selectedIndex
    frame._modelItems = buildModelFromProvider(src.provider)
    if frame.JournalList and type(MetaAchievementJournalList_SetItems) == "function" then
        MetaAchievementJournalList_SetItems(frame.JournalList, frame._modelItems, frame)
    end
    if prevIndex and frame._modelItems[prevIndex] then
        self:SetSelectedIndex(frame, prevIndex)
    elseif frame._modelItems and frame._modelItems[1] then
        self:SetSelectedIndex(frame, 1)
    else
        if frame.Breadcrumbs and type(MetaAchievementBreadcrumbs_SetSelection) == "function" then
            MetaAchievementBreadcrumbs_SetSelection(frame.Breadcrumbs, frame._modelItems or {}, nil, getTopNodeForBreadcrumbs(frame))
        end
        self:RenderMap(frame, nil)
    end
    self:UpdateListVisibility(frame)
end

function MetaAchievementJournalMap:SetSelectedIndex(frame, index)
    frame._selectedIndex = index
    if frame.JournalList and type(MetaAchievementJournalList_SetSelectedIndex) == "function" then
        MetaAchievementJournalList_SetSelectedIndex(frame.JournalList, index)
    end
    local item = frame._modelItems and frame._modelItems[index] or nil
    if frame.Breadcrumbs and type(MetaAchievementBreadcrumbs_SetSelection) == "function" then
        MetaAchievementBreadcrumbs_SetSelection(frame.Breadcrumbs, frame._modelItems, item, getTopNodeForBreadcrumbs(frame))
    end
    self:RenderMap(frame, item)
end

function MetaAchievementJournalMap:ClearMap(frame)
    if not frame or not frame.MapInset or not frame.MapInset.MapCanvas or not frame.MapInset.MapCanvas.Content then
        return
    end
    local content = frame.MapInset.MapCanvas.DynamicContent or frame.MapInset.MapCanvas.Content
    clearChildren(content)
    clearRegions(content)
end

-- Map part: accepts arbitrary elements (pins, overlays, widgets) as children of MapCanvas.Content
function MetaAchievementJournalMap:AddMapElement(frame, element)
    if not frame or not element then
        return
    end
    local content = frame.MapInset.MapCanvas.DynamicContent or frame.MapInset.MapCanvas.Content
    element:SetParent(content)
    element:Show()
end

function MetaAchievementJournalMap:RenderMap(frame, selectedItem)
    self:ClearMap(frame)

    local src = self:GetSelectedSource(frame)
    if not src or not src.provider then
        return
    end

    local provider = src.provider
    local content = frame.MapInset.MapCanvas.DynamicContent or frame.MapInset.MapCanvas.Content

    -- Provider can render anything into the map content container (pass frame so provider can set frame._currentMapDetail)
    local rendered = safeCall(provider.RenderMap, provider, frame, frame.MapInset.MapCanvas, content, selectedItem)
        or safeCall(provider.renderMap, provider, frame, frame.MapInset.MapCanvas, content, selectedItem)

    -- Default: simple details widget if provider didn't render anything
    if rendered == nil then
        local detailName = frame:GetName() .. "MapDetail"
        local detail = _G[detailName]
        if not detail then
            detail = CreateFrame("Frame", detailName, content, "MetaAchievementMapDetailTemplate")
        else
            detail:SetParent(content)
        end
        detail.journalFrame = frame
        frame._currentMapDetail = detail

        -- The content frame already has padding; don't add another large inset here.
        detail:ClearAllPoints()
        detail:SetPoint("TOPLEFT", content, "TOPLEFT", 0, 0)
        detail:SetPoint("BOTTOMRIGHT", content, "BOTTOMRIGHT", 0, 0)
        detail:Show()

        if selectedItem and selectedItem.id and type(MetaAchievementMapDetail_SetFromAchievementId) == "function" then
            local topId = (src and src.provider and src.provider.topAchievementId) or nil
            MetaAchievementMapDetail_SetFromAchievementId(detail, selectedItem.id, selectedItem, topId)
        elseif type(MetaAchievementMapDetail_SetData) == "function" then
            MetaAchievementMapDetail_SetData(detail, {
                title = "Select an item",
                isFeat = true,
                description = "Select an item from the journal list to see details here.",
                reward = "—",
                requirements = {},
            })
        end
    end
end

-- XML hooks
function MetaAchievementJournalMapFrame_OnLoad(self)
    MetaAchievementJournalMap.frame = self

    -- Ensure the inherited template initializes its regions/scripts
    if type(ButtonFrameTemplate_OnLoad) == "function" then
        ButtonFrameTemplate_OnLoad(self)
    end

    self:SetMovable(false)
    self:EnableMouse(true)

    -- ButtonFrameTemplate / PortraitFrameTemplate title region varies by client version
    if type(ButtonFrameTemplate_SetTitle) == "function" then
        ButtonFrameTemplate_SetTitle(self, "Meta Achievement Journal")
    else
        local titleRegion =
            self.TitleText
            or (self.TitleContainer and self.TitleContainer.TitleText)
            or _G[self:GetName() .. "TitleText"]
        if titleRegion and titleRegion.SetText then
            titleRegion:SetText("Meta Achievement Journal")
        end
    end

    -- Convenience handles for Lua (match XML names)
    self.SourceDropdown = _G[self:GetName() .. "SourceDropdown"]
    self.JournalList = _G[self:GetName() .. "JournalList"]
    self.MapInset = _G[self:GetName() .. "MapInset"]
    self.EmptyStatePanel = _G[self:GetName() .. "EmptyStatePanel"]
    self.Breadcrumbs = _G[self:GetName() .. "Breadcrumbs"]
    self.SettingsButton = _G[self:GetName() .. "SettingsButton"]
    self.SilverCogButton = _G[self:GetName() .. "SilverCogButton"]
    -- ButtonFrameTemplate provides CloseButton; we anchor our button to it (Blizzard-style: extra button next to close)
    self.CloseButton = _G[self:GetName() .. "CloseButton"]

    if self.SilverCogButton then
        self.SilverCogButton:SetParent(UIParent)
        self.SilverCogButton:SetFrameStrata("FULLSCREEN_DIALOG")
        self.SilverCogButton:SetFrameLevel(1000)
        if self.SettingsButton then
            self.SilverCogButton:ClearAllPoints()
            self.SilverCogButton:SetPoint("RIGHT", self.SettingsButton, "LEFT", -4, 0)
        else
            self.SilverCogButton:ClearAllPoints()
            self.SilverCogButton:SetPoint("TOPRIGHT", self, "TOPRIGHT", -120, -2)
        end
        self.SilverCogButton:Hide()
        self.SilverCogButton:SetScript("OnClick", function()
            if Settings and type(Settings.OpenToCategory) == "function" and MetaAchievementSettingsCategoryID then
                Settings.OpenToCategory(MetaAchievementSettingsCategoryID)
            end
        end)
        if MetaAchievementSilverCogButton_SetTooltip then
            MetaAchievementSilverCogButton_SetTooltip(self.SilverCogButton, "Addon settings")
        end
    end

    if self.SettingsButton then
        -- Reparent to UIParent + higher strata so button draws above template title bar (frame level alone is not enough;
        -- see e.g. WeakAuras #384, WoWInterface "button not showing on frame" – strata/level fix)
        self.SettingsButton:SetParent(UIParent)
        self.SettingsButton:SetFrameStrata("FULLSCREEN_DIALOG")
        self.SettingsButton:SetFrameLevel(1000)
        if self.CloseButton then
            self.SettingsButton:ClearAllPoints()
            self.SettingsButton:SetPoint("RIGHT", self.CloseButton, "LEFT", -2, 0)
        else
            self.SettingsButton:ClearAllPoints()
            self.SettingsButton:SetPoint("TOPRIGHT", self, "TOPRIGHT", -24, -2)
        end
        self.SettingsButton:Hide()
        self.SettingsButton:SetScript("OnClick", function()
            if Settings and type(Settings.OpenToCategory) == "function" and MetaAchievementSettingsCategoryID then
                Settings.OpenToCategory(MetaAchievementSettingsCategoryID)
            end
        end)
        if MetaAchievementSettingsCogButton_SetTooltip then
            MetaAchievementSettingsCogButton_SetTooltip(self.SettingsButton, "Addon settings")
        end
    end

    -- Hide the old dropdown (functionality moved to breadcrumbs)
    if self.SourceDropdown then
        self.SourceDropdown:Hide()
    end

    -- Set up breadcrumbs data source callback
    if self.Breadcrumbs and type(MetaAchievementBreadcrumbsDropdown_SetDataSourceCallback) == "function" then
        MetaAchievementBreadcrumbsDropdown_SetDataSourceCallback(
            self.Breadcrumbs,
            function()
                return MetaAchievementJournalMap:GetDataSourcesSorted()
            end,
            function(key)
                MetaAchievementJournalMap:SelectSource(self, key)
            end,
            self._selectedSourceKey
        )
    end
    -- Subscribe to list element events
    if MetaAchievementUIBus and type(MetaAchievementUIBus.Register) == "function" then
        local frameRef = self
        MetaAchievementUIBus:Register("MA_JOURNAL_LIST_ITEM_CLICKED", function(listFrame, index, item, button)
            if frameRef and listFrame == frameRef.JournalList then
                MetaAchievementJournalMap:SetSelectedIndex(frameRef, index)

                local src = MetaAchievementJournalMap:GetSelectedSource(frameRef)
                if src and src.provider and item then
                    safeCall(src.provider.OnItemSelected, src.provider, item, button)
                    safeCall(src.provider.onItemSelected, src.provider, item, button)
                end
            end
        end)

        MetaAchievementUIBus:Register("MA_BREADCRUMB_CLICKED", function(owner, nodeId, node, button)
            if not frameRef or owner ~= frameRef.Breadcrumbs then
                return
            end
            local idx = findIndexById(frameRef._modelItems, nodeId)
            if idx then
                MetaAchievementJournalMap:SetSelectedIndex(frameRef, idx)
            end
        end)
    end
    if self.MapInset then
        self.MapInset.MapCanvas = _G[self.MapInset:GetName() .. "MapCanvas"]
        if self.MapInset.MapCanvas then
            self.MapInset.MapCanvas.Content = _G[self.MapInset.MapCanvas:GetName() .. "Content"]
            if self.MapInset.MapCanvas.Content then
                self.MapInset.MapCanvas.DynamicContent = CreateFrame("Frame", nil, self.MapInset.MapCanvas.Content)
                self.MapInset.MapCanvas.DynamicContent:SetAllPoints()
            end
        end
    end

    -- Register with Blizzard's UIPanel system: area "left" (like Character/Spellbook), not "full",
    -- so we get mutual exclusivity without hiding the rest of the interface. pushable=0 = replace other left panels.
    self:SetAttribute("UIPanelLayout-defined", true)
    self:SetAttribute("UIPanelLayout-enabled", true)
    self:SetAttribute("UIPanelLayout-area", "left")
    self:SetAttribute("UIPanelLayout-pushable", 0)
    self:SetAttribute("UIPanelLayout-whileDead", true)

    -- Draw above action bars and other game UI (they use MEDIUM/HIGH). Frame level only applies within same strata.
    self:SetFrameStrata("DIALOG")
    self:SetFrameLevel(200)

    -- When these settings change, refresh the journal so list/detail/visibility match without re-opening or changing selection.
    do
        local keysToRefreshOn = { "hideCompleted", "showCompletedScreenWhenTopDone", "achievementLinkSource", "addWpsOnlyForUncompletedAchis" }
        for _, key in ipairs(keysToRefreshOn) do
            if MetaAchievementSettings and type(MetaAchievementSettings.RegisterListener) == "function" then
                MetaAchievementSettings:RegisterListener(key, function()
                    local f = MetaAchievementJournalMap.frame
                    if f then
                        MetaAchievementJournalMap:RefreshList(f)
                    end
                end)
            end
        end
    end

    -- When showSettingsButton changes, update button visibility if the journal is open.
    if MetaAchievementSettings and type(MetaAchievementSettings.RegisterListener) == "function" then
        MetaAchievementSettings:RegisterListener("showSettingsButton", function(_, show)
            if self:IsShown() then
                if self.SilverCogButton then
                    if show then self.SilverCogButton:Show() else self.SilverCogButton:Hide() end
                end
                if self.SettingsButton then
                    if show then self.SettingsButton:Show() else self.SettingsButton:Hide() end
                end
            end
        end)
    end

    MetaAchievementJournalMap:RefreshDropdown(self)
end

function MetaAchievementJournalMapFrame_OnShow(self)
    MetaAchievementJournalMap:RefreshDropdown(self)
    -- Ensure breadcrumb dropdown is usable on first open (clears addon-load init guard).
    if self.Breadcrumbs and type(MetaAchievementBreadcrumbsDropdown_SetInitializationComplete) == "function" then
        MetaAchievementBreadcrumbsDropdown_SetInitializationComplete(self.Breadcrumbs)
    end

    -- If we have a selected source but no selected item yet, auto-select the first item.
    if self._selectedSourceKey and (not self._selectedIndex) and self._modelItems and self._modelItems[1] then
        MetaAchievementJournalMap:SetSelectedIndex(self, 1)
    end

    -- Re-anchor and show/hide settings buttons based on option (reparented to UIParent so they stay on top of title bar)
    local showSettings = MetaAchievementSettings and MetaAchievementSettings:Get("showSettingsButton")
    if self.SilverCogButton then
        self.SilverCogButton:ClearAllPoints()
        if self.SettingsButton then
            self.SilverCogButton:SetPoint("RIGHT", self.SettingsButton, "LEFT", -4, 0)
        else
            self.SilverCogButton:SetPoint("TOPRIGHT", self, "TOPRIGHT", -120, -2)
        end
        if showSettings then self.SilverCogButton:Show() else self.SilverCogButton:Hide() end
    end
    if self.SettingsButton then
        self.SettingsButton:ClearAllPoints()
        if self.CloseButton then
            self.SettingsButton:SetPoint("RIGHT", self.CloseButton, "LEFT", -2, 0)
        else
            self.SettingsButton:SetPoint("TOPRIGHT", self, "TOPRIGHT", -24, -2)
        end
        if showSettings then self.SettingsButton:Show() else self.SettingsButton:Hide() end
    end
end

function MetaAchievementJournalMapFrame_OnHide(self)
    if self.SilverCogButton then self.SilverCogButton:Hide() end
    if self.SettingsButton then self.SettingsButton:Hide() end
end

-- Close our other addon window (old tabbed main) when we open the journal.
function MetaAchievementJournalMap:CloseOtherAddonWindows()
    if MetaAchievementDB and MetaAchievementDB.mainFrame and MetaAchievementDB.mainFrame.hideWindow then
        local oldMain = MetaAchievementDB.mainFrame:getFrame()
        if oldMain and oldMain:IsShown() then
            MetaAchievementDB.mainFrame:hideWindow()
        end
    end
end

-- Show/hide via UIPanel so we participate in panel stacking (open us = close others, open others = close us).
-- area "left" + pushable 0 avoids "full" which was hiding the rest of the interface. In combat, use frame Show/Hide.
local function JournalPanelShow(frame)
    if not frame then return end
    if not InCombatLockdown() and type(ShowUIPanel) == "function" then
        ShowUIPanel(frame)
    elseif frame.Show then
        frame:Show()
    end
end

local function JournalPanelHide(frame)
    if not frame then return end
    if not InCombatLockdown() and type(HideUIPanel) == "function" then
        HideUIPanel(frame)
    elseif frame.Hide then
        frame:Hide()
    end
end

function MetaAchievementJournalMap:ShowPanel()
    if self.frame then
        self:CloseOtherAddonWindows()
        JournalPanelShow(self.frame)
    end
end

function MetaAchievementJournalMap:HidePanel()
    if self.frame then
        JournalPanelHide(self.frame)
    end
end

function MetaAchievementJournalMap:Toggle()
    if not self.frame then
        return
    end
    if self.frame:IsShown() then
        self:HidePanel()
    else
        self:ShowPanel()
    end
end

