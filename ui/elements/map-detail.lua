-- Map detail element controller.
-- Shows header (icon + title + points/feat), description, reward, and scrollable requirements list.

local REQUIREMENT_ROW_HEIGHT = 20
local REQUIREMENT_ROW_GAP = 0
local REQUIREMENTS_CRITERIA_GAP = 8  -- Vertical gap between Requirements box bottom and Criteria information box top

local function ensureBus()
    MetaAchievementUIBus = MetaAchievementUIBus or {}
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

local function setScrollChildWidth(self)
    if not self.RequirementsBox or not self.RequirementsBox.ScrollFrame or not self.RequirementsBox.ScrollFrame.ScrollChild then
        return
    end
    local w = self.RequirementsBox.ScrollFrame:GetWidth() or 0
    if w > 0 then
        self.RequirementsBox.ScrollFrame.ScrollChild:SetWidth(w)
    end
end

local function updateHelpBoxContent(self, helpText)
    if not self.HelpBox or not self.HelpBox.ScrollFrame or not self.HelpBox.ScrollFrame.ScrollChild or not self.HelpBox.Text then
        return
    end
    local sf = self.HelpBox.ScrollFrame
    local sc = sf.ScrollChild
    local text = self.HelpBox.Text
    local w = sf:GetWidth() or (self.HelpBox:GetWidth() and (self.HelpBox:GetWidth() - 24) or 200)
    if w <= 0 then
        w = 200
    end
    if type(helpText) ~= "string" or helpText == "" then
        text:SetText("")
        sc:SetHeight(1)
        sc:SetWidth(w)
        return
    end
    text:SetWidth(w)
    if text.SetWordWrap then
        text:SetWordWrap(true)
    end
    text:SetText(helpText)
    local contentH = (text:GetStringHeight() or 0) + 8
    sc:SetWidth(w)
    sc:SetHeight(math.max(contentH, sf:GetHeight() or 1))
end

local function updateCriteriaInfoBoxContent(self, text)
    if not self.CriteriaInfoBox or not self.CriteriaInfoBox.ScrollFrame or not self.CriteriaInfoBox.ScrollFrame.ScrollChild or not self.CriteriaInfoBox.Text then
        return
    end
    local sf = self.CriteriaInfoBox.ScrollFrame
    local sc = sf.ScrollChild
    local fs = self.CriteriaInfoBox.Text
    local w = sf:GetWidth() or (self.CriteriaInfoBox:GetWidth() and (self.CriteriaInfoBox:GetWidth() - 24) or 200)
    if w <= 0 then
        w = 200
    end
    if type(text) ~= "string" or text == "" then
        fs:SetText("")
        sc:SetHeight(1)
        sc:SetWidth(w)
        return
    end
    fs:SetWidth(w)
    if fs.SetWordWrap then
        fs:SetWordWrap(true)
    end
    fs:SetText(text)
    local contentH = (fs:GetStringHeight() or 0) + 8
    sc:SetWidth(w)
    sc:SetHeight(math.max(contentH, sf:GetHeight() or 1))
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
            row.Text:SetText(req.text or "")
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
    ensureBus()

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
        self.RewardBox.Text = _G[self.RewardBox:GetName() .. "Text"]
    end
    if self.HelpBox then
        self.HelpBox.ScrollFrame = _G[self.HelpBox:GetName() .. "ScrollFrame"]
        if self.HelpBox.ScrollFrame then
            self.HelpBox.ScrollFrame.ScrollChild = _G[self.HelpBox.ScrollFrame:GetName() .. "ScrollChild"]
            if self.HelpBox.ScrollFrame.ScrollChild then
                self.HelpBox.Text = _G[self.HelpBox.ScrollFrame.ScrollChild:GetName() .. "Text"]
            end
        end
        self.HelpBox.ScrollBar = _G[self.HelpBox:GetName() .. "ScrollBar"]
        if self.HelpBox.ScrollBar and self.HelpBox.ScrollFrame and type(MetaAchievementScrollBar_Attach) == "function" then
            MetaAchievementScrollBar_Attach(self.HelpBox.ScrollBar, self.HelpBox.ScrollFrame)
        end
    end
    if self.RequirementsBox then
        self.RequirementsBox.Label = _G[self.RequirementsBox:GetName() .. "Label"]
        if self.RequirementsBox.Label and self.RequirementsBox.Label.SetText then
            self.RequirementsBox.Label:SetText("REQUIREMENTS")
        end
        self.RequirementsBox.ScrollFrame = _G[self.RequirementsBox:GetName() .. "ScrollFrame"]
        if self.RequirementsBox.ScrollFrame then
            self.RequirementsBox.ScrollFrame.ScrollChild = _G[self.RequirementsBox.ScrollFrame:GetName() .. "ScrollChild"]
            self.RequirementsBox.ScrollFrame:HookScript("OnSizeChanged", function()
                setScrollChildWidth(self)
                renderRequirements(self)
            end)
        end
        self.RequirementsBox.ScrollBar = _G[self.RequirementsBox:GetName() .. "ScrollBar"]

        if self.RequirementsBox.ScrollBar and self.RequirementsBox.ScrollFrame and type(MetaAchievementScrollBar_Attach) == "function" then
            MetaAchievementScrollBar_Attach(self.RequirementsBox.ScrollBar, self.RequirementsBox.ScrollFrame)
        end
    end
    self.CriteriaInfoBox = _G[self:GetName() .. "CriteriaInfoBox"]
    if self.CriteriaInfoBox then
        self.CriteriaInfoBox.Label = _G[self.CriteriaInfoBox:GetName() .. "Label"]
        self.CriteriaInfoBox.ScrollFrame = _G[self.CriteriaInfoBox:GetName() .. "ScrollFrame"]
        if self.CriteriaInfoBox.ScrollFrame then
            self.CriteriaInfoBox.ScrollFrame.ScrollChild = _G[self.CriteriaInfoBox.ScrollFrame:GetName() .. "ScrollChild"]
            if self.CriteriaInfoBox.ScrollFrame.ScrollChild then
                self.CriteriaInfoBox.Text = _G[self.CriteriaInfoBox.ScrollFrame.ScrollChild:GetName() .. "Text"]
            end
        end
        self.CriteriaInfoBox.ScrollBar = _G[self.CriteriaInfoBox:GetName() .. "ScrollBar"]
        if self.CriteriaInfoBox.ScrollBar and self.CriteriaInfoBox.ScrollFrame and type(MetaAchievementScrollBar_Attach) == "function" then
            MetaAchievementScrollBar_Attach(self.CriteriaInfoBox.ScrollBar, self.CriteriaInfoBox.ScrollFrame)
        end
    end

    self._requirements = {}
    self._reqRowPool = {}
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

