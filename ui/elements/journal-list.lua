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

function MetaAchievementJournalList_SetItems(self, items)
    self._items = items or {}
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
