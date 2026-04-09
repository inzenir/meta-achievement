-- Journal list UI element: Blizzard WowScrollBoxList + MinimalScrollBar (pet/mount journal look).
-- Uses CreateScrollBoxListLinearView + SetElementInitializer + ScrollUtil.InitScrollBoxListWithScrollBar.

local ROW_HEIGHT = 22
local ROW_GAP = 0

--- ScrollBox rows are often unnamed; GetRegions() order is not guaranteed, so the first Texture is not always $parentSelected.
--- Selection uses the BACKGROUND QuestTitleHighlight layer; the Button's HighlightTexture uses the same file — skip GetHighlightTexture().
local function journalRowResolveSelectedTexture(frame)
    if not frame then return nil end
    local hi = frame.GetHighlightTexture and frame:GetHighlightTexture()
    local function isSelectionHighlight(tex)
        if not tex or not tex.GetTexture then return false end
        local p = tex:GetTexture()
        return type(p) == "string" and p:find("QuestTitleHighlight", 1, true) ~= nil
    end
    if frame.Selected and isSelectionHighlight(frame.Selected) and frame.Selected ~= hi then
        return frame.Selected
    end
    local name = frame:GetName()
    if name then
        local sel = _G[name .. "Selected"]
        if sel and isSelectionHighlight(sel) and sel ~= hi then
            return sel
        end
    end
    for _, r in ipairs({ frame:GetRegions() }) do
        if r and r.GetObjectType and r:GetObjectType() == "Texture" and r ~= hi and isSelectionHighlight(r) then
            return r
        end
    end
    return nil
end

local function journalRowEnsureSelectedTexture(frame)
    local sel = journalRowResolveSelectedTexture(frame)
    if sel then return sel end
    if frame._metaJournalCreatedSelected then
        return frame._metaJournalCreatedSelected
    end
    if not frame.CreateTexture then return nil end
    local t = frame:CreateTexture(nil, "BACKGROUND")
    t:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
    t:SetBlendMode("ADD")
    t:SetAllPoints(frame)
    t:Hide()
    frame._metaJournalCreatedSelected = t
    return t
end

--- Prefer ActiveAchievementState id (source of truth); fall back to list index when state is unavailable.
local function journalRowShouldShowSelectionHighlight(list, index, item)
    if not list or not index or not item then return false end
    if AchievementListUtils and type(AchievementListUtils.resolveIdFromNode) == "function" and type(AchievementListUtils.normalizeAchievementId) == "function" then
        local st = ActiveAchievementState and ActiveAchievementState:GetInstance()
        local aid = st and type(st.GetActiveAchievementId) == "function" and st:GetActiveAchievementId()
        local rid = AchievementListUtils.resolveIdFromNode(item)
        if aid and rid then
            return AchievementListUtils.normalizeAchievementId(aid) == AchievementListUtils.normalizeAchievementId(rid)
        end
    end
    return list._selectedIndex == index
end

local function journalListScrollBoxBumpLayout(scrollBox)
    if not scrollBox then return end
    if type(scrollBox.FullUpdate) == "function" then
        scrollBox:FullUpdate()
    elseif type(scrollBox.Update) == "function" then
        scrollBox:Update()
    end
end

--- WowScrollBoxList scroll position (percentage or scrollbar value) before Flush+Insert; restored after layout.
local function journalListCaptureScroll(scrollBox, scrollBar)
    if scrollBox and type(scrollBox.GetScrollPercentage) == "function" then
        local ok, p = pcall(function()
            return scrollBox:GetScrollPercentage()
        end)
        if ok and type(p) == "number" then
            return { kind = "pct", v = p }
        end
    end
    if scrollBar and type(scrollBar.GetValue) == "function" and type(scrollBar.GetMinMaxValues) == "function" then
        local vmin, vmax = scrollBar:GetMinMaxValues()
        local v = scrollBar:GetValue()
        if type(vmax) == "number" and vmax > 0 then
            return { kind = "bar", v = v, vmin = vmin or 0, vmax = vmax }
        end
    end
    return nil
end

local function journalListRestoreScroll(scrollBox, scrollBar, saved)
    if not saved then
        return
    end
    if saved.kind == "pct" and scrollBox and type(scrollBox.SetScrollPercentage) == "function" then
        pcall(function()
            scrollBox:SetScrollPercentage(saved.v)
        end)
        return
    end
    if saved.kind == "bar" and scrollBar and type(scrollBar.SetValue) == "function" then
        pcall(function()
            scrollBar:SetValue(saved.v)
        end)
    end
end

--- True when scroll is not at the top (worth masking during rebuild to avoid a one-frame jump).
local function journalListScrollNeedsPreserveForMask(preserve)
    if not preserve then
        return false
    end
    if preserve.kind == "pct" and type(preserve.v) == "number" and preserve.v > 0.0001 then
        return true
    end
    if preserve.kind == "bar" and type(preserve.v) == "number" and type(preserve.vmax) == "number" and preserve.vmax > 0 then
        local vmin = preserve.vmin or 0
        return preserve.v > vmin + 0.25
    end
    return false
