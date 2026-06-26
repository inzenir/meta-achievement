-- Map detail element controller.
-- Shows header (icon + title + points/feat), description, reward, and scrollable requirements list.

local REQUIREMENT_ROW_HEIGHT = 20  -- fallback when RequirementRows not loaded yet
local REQUIREMENT_ROW_GAP = 0
local REQUIREMENTS_CRITERIA_GAP = 8  -- Vertical gap between Requirements box bottom and Criteria information box top

--- Return achievement link source: "none", "wowhead", or "wowdb". Tries Settings then raw DB (Blizzard may store under prefixed key).
local function getAchievementLinkSource()
    local v = (MetaAchievementSettings and MetaAchievementSettings:Get("achievementLinkSource")) or "none"
    if v ~= "none" then return v end
    if MetaAchievementConfigurationDB then
        local raw = MetaAchievementConfigurationDB["MetaAchievement_achievementLinkSource"] or MetaAchievementConfigurationDB["achievementLinkSource"]
        if raw == "wowhead" or raw == "wowdb" then return raw end
    end
    return "none"
end

--- Return RequirementsBox link button, resolving by name if not cached.
local function getRequirementsLinkButton(reqBox)
    if not reqBox then return nil end
    if reqBox.LinkButton then return reqBox.LinkButton end
    local name = reqBox:GetName()
    if name and name ~= "" then
        reqBox.LinkButton = _G[name .. "LinkButton"]
        return reqBox.LinkButton
    end
    return nil
end

local function requirementRowExtent(_elementData)
    return (RequirementRows and RequirementRows.REGULAR_HEIGHT) or REQUIREMENT_ROW_HEIGHT
end

--- True when a registered custom body override is active (hides default ScrollBox list).
local function mapDetailHasActiveBodyOverride(detail)
    if not detail or not MetaAchievementCustomRequirements then
        return false
    end
    local ov = detail._requirementsBodyOverrideElement
    if type(ov) ~= "string" or ov == "" then
        return false
    end
    if type(MetaAchievementCustomRequirements.GetBodyElement) ~= "function" then
        return false
    end
    return MetaAchievementCustomRequirements.GetBodyElement(ov) ~= nil
end

