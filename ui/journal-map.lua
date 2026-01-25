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
    if not frame or not frame.SourceDropdown then
        return
    end

    local sources = self:GetDataSourcesSorted()

    UIDropDownMenu_SetWidth(frame.SourceDropdown, 240)
    UIDropDownMenu_JustifyText(frame.SourceDropdown, "LEFT")

    UIDropDownMenu_Initialize(frame.SourceDropdown, function(dropdown, level)
        for _, src in ipairs(sources) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = src.name
            info.value = src.key
            info.func = function()
                MetaAchievementJournalMap:SelectSource(frame, src.key)
            end

            -- Radio style: always show a circle; selected one is filled (gold dot)
            info.isNotRadio = false
            info.notCheckable = false
            info.checked = (frame._selectedSourceKey == src.key)

            UIDropDownMenu_AddButton(info, level)
        end
    end)

    if frame._selectedSourceKey and self.dataSources and self.dataSources[frame._selectedSourceKey] then
        UIDropDownMenu_SetSelectedValue(frame.SourceDropdown, frame._selectedSourceKey)
        UIDropDownMenu_SetText(frame.SourceDropdown, self.dataSources[frame._selectedSourceKey].name)
    elseif sources[1] then
        self:SelectSource(frame, sources[1].key)
    else
        UIDropDownMenu_SetText(frame.SourceDropdown, "No sources registered")
    end
end

local function buildModelFromProvider(provider)
    local items = safeCall(provider.GetList, provider) or safeCall(provider.getList, provider) or {}
    if type(items) ~= "table" then
        items = {}
    end
    return items
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
    frame._modelItems = buildModelFromProvider(src.provider)
    frame._selectedIndex = nil

    UIDropDownMenu_SetSelectedValue(frame.SourceDropdown, key)
    UIDropDownMenu_SetText(frame.SourceDropdown, src.name)

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
        MetaAchievementJournalList_SetItems(frame.JournalList, frame._modelItems)
    end

    -- When switching/opening a source, default to the first item so the map is populated immediately.
    if frame._modelItems and frame._modelItems[1] then
        self:SetSelectedIndex(frame, 1)
    else
        self:RenderMap(frame, nil)
    end
end

function MetaAchievementJournalMap:GetSelectedSource(frame)
    if not frame or not frame._selectedSourceKey then
        return nil
    end
    self.dataSources = self.dataSources or {}
    return self.dataSources[frame._selectedSourceKey]
end

function MetaAchievementJournalMap:SetSelectedIndex(frame, index)
    frame._selectedIndex = index
    if frame.JournalList and type(MetaAchievementJournalList_SetSelectedIndex) == "function" then
        MetaAchievementJournalList_SetSelectedIndex(frame.JournalList, index)
    end
    local item = frame._modelItems and frame._modelItems[index] or nil
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

    -- Provider can render anything into the map content container
    local rendered = safeCall(provider.RenderMap, provider, frame.MapInset.MapCanvas, content, selectedItem)
        or safeCall(provider.renderMap, provider, frame.MapInset.MapCanvas, content, selectedItem)

    -- Default: simple details widget if provider didn't render anything
    if rendered == nil then
        local detailName = frame:GetName() .. "MapDetail"
        local detail = _G[detailName]
        if not detail then
            detail = CreateFrame("Frame", detailName, content, "MetaAchievementMapDetailTemplate")
        else
            detail:SetParent(content)
        end

        -- The content frame already has padding; don't add another large inset here.
        detail:ClearAllPoints()
        detail:SetPoint("TOPLEFT", content, "TOPLEFT", 0, 0)
        detail:SetPoint("BOTTOMRIGHT", content, "BOTTOMRIGHT", 0, 0)
        detail:Show()

        if selectedItem and selectedItem.id and type(MetaAchievementMapDetail_SetFromAchievementId) == "function" then
            MetaAchievementMapDetail_SetFromAchievementId(detail, selectedItem.id, selectedItem)
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

    self:SetMovable(true)
    self:EnableMouse(true)
    self:RegisterForDrag("LeftButton")
    self:SetScript("OnDragStart", self.StartMoving)
    self:SetScript("OnDragStop", self.StopMovingOrSizing)

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

    -- Force dropdown above template artwork
    local baseLevel = self:GetFrameLevel() or 0
    if self.SourceDropdown then
        self.SourceDropdown:SetFrameLevel(baseLevel + 20)
        self.SourceDropdown:Show()

        local btn = _G[self.SourceDropdown:GetName() .. "Button"]
        if btn and btn.SetFrameLevel then
            btn:SetFrameLevel(baseLevel + 21)
        end
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

    MetaAchievementJournalMap:RefreshDropdown(self)
end

function MetaAchievementJournalMapFrame_OnShow(self)
    MetaAchievementJournalMap:RefreshDropdown(self)

    -- If we have a selected source but no selected item yet, auto-select the first item.
    if self._selectedSourceKey and (not self._selectedIndex) and self._modelItems and self._modelItems[1] then
        MetaAchievementJournalMap:SetSelectedIndex(self, 1)
    end
end

-- Public helpers
function MetaAchievementJournalMap:Toggle()
    if not self.frame then
        return
    end
    if self.frame:IsShown() then
        self.frame:Hide()
    else
        self.frame:Show()
    end
end

