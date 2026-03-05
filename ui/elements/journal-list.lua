-- Journal list UI element: Blizzard WowScrollBoxList + MinimalScrollBar (pet/mount journal look).
-- Uses CreateScrollBoxListLinearView + SetElementInitializer + ScrollUtil.InitScrollBoxListWithScrollBar.

local ROW_HEIGHT = 22
local ROW_GAP = 0

local function ensureBus()
    MetaAchievementUIBus = MetaAchievementUIBus or {}
    if type(MetaAchievementUIBus.Register) ~= "function" then
        function MetaAchievementUIBus:Register(eventName, handler)
            self._listeners = self._listeners or {}
            self._listeners[eventName] = self._listeners[eventName] or {}
            self._listeners[eventName][#self._listeners[eventName] + 1] = handler
            return handler
        end
    end
    if type(MetaAchievementUIBus.Emit) ~= "function" then
        function MetaAchievementUIBus:Emit(eventName, ...)
            local list = self._listeners and self._listeners[eventName]
            if not list then return end
            for _, handler in ipairs(list) do pcall(handler, ...) end
        end
    end
end

function MetaAchievementJournalList_OnLoad(self)
    ensureBus()

    self.ScrollBox = self.ScrollBox or _G[self:GetName() .. "ScrollBox"]
    self.ScrollBar = self.ScrollBar or _G[self:GetName() .. "ScrollBar"]

    self._items = {}
    self._selectedIndex = nil

    if not self.ScrollBox or not self.ScrollBar or not CreateScrollBoxListLinearView or not ScrollUtil or not ScrollUtil.InitScrollBoxListWithScrollBar then
        return
    end

    local scrollBox, scrollBar = self.ScrollBox, self.ScrollBar
    local list = self

    local view = CreateScrollBoxListLinearView()
    view:SetElementExtent(ROW_HEIGHT)

    view:SetElementInitializer("MetaAchievementJournalListRowTemplate", function(frame, elementData)
        local item = elementData and elementData.item
        local index = elementData and elementData.index or 0
        if not frame or not item then return end

        frame._owner = list
        frame._index = index
        frame._item = item

        if not frame.Text then
            local name = frame:GetName()
            if name then
                frame.Text = _G[name .. "Text"]
                frame.Icon = _G[name .. "Icon"]
                frame.Status = _G[name .. "Status"]
                frame.Selected = _G[name .. "Selected"]
                frame.Expand = _G[name .. "Expand"]
            else
                -- ScrollBox creates frames without global names; find regions by type
                local highlightTex = frame.GetHighlightTexture and frame:GetHighlightTexture()
                local regions = { frame:GetRegions() }
                local texIdx = 0
                for _, r in ipairs(regions) do
                    if r and r.GetObjectType then
                        local t = r:GetObjectType()
                        if t == "FontString" then
                            frame.Text = r
                        elseif t == "Texture" and r ~= highlightTex then
                            texIdx = texIdx + 1
                            if texIdx == 1 then frame.Selected = r
                            elseif texIdx == 2 then frame.Icon = r
                            elseif texIdx == 3 then frame.Status = r
                            end
                        end
                    end
                end
                -- Expand button may be a child frame
                for _, child in ipairs({ frame:GetChildren() }) do
                    if child and child.GetName and child:GetName() and child:GetName():find("Expand") then
                        frame.Expand = child
                        break
                    end
                end
            end
        end

        -- Expand/collapse button: show only when item has children; + when collapsed, − when expanded
        local hasChildren = item.children and type(item.children) == "table" and #item.children > 0
        if frame.Expand then
            if hasChildren then
                if not frame.Expand.label then
                    frame.Expand.label = frame.Expand:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
                    frame.Expand.label:SetPoint("CENTER")
                    frame.Expand.label:SetJustifyH("CENTER")
                    frame.Expand.label:SetJustifyV("MIDDLE")
                end
                frame.Expand.label:SetText(item.colapsed and "+" or "−")
                frame.Expand:Show()
                frame.Expand._item = item
                frame.Expand._owner = list
                frame.Expand:SetScript("OnClick", function(btn)
                    if not btn._item or not btn._owner then return end
                    MetaAchievementJournalListExpand_OnClick(btn)
                end)
                -- When hovering the button, highlight the whole row (subtle) while button keeps its own highlight for emphasis
                if not frame._rowHoverHighlight then
                    frame._rowHoverHighlight = frame:CreateTexture(nil, "BACKGROUND")
                    frame._rowHoverHighlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
                    frame._rowHoverHighlight:SetBlendMode("ADD")
                    frame._rowHoverHighlight:SetAlpha(0.35)
                    frame._rowHoverHighlight:SetAllPoints(frame)
                    frame._rowHoverHighlight:Hide()
                end
                frame.Expand:SetScript("OnEnter", function(btn)
                    local row = btn:GetParent()
                    if row and row._rowHoverHighlight then row._rowHoverHighlight:Show() end
                end)
                frame.Expand:SetScript("OnLeave", function(btn)
                    local row = btn:GetParent()
                    if row and row._rowHoverHighlight then row._rowHoverHighlight:Hide() end
                end)
            else
                frame.Expand:Hide()
            end
        end

        local text = item.title or (item.data and item.data.name) or tostring(item.id or "")
        local depth = tonumber(item.depth or 0) or 0
        if depth > 0 then
            text = string.rep("   ", depth) .. text
        end

        if frame.Text and frame.Text.SetText then
            frame.Text:SetText(text)
        end
        if frame.Icon then
            if item.data and item.data.icon then
                frame.Icon:SetTexture(item.data.icon)
                frame.Icon:Show()
            else
                frame.Icon:Hide()
            end
        end
        if frame.Status then
            frame.Status:SetTexture(item.completedIcon or "")
            -- Red color for incomplete (X icon), default for completed (checkmark)
            if item.completedIcon and item.completedIcon:find("StopButton", 1, true) then
                frame.Status:SetVertexColor(1, 0, 0, 1)  -- Red
            else
                frame.Status:SetVertexColor(1, 1, 1, 1)  -- Default (white/gold)
            end
        end
        if frame.Selected then
            frame.Selected:SetShown(list._selectedIndex == index)
        end

        frame:SetScript("OnClick", function(f, btn)
            list._selectedIndex = f._index
            if list._view and list._view.Refresh then list._view:Refresh() end
            local it = list._items and list._items[f._index]
            MetaAchievementUIBus:Emit("MA_JOURNAL_LIST_ITEM_CLICKED", list, f._index, it, btn)
        end)
    end)

    ScrollUtil.InitScrollBoxListWithScrollBar(scrollBox, scrollBar, view)

    local dataProvider = CreateDataProvider()
    scrollBox:SetDataProvider(dataProvider)

    self._dataProvider = dataProvider
    self._view = view
end

function MetaAchievementJournalList_SetItems(self, items, journalFrame)
    self._items = items or {}
    self._journalFrame = journalFrame
    self._selectedIndex = nil
    local dp = self._dataProvider
    if not dp then return end
    dp:Flush()
    for i, item in ipairs(self._items) do
        dp:Insert({ index = i, item = item })
    end
    if self._view and self._view.Refresh then
        self._view:Refresh()
    end
end

function MetaAchievementJournalListExpand_OnClick(expandButton)
    local list = expandButton._owner
    local item = expandButton._item
    if not list or not list._journalFrame or not item or not item.id then return end
    local frame = list._journalFrame
    local src = MetaAchievementJournalMap and MetaAchievementJournalMap:GetSelectedSource(frame)
    if not src or not src.provider or type(src.provider.ToggleCollapsed) ~= "function" then return end
    src.provider:ToggleCollapsed(item.id)
    if MetaAchievementJournalMap and type(MetaAchievementJournalMap.RefreshList) == "function" then
        MetaAchievementJournalMap:RefreshList(frame)
    end
end

function MetaAchievementJournalList_SetSelectedIndex(self, index)
    self._selectedIndex = index
    if self._view and self._view.Refresh then
        self._view:Refresh()
    end
end

function MetaAchievementJournalListRow_OnClick(row, button)
    ensureBus()
    local list = row._owner
    if not list then return end
    list._selectedIndex = row._index
    if list._view and list._view.Refresh then
        list._view:Refresh()
    end
    local item = list._items and list._items[row._index]
    MetaAchievementUIBus:Emit("MA_JOURNAL_LIST_ITEM_CLICKED", list, row._index, item, button)
end