end

--- Call before repopulating a new meta/source so the next scroll capture starts at the top (not the previous meta).
function MetaAchievementJournalList_ResetScrollPreserveForNewSource(self)
    if not self then
        return
    end
    self._journalScrollPreserve = nil
    local sb = self.ScrollBox
    if sb and type(sb.ScrollToBegin) == "function" then
        sb:ScrollToBegin()
    elseif self.ScrollBar and type(self.ScrollBar.SetValue) == "function" and type(self.ScrollBar.GetMinMaxValues) == "function" then
        local vmin, vmax = self.ScrollBar:GetMinMaxValues()
        if type(vmax) == "number" and vmax > 0 then
            self.ScrollBar:SetValue(vmin or 0)
        end
    end
end

--- WowScrollBoxList does not reliably re-run the row initializer when only list._selectedIndex changes; Flush+Insert forces the same repaint as open/close.
--- Multiple flushes in one frame (e.g. SetItems then SetSelectedIndex) share one pre-flush scroll capture so the second flush does not reset to top.
--- Restore runs in the same frame as Flush (no deferred timer) so the list does not paint at scroll 0 then jump — avoids visible twitch.
local function journalListFlushAndRepaint(self)
    local dp = self._dataProvider
    if not dp or not self._items then
        return
    end
    local scrollBox, scrollBar = self.ScrollBox, self.ScrollBar
    if self._journalScrollPreserve == nil and scrollBox then
        self._journalScrollPreserve = journalListCaptureScroll(scrollBox, scrollBar)
    end
    local preserve = self._journalScrollPreserve
    local mask = journalListScrollNeedsPreserveForMask(preserve)
    if mask and self.SetAlpha then
        self:SetAlpha(0)
    end
    dp:Flush()
    for i, item in ipairs(self._items) do
        dp:Insert({ index = i, item = item })
    end
    if self._view and self._view.Refresh then
        self._view:Refresh()
    end
    journalListScrollBoxBumpLayout(scrollBox)
    journalListRestoreScroll(scrollBox, scrollBar, preserve)
    journalListScrollBoxBumpLayout(scrollBox)
    journalListRestoreScroll(scrollBox, scrollBar, preserve)
    self._journalScrollPreserve = nil
    if mask and self.SetAlpha then
        self:SetAlpha(1)
    end
end

function MetaAchievementJournalList_OnLoad(self)
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
        frame.Selected = journalRowEnsureSelectedTexture(frame)
        if frame.Selected then
            frame.Selected:SetShown(journalRowShouldShowSelectionHighlight(list, index, item))
        end

        -- Selection + highlight: MA_JOURNAL_LIST_ITEM_CLICKED → SetSelectedIndex → JournalList_SetSelectedIndex (do not Refresh here:
        -- state must update first, and view:Refresh alone does not repaint pooled rows until ScrollBox FullUpdate).
        frame:SetScript("OnClick", function(f, btn)
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
    local state = ActiveAchievementState and ActiveAchievementState:GetInstance()
    if state and type(state.GetActiveIndex) == "function" then
        local ai = state:GetActiveIndex()
        if ai and ai >= 1 and ai <= #self._items then
            self._selectedIndex = ai
        end
    end
    if not self._selectedIndex and journalFrame and type(journalFrame._selectedIndex) == "number" then
        local j = journalFrame._selectedIndex
        if j >= 1 and j <= #self._items then
            self._selectedIndex = j
        end
    end
    journalListFlushAndRepaint(self)
end

function MetaAchievementJournalListExpand_OnClick(expandButton)
    local list = expandButton._owner
    local item = expandButton._item
    if not list or not list._journalFrame or not item or not item.id then return end
    local frame = list._journalFrame
    local src = MetaAchievementMainFrameMgr and MetaAchievementMainFrameMgr:GetSelectedSource(frame)
    if not src or not src.provider or type(src.provider.ToggleCollapsed) ~= "function" then return end
    src.provider:ToggleCollapsed(item.id)
    if MetaAchievementMainFrameMgr and type(MetaAchievementMainFrameMgr.RefreshList) == "function" then
        MetaAchievementMainFrameMgr:RefreshList(frame)
    end
end

function MetaAchievementJournalList_SetSelectedIndex(self, index)
    if type(index) ~= "number" or index < 1 then
        return
    end
    self._selectedIndex = index
    journalListFlushAndRepaint(self)
end

function MetaAchievementJournalListRow_OnClick(row, button)
    local list = row._owner
    if not list then return end
    local item = list._items and list._items[row._index]
    MetaAchievementUIBus:Emit("MA_JOURNAL_LIST_ITEM_CLICKED", list, row._index, item, button)
end