local function hasHelpText(helpText)
    if type(helpText) ~= "string" then
        return false
    end
    local t = helpText:gsub("^%s+", ""):gsub("%s+$", "")
    return t ~= ""
end

local function updateRewardHelpAndRequirementsLayout(self, rewardText, helpText)
    if not self or not self.RewardBox or not self.RequirementsBox or not self.Header then
        return
    end

    local hasReward = not isRewardEmpty(rewardText)
    local hasHelp = self.HelpBox and hasHelpText(helpText)

    self.RewardBox:SetShown(hasReward)

    if self.HelpBox then
        self.HelpBox:SetShown(hasHelp)
        if hasHelp then
            self.HelpBox:ClearAllPoints()
            if hasReward then
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

    -- Requirements anchor below help (if shown), else reward, else header. Bottom is above Criteria information when that box is shown.
    self.RequirementsBox:ClearAllPoints()
    local anchorAbove = self
    local anchorPoint = "BOTTOMLEFT"
    if hasHelp and self.HelpBox then
        anchorAbove = self.HelpBox
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

local CRITERIA_INFO_BOX_TITLE = "CRITERIA INFORMATION"

local function setCriteriaInfoBox(self, content, criteriaName)
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
    if hasContent then
        updateCriteriaInfoBoxContent(self, content)
        self.CriteriaInfoBox:Show()
    else
        updateCriteriaInfoBoxContent(self, "")
        self.CriteriaInfoBox:Hide()
    end
    updateRewardHelpAndRequirementsLayout(self, self._currentRewardText or "", self._currentHelpText or "")
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

    if self.RewardBox and self.RewardBox.Text and self.RewardBox.Text.SetText then
        self.RewardBox.Text:SetText(formatRewardText(data.reward or ""))
    end

    if self.HelpBox then
        local ht = (type(data.helpText) == "string" and data.helpText ~= "") and normalizeForWrap(data.helpText) or ""
        updateHelpBoxContent(self, ht)
    end

    self._currentRewardText = data.reward or ""
    self._currentHelpText = data.helpText or ""
    setCriteriaInfoBox(self, nil)
    updateRewardHelpAndRequirementsLayout(self, data.reward, data.helpText)

    self._requirements = data.requirements or {}
    renderRequirements(self)
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