--- Requirements chrome (border, title, buttons) visible when there are rows OR a valid custom body override.
local function mapDetailShowsRequirementsChrome(detail)
    local n = (detail._requirements and #detail._requirements) or 0
    return n > 0 or mapDetailHasActiveBodyOverride(detail)
end

--- Pinned summary rows (virtual ProgressBar) render outside the ScrollBox to avoid variable-extent scroll glitches.
local function splitRequirementsForScroll(requirements)
    local pinned, scrollable = {}, {}
    for _, req in ipairs(requirements or {}) do
        if type(req) == "table" and req.isPinnedSummary then
            pinned[#pinned + 1] = req
        else
            scrollable[#scrollable + 1] = req
        end
    end
    return pinned, scrollable
end

local function ensureRequirementsPinnedHost(box)
    if not box then
        return nil
    end
    if box.PinnedHost then
        return box.PinnedHost
    end
    local boxName = box.GetName and box:GetName()
    if boxName and boxName ~= "" then
        box.PinnedHost = _G[boxName .. "PinnedHost"]
    end
    if box.PinnedHost then
        return box.PinnedHost
    end
    if type(CreateFrame) ~= "function" then
        return nil
    end
    local hostName = (boxName and boxName ~= "") and (boxName .. "PinnedHost") or nil
    local host = CreateFrame("Frame", hostName, box)
    host:SetPoint("TOPLEFT", box, "TOPLEFT", 6, -24)
    host:SetPoint("TOPRIGHT", box, "TOPRIGHT", -22, -24)
    host:SetHeight(0.001)
    host:Hide()
    if host.SetClipsChildren then
        host:SetClipsChildren(true)
    end
    box.PinnedHost = host
    return host
end

local function updateRequirementsScrollAnchors(self)
    local box = self and self.RequirementsBox
    if not box or not box.ScrollBox then
        return
    end
    local pinnedCount = #(self._requirementsPinned or {})
    local pinHeight = pinnedCount * ((RequirementRows and RequirementRows.PROGRESS_HEIGHT) or 41)
    local host = ensureRequirementsPinnedHost(box)
    local scrollBox = box.ScrollBox
    scrollBox:ClearAllPoints()
    if host and pinHeight > 0 then
        host:SetHeight(pinHeight)
        host:Show()
        scrollBox:SetPoint("TOPLEFT", host, "BOTTOMLEFT", 0, -2)
    else
        if host then
            host:SetHeight(0.001)
            host:Hide()
        end
        scrollBox:SetPoint("TOPLEFT", box, "TOPLEFT", 6, -24)
    end
    scrollBox:SetPoint("BOTTOMRIGHT", box, "BOTTOMRIGHT", -22, 8)
end

local function refreshRequirementsPinnedRows(self)
    if mapDetailHasActiveBodyOverride(self) then
        local host = self and self.RequirementsBox and self.RequirementsBox.PinnedHost
        if host then
            host:Hide()
        end
        return
    end
    local box = self and self.RequirementsBox
    if not box then
        return
    end
    local host = ensureRequirementsPinnedHost(box)
    if not host then
        return
    end
    local pinned = self._requirementsPinned or {}
    self._pinnedRowPool = self._pinnedRowPool or {}
    local pool = self._pinnedRowPool
    local rowHeight = (RequirementRows and RequirementRows.PROGRESS_HEIGHT) or 41

    for i = #pinned + 1, #pool do
        if pool[i] then
            pool[i]:Hide()
        end
    end

    for i, req in ipairs(pinned) do
        local row = pool[i]
        if not row then
            local rowName = box.GetName and box:GetName()
            rowName = (rowName and rowName ~= "") and (rowName .. "PinnedReq" .. i) or nil
            row = CreateFrame("Button", rowName, host, "MetaAchievementMapRequirementRowProgressTemplate")
            pool[i] = row
        end
        row:SetParent(host)
        row:Show()
        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", host, "TOPLEFT", 0, -((i - 1) * rowHeight))
        row:SetPoint("TOPRIGHT", host, "TOPRIGHT", 0, -((i - 1) * rowHeight))
        row:SetHeight(rowHeight)
        if RequirementRows and RequirementRows.InitRow then
            RequirementRows.InitRow(row, {
                index = i,
                req = req,
                templateName = RequirementRows.TEMPLATE_PROGRESS,
            }, self)
        end
    end

    updateRequirementsScrollAnchors(self)
end

--- Swap default requirement list vs. custom body; keeps RequirementsBox chrome. Global for docs / RefreshContentLayout.
function MetaAchievementMapDetail_SyncRequirementsBodyDisplay(self)
    if not self or not self.RequirementsBox or not MetaAchievementCustomRequirements then
        return
    end
    local box = self.RequirementsBox
    local ov = self._requirementsBodyOverrideElement
    local api
    if type(ov) == "string" and ov ~= "" then
        api = MetaAchievementCustomRequirements.GetBodyElement(ov)
        if not api then
            MetaAchievementCustomRequirements.WarnUnknownBodyElementOnce(ov)
        end
    end

    local sb, sbar = box.ScrollBox, box.ScrollBar
    local host = box.CustomBodyHost

    if api then
        if sb then
            sb:Hide()
        end
        if sbar then
            sbar:Hide()
        end
        if host then
            host:Show()
        end

        if self._customRequirementsBodyName ~= ov then
            MetaAchievementCustomRequirements.ReleaseDetailBody(self)
            self._customRequirementsBodyName = ov
            self._customRequirementsBodyFrame = api.Create(host, self)
            if self._customRequirementsBodyFrame then
                self._customRequirementsBodyFrame:SetParent(host)
                self._customRequirementsBodyFrame:ClearAllPoints()
                self._customRequirementsBodyFrame:SetAllPoints()
                self._customRequirementsBodyFrame:Show()
            end
        end
        if self._customRequirementsBodyFrame and api.SetContext then
            api.SetContext(self._customRequirementsBodyFrame, self)
        end
    else
        if sb then
            sb:Show()
        end
        if sbar then
            sbar:Show()
        end
        if host then
            host:Hide()
        end
        MetaAchievementCustomRequirements.ReleaseDetailBody(self)
        self._customRequirementsBodyName = nil
    end
end

local function setScrollChildWidth(self)
    if not self.RequirementsBox or not self.RequirementsBox.ScrollFrame or not self.RequirementsBox.ScrollFrame.ScrollChild then
        return
    end
    local w = self.RequirementsBox.ScrollFrame:GetWidth() or 0
    if w > 0 then
        self.RequirementsBox.ScrollFrame.ScrollChild:SetWidth(w)
    end
end

local function scrollableRequirementsUseProgressRows(scrollable)
    if not RequirementRows or not RequirementRows.IsProgressRequirement then
        return false
    end
    for _, req in ipairs(scrollable or {}) do
        if RequirementRows.IsProgressRequirement(req) then
            return true
        end
    end
    return false
end

local function configureRequirementsScrollView(box, scrollable)
    local view = box and box._view
    if not view then
        return
    end
    if scrollableRequirementsUseProgressRows(scrollable)
        and view.SetVariableExtentEnabled
        and view.SetElementExtentProvider
    then
        view:SetVariableExtentEnabled(true)
        view:SetElementExtentProvider(function(elementData)
            if RequirementRows and RequirementRows.GetRowHeightForTemplate then
                return RequirementRows.GetRowHeightForTemplate(elementData and elementData.templateName)
            end
            return REQUIREMENT_ROW_HEIGHT
        end)
    else
        if view.SetVariableExtentEnabled then
            view:SetVariableExtentEnabled(false)
        end
        view:SetElementExtent(requirementRowExtent())
    end
end

local function refreshRequirementsDataProvider(self)
    if mapDetailHasActiveBodyOverride(self) then
        return
    end
    refreshRequirementsPinnedRows(self)
    local box = self.RequirementsBox
    if not box or not box._dataProvider then return end
    local scrollable = self._requirementsScroll or {}
    configureRequirementsScrollView(box, scrollable)
    local dp = box._dataProvider
    local pinnedCount = #(self._requirementsPinned or {})
    dp:Flush()
    for i, req in ipairs(scrollable) do
        local templateName = (RequirementRows and RequirementRows.GetTemplateName)
            and RequirementRows.GetTemplateName(req)
            or "MetaAchievementMapRequirementRowRegularTemplate"
        dp:Insert({ index = pinnedCount + i, req = req, templateName = templateName })
    end
    if box._view and box._view.Refresh then box._view:Refresh() end
    local sb = box.ScrollBox
    if sb and sb.FullUpdate then
        pcall(function()
            sb:FullUpdate()
        end)
    end
end

--- Debounced refresh when the requirements ScrollBox gains non-zero size (WowScrollBoxList often paints 0 rows until layout settles).
local function scheduleRequirementsScrollRefresh(detail)
    if not detail or not C_Timer or not C_Timer.After then
        return
    end
    local token = (detail._reqScrollRefreshToken or 0) + 1
    detail._reqScrollRefreshToken = token
    C_Timer.After(0, function()
        if not detail or detail._reqScrollRefreshToken ~= token then
            return
        end
        if type(MetaAchievementMapDetail_RefreshContentLayout) == "function" then
            MetaAchievementMapDetail_RefreshContentLayout(detail)
        end
    end)
end

local function normalizeForWrap(s)
    if type(s) ~= "string" then
        return ""
    end
    -- Keep it readable in a wrapped FontString
    s = s:gsub("\r", "\n")
    s = s:gsub("\n+", "\n")
    s = s:gsub("[ \t]+", " ")
    s = s:gsub("^%s+", ""):gsub("%s+$", "")
    return s
end

local function formatRewardText(s)
    if type(s) ~= "string" then
        return ""
    end
    s = normalizeForWrap(s)

    -- Rewards often come as "A; B; C" or "A, B, C" — show each on its own line.
    -- We only split on ", " (comma+space) to avoid breaking numbers like "1,000".
    local hasSemicolon = s:find(";", 1, true) ~= nil
    local hasCommaSpace = s:find(", ", 1, true) ~= nil
    if not hasSemicolon and not hasCommaSpace then
        return s
    end

    -- Normalize both separators into ';' then split.
    local normalized = s
    if hasCommaSpace then
        normalized = normalized:gsub(",%s+", "; ")
    end

    local parts = {}
    for part in normalized:gmatch("([^;]+)") do
        part = part:gsub("^%s+", ""):gsub("%s+$", "")
        if part ~= "" then
            parts[#parts + 1] = part
        end
    end

    -- If normalization didn't actually produce multiple parts, keep original.
    if #parts <= 1 then
        return s
    end

    return table.concat(parts, "\n")
end

local HELP_BOX_MIN_HEIGHT = 88
local HELP_BOX_MAX_HEIGHT = 220

local function configureWrappedScrollText(text, scrollChild, scrollFrame, containerFrame, content, horizontalPadding)
    horizontalPadding = horizontalPadding or 16
    if not text or not scrollChild or not scrollFrame then
        return 0
    end

    local w = scrollFrame:GetWidth()
    if (not w or w <= 0) and containerFrame then
        w = containerFrame:GetWidth()
    end
    if not w or w <= 0 then
        w = 200
    end
    w = w - horizontalPadding
    if w < 50 then
        w = 50
    end

    if type(content) ~= "string" or content == "" then
        text:SetText("")
        scrollChild:SetWidth(w + horizontalPadding)
        scrollChild:SetHeight(1)
        if scrollFrame.SetVerticalScroll then
            scrollFrame:SetVerticalScroll(0)
        end
        return 0
    end

    if text.ClearAllPoints and text.SetPoint then
        text:ClearAllPoints()
        text:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", horizontalPadding / 2, 0)
    end
    if text.SetWordWrap then
        text:SetWordWrap(true)
    end
    if text.SetNonSpaceWrap then
        text:SetNonSpaceWrap(false)
    end
    if text.SetMaxLines then
        text:SetMaxLines(0)
    end
    text:SetWidth(w)
    text:SetText(content)

    local contentH = (text:GetStringHeight() or 0) + 8
    scrollChild:SetWidth(w + horizontalPadding)
    scrollChild:SetHeight(math.max(contentH, scrollFrame:GetHeight() or 1))
    if scrollFrame.SetVerticalScroll then
        scrollFrame:SetVerticalScroll(0)
    end
    return contentH
end

local function resizeHelpBoxForContent(self, contentH)
    if not self.HelpBox or type(self.HelpBox.SetHeight) ~= "function" then
        return
    end
    local chrome = 32
    local want = math.min(HELP_BOX_MAX_HEIGHT, math.max(HELP_BOX_MIN_HEIGHT, contentH + chrome))
    self.HelpBox:SetHeight(want)
end

local function updateHelpBoxContent(self, helpText)
    if not self.HelpBox or not self.HelpBox.ScrollFrame or not self.HelpBox.ScrollFrame.ScrollChild or not self.HelpBox.Text then
        return
    end
    local sf = self.HelpBox.ScrollFrame
    local sc = sf.ScrollChild
    local text = self.HelpBox.Text
    local normalized = (type(helpText) == "string" and helpText ~= "") and normalizeForWrap(helpText) or ""
    local contentH = configureWrappedScrollText(text, sc, sf, self.HelpBox, normalized, 16)
    resizeHelpBoxForContent(self, contentH)
end

local function updateRewardBoxContent(self, rewardText)
    if not self.RewardBox or not self.RewardBox.ScrollFrame or not self.RewardBox.ScrollFrame.ScrollChild or not self.RewardBox.Text then
        return
    end
    local sf = self.RewardBox.ScrollFrame
    local sc = sf.ScrollChild
    local text = self.RewardBox.Text
    local normalized = (type(rewardText) == "string" and rewardText ~= "") and formatRewardText(rewardText) or ""
    configureWrappedScrollText(text, sc, sf, self.RewardBox, normalized, 12)
end

local function updateCriteriaInfoBoxContent(self, text)
    if not self.CriteriaInfoBox or not self.CriteriaInfoBox.ScrollFrame or not self.CriteriaInfoBox.ScrollFrame.ScrollChild or not self.CriteriaInfoBox.Text then
        return
    end
    local sf = self.CriteriaInfoBox.ScrollFrame
    local sc = sf.ScrollChild
    local fs = self.CriteriaInfoBox.Text
    local normalized = (type(text) == "string" and text ~= "") and normalizeForWrap(text) or ""
    configureWrappedScrollText(fs, sc, sf, self.CriteriaInfoBox, normalized, 16)
end

local function acquireReqRow(self, idx)
    self._reqRowPool = self._reqRowPool or {}
    local row = self._reqRowPool[idx]
    if row then
        row:Show()
        return row
    end

    local scrollChild = self.RequirementsBox
        and self.RequirementsBox.ScrollFrame
        and self.RequirementsBox.ScrollFrame.ScrollChild
        or nil
    if not scrollChild then
        return nil
    end

    local rowName = self:GetName() .. "ReqRow" .. tostring(idx)
    row = CreateFrame("Button", rowName, scrollChild, "MetaAchievementMapRequirementRowTemplate")
    row:EnableMouse(true)
    row:RegisterForClicks("AnyUp")
    row._owner = self
    row._index = idx

    row.Check = _G[rowName .. "Check"]
    row.Text = _G[rowName .. "Text"]

    self._reqRowPool[idx] = row
    return row
end

local function renderRequirements(self)
    if not self.RequirementsBox or not self.RequirementsBox.ScrollFrame or not self.RequirementsBox.ScrollFrame.ScrollChild then
        return
    end

    local model = self._requirements or {}
    local scrollChild = self.RequirementsBox.ScrollFrame.ScrollChild
    setScrollChildWidth(self)

    self._reqRowPool = self._reqRowPool or {}

    for i = #model + 1, #self._reqRowPool do
        if self._reqRowPool[i] then
            self._reqRowPool[i]:Hide()
        end
    end

    for i, req in ipairs(model) do
        local row = acquireReqRow(self, i)
        if not row then
            return
        end
        row._index = i

        row:ClearAllPoints()
        if i == 1 then
            row:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 0, -2)
        else
            row:SetPoint("TOPLEFT", self._reqRowPool[i - 1], "BOTTOMLEFT", 0, -REQUIREMENT_ROW_GAP)
        end
        row:SetPoint("RIGHT", scrollChild, "RIGHT", 0, 0)

        if row.Text and row.Text.SetText then
            local availability = (type(req.availabilityText) == "string" and req.availabilityText ~= "") and (" |cffc8c8c8(" .. req.availabilityText .. ")|r") or ""
            row.Text:SetText((req.text or "") .. availability)
        end
        if row.Check then
            if req.completed == true then
                row.Check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
                row.Check:SetVertexColor(1, 1, 1)
            else
                row.Check:SetTexture("Interface\\Buttons\\UI-StopButton")
                row.Check:SetVertexColor(1, 0, 0)
            end
        end
    end

    scrollChild:SetHeight((#model * (REQUIREMENT_ROW_HEIGHT + REQUIREMENT_ROW_GAP)) + 8)
end

function MetaAchievementMapDetail_OnLoad(self)
    self.Header = _G[self:GetName() .. "Header"]
    self.RewardBox = _G[self:GetName() .. "RewardBox"]
    self.HelpBox = _G[self:GetName() .. "HelpBox"]
    self.RequirementsBox = _G[self:GetName() .. "RequirementsBox"]

    if self.Header then
        self.Header.LeftIcon = _G[self.Header:GetName() .. "LeftIcon"]
        if self.Header.LeftIcon then
            self.Header.LeftIcon.Icon = _G[self.Header.LeftIcon:GetName() .. "Icon"]
        end
        self.Header.Title = _G[self.Header:GetName() .. "Title"]
        self.Header.Subtitle = _G[self.Header:GetName() .. "Subtitle"]
        self.Header.RightBadge = _G[self.Header:GetName() .. "RightBadge"]
        if self.Header.RightBadge then
            self.Header.RightBadge.Feat = _G[self.Header.RightBadge:GetName() .. "Feat"]
            self.Header.RightBadge.PointsIcon = _G[self.Header.RightBadge:GetName() .. "PointsIcon"]
            self.Header.RightBadge.PointsFrame = _G[self.Header.RightBadge:GetName() .. "PointsFrame"]
            self.Header.RightBadge.PointsText = _G[self.Header.RightBadge:GetName() .. "PointsText"]
        end
    end

    if self.RewardBox then
        self.RewardBox.PreviewButton = _G[self.RewardBox:GetName() .. "PreviewButton"]
        self.RewardBox.ScrollFrame = _G[self.RewardBox:GetName() .. "ScrollFrame"]
        if self.RewardBox.ScrollFrame then
            self.RewardBox.ScrollFrame.ScrollChild = _G[self.RewardBox.ScrollFrame:GetName() .. "ScrollChild"]
            if self.RewardBox.ScrollFrame.ScrollChild then
                self.RewardBox.Text = _G[self.RewardBox.ScrollFrame.ScrollChild:GetName() .. "Text"]
            end
        end
        self.RewardBox.ScrollBar = _G[self.RewardBox:GetName() .. "ScrollBar"]
        if self.RewardBox.ScrollBar and self.RewardBox.ScrollFrame and ScrollUtil and type(ScrollUtil.InitScrollFrameWithScrollBar) == "function" then
            ScrollUtil.InitScrollFrameWithScrollBar(self.RewardBox.ScrollFrame, self.RewardBox.ScrollBar)
        end
    end
    self.MountPreviewPanel = _G[self:GetName() .. "MountPreviewPanel"]
    if self.HelpBox then
        self.HelpBox.WaypointButton = _G[self.HelpBox:GetName() .. "WaypointButton"]
        if self.HelpBox.WaypointButton and MetaAchievementWaypointButton_SetTooltip then
            MetaAchievementWaypointButton_SetTooltip(self.HelpBox.WaypointButton, "Add all waypoints")
        end
        self.HelpBox.ScrollFrame = _G[self.HelpBox:GetName() .. "ScrollFrame"]
        if self.HelpBox.ScrollFrame then
            self.HelpBox.ScrollFrame.ScrollChild = _G[self.HelpBox.ScrollFrame:GetName() .. "ScrollChild"]
            if self.HelpBox.ScrollFrame.ScrollChild then
                self.HelpBox.Text = _G[self.HelpBox.ScrollFrame.ScrollChild:GetName() .. "Text"]
            end
        end
        self.HelpBox.ScrollBar = _G[self.HelpBox:GetName() .. "ScrollBar"]
        if self.HelpBox.ScrollBar and self.HelpBox.ScrollFrame and ScrollUtil and type(ScrollUtil.InitScrollFrameWithScrollBar) == "function" then
            ScrollUtil.InitScrollFrameWithScrollBar(self.HelpBox.ScrollFrame, self.HelpBox.ScrollBar)
        end
        if self.HelpBox.ScrollFrame and not self.HelpBox.ScrollFrame._metaHelpTextWidthHook then
            self.HelpBox.ScrollFrame._metaHelpTextWidthHook = true
            self.HelpBox.ScrollFrame:HookScript("OnSizeChanged", function()
                if self._currentHelpText and type(self._currentHelpText) == "string" and self._currentHelpText ~= "" then
                    updateHelpBoxContent(self, self._currentHelpText)
                end
            end)
        end
    end
    if self.RequirementsBox then
        self.RequirementsBox.Label = _G[self.RequirementsBox:GetName() .. "Label"]
        if self.RequirementsBox.Label and self.RequirementsBox.Label.SetText then
            self.RequirementsBox.Label:SetText("REQUIREMENTS")
        end
        self.RequirementsBox.WaypointButton = _G[self.RequirementsBox:GetName() .. "WaypointButton"]
        if self.RequirementsBox.WaypointButton and MetaAchievementWaypointButton_SetTooltip then
            MetaAchievementWaypointButton_SetTooltip(self.RequirementsBox.WaypointButton, "Add all waypoints")
        end
        self.RequirementsBox.LinkButton = _G[self.RequirementsBox:GetName() .. "LinkButton"]
        if self.RequirementsBox.LinkButton and MetaAchievementLinkButton_SetTooltip then
            MetaAchievementLinkButton_SetTooltip(self.RequirementsBox.LinkButton, "Open achievement link")
        end
        self.RequirementsBox.ScrollBox = _G[self.RequirementsBox:GetName() .. "ScrollBox"]
        self.RequirementsBox.ScrollBar = _G[self.RequirementsBox:GetName() .. "ScrollBar"]
        self.RequirementsBox.PinnedHost = _G[self.RequirementsBox:GetName() .. "PinnedHost"]
        ensureRequirementsPinnedHost(self.RequirementsBox)
        self.RequirementsBox.CustomBodyHost = _G[self.RequirementsBox:GetName() .. "CustomBodyHost"]

        if self.RequirementsBox.ScrollBox and self.RequirementsBox.ScrollBar and CreateScrollBoxListLinearView and ScrollUtil and ScrollUtil.InitScrollBoxListWithScrollBar and CreateDataProvider then
            local box = self.RequirementsBox
            local scrollBox, scrollBar = box.ScrollBox, box.ScrollBar
            local detail = self

            local view = CreateScrollBoxListLinearView()
            -- Scroll list is regular rows only; pinned summary progress renders in PinnedHost above.
            view:SetElementExtent(requirementRowExtent())

            local function requirementRowInit(frame, elementData)
                if RequirementRows and RequirementRows.ApplyRowFrameMetrics then
                    RequirementRows.ApplyRowFrameMetrics(frame, elementData)
                end
                if RequirementRows and RequirementRows.InitRow then
                    RequirementRows.InitRow(frame, elementData, detail)
                end
            end

            if view.SetElementTemplateProvider then
                view:SetElementTemplateProvider(function(elementData)
                    return (elementData and elementData.templateName) or "MetaAchievementMapRequirementRowRegularTemplate"
                end)
                view:SetElementInitializer("MetaAchievementMapRequirementRowDescriptionTemplate", requirementRowInit)
                view:SetElementInitializer("MetaAchievementMapRequirementRowRegularTemplate", requirementRowInit)
                view:SetElementInitializer("MetaAchievementMapRequirementRowProgressTemplate", requirementRowInit)
            else
                view:SetElementInitializer("MetaAchievementMapRequirementRowTemplate", requirementRowInit)
            end

            ScrollUtil.InitScrollBoxListWithScrollBar(scrollBox, scrollBar, view)

            local dataProvider = CreateDataProvider()
            scrollBox:SetDataProvider(dataProvider)

            box._dataProvider = dataProvider
            box._view = view

            -- Repopulate once when the ScrollBox first gets usable dimensions (avoid re-flushing on every scroll resize).
            scrollBox:SetScript("OnSizeChanged", function(sb)
                local w = sb:GetWidth() or 0
                local h = sb:GetHeight() or 0
                if w < 2 or h < 2 then
                    return
                end
                if not detail._requirements or #detail._requirements == 0 then
                    return
                end
                if detail._reqScrollLayoutReady then
                    return
                end
                detail._reqScrollLayoutReady = true
                scheduleRequirementsScrollRefresh(detail)
            end)
            scrollBox:SetScript("OnShow", function()
                if detail._requirements and #detail._requirements > 0 and not detail._reqScrollLayoutReady then
                    scheduleRequirementsScrollRefresh(detail)
                end
            end)
        end
    end
    self.CriteriaInfoBox = _G[self:GetName() .. "CriteriaInfoBox"]
    if self.CriteriaInfoBox then
        self.CriteriaInfoBox.Label = _G[self.CriteriaInfoBox:GetName() .. "Label"]
        self.CriteriaInfoBox.WaypointButton = _G[self.CriteriaInfoBox:GetName() .. "WaypointButton"]
        if self.CriteriaInfoBox.WaypointButton and MetaAchievementWaypointButton_SetTooltip then
            MetaAchievementWaypointButton_SetTooltip(self.CriteriaInfoBox.WaypointButton, "Add waypoint")
        end
        self.CriteriaInfoBox.ScrollFrame = _G[self.CriteriaInfoBox:GetName() .. "ScrollFrame"]
        if self.CriteriaInfoBox.ScrollFrame then
            self.CriteriaInfoBox.ScrollFrame.ScrollChild = _G[self.CriteriaInfoBox.ScrollFrame:GetName() .. "ScrollChild"]
            if self.CriteriaInfoBox.ScrollFrame.ScrollChild then
                self.CriteriaInfoBox.Text = _G[self.CriteriaInfoBox.ScrollFrame.ScrollChild:GetName() .. "Text"]
            end
        end
        self.CriteriaInfoBox.ScrollBar = _G[self.CriteriaInfoBox:GetName() .. "ScrollBar"]
        if self.CriteriaInfoBox.ScrollBar and self.CriteriaInfoBox.ScrollFrame and ScrollUtil and type(ScrollUtil.InitScrollFrameWithScrollBar) == "function" then
            ScrollUtil.InitScrollFrameWithScrollBar(self.CriteriaInfoBox.ScrollFrame, self.CriteriaInfoBox.ScrollBar)
        end
    end

    self._requirements = {}
    self._reqRowPool = {}

    -- Set up waypoint button OnClick handlers
    if self.HelpBox and self.HelpBox.WaypointButton then
        self.HelpBox.WaypointButton:SetScript("OnClick", function()
            MetaAchievementMapDetail_OnHelpBoxWaypointButtonClick(self)
        end)
    end
    if self.RequirementsBox and self.RequirementsBox.WaypointButton then
        self.RequirementsBox.WaypointButton:SetScript("OnClick", function()
            MetaAchievementMapDetail_OnRequirementsBoxWaypointButtonClick(self)
        end)
    end
    if self.RequirementsBox and self.RequirementsBox.LinkButton then
        self.RequirementsBox.LinkButton:SetScript("OnClick", function()
            MetaAchievementMapDetail_OnRequirementsBoxLinkButtonClick(self)
        end)
    end
    if self.CriteriaInfoBox and self.CriteriaInfoBox.WaypointButton then
        self.CriteriaInfoBox.WaypointButton:SetScript("OnClick", function()
            MetaAchievementMapDetail_OnCriteriaInfoBoxWaypointButtonClick(self)
        end)
    end

    -- Refresh content layout when detail is shown (fixes empty panels when SetData ran before frame had valid dimensions).
    self:SetScript("OnShow", function()
        if self._currentRewardText ~= nil or self._currentHelpText ~= nil or mapDetailShowsRequirementsChrome(self) then
            MetaAchievementMapDetail_RefreshContentLayout(self)
        end
    end)
end

local function isRewardEmpty(rewardText)
    if type(rewardText) ~= "string" then
        return true
    end
    local t = rewardText:gsub("^%s+", ""):gsub("%s+$", "")
    if t == "" then
        return true
    end
    -- Common placeholders
    if t == "—" or t == "-" then
        return true
    end
    return false
end

local DEFAULT_WAYPOINT_HELP = "Use the waypoint button to add this location to your map."
local DELVE_STORY_CRITERIA_TYPE = 73

local function criterionHasWaypoints(cinfo)
    if type(cinfo) ~= "table" or type(cinfo.waypoints) ~= "table" then
        return false
    end
    if #cinfo.waypoints > 0 then
        return true
    end
    for _ in pairs(cinfo.waypoints) do
        return true
    end
    return false
end

local function achievementHasDirectWaypoints(flatInfo)
    if not flatInfo or type(flatInfo.waypoints) ~= "table" then
        return false
    end
    if #flatInfo.waypoints > 0 then
        return true
    end
    for _ in pairs(flatInfo.waypoints) do
        return true
    end
    return false
end

--- True if this criterion row is completed. Virtual rows (e.g. quest IDs + criteriaType 27) must use
--- `IsAchievementCriteriaCompleted`; `MetaAchievementMapCriterionIsCompleted` only matches WoW API criteria indices/ids.
local function isCriterionCompleted(achievementId, criteriaId, cinfo)
    if not achievementId or not criteriaId then
        return false
    end
    if type(cinfo) == "table" and type(cinfo.criteriaType) == "number" then
        if VirtualCriteriaTypes and VirtualCriteriaTypes.IsVirtual(cinfo.criteriaType) then
            return false
        end
        if type(IsAchievementCriteriaCompleted) == "function" then
            local viaType = IsAchievementCriteriaCompleted(achievementId, criteriaId, cinfo.criteriaType)
            if viaType ~= nil then
                return viaType == true
            end
        end
    end
    if type(MetaAchievementMapCriterionIsCompleted) == "function" then
        return MetaAchievementMapCriterionIsCompleted(achievementId, criteriaId)
    end
    return false
end

local function hasHelpText(helpText)
    if type(helpText) ~= "string" then
        return false
    end
    local t = helpText:gsub("^%s+", ""):gsub("%s+$", "")
    return t ~= ""
end

local function getDelveAvailabilityForCriterion(achievementId, criteriaId, criterion)
    if type(criterion) ~= "table" then
        return nil, nil
    end
    if type(criterion.criteriaType) ~= "number" or criterion.criteriaType ~= DELVE_STORY_CRITERIA_TYPE then
        return nil, nil
    end
    if type(achievementId) ~= "number" or type(criteriaId) ~= "number" then
        return nil, nil
    end
    if not MetaAchievementDelveStoryAvailability
        or type(MetaAchievementDelveStoryAvailability.GetAvailabilityStateForCriteria) ~= "function"
    then
        return nil, nil
    end
    local state, text = MetaAchievementDelveStoryAvailability.GetAvailabilityStateForCriteria(achievementId, criteriaId)
    return state, text
end

--- True when achievement data includes delve storyline rows (criteriaType 73) for availability labels.
local function achievementNeedsDelveStoryAvailabilityScan(achievementInformation)
    if type(achievementInformation) ~= "table" then
        return false
    end
    local crit = achievementInformation.criteria
    if type(crit) == "table" then
        for _, cinfo in pairs(crit) do
            if type(cinfo) == "table" and cinfo.criteriaType == DELVE_STORY_CRITERIA_TYPE then
                return true
            end
        end
    end
    local vc = achievementInformation.virtualCriteria
    if type(vc) == "table" then
        for _, cinfo in pairs(vc) do
            if type(cinfo) == "table" and cinfo.criteriaType == DELVE_STORY_CRITERIA_TYPE then
                return true
            end
        end
    end
    return false
end

local function updateRewardHelpAndRequirementsLayout(self, rewardText, helpText)
    if not self or not self.RewardBox or not self.RequirementsBox or not self.Header then
        return
    end

    local hasReward = not isRewardEmpty(rewardText)
    local hasHelp = self.HelpBox and hasHelpText(helpText)
    local hasRequirements = mapDetailShowsRequirementsChrome(self)

    self.RewardBox:SetShown(hasReward)

    if self.HelpBox then
        self.HelpBox:SetShown(hasHelp)
        if hasHelp then
            self.HelpBox:ClearAllPoints()
            local mountPreviewShown = self.MountPreviewPanel and self.MountPreviewPanel:IsShown()
            if mountPreviewShown and self.MountPreviewPanel then
                self.HelpBox:SetPoint("TOPLEFT", self.MountPreviewPanel, "BOTTOMLEFT", 0, -6)
                self.HelpBox:SetPoint("TOPRIGHT", self.MountPreviewPanel, "BOTTOMRIGHT", 0, -6)
            elseif hasReward then
                self.HelpBox:SetPoint("TOPLEFT", self.RewardBox, "BOTTOMLEFT", 0, -6)
                self.HelpBox:SetPoint("TOPRIGHT", self.RewardBox, "BOTTOMRIGHT", 0, -6)
            else
                self.HelpBox:SetPoint("TOPLEFT", self.Header, "BOTTOMLEFT", 0, -6)
                self.HelpBox:SetPoint("TOPRIGHT", self.Header, "BOTTOMRIGHT", 0, -6)
            end
            -- Refresh scroll content with correct width now that the box is laid out
            updateHelpBoxContent(self, helpText)
        end
    end

    -- Hide RequirementsBox if there are no requirements
    self.RequirementsBox:SetShown(hasRequirements)
    if not hasRequirements then
        return
    end

    -- Show link button only when achievement link source is not None
    local linkSource = getAchievementLinkSource()
    local linkBtn = getRequirementsLinkButton(self.RequirementsBox)
    if linkBtn then
        linkBtn:SetShown(linkSource ~= "none")
    end

    -- Requirements anchor below help (if shown), else mount preview, else reward, else header.
    self.RequirementsBox:ClearAllPoints()
    local anchorAbove = self
    local anchorPoint = "BOTTOMLEFT"
    local mountPreviewShown = self.MountPreviewPanel and self.MountPreviewPanel:IsShown()
    if hasHelp and self.HelpBox then
        anchorAbove = self.HelpBox
        anchorPoint = "BOTTOMLEFT"
    elseif mountPreviewShown and self.MountPreviewPanel then
        anchorAbove = self.MountPreviewPanel
        anchorPoint = "BOTTOMLEFT"
    elseif hasReward then
        anchorAbove = self.RewardBox
        anchorPoint = "BOTTOMLEFT"
    else
        anchorAbove = self.Header
        anchorPoint = "BOTTOMLEFT"
    end
    self.RequirementsBox:SetPoint("TOPLEFT", anchorAbove, anchorPoint, 0, -6)
    if self.CriteriaInfoBox and self.CriteriaInfoBox:IsShown() then
        local gap = -REQUIREMENTS_CRITERIA_GAP
        self.RequirementsBox:SetPoint("BOTTOMLEFT", self.CriteriaInfoBox, "TOPLEFT", 0, REQUIREMENTS_CRITERIA_GAP)
        self.RequirementsBox:SetPoint("BOTTOMRIGHT", self.CriteriaInfoBox, "TOPRIGHT", 0, gap)
    else
        self.RequirementsBox:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)
    end
end

--- Re-apply scroll content and requirements layout after the frame has been laid out (fixes empty/broken layout on first open).
--- Global so OnShow and C_Timer.After callbacks can call it (they run in contexts where locals may be out of scope).
--- Repopulates the requirements ScrollBox data provider: a bare view:Refresh() is not enough when the ScrollBox had
--- zero height or was not laid out when SetData first ran.
function MetaAchievementMapDetail_RefreshContentLayout(self)
    if not self then return end
    local rewardText = self._currentRewardText
    local helpText = self._currentHelpText
    if self.RewardBox then
        updateRewardBoxContent(self, formatRewardText(rewardText or ""))
    end
    if self.HelpBox and type(helpText) == "string" then
        updateHelpBoxContent(self, (helpText ~= "") and normalizeForWrap(helpText) or "")
    end
    -- Anchor RequirementsBox after reward/help heights are final, then flush+reinsert rows (ScrollBoxList needs this on first paint).
    updateRewardHelpAndRequirementsLayout(self, rewardText or "", helpText or "")
    refreshRequirementsDataProvider(self)
    MetaAchievementMapDetail_SyncRequirementsBodyDisplay(self)
end

local CRITERIA_INFO_BOX_TITLE = "CRITERIA INFORMATION"

local function setCriteriaInfoBox(self, content, criteriaName, criteriaId)
    if not self or not self.CriteriaInfoBox then
        return
    end
    local hasContent = type(content) == "string" and content:gsub("^%s+", ""):gsub("%s+$", "") ~= ""
    if self.CriteriaInfoBox.Label and self.CriteriaInfoBox.Label.SetText then
        local title = CRITERIA_INFO_BOX_TITLE
        if hasContent and type(criteriaName) == "string" and criteriaName:gsub("^%s+", ""):gsub("%s+$", "") ~= "" then
            title = CRITERIA_INFO_BOX_TITLE .. " - " .. criteriaName:upper()
        end
        self.CriteriaInfoBox.Label:SetText(title)
    end
    
    -- Store the selected criteria ID for waypoint button handler
    self._selectedCriteriaId = criteriaId
    
    -- Show/hide waypoint button based on whether this criterion has waypoints (and, if addWpsOnlyForUncompletedAchis, only when criterion is not completed)
    local hasWaypoints = false
    local cinfo = nil
    if criteriaId and self._flatInfo then
        if type(self._flatInfo.criteria) == "table" then
            cinfo = self._flatInfo.criteria[criteriaId]
        end
        if not cinfo and type(self._flatInfo.virtualCriteria) == "table" then
            cinfo = self._flatInfo.virtualCriteria[criteriaId]
        end
        hasWaypoints = criterionHasWaypoints(cinfo)
    end
    local onlyUncompleted = MetaAchievementSettings and MetaAchievementSettings:Get("addWpsOnlyForUncompletedAchis")
    local criterionCompleted = criteriaId and self._achievementId and isCriterionCompleted(self._achievementId, criteriaId, cinfo)
    local showWaypoint = hasWaypoints and hasContent and (not onlyUncompleted or not criterionCompleted)
    if self.CriteriaInfoBox.WaypointButton then
        self.CriteriaInfoBox.WaypointButton:SetShown(showWaypoint)
    end
    
    if hasContent then
        updateCriteriaInfoBoxContent(self, content)
        self.CriteriaInfoBox:Show()
    else
        updateCriteriaInfoBoxContent(self, "")
        self.CriteriaInfoBox:Hide()
    end
    updateRewardHelpAndRequirementsLayout(self, self._currentRewardText or "", self._currentHelpText or "")
    MetaAchievementMapDetail_SyncRequirementsBodyDisplay(self)
end

function MetaAchievementMapDetail_SetData(self, data)
    data = data or {}

    if self.Header and self.Header.LeftIcon and self.Header.LeftIcon.Icon and data.icon then
        self.Header.LeftIcon.Icon:SetTexture(data.icon)
    end
    if self.Header and self.Header.Title and self.Header.Title.SetText then
        self.Header.Title:SetText(data.title or "")
        self.Header.Title:SetScale(1.15)
    end
    if self.Header and self.Header.Subtitle and self.Header.Subtitle.SetText then
        local subtitle = data.subtitle or data.headerDescription or data.description or ""
        subtitle = normalizeForWrap(subtitle)
        -- Prefer up to 2 lines in the banner when available (client-dependent API).
        if self.Header.Subtitle.SetWordWrap then
            self.Header.Subtitle:SetWordWrap(true)
        end
        if self.Header.Subtitle.SetMaxLines then
            self.Header.Subtitle:SetMaxLines(2)
        end
        self.Header.Subtitle:SetText(subtitle)
        self.Header.Subtitle:SetShown(subtitle ~= "")
    end

    -- Right badge: points or feat (default feat)
    local points = data.points
    local isFeat = (data.isFeat == true) or (points == nil)
    if self.Header and self.Header.RightBadge then
        if self.Header.RightBadge.Feat then
            self.Header.RightBadge.Feat:SetShown(isFeat)
        end
        if self.Header.RightBadge.PointsIcon then
            self.Header.RightBadge.PointsIcon:SetShown(not isFeat)
        end
        if self.Header.RightBadge.PointsFrame then
            self.Header.RightBadge.PointsFrame:SetShown(not isFeat)
        end
        if self.Header.RightBadge.PointsText then
            self.Header.RightBadge.PointsText:SetShown(not isFeat)
            if not isFeat then
                self.Header.RightBadge.PointsText:SetText(tostring(points or ""))
            end
        end
    end

    if self.RewardBox then
        updateRewardBoxContent(self, formatRewardText(data.reward or ""))
    end

    if self.HelpBox then
        local ht = (type(data.helpText) == "string" and data.helpText ~= "") and normalizeForWrap(data.helpText) or ""
        updateHelpBoxContent(self, ht)
    end

    self._currentRewardText = data.reward or ""
    self._currentHelpText = data.helpText or ""
    self._requirementsBodyOverrideElement = data.requirementsBodyOverrideElement
    local allRequirements = data.requirements or {}
    self._requirements = allRequirements
    self._requirementsPinned, self._requirementsScroll = splitRequirementsForScroll(allRequirements)
    self._reqScrollLayoutReady = false

    setCriteriaInfoBox(self, nil)
    updateRewardHelpAndRequirementsLayout(self, data.reward, data.helpText)
    refreshRequirementsDataProvider(self)
    MetaAchievementMapDetail_SyncRequirementsBodyDisplay(self)

    -- Defer layout refresh so scroll frames have valid dimensions (fixes empty reward/help/requirements on first open).
    if C_Timer and type(C_Timer.After) == "function" then
        C_Timer.After(0, function()
            if self and (self._currentRewardText ~= nil or self._currentHelpText ~= nil or mapDetailShowsRequirementsChrome(self)) then
                MetaAchievementMapDetail_RefreshContentLayout(self)
            end
        end)
        -- Second tick: map inset / ScrollBox often only get final size after the first deferred frame.
        C_Timer.After(0.05, function()
            if self and mapDetailShowsRequirementsChrome(self) then
                MetaAchievementMapDetail_RefreshContentLayout(self)
            end
        end)
    end
end

local function getAchievementInfoSafe(achievementId)
    if type(GetAchievementInfo) ~= "function" then
        return nil
    end
    local ok, _, name, points, _, _, _, _, description, _, icon, reward = pcall(GetAchievementInfo, achievementId)
    if not ok then
        return nil
    end
    return name, points, description, icon, reward
end

--- virtualCriteria key order: numeric keys ascending when all keys are numbers (matches sorted waypoints files).
--- Else if every row has numeric criterion.index, sort by that. Else hash iteration order (undefined).
--- Skips non-table values (e.g. combineVirtualAndRegularCriteria = true on the virtualCriteria table).
local function virtualCriteriaSortedKeys(virtualCriteria)
    local keys = {}
    for k in pairs(virtualCriteria) do
        if type(virtualCriteria[k]) == "table" then
            keys[#keys + 1] = k
        end
    end
    local n = #keys
    if n == 0 then
        return keys
    end
    local allNumericKeys = true
    for _, k in ipairs(keys) do
        if type(k) ~= "number" then
            allNumericKeys = false
            break
        end
    end
    if allNumericKeys then
        table.sort(keys)
        return keys
    end
    for _, k in ipairs(keys) do
        local c = virtualCriteria[k]
        if type(c) ~= "table" or type(c.index) ~= "number" then
            return keys
        end
    end
    table.sort(keys, function(a, b)
        local ia = virtualCriteria[a].index
        local ib = virtualCriteria[b].index
        if ia ~= ib then
            return ia < ib
        end
        return tostring(a) < tostring(b)
    end)
    return keys
end

--- Count completed vs total rows in a waypoints `criteria` table (used by virtual progress-bar criteria).
local function countTrackedCriteriaProgress(achievementId, criteriaTable)
    if not achievementId or type(criteriaTable) ~= "table" then
        return 0, 0
    end
    local total, completed = 0, 0
    for criteriaId, cinfo in pairs(criteriaTable) do
        if type(cinfo) == "table" then
            total = total + 1
            if isCriterionCompleted(achievementId, criteriaId, cinfo) then
                completed = completed + 1
            end
        end
    end
    return completed, total
end

--- Count completed vs total from WoW API criteria (for ProgressBar rows with countFromApi on virtualCriteria).
local function countApiCriteriaProgress(achievementId)
    if not achievementId or type(GetAchievementNumCriteria) ~= "function" or type(GetAchievementCriteriaInfo) ~= "function" then
        return 0, 0
    end
    local num = GetAchievementNumCriteria(achievementId) or 0
    local total, completed = 0, 0
    for i = 1, num do
        local _, _, completedFlag = GetAchievementCriteriaInfo(achievementId, i)
        total = total + 1
        if completedFlag == true then
            completed = completed + 1
        end
    end
    return completed, total
end

--- True when virtual rows are appended after regular WoW API criteria. Flag may be on the achievement entry or on virtualCriteria.
local function getCombineVirtualAndRegularFlag(achievementInformation)
    if not achievementInformation then
        return false
    end
    if achievementInformation.combineVirtualAndRegularCriteria == true then
        return true
    end
    local vc = achievementInformation.virtualCriteria
    if type(vc) == "table" and vc.combineVirtualAndRegularCriteria == true then
        return true
    end
    return false
end

local CRITERIA_TYPE_ACHIEVEMENT = 8

--- Parent meta criterion (type 8) for a sub-achievement id, if any.
local function findParentCriterionForSubAchievement(parentAchievementId, subAchievementId)
    if not parentAchievementId or not subAchievementId then
        return nil
    end
    if type(GetAchievementNumCriteria) ~= "function" or type(GetAchievementCriteriaInfo) ~= "function" then
        return nil
    end
    local numCriteria = GetAchievementNumCriteria(parentAchievementId) or 0
    for i = 1, numCriteria do
        local criteriaString, criteriaType, completed, quantity, reqQuantity, _charName, flags, assetID, quantityString, criteriaID =
            GetAchievementCriteriaInfo(parentAchievementId, i)
        if criteriaType == CRITERIA_TYPE_ACHIEVEMENT and assetID == subAchievementId then
            return {
                index = i,
                criteriaId = criteriaID,
                criteriaType = criteriaType,
                completed = completed == true,
                criteriaString = criteriaString,
                quantity = quantity,
                reqQuantity = reqQuantity,
                quantityString = quantityString,
            }
        end
    end
    return nil
end

--- Append WoW API criteria rows. apiCriteriaIndex is stored for requirement row clicks when combined with virtual rows (display order may differ from API index).
local function appendRegularCriteriaFromApi(achievementId, requirements, achievementInformation)
    if type(GetAchievementNumCriteria) ~= "function" or type(GetAchievementCriteriaInfo) ~= "function" then
        return
    end
    local numCriteria = GetAchievementNumCriteria(achievementId) or 0
    local overrides = achievementInformation and type(achievementInformation.criteria) == "table" and achievementInformation.criteria
    for i = 1, numCriteria do
        local criteriaString, criteriaType, completed, quantity, reqQuantity, _charName, _flags, _assetID, quantityString, criteriaID, _eligible =
            GetAchievementCriteriaInfo(achievementId, i)
        -- List title: explicit override, then API name, then waypoints name. helpText is for the criteria info box only.
        local text
        if overrides and criteriaID then
            local o = overrides[criteriaID]
            if type(o) == "table" and type(o.text) == "string" and o.text ~= "" then
                text = o.text
            end
        end
        if not text and type(criteriaString) == "string" and criteriaString ~= "" then
            text = criteriaString
        end
        if not text and overrides and criteriaID then
            local o = overrides[criteriaID]
            if type(o) == "table" and type(o.name) == "string" and o.name ~= "" then
                text = o.name
            end
        end
        text = text or ("Criteria " .. tostring(i))
        local entry = {
            text = text,
            completed = completed == true,
            apiCriteriaIndex = i,
            criteriaId = criteriaID,
            criteriaType = criteriaType,
        }
        if overrides and criteriaID and type(overrides[criteriaID]) == "table" then
            local state, availabilityText = getDelveAvailabilityForCriterion(achievementId, criteriaID, overrides[criteriaID])
            entry.availabilityState = state
            entry.availabilityText = availabilityText
        end
        if reqQuantity and reqQuantity > 0 and quantity ~= nil then
            entry.quantity = quantity
            entry.reqQuantity = reqQuantity
            if type(quantityString) == "string" and quantityString ~= "" then
                entry.quantityString = quantityString
            end
        end
        requirements[#requirements + 1] = entry
    end
end

local function buildRequirementsFromCriteria(achievementId, topAchievementId)
    local requirements = {}

    local achievementInformation = AchievementData:GetInformation(topAchievementId, achievementId)
    if achievementInformation and achievementNeedsDelveStoryAvailabilityScan(achievementInformation) then
        if MetaAchievementDelveStoryAvailability and type(MetaAchievementDelveStoryAvailability.TryRefreshForMapDetail) == "function" then
            MetaAchievementDelveStoryAvailability.TryRefreshForMapDetail()
        end
    end
    local hasVirtual = achievementInformation and type(achievementInformation.virtualCriteria) == "table"
    local combineVirtualAndRegular = hasVirtual and getCombineVirtualAndRegularFlag(achievementInformation)

    local function buildVirtualCriteriaEntry(i, criterion)
        local entry = {
            text = criterion.text or i,
            criteriaId = i,
            criteriaType = criterion.criteriaType,
        }
        local virtualCtx = {
            achievementId = achievementId,
            criterion = criterion,
            criteriaTable = achievementInformation and achievementInformation.criteria,
            countCompleted = function(aid, criteriaTable)
                if criterion.countFromApi == true then
                    return countApiCriteriaProgress(aid)
                end
                return countTrackedCriteriaProgress(aid, criteriaTable)
            end,
        }
        if VirtualCriteriaTypes and VirtualCriteriaTypes.ApplyToRequirementEntry(entry, virtualCtx) then
            -- Virtual criteria type handled (e.g. ProgressBar = -1).
        elseif type(criterion.criteriaType) == "number" and VirtualCriteriaTypes and VirtualCriteriaTypes.IsVirtual(criterion.criteriaType) then
            entry.completed = false
        else
            entry.completed = IsAchievementCriteriaCompleted(achievementId, i, criterion.criteriaType) == true
            -- Virtual criteria indices may not exist in the WoW API; use pcall to avoid "criteria not found" errors.
            if type(GetAchievementCriteriaInfo) == "function" then
                local ok, _, _, quantity, reqQuantity, _, _, _, quantityString = pcall(GetAchievementCriteriaInfo, achievementId, i)
                if ok and reqQuantity and reqQuantity > 0 and quantity ~= nil then
                    entry.quantity = quantity
                    entry.reqQuantity = reqQuantity
                    if type(quantityString) == "string" and quantityString ~= "" then
                        entry.quantityString = quantityString
                    end
                end
            end
        end
        local state, availabilityText = getDelveAvailabilityForCriterion(achievementId, i, criterion)
        entry.availabilityState = state
        entry.availabilityText = availabilityText
        return entry
    end

    local function shouldPrependVirtualCriterion(criterion)
        return type(criterion) == "table"
            and VirtualCriteriaTypes
            and VirtualCriteriaTypes.PrependWhenCombined(criterion.criteriaType)
    end

    local function appendVirtualRows(prependOnly)
        if not hasVirtual then
            return
        end
        local vc = achievementInformation.virtualCriteria
        for _, i in ipairs(virtualCriteriaSortedKeys(vc)) do
            local criterion = vc[i]
            if type(criterion) == "table"
                and not (VirtualCriteriaTypes and VirtualCriteriaTypes.IsHidden(criterion))
            then
                local prepend = shouldPrependVirtualCriterion(criterion)
                if prependOnly == nil or (prependOnly == true and prepend) or (prependOnly == false and not prepend) then
                    requirements[#requirements + 1] = buildVirtualCriteriaEntry(i, criterion)
                end
            end
        end
    end

    if combineVirtualAndRegular then
        -- Prepend virtual types (e.g. ProgressBar), then regular API criteria, then remaining virtual rows.
        appendVirtualRows(true)
        appendRegularCriteriaFromApi(achievementId, requirements, achievementInformation)
        appendVirtualRows(false)
    elseif hasVirtual then
        appendVirtualRows()
    else
        appendRegularCriteriaFromApi(achievementId, requirements, achievementInformation)
    end

    return requirements
end

--- Build requirements from our filtered tree (node.children) or raw definition (node.data.children).
--- Prefer node.children: it's already filtered by faction/requirements in scanData.
--- Sub-achievement rows (meta criteria type 8) use parent GetAchievementCriteriaInfo completion, not GetAchievementInfo(child).
local function buildRequirementsFromChildren(node)
    local requirements = {}
    if type(GetAchievementInfo) ~= "function" then
        return requirements
    end

    local parentAchievementId = node and node.id

    -- Prefer filtered tree (node.children) - respects faction, eventId, etc.
    local children = node and node.children
    if type(children) ~= "table" or #children == 0 then
        children = node and node.data and node.data.children or nil
    end
    if type(children) ~= "table" then
        return requirements
    end

    for _, child in ipairs(children) do
        local childId = child and child.id
        if childId then
            local _, childName = GetAchievementInfo(childId)
            local entry = {
                text = childName or ("Achievement " .. tostring(childId)),
            }

            local parentCriterion = parentAchievementId
                and findParentCriterionForSubAchievement(parentAchievementId, childId)
            if parentCriterion then
                entry.completed = parentCriterion.completed
                entry.criteriaId = parentCriterion.criteriaId
                entry.criteriaType = parentCriterion.criteriaType
                entry.apiCriteriaIndex = parentCriterion.index
                if parentCriterion.reqQuantity and parentCriterion.reqQuantity > 0 and parentCriterion.quantity ~= nil then
                    entry.quantity = parentCriterion.quantity
                    entry.reqQuantity = parentCriterion.reqQuantity
                    if type(parentCriterion.quantityString) == "string" and parentCriterion.quantityString ~= "" then
                        entry.quantityString = parentCriterion.quantityString
                    end
                end
                if type(parentCriterion.criteriaString) == "string" and parentCriterion.criteriaString ~= "" then
                    entry.text = parentCriterion.criteriaString
                end
            else
                local _, _, _, childCompleted = GetAchievementInfo(childId)
                entry.completed = childCompleted == true
            end

            requirements[#requirements + 1] = entry
        end
    end

    return requirements
end

-- Build a MetaAchievementMapDetailTemplate data table for an achievement id.
-- topAchievementId: optional; when given, waypoints/help are looked up from the flat table and helpText merged into description.
-- Returns data, flatInfo (flatInfo is the { helpText?, waypoints?, criteria? } entry for use by the detail frame).
function MetaAchievementMapDetail_BuildDataFromAchievementId(achievementId, node, topAchievementId)
    local name, points, description, icon, rewardText = getAchievementInfoSafe(achievementId)

    if not rewardText or rewardText == "" then
        pcall(function()
            rewardText = GetAchievementReward(achievementId)
        end)
    end

    -- Prefer our filtered tree (flat data) over WoW API: it respects faction, eventId, etc.
    local requirements = buildRequirementsFromChildren(node)
    if #requirements == 0 then
        requirements = buildRequirementsFromCriteria(achievementId, topAchievementId)
    end
    -- If still no requirements, show achievement description as a single virtual requirement row
    if #requirements == 0 and type(description) == "string" and description:gsub("^%s+", ""):gsub("%s+$", "") ~= "" then
        requirements = { { text = description, isDescriptionRow = true } }
    end

    local pointsValue = (points and points > 0) and points or nil
    local isFeat = not (points and points > 0)

    -- Look up waypoints/help from the flat table (topAchievementId -> achievementId -> { helpText, waypoints, criteria }).
    -- helpText is separate from the achievement description; it is kept on flatInfo for use in a help/tips area.
    local flatInfo = nil
    if topAchievementId and AchievementData and type(AchievementData.GetInformation) == "function" then
        flatInfo = AchievementData:GetInformation(topAchievementId, achievementId)
    end

    local data = {
        icon = icon or (node and node.data and node.data.icon) or "Interface\\Icons\\INV_Misc_QuestionMark",
        title = name or (node and node.data and node.data.name) or "Achievement",
        points = pointsValue,
        isFeat = isFeat,
        description = description or "",
        reward = rewardText or "",
        requirements = requirements,
    }
    if flatInfo and type(flatInfo.requirementsBodyOverrideElement) == "string" and flatInfo.requirementsBodyOverrideElement ~= "" then
        data.requirementsBodyOverrideElement = flatInfo.requirementsBodyOverrideElement
    end
    return data, flatInfo
end

-- Show mount-reward-panel for the current (top) achievement. Called when preview button is clicked.
function MetaAchievementMapDetail_PreviewMountReward(self)
    if not self or not self.MountPreviewPanel then
        return
    end
    -- Use stored reference, or walk up: detail -> DynamicContent -> Content -> MapCanvas -> MapInset -> journal frame
    local journalFrame = self.journalFrame
    if not journalFrame then
        local p = self:GetParent()
        for _ = 1, 5 do
            if not p then break end
            if p._selectedSourceKey ~= nil then
                journalFrame = p
                break
            end
            p = p:GetParent()
        end
    end
    if not journalFrame or not MetaAchievementMainFrameMgr or type(MetaAchievementMainFrameMgr.GetSelectedSource) ~= "function" then
        return
    end
    local src = MetaAchievementMainFrameMgr:GetSelectedSource(journalFrame)
    local mountId = (src and src.provider and src.provider.topAchievementMountId) or nil
    if type(MetaAchievementMountRewardPanel_Update) == "function" then
        MetaAchievementMountRewardPanel_Update(self.MountPreviewPanel, mountId)
    end
    updateRewardHelpAndRequirementsLayout(self, self._currentRewardText, self._currentHelpText)
    MetaAchievementMapDetail_SyncRequirementsBodyDisplay(self)
end

-- Convenience: populate the detail frame from an achievement id.
-- topAchievementId: optional; top achievement of the selected group (from the dropdown).
function MetaAchievementMapDetail_SetFromAchievementId(self, achievementId, node, topAchievementId)
    if not self or not achievementId then
        return
    end
    if type(MetaAchievementMapDetail_SetData) ~= "function" then
        return
    end

    if self.MountPreviewPanel then
        self.MountPreviewPanel:Hide()
    end

    self._achievementId = achievementId
    self._topAchievementId = topAchievementId

    local data, flatInfo = MetaAchievementMapDetail_BuildDataFromAchievementId(achievementId, node, topAchievementId)
    self._flatInfo = flatInfo
    data.helpText = (flatInfo and type(flatInfo.helpText) == "string" and flatInfo.helpText ~= "") and flatInfo.helpText or nil
    MetaAchievementMapDetail_SetData(self, data)

    -- Show preview button only when the displayed achievement is the top (meta) achievement
    if self.RewardBox and self.RewardBox.PreviewButton then
        local isTopAchievement = (topAchievementId and achievementId == topAchievementId)
        self.RewardBox.PreviewButton:SetShown(isTopAchievement)
    end

    -- Show/hide HelpBox waypoint button based on whether achievement has direct waypoints
    local hasDirectWaypoints = achievementHasDirectWaypoints(flatInfo)
    if self.HelpBox and self.HelpBox.WaypointButton then
        self.HelpBox.WaypointButton:SetShown(hasDirectWaypoints)
    end

    -- Show/hide RequirementsBox waypoint button: when addWpsOnlyForUncompletedAchis, only show if at least one criterion with waypoints is not completed
    local hasAnyWaypoint = false
    local onlyUncompleted = MetaAchievementSettings and MetaAchievementSettings:Get("addWpsOnlyForUncompletedAchis")

    local criteria = nil
    if flatInfo and type(flatInfo.virtualCriteria) == "table" then
        criteria = flatInfo.virtualCriteria
    elseif flatInfo and type(flatInfo.criteria) == "table" then
        criteria = flatInfo.criteria
    end

    if criteria and type(criteria) == "table" then
        if onlyUncompleted then
            for criteriaId, cinfo in pairs(criteria) do
                if type(cinfo) == "table" and criterionHasWaypoints(cinfo) and not isCriterionCompleted(achievementId, criteriaId, cinfo) then
                    hasAnyWaypoint = true
                    break
                end
            end
        else
            for _, cinfo in pairs(criteria) do
                if type(cinfo) == "table" and criterionHasWaypoints(cinfo) then
                    hasAnyWaypoint = true
                    break
                end
            end
        end
    end
    if self.RequirementsBox and self.RequirementsBox.WaypointButton then
        self.RequirementsBox.WaypointButton:SetShown(hasAnyWaypoint)
    end

    -- Link button visibility: set here and in updateRewardHelpAndRequirementsLayout when link source ~= "none"
    local linkSource = getAchievementLinkSource()
    local linkBtn = getRequirementsLinkButton(self.RequirementsBox)
    if linkBtn then
        linkBtn:SetShown(linkSource ~= "none")
    end
end

-- Map: criteriaType -> function(owner, criteriaInfo, achievementId, criteriaIndex).
-- Use key "default" for a fallback when criteriaType is not in the map.
-- Add entries to dispatch by criteria type when a requirement row is clicked.
MetaAchievementMapDetail_CriteriaTypeHandlers = MetaAchievementMapDetail_CriteriaTypeHandlers or {}

local function criteriaTypeHandler_Achievement(owner, criteriaInfo, achievementId, criteriaIndex)
    local assetId = criteriaInfo and criteriaInfo.assetID
    if type(assetId) ~= "number" or assetId <= 0 then
        return
    end
    local journalFrame = owner
    while journalFrame do
        if journalFrame._modelItems and journalFrame._selectedSourceKey then
            break
        end
        journalFrame = journalFrame:GetParent()
    end
    if not journalFrame or not journalFrame._modelItems then
        return
    end
    local selIdx = nil
    for i, node in ipairs(journalFrame._modelItems) do
        if node and node.id == assetId then
            selIdx = i
            break
        end
    end
    if selIdx then
        local list = journalFrame.JournalList
        local item = journalFrame._modelItems and journalFrame._modelItems[selIdx]
        if MetaAchievementUIBus and type(MetaAchievementUIBus.Emit) == "function" and list then
            MetaAchievementUIBus:Emit("MA_JOURNAL_LIST_ITEM_CLICKED", list, selIdx, item, nil)
        elseif MetaAchievementMainFrameMgr and type(MetaAchievementMainFrameMgr.SetSelectedIndex) == "function" then
            MetaAchievementMainFrameMgr:SetSelectedIndex(journalFrame, selIdx)
        end
    end
end

local function criteriaTypeHandler_Default(owner, criteriaInfo, achievementId, criteriaIndex)
    -- When criteria is not another achievement, check waypoints flat table for additional criteria info.
    local criteriaId = criteriaInfo and criteriaInfo.criteriaID
    if not criteriaId or not owner or not owner._flatInfo then
        return
    end
    local cinfo = (owner._flatInfo.virtualCriteria and owner._flatInfo.virtualCriteria[criteriaId])
        or (owner._flatInfo.criteria and owner._flatInfo.criteria[criteriaId])
    if not cinfo then
        return
    end
    local criteriaName = (criteriaInfo and type(criteriaInfo.criteriaString) == "string") and criteriaInfo.criteriaString or nil
    -- Show criteria-level helpText in the "Criteria information" box below requirements. Title includes criteria name when available.
    -- If criterion has waypoints but no helpText, use default so the box (and waypoint button) are shown.
    local ht = (type(cinfo.helpText) == "string" and cinfo.helpText ~= "") and normalizeForWrap(cinfo.helpText) or ""
    if ht == "" and criterionHasWaypoints(cinfo) then
        ht = DEFAULT_WAYPOINT_HELP
    end
    setCriteriaInfoBox(owner, ht, criteriaName, criteriaId)
end

do
    MetaAchievementMapDetail_CriteriaTypeHandlers["default"] = criteriaTypeHandler_Default
    MetaAchievementMapDetail_CriteriaTypeHandlers[_G.CRITERIA_TYPE_ACHIEVEMENT or 8] = criteriaTypeHandler_Achievement
end

--- Dispatch an action based on criteria type when a requirement row is clicked.
--- Uses MetaAchievementMapDetail_CriteriaTypeHandlers[criteriaType]; falls back to ["default"] when type is not in the map.
--- @param owner frame The map-detail frame (row._owner).
--- @param criteriaInfo table GetAchievementCriteriaInfo return values: criteriaString, criteriaType, completed, quantity, reqQuantity, charName, flags, assetID, quantityString, criteriaID, eligible.
--- @param achievementId number Parent achievement ID.
--- @param criteriaIndex number Criteria index (1-based).
function MetaAchievementMapDetail_OnRequirementClicked(owner, criteriaInfo, achievementId, criteriaIndex)
    if not owner or type(criteriaInfo) ~= "table" then
        return
    end
    local ctype = criteriaInfo.criteriaType
    local handler = MetaAchievementMapDetail_CriteriaTypeHandlers[ctype] or MetaAchievementMapDetail_CriteriaTypeHandlers["default"]
    if type(handler) == "function" then
        handler(owner, criteriaInfo, achievementId, criteriaIndex)
    end
end

-- Handler for HelpBox waypoint button: adds all direct achievement waypoints
function MetaAchievementMapDetail_OnHelpBoxWaypointButtonClick(self)
    if not self or not self._achievementId or not self._flatInfo then
        return
    end
    local waypoints = self._flatInfo.waypoints
    if not waypoints or type(waypoints) ~= "table" then
        return
    end
    if MapIntegrationBase and type(MapIntegrationBase.ToggleWaypointsForAchievement) == "function" then
        MapIntegrationBase.ToggleWaypointsForAchievement(self._achievementId, waypoints)
    end
end

-- Flatten waypoints: each { kind="point", coordinates={c1,c2,...} } becomes one waypoint per coordinate.
local function flattenWaypoints(waypoints)
    if not waypoints or type(waypoints) ~= "table" then
        return {}
    end
    local out = {}
    for _, wp in pairs(waypoints) do
        if type(wp) == "table" and wp.kind == "point" and wp.coordinates and type(wp.coordinates) == "table" then
            for _, coord in pairs(wp.coordinates) do
                if type(coord) == "table" and coord.mapId and coord.x and coord.y then
                    out[#out + 1] = { kind = "point", coordinates = { coord } }
                end
            end
        elseif type(wp) == "table" then
            out[#out + 1] = wp
        end
    end
    return out
end

-- Handler for RequirementsBox waypoint button: adds all criteria waypoints (excluding completed criteria when addWpsOnlyForUncompletedAchis)
function MetaAchievementMapDetail_OnRequirementsBoxWaypointButtonClick(self)
    if not self or not self._achievementId or not self._flatInfo then
        return
    end
    local criteria = self._flatInfo.virtualCriteria or self._flatInfo.criteria
    if not criteria or type(criteria) ~= "table" then
        return
    end
    local onlyUncompleted = MetaAchievementSettings and MetaAchievementSettings:Get("addWpsOnlyForUncompletedAchis")
    local allWaypoints = {}
    for criteriaId, cinfo in pairs(criteria) do
        if type(cinfo) ~= "table" then
            -- skip meta keys on virtualCriteria (e.g. combineVirtualAndRegularCriteria)
        elseif onlyUncompleted and isCriterionCompleted(self._achievementId, criteriaId, cinfo) then
            -- skip completed criteria when setting is on
        elseif type(cinfo.waypoints) == "table" then
            for _, wp in pairs(flattenWaypoints(cinfo.waypoints)) do
                if type(wp) == "table" and criteriaId then
                    wp.criteriaId = criteriaId
                    if type(cinfo.criteriaType) == "number" then
                        wp.criteriaType = cinfo.criteriaType
                    end
                end
                allWaypoints[#allWaypoints + 1] = wp
            end
        end
    end
    if #allWaypoints > 0 and MapIntegrationBase and type(MapIntegrationBase.ToggleWaypointsForAchievement) == "function" then
        MapIntegrationBase.ToggleWaypointsForAchievement(self._achievementId, allWaypoints)
    end
end

--- Add all criteria waypoints for an achievement (e.g. from mini list criteria header). Global so mini list can call.
function MetaAchievementMapDetail_AddCriteriaWaypoints(achievementId, topAchievementId)
    if not achievementId or not topAchievementId or not AchievementData or type(AchievementData.GetInformation) ~= "function" then
        return
    end
    local flatInfo = AchievementData:GetInformation(topAchievementId, achievementId)
    if not flatInfo then return end
    local criteria = flatInfo.virtualCriteria or flatInfo.criteria
    if not criteria or type(criteria) ~= "table" then return end
    local onlyUncompleted = MetaAchievementSettings and MetaAchievementSettings:Get("addWpsOnlyForUncompletedAchis")
    local allWaypoints = {}
    for criteriaId, cinfo in pairs(criteria) do
        if type(cinfo) ~= "table" then
            -- skip meta keys on virtualCriteria
        elseif onlyUncompleted and isCriterionCompleted(achievementId, criteriaId, cinfo) then
            -- skip
        elseif type(cinfo.waypoints) == "table" then
            for _, wp in pairs(flattenWaypoints(cinfo.waypoints)) do
                if type(wp) == "table" and criteriaId then
                    wp.criteriaId = criteriaId
                    if type(cinfo.criteriaType) == "number" then
                        wp.criteriaType = cinfo.criteriaType
                    end
                end
                allWaypoints[#allWaypoints + 1] = wp
            end
        end
    end
    if #allWaypoints > 0 and MapIntegrationBase and type(MapIntegrationBase.ToggleWaypointsForAchievement) == "function" then
        MapIntegrationBase.ToggleWaypointsForAchievement(achievementId, allWaypoints)
    end
end

--- Create or return the link dialog frame (title + text box with link + Close).
local function getOrCreateLinkDialog()
    if _G.MetaAchievementLinkDialog then return _G.MetaAchievementLinkDialog end
    local d = CreateFrame("Frame", "MetaAchievementLinkDialog", UIParent, "BackdropTemplate")
    d:SetSize(360, 140)
    local screenH = UIParent and UIParent:GetHeight() or 600
    d:SetPoint("TOP", UIParent, "TOP", 0, -screenH / 3)
    d:SetFrameStrata("TOOLTIP")
    d:SetFrameLevel(100)
    local dBg = d:CreateTexture(nil, "BACKGROUND")
    dBg:SetAllPoints(d)
    dBg:SetColorTexture(0.1, 0.1, 0.1, 0.95)
    d:SetBackdrop({
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        edgeSize = 32,
        insets = { left = 0, right = 50, top = 16, bottom = 16 },
    })
    d:Hide()

    local title = d:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -18)
    d.Title = title

    local hint = d:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    hint:SetPoint("TOP", title, "BOTTOM", 0, -16)
    hint:SetText("Use Ctrl+C to copy link")
    d.Hint = hint

    local edit = CreateFrame("EditBox", nil, d)
    edit:SetSize(320, 32)
    edit:SetPoint("TOP", hint, "BOTTOM", 0, -2)
    edit:SetAutoFocus(false)
    edit:SetFontObject("GameFontHighlight")
    edit:SetMultiLine(false)
    if edit.SetTextInsets then edit:SetTextInsets(6, 6, 4, 4) end
    edit:SetScript("OnEscapePressed", function() edit:ClearFocus() d:Hide() end)
    d.EditBox = edit

    local editBg = edit:CreateTexture(nil, "BACKGROUND")
    editBg:SetAllPoints(edit)
    editBg:SetColorTexture(0.1, 0.1, 0.1, 0)

    local close = CreateFrame("Button", nil, d, "UIPanelButtonTemplate")
    close:SetText(CLOSE or "Close")
    close:SetSize(100, 22)
    close:SetPoint("BOTTOM", 0, 14)
    close:SetScript("OnClick", function() d:Hide() end)

    if UISpecialFrames and not tContains(UISpecialFrames, "MetaAchievementLinkDialog") then
        tinsert(UISpecialFrames, "MetaAchievementLinkDialog")
    end

    _G.MetaAchievementLinkDialog = d
    return d
end

local function showLinkDialog(sourceName, url)
    local d = getOrCreateLinkDialog()
    d.Title:SetText(sourceName .. " link")
    d.EditBox:SetText(url or "")
    d.EditBox:SetCursorPosition(0)
    d.EditBox:HighlightText(0, url and #url or 0)
    d:Show()
    d.EditBox:SetFocus()
end

--- Build achievement URL for the configured link source (wowhead or wowdb).
local function getAchievementURL(achievementId, linkSource)
    if type(achievementId) ~= "number" or achievementId <= 0 then return nil end
    if linkSource == "wowhead" then
        return ("https://www.wowhead.com/achievement=%d"):format(achievementId)
    end
    if linkSource == "wowdb" then
        return ("https://www.wowdb.com/achievements/%d"):format(achievementId)
    end
    return nil
end

--- Handler for RequirementsBox link button: shows dialog with title "<source> link" and text box with the URL.
function MetaAchievementMapDetail_OnRequirementsBoxLinkButtonClick(self)
    if not self or not self._achievementId then return end
    local linkSource = getAchievementLinkSource()
    if linkSource == "none" then return end
    local url = getAchievementURL(self._achievementId, linkSource)
    if not url then return end
    local sourceName = (linkSource == "wowdb") and "WowDB" or "Wowhead"
    showLinkDialog(sourceName, url)
end

-- Handler for CriteriaInfoBox waypoint button: adds waypoints for the selected criterion (none if addWpsOnlyForUncompletedAchis and criterion is completed)
function MetaAchievementMapDetail_OnCriteriaInfoBoxWaypointButtonClick(self)
    if not self or not self._achievementId or not self._flatInfo or not self._selectedCriteriaId then
        return
    end
    local criteria = self._flatInfo.virtualCriteria or self._flatInfo.criteria
    if not criteria or type(criteria) ~= "table" then
        return
    end
    local cinfo = criteria[self._selectedCriteriaId]
    local onlyUncompleted = MetaAchievementSettings and MetaAchievementSettings:Get("addWpsOnlyForUncompletedAchis")
    if onlyUncompleted and isCriterionCompleted(self._achievementId, self._selectedCriteriaId, cinfo) then
        return
    end
    if not cinfo or not criterionHasWaypoints(cinfo) then
        return
    end
    local waypoints = flattenWaypoints(cinfo.waypoints)
    local critId = self._selectedCriteriaId
    for _, wp in ipairs(waypoints) do
        if type(wp) == "table" and critId then
            wp.criteriaId = critId
            if type(cinfo.criteriaType) == "number" then
                wp.criteriaType = cinfo.criteriaType
            end
        end
    end
    if #waypoints > 0 and MapIntegrationBase and type(MapIntegrationBase.ToggleWaypointsForAchievement) == "function" then
        MapIntegrationBase.ToggleWaypointsForAchievement(self._achievementId, waypoints)
    end
end

function MetaAchievementMapRequirementRow_OnClick(row, button)
    local owner = row and row._owner or nil
    if not owner then
        return
    end
    local req = owner._requirements and owner._requirements[row._index] or nil
    if req and req.isDescriptionRow then
        return
    end
    local aid = owner._achievementId
    local idx = row._index
    -- When virtual + API criteria are combined, API rows come first and use apiCriteriaIndex (row._index is display order).
    local apiIdx = (req and req.apiCriteriaIndex) or idx

    -- Virtual criteria path: use stored criteriaId from requirement
    if aid and owner._flatInfo and type(owner._flatInfo.virtualCriteria) == "table" and req and req.criteriaId then
        local vc = owner._flatInfo.virtualCriteria[req.criteriaId]
        if vc then
            MetaAchievementMapDetail_OnRequirementClicked(owner, {
                criteriaString = req.text,
                criteriaType = vc.criteriaType or 27,
                criteriaID = req.criteriaId,
            }, aid, idx)
            MetaAchievementUIBus:Emit("MA_MAPDETAIL_REQUIREMENT_CLICKED", owner, row._index, req, button)
            return
        end
    end

    -- WoW API path
    if aid and apiIdx and type(GetAchievementCriteriaInfo) == "function" then
        local ok, cs, ctype, completed, qty, reqQty, charName, flags, assetId, qtyStr, criteriaId, eligible =
            pcall(GetAchievementCriteriaInfo, aid, apiIdx)
        if ok and cs ~= nil then
            MetaAchievementMapDetail_OnRequirementClicked(owner, {
                criteriaString = cs,
                criteriaType = ctype,
                completed = completed,
                quantity = qty,
                reqQuantity = reqQty,
                charName = charName,
                flags = flags,
                assetID = assetId,
                quantityString = qtyStr,
                criteriaID = criteriaId,
                eligible = eligible,
            }, aid, apiIdx)
        end
    end
    MetaAchievementUIBus:Emit("MA_MAPDETAIL_REQUIREMENT_CLICKED", owner, row._index, req, button)
end

