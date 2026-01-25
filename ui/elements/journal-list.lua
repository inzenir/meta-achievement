-- Journal list UI element (inset + scrollframe + separate scrollbar).
-- Renders items, manages selection UI, and communicates with parent via MetaAchievementUIBus events.

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
            if not list then
                return
            end
            for _, handler in ipairs(list) do
                pcall(handler, ...)
            end
        end
    end
end

local function updateScrollChildWidth(self)
    if not self or not self.ScrollFrame or not self.ScrollFrame.ScrollChild then
        return
    end

    local scrollChild = self.ScrollFrame.ScrollChild
    -- IMPORTANT: Do NOT touch ScrollChild points here.
    -- ScrollFrame moves the scroll child while scrolling; clearing/setting points breaks hit rects after scroll.
    local w = self.ScrollFrame:GetWidth() or 0
    if w > 0 then
        scrollChild:SetWidth(w)
    end
end

local function acquireRow(self, idx)
    self._rowPool = self._rowPool or {}
    local row = self._rowPool[idx]
    if row then
        row:Show()
        return row
    end

    local scrollChild = self.ScrollFrame and self.ScrollFrame.ScrollChild or nil
    if not scrollChild then
        return nil
    end

    local rowName = self:GetName() .. "Row" .. tostring(idx)
    row = CreateFrame("Button", rowName, scrollChild, "MetaAchievementJournalListRowTemplate")
    row:SetHeight(ROW_HEIGHT)
    row:EnableMouse(true)
    row:RegisterForClicks("AnyUp")
    row:SetScript("OnClick", MetaAchievementJournalListRow_OnClick)
    row._index = idx
    row._owner = self

    row.Text = _G[rowName .. "Text"]
    row.Icon = _G[rowName .. "Icon"]
    row.Status = _G[rowName .. "Status"]
    row.Selected = _G[rowName .. "Selected"]

    self._rowPool[idx] = row
    return row
end

local function render(self)
    if not self.ScrollFrame or not self.ScrollFrame.ScrollChild then
        return
    end

    local model = self._items or {}
    local scrollChild = self.ScrollFrame.ScrollChild

    -- Ensure the scroll child matches the visible scrollframe width,
    -- otherwise rows can end up effectively 1px wide (looks fine, but isn't clickable).
    updateScrollChildWidth(self)

    self._rowPool = self._rowPool or {}

    -- hide extra
    for i = #model + 1, #self._rowPool do
        if self._rowPool[i] then
            self._rowPool[i]:Hide()
        end
    end

    for i, item in ipairs(model) do
        local row = acquireRow(self, i)
        if not row then
            return
        end

        row._index = i
        row:ClearAllPoints()
        if i == 1 then
            row:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 0, -2)
        else
            row:SetPoint("TOPLEFT", self._rowPool[i - 1], "BOTTOMLEFT", 0, -ROW_GAP)
        end
        row:SetPoint("RIGHT", scrollChild, "RIGHT", 0, 0)

        local text = item.title or item.data.name or tostring(item.id or "")
        local depth = tonumber(item.depth or 0) or 0
        if depth > 0 then
            text = string.rep("   ", depth) .. text
        end

        if row.Text and row.Text.SetText then
            row.Text:SetText(text)
        end

        if row.Icon then
            if item.data.icon then
                row.Icon:SetTexture(item.data.icon)
                row.Icon:Show()
            else
                row.Icon:Hide()
            end
        end

        if row.Status then
            row.Status:SetTexture(item.completedIcon)
            
        end

        if row.Selected then
            row.Selected:SetShown(self._selectedIndex == i)
        end
    end

    scrollChild:SetHeight((#model * (ROW_HEIGHT + ROW_GAP)) + 8)
end

function MetaAchievementJournalList_OnLoad(self)
    ensureBus()

    self.ScrollFrame = _G[self:GetName() .. "ScrollFrame"]
    if self.ScrollFrame then
        self.ScrollFrame.ScrollChild = _G[self.ScrollFrame:GetName() .. "ScrollChild"]
    end
    self.ScrollBar = _G[self:GetName() .. "ScrollBar"]

    self._items = {}
    self._selectedIndex = nil
    self._rowPool = {}

    if self.ScrollFrame then
        self.ScrollFrame:HookScript("OnSizeChanged", function()
            updateScrollChildWidth(self)
            render(self)
        end)
    end

    if self.ScrollBar and self.ScrollFrame and type(MetaAchievementScrollBar_Attach) == "function" then
        MetaAchievementScrollBar_Attach(self.ScrollBar, self.ScrollFrame)
    end

    -- Forward scrollbar events as list events
    MetaAchievementUIBus:Register("MA_SCROLLBAR_VALUE_CHANGED", function(scrollBar, scrollFrame, value)
        if scrollBar == self.ScrollBar and scrollFrame == self.ScrollFrame then
            MetaAchievementUIBus:Emit("MA_JOURNAL_LIST_SCROLL_CHANGED", self, value)
        end
    end)
end

function MetaAchievementJournalList_SetItems(self, items)
    self._items = items or {}
    self._selectedIndex = nil
    render(self)
end

function MetaAchievementJournalList_SetSelectedIndex(self, index)
    self._selectedIndex = index
    render(self)
end

function MetaAchievementJournalListRow_OnClick(row, button)
    ensureBus()
    local list = row._owner
    if not list then
        return
    end

    list._selectedIndex = row._index
    render(list)

    local item = list._items and list._items[row._index] or nil
    MetaAchievementUIBus:Emit("MA_JOURNAL_LIST_ITEM_CLICKED", list, row._index, item, button)
end