local function buildRequirementsFromCriteria(achievementId)
    local requirements = {}
    if type(GetAchievementNumCriteria) ~= "function" or type(GetAchievementCriteriaInfo) ~= "function" then
        return requirements
    end

    local numCriteria = GetAchievementNumCriteria(achievementId) or 0
    for i = 1, numCriteria do
        local criteriaString, _, completed = GetAchievementCriteriaInfo(achievementId, i)
        if criteriaString and criteriaString ~= "" then
            requirements[#requirements + 1] = {
                text = criteriaString,
                completed = completed == true
            }
        end
    end

    return requirements
end

local function buildRequirementsFromChildren(node)
    local requirements = {}
    if type(GetAchievementInfo) ~= "function" then
        return requirements
    end

    local children = node and node.data and node.data.children or nil
    if type(children) ~= "table" then
        return requirements
    end

    for _, child in ipairs(children) do
        if child and child.id then
            local _, childName, _, childCompleted = GetAchievementInfo(child.id)
            requirements[#requirements + 1] = {
                text = childName or ("Achievement " .. tostring(child.id)),
                completed = childCompleted == true
            }
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

    local requirements = buildRequirementsFromCriteria(achievementId)
    if #requirements == 0 then
        requirements = buildRequirementsFromChildren(node)
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
    return data, flatInfo
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

    self._achievementId = achievementId
    self._topAchievementId = topAchievementId

    local data, flatInfo = MetaAchievementMapDetail_BuildDataFromAchievementId(achievementId, node, topAchievementId)
    self._flatInfo = flatInfo
    data.helpText = (flatInfo and type(flatInfo.helpText) == "string" and flatInfo.helpText ~= "") and flatInfo.helpText or nil
    MetaAchievementMapDetail_SetData(self, data)
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
    if selIdx and MetaAchievementJournalMap and type(MetaAchievementJournalMap.SetSelectedIndex) == "function" then
        MetaAchievementJournalMap:SetSelectedIndex(journalFrame, selIdx)
    end
end

local function criteriaTypeHandler_Default(owner, criteriaInfo, achievementId, criteriaIndex)
    -- When criteria is not another achievement, check waypoints flat table for additional criteria info.
    local criteriaId = criteriaInfo and criteriaInfo.criteriaID
    if not criteriaId or not owner or not owner._flatInfo or type(owner._flatInfo.criteria) ~= "table" then
        return
    end
    local cinfo = owner._flatInfo.criteria[criteriaId]
    if not cinfo then
        return
    end
    -- Show criteria-level helpText in the "Criteria information" box below requirements. Title includes criteria name when available.
    local ht = (type(cinfo.helpText) == "string" and cinfo.helpText ~= "") and normalizeForWrap(cinfo.helpText) or ""
    local criteriaName = (criteriaInfo and type(criteriaInfo.criteriaString) == "string") and criteriaInfo.criteriaString or nil
    setCriteriaInfoBox(owner, ht, criteriaName)
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

function MetaAchievementMapRequirementRow_OnClick(row, button)
    ensureBus()
    local owner = row and row._owner or nil
    if not owner then
        return
    end
    local req = owner._requirements and owner._requirements[row._index] or nil
    local aid = owner._achievementId
    local idx = row._index

    if aid and idx and type(GetAchievementCriteriaInfo) == "function" then
        local ok, cs, ctype, completed, qty, reqQty, charName, flags, assetId, qtyStr, criteriaId, eligible =
            pcall(GetAchievementCriteriaInfo, aid, idx)
        if ok and cs ~= nil then
            if owner._flatInfo and type(owner._flatInfo.criteria) == "table" and criteriaId then
                local cinfo = owner._flatInfo.criteria[criteriaId]
            end
            -- Dispatch action by criteria type
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
            }, aid, idx)
        end
    elseif aid and idx and type(GetAchievementNumCriteria) == "function" then
        local n = GetAchievementNumCriteria(aid) or 0
        if n == 0 then
            print("[MetaAchievement] Criteria click (child-achievement row): achievementId", aid, "rowIndex", idx)
            print("  req", req and req.text or "nil")
        end
    end
    if MetaAchievementUIBus and type(MetaAchievementUIBus.Emit) == "function" then
        MetaAchievementUIBus:Emit("MA_MAPDETAIL_REQUIREMENT_CLICKED", owner, row._index, req, button)
    end
end

