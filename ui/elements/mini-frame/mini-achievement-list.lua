-- Mini achievement list: compact tree-view (same data as main journal list, smaller rows).
-- Uses WowScrollBoxList + MinimalScrollBar; selection and expand sync with ActiveAchievementState.
-- Achievements with no sub-achievements but with criteria can be expanded to show criteria rows.

local ROW_HEIGHT = 16
local ROW_GAP = 0
local CRITERIA_LINE_PROGRESS_HEIGHT = 28  -- progress rows (with bar) are taller than regular (16)

-- Assume every achievement is expanded for criteria (always show criteria when present).

local function getCriteriaLineHeight(criterion)
    if criterion and criterion.reqQuantity and criterion.reqQuantity > 1 and criterion.quantity ~= nil then
        return CRITERIA_LINE_PROGRESS_HEIGHT
    end
    return ROW_HEIGHT
end

--- Return extent (height) for a single flat display row. Used by extent provider and total height.
local function getFlatRowExtent(entry)
    if not entry then return ROW_HEIGHT end
    if entry.rowType == "criteria_line" and entry.criterion then
        return getCriteriaLineHeight(entry.criterion)
    end
    return ROW_HEIGHT
end
local NODE_ICON_COMPLETED = "Interface\\Buttons\\UI-CheckBox-Check"
local NODE_ICON_NOT_COMPLETED = "Interface\\Buttons\\UI-StopButton"

local function isMiniListAchievementCompleted(item)
    return item and item.data and item.data.completed == true
end

--- True if any criterion for this achievement has waypoints (from AchievementData).
local function achievementCriteriaHaveWaypoints(topAchievementId, achievementId)
    if not topAchievementId or not achievementId or not AchievementData or type(AchievementData.GetInformation) ~= "function" then
        return false
    end
    local flatInfo = AchievementData:GetInformation(topAchievementId, achievementId)
    if not flatInfo then return false end
    local criteria = flatInfo.virtualCriteria or flatInfo.criteria
    if not criteria or type(criteria) ~= "table" then return false end
    for _, cinfo in pairs(criteria) do
        if type(cinfo) == "table" and type(cinfo.waypoints) == "table" then
            if #cinfo.waypoints > 0 then return true end
            for _ in pairs(cinfo.waypoints) do return true end
        end
    end
    return false
end

--- Return number of criteria for an achievement (WoW API); 0 if none or API missing.
local function getAchievementNumCriteria(achievementId)
    if not achievementId or type(GetAchievementNumCriteria) ~= "function" then return 0 end
    local n = GetAchievementNumCriteria(achievementId)
    return (type(n) == "number" and n > 0) and n or 0
end

--- Return { total, completed, list } for achievement criteria. list entries match main-frame requirement shape: text, completed, quantity?, reqQuantity?, quantityString? (for progress vs regular display).
local function getCriteriaSummary(achievementId)
    local out = { total = 0, completed = 0, list = {} }
    if not achievementId or type(GetAchievementNumCriteria) ~= "function" or type(GetAchievementCriteriaInfo) ~= "function" then
        return out
    end
    local n = GetAchievementNumCriteria(achievementId)
    for i = 1, (n or 0) do
        local criteriaString, _, completed, quantity, reqQuantity, _, _, _, quantityString = GetAchievementCriteriaInfo(achievementId, i)
        if criteriaString and criteriaString ~= "" then
            local entry = {
                text = criteriaString,
                completed = completed == true,
            }
            if reqQuantity and reqQuantity > 0 and quantity ~= nil then
                entry.quantity = quantity
                entry.reqQuantity = reqQuantity
                if type(quantityString) == "string" and quantityString ~= "" then
                    entry.quantityString = quantityString
                end
            end
            out.total = out.total + 1
            if completed == true then out.completed = out.completed + 1 end
            out.list[#out.list + 1] = entry
        end
    end
    return out
end

function MetaAchievementMiniList_OnLoad(self)
    self.ScrollBox = self.ScrollBox or _G[self:GetName() .. "ScrollBox"]
    self.ScrollBar = self.ScrollBar or _G[self:GetName() .. "ScrollBar"]

    self._items = {}
    self._criteriaExpanded = {}  -- [achievementId] = true when criteria are shown
    self._selectedIndex = nil
    self._miniFrame = nil

    if not self.ScrollBox or not self.ScrollBar or not CreateScrollBoxListLinearView or not ScrollUtil or not ScrollUtil.InitScrollBoxListWithScrollBar then
        return
    end

    local scrollBox, scrollBar = self.ScrollBox, self.ScrollBar
    local list = self

    -- One row per entry; each row has a fixed extent (16 or 28 for progress criteria) so scroll math is correct.
    local view = CreateScrollBoxListLinearView(0, 0, 0, 0, 0)
    if view.SetVariableExtentEnabled and view.SetElementExtentProvider then
        view:SetVariableExtentEnabled(true)
        view:SetElementExtentProvider(function(elementData)
            return getFlatRowExtent(elementData)
        end)
    else
        view:SetElementExtent(ROW_HEIGHT)
    end

    view:SetElementInitializer("MetaAchievementMiniListRowTemplate", function(frame, elementData)
        local rowType = elementData and elementData.rowType
        local index = elementData and elementData.index or 0
        if not frame or not rowType then return end

        frame._owner = list
        frame._index = index
        frame._elementData = elementData

        -- Resolve refs once per frame (reused across rows).
        local name = frame:GetName()
        if name then
            frame.Text = frame.Text or _G[name .. "Text"]
            frame.Icon = frame.Icon or _G[name .. "Icon"]
            frame.Status = frame.Status or _G[name .. "Status"]
            frame.Selected = frame.Selected or _G[name .. "Selected"]
            frame.Expand = frame.Expand or _G[name .. "Expand"]
            frame.CriteriaHeaderRow = frame.CriteriaHeaderRow or _G[name .. "CriteriaHeaderRow"]
            frame.CriteriaLineRow = frame.CriteriaLineRow or _G[name .. "CriteriaLineRow"]
        end
        if not frame.CriteriaHeaderRow or not frame.CriteriaLineRow then
            for _, child in ipairs({ frame:GetChildren() }) do
                if child and child.GetName then
                    local cn = child:GetName()
                    if cn and cn:find("CriteriaHeaderRow") then frame.CriteriaHeaderRow = frame.CriteriaHeaderRow or child
                    elseif cn and cn:find("CriteriaLineRow") then frame.CriteriaLineRow = frame.CriteriaLineRow or child
                    end
                end
            end
        end
        if not frame.Text then
            for _, r in ipairs({ frame:GetRegions() }) do
                if r and r.GetObjectType then
                    if r:GetObjectType() == "FontString" then frame.Text = r
                    elseif r:GetObjectType() == "Texture" then
                        if not frame.Selected then frame.Selected = r
                        elseif not frame.Icon then frame.Icon = r
                        elseif not frame.Status then frame.Status = r
                        end
                    end
                end
            end
            for _, child in ipairs({ frame:GetChildren() }) do
                if child and child.GetName and child:GetName() and child:GetName():find("Expand") then
                    frame.Expand = child
                    break
                end
            end
        end
        for _, cr in ipairs({ frame.CriteriaHeaderRow, frame.CriteriaLineRow }) do
            if cr then
                local crName = cr:GetName()
                if crName then cr.Text = cr.Text or _G[crName .. "Text"] end
                if not cr.Text and cr.GetRegions then
                    for _, r in ipairs({ cr:GetRegions() }) do
                        if r and r.GetObjectType and r:GetObjectType() == "FontString" then
                            cr.Text = r
                            break
                        end
                    end
                end
            end
        end

        local extent = getFlatRowExtent(elementData)
        frame:SetHeight(extent)

        -- Hide template criteria regions; we show a single row per frame (header or one line) when needed.
        if frame.CriteriaHeaderRow then frame.CriteriaHeaderRow:Hide() end
        if frame.CriteriaLineRow then frame.CriteriaLineRow:Hide() end
        if frame._criteriaHeaderFrame then frame._criteriaHeaderFrame:Hide() end
        if frame._criteriaLineFrames then
            for _, lf in ipairs(frame._criteriaLineFrames) do lf:Hide() end
        end

        if rowType == "achievement" then
            local item = elementData.item
            local hasChildren = item and item.children and type(item.children) == "table" and #item.children > 0
            local numCriteria = (item and item.id) and getAchievementNumCriteria(item.id) or 0
            local hasCriteriaOnly = not hasChildren and numCriteria > 0
            local showExpand = (hasChildren or hasCriteriaOnly) and not isMiniListAchievementCompleted(item)

            if frame.Text then
                frame.Text:Show()
                local text = item and (item.title or (item.data and item.data.name) or tostring(item.id or "")) or ""
                local depth = tonumber(item and item.depth or 0) or 0
                if depth > 0 then text = string.rep("  ", depth) .. text end
                if frame.Text.SetText then frame.Text:SetText(text) end
            end
            if frame.Icon then
                if item and item.data and item.data.icon then
                    frame.Icon:SetTexture(item.data.icon)
                    frame.Icon:Show()
                else frame.Icon:Hide() end
            end
            if frame.Status then
                if item and item.completedIcon then
                    frame.Status:SetTexture(item.completedIcon)
                    if tostring(item.completedIcon):find("StopButton", 1, true) then
                        frame.Status:SetVertexColor(1, 0, 0, 1)
                    else
                        frame.Status:SetVertexColor(1, 1, 1, 1)
                    end
                    frame.Status:Show()
                else frame.Status:Hide() end
            end
            if frame.Expand then
                if showExpand then
                    if not frame.Expand.label then
                        frame.Expand.label = frame.Expand:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
                        frame.Expand.label:SetPoint("CENTER")
                        frame.Expand.label:SetJustifyH("CENTER")
                        frame.Expand.label:SetJustifyV("MIDDLE")
                    end
                    local showPlus = (hasChildren and item.colapsed) or (hasCriteriaOnly and list._criteriaExpanded[item.id] ~= true)
                    frame.Expand.label:SetText(showPlus and "+" or "−")
                    frame.Expand:Show()
                    frame.Expand._item = item
                    frame.Expand._owner = list
                    frame.Expand:SetScript("OnClick", function(btn) if btn._item and btn._owner then MetaAchievementMiniListExpand_OnClick(btn) end end)
                else frame.Expand:Hide() end
            end
        else
            if frame.Text then frame.Text:Hide() end
            if frame.Icon then frame.Icon:Hide() end
            if frame.Status then frame.Status:Hide() end
            if frame.Expand then frame.Expand:Hide() end

            if rowType == "criteria_header" then
                if not frame._criteriaHeaderFrame then
                    frame._criteriaHeaderFrame = CreateFrame("Frame", nil, frame, "MetaAchievementMiniListCriteriaHeaderRowTemplate")
                end
                local headerFrame = frame._criteriaHeaderFrame
                headerFrame:ClearAllPoints()
                headerFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
                headerFrame:SetPoint("RIGHT", frame, "RIGHT", 0, 0)
                headerFrame:SetHeight(ROW_HEIGHT)
                headerFrame:SetFrameLevel(frame:GetFrameLevel() + 1)
                local w = frame:GetWidth()
                if not w or w <= 0 then w = 280 end
                headerFrame:SetWidth(w)
                if MiniCriteriaRows and MiniCriteriaRows.ApplyHeader then
                    MiniCriteriaRows.ApplyHeader(headerFrame, elementData.completed or 0, elementData.total or 0)
                end
                -- Waypoint button: created and positioned in Lua (right side of criteria header when waypoints available)
                if not headerFrame.WaypointButton then
                    local btn = CreateFrame("Button", nil, headerFrame)
                    btn:SetSize(14, 14)
                    btn:SetPoint("TOPRIGHT", headerFrame, "TOPRIGHT", -28, 0)
                    local tex = btn:CreateTexture(nil, "ARTWORK")
                    tex:SetTexture("Interface\\MINIMAP\\Minimap-Waypoint-MapPin-Tracked")
                    tex:SetAllPoints(btn)
                    btn:SetScript("OnClick", function(b)
                        if b._achievementId and b._topAchievementId and type(MetaAchievementMapDetail_AddCriteriaWaypoints) == "function" then
                            MetaAchievementMapDetail_AddCriteriaWaypoints(b._achievementId, b._topAchievementId)
                        end
                    end)
                    headerFrame.WaypointButton = btn
                end
                local wpBtn = headerFrame.WaypointButton
                if elementData.hasWaypoints and elementData.achievementId and elementData.topAchievementId then
                    wpBtn._achievementId = elementData.achievementId
                    wpBtn._topAchievementId = elementData.topAchievementId
                    if type(MetaAchievementWaypointButton_SetTooltip) == "function" then
                        MetaAchievementWaypointButton_SetTooltip(wpBtn, "Add waypoints")
                    end
                    wpBtn:Show()
                else
                    wpBtn:Hide()
                end
                headerFrame:Show()
            elseif rowType == "criteria_line" then
                if not frame._criteriaLineFrames then
                    local lineFrame = CreateFrame("Frame", nil, frame, "MetaAchievementMiniListCriteriaLineTemplate")
                    local ln = lineFrame:GetName()
                    if ln then lineFrame.Text = lineFrame.Text or _G[ln .. "Text"]; lineFrame.Check = lineFrame.Check or _G[ln .. "Check"] end
                    if not lineFrame.Text and lineFrame.GetRegions then
                        for _, r in ipairs({ lineFrame:GetRegions() }) do
                            if r and r.GetObjectType then
                                if r:GetObjectType() == "FontString" then lineFrame.Text = r
                                elseif r:GetObjectType() == "Texture" then lineFrame.Check = lineFrame.Check or r end
                            end
                        end
                    end
                    frame._criteriaLineFrames = { lineFrame }
                end
                local lineFrame = frame._criteriaLineFrames[1]
                lineFrame:ClearAllPoints()
                lineFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
                lineFrame:SetPoint("RIGHT", frame, "RIGHT", 0, 0)
                lineFrame:SetFrameLevel(frame:GetFrameLevel() + 1)
                if MiniCriteriaRows and MiniCriteriaRows.ApplyLine and elementData.criterion then
                    MiniCriteriaRows.ApplyLine(lineFrame, elementData.criterion)
                elseif lineFrame.Text and elementData.criterion then
                    if lineFrame.Text.SetText then lineFrame.Text:SetText(elementData.criterion.text or "") end
                    lineFrame.Text:Show()
                end
                lineFrame:Show()
            end
        end

        -- Do not show row selection highlight (index can desync from visible rows when list changes).
        if frame.Selected then
            frame.Selected:Hide()
        end

        local parentOriginalIndex = elementData.parentOriginalIndex or (elementData.item and elementData.item._originalIndex)
        frame:SetScript("OnClick", function(f)
            list._selectedIndex = f._index
            if list._view and list._view.Refresh then list._view:Refresh() end
            local state = ActiveAchievementState and ActiveAchievementState:GetInstance()
            if state and type(state.SetActiveAchievementByIndex) == "function" and parentOriginalIndex then
                state:SetActiveAchievementByIndex(parentOriginalIndex)
            end
            -- Do not call RefreshContent here: it rebuilds the entire list and causes a large FPS drop. Selection + state update is enough.
        end)
        frame:SetScript("OnEnter", nil)
        frame:SetScript("OnLeave", nil)
    end)

    ScrollUtil.InitScrollBoxListWithScrollBar(scrollBox, scrollBar, view)

    local dataProvider = CreateDataProvider()
    scrollBox:SetDataProvider(dataProvider)

    self._dataProvider = dataProvider
    self._view = view
end

function MetaAchievementMiniList_SetItems(self, items, miniFrame)
    self._items = items or {}
    self._miniFrame = miniFrame
    self._criteriaExpanded = self._criteriaExpanded or {}
    local state = ActiveAchievementState and ActiveAchievementState:GetInstance()
    local wantOriginalIndex = (state and type(state.GetActiveIndex) == "function") and state:GetActiveIndex() or nil
    local topAchievementId = nil
    if state and type(state.GetActiveSource) == "function" then
        local src = state:GetActiveSource()
        if src and src.provider and src.provider.topAchievementId then
            topAchievementId = src.provider.topAchievementId
        end
    end

    -- Build flat display list: one entry per visible row (achievement, criteria header, or one criteria line each).
    local hideCompletedCriteria = MetaAchievementSettings and MetaAchievementSettings:Get("miniJournalHideCompletedCriteria")
    local displayEntries = {}
    for i, item in ipairs(self._items) do
        item._originalIndex = i
        displayEntries[#displayEntries + 1] = {
            index = #displayEntries + 1,
            rowType = "achievement",
            item = item,
            parentOriginalIndex = i,
        }
        local hasChildren = item.children and type(item.children) == "table" and #item.children > 0
        local numCriteria = getAchievementNumCriteria(item.id or 0)
        -- No criteria sub-rows for completed achievements (expand is hidden for those rows).
        if not hasChildren and numCriteria > 0 and not isMiniListAchievementCompleted(item) then
            -- Criteria block only when expanded (default collapsed when nil).
            if self._criteriaExpanded[item.id] == true then
            local summary = getCriteriaSummary(item.id)
            local list = summary.list or {}
            local visibleList = list
            if hideCompletedCriteria then
                visibleList = {}
                for _, c in ipairs(list) do
                    if not c.completed then visibleList[#visibleList + 1] = c end
                end
            end
            -- Header always shows real achievement counts (e.g. 2/5), not just visible counts.
            if #visibleList > 0 then
                displayEntries[#displayEntries + 1] = {
                    index = #displayEntries + 1,
                    rowType = "criteria_header",
                    achievementId = item.id,
                    parentOriginalIndex = i,
                    completed = summary.completed or 0,
                    total = summary.total or 0,
                    hasWaypoints = topAchievementId and achievementCriteriaHaveWaypoints(topAchievementId, item.id),
                    topAchievementId = topAchievementId,
                }
                for _, c in ipairs(visibleList) do
                    displayEntries[#displayEntries + 1] = {
                        index = #displayEntries + 1,
                        rowType = "criteria_line",
                        achievementId = item.id,
                        parentOriginalIndex = i,
                        criterion = c,
                    }
                end
            end
            end
        end
    end

    -- Resolve selected index: the display index of the achievement row for wantOriginalIndex.
    -- Store mapping so SetSelectedIndex(originalIndex) can resolve to display index.
    self._originalToDisplayIndex = {}
    for displayIdx, entry in ipairs(displayEntries) do
        if entry.rowType == "achievement" and entry.parentOriginalIndex then
            self._originalToDisplayIndex[entry.parentOriginalIndex] = displayIdx
        end
    end
    self._selectedIndex = nil
    if wantOriginalIndex then
        self._selectedIndex = self._originalToDisplayIndex[wantOriginalIndex]
    end

    local dp = self._dataProvider
    if not dp then return end
    dp:Flush()
    for _, entry in ipairs(displayEntries) do
        dp:Insert(entry)
    end

    local scrollBox = self.ScrollBox
    local scrollBar = self.ScrollBar
    local view = self._view
    if view and view.Refresh then view:Refresh() end
    -- Single deferred pass to settle scroll (avoid multiple Refresh/FullUpdate that hurt FPS).
    C_Timer.After(0, function()
        if scrollBox then
            if type(scrollBox.FullUpdate) == "function" then scrollBox:FullUpdate()
            elseif type(scrollBox.Update) == "function" then scrollBox:Update() end
            if type(scrollBox.ScrollToBegin) == "function" then scrollBox:ScrollToBegin()
            elseif scrollBar and type(scrollBar.SetValue) == "function" then scrollBar:SetValue(0) end
        end
    end)
end

function MetaAchievementMiniList_SetSelectedIndex(self, index)
    -- index is original achievement list index; convert to flat display index.
    self._selectedIndex = (self._originalToDisplayIndex and self._originalToDisplayIndex[index]) or index
    if self._view and self._view.Refresh then
        self._view:Refresh()
    end
end

function MetaAchievementMiniListExpand_OnClick(expandButton)
    local list = expandButton._owner
    local item = expandButton._item
    if not list or not item then return end
    if isMiniListAchievementCompleted(item) then
        return
    end
    local hasChildren = item.children and type(item.children) == "table" and #item.children > 0
    local numCriteria = (item.id and getAchievementNumCriteria(item.id)) or 0
    local hasCriteriaOnly = not hasChildren and numCriteria > 0

    if hasCriteriaOnly then
        list._criteriaExpanded = list._criteriaExpanded or {}
        list._criteriaExpanded[item.id] = not list._criteriaExpanded[item.id]
        MetaAchievementMiniList_SetItems(list, list._items, list._miniFrame)
        return
    end

    if not item.id then return end
    local state = ActiveAchievementState and ActiveAchievementState:GetInstance()
    if not state or type(state.GetActiveSource) ~= "function" then return end
    local src = state:GetActiveSource()
    if not src or not src.provider or type(src.provider.ToggleCollapsed) ~= "function" then return end
    src.provider:ToggleCollapsed(item.id)
    if type(state.InvalidateList) == "function" then
        state:InvalidateList()
    end
    local newList = type(state.GetList) == "function" and state:GetList() or {}
    MetaAchievementMiniList_SetItems(list, newList, list._miniFrame)
end

function MetaAchievementMiniListRow_OnClick(row, button)
    local list = row._owner
    if not list then return end
    list._selectedIndex = row._index
    if list._view and list._view.Refresh then list._view:Refresh() end
    local state = ActiveAchievementState and ActiveAchievementState:GetInstance()
    local originalIndex = row._elementData and row._elementData.parentOriginalIndex
    if state and type(state.SetActiveAchievementByIndex) == "function" and originalIndex then
        state:SetActiveAchievementByIndex(originalIndex)
    end
    -- Do not call RefreshContent: it rebuilds the entire list and causes a large FPS drop.
end
