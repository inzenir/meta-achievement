-- Map detail element controller.
-- Shows header (icon + title + points/feat), description, reward, and scrollable requirements list.

local REQUIREMENT_ROW_HEIGHT = 20
local REQUIREMENT_ROW_GAP = 0

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

local function updateRewardVisibilityAndLayout(self, rewardText)
    if not self or not self.RewardBox or not self.RequirementsBox or not self.Header then
        return
    end

    local hasReward = not isRewardEmpty(rewardText)
    self.RewardBox:SetShown(hasReward)

    -- Re-anchor requirements depending on whether RewardBox is visible.
    self.RequirementsBox:ClearAllPoints()
    if hasReward then
        self.RequirementsBox:SetPoint("TOPLEFT", self.RewardBox, "BOTTOMLEFT", 0, -6)
        self.RequirementsBox:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)
    else
        self.RequirementsBox:SetPoint("TOPLEFT", self.Header, "BOTTOMLEFT", 0, -6)
        self.RequirementsBox:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)
    end
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

    updateRewardVisibilityAndLayout(self, data.reward)
    if self.RewardBox and self.RewardBox.Text and self.RewardBox.Text.SetText then
        self.RewardBox.Text:SetText(formatRewardText(data.reward or ""))
    end

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
function MetaAchievementMapDetail_BuildDataFromAchievementId(achievementId, node)
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

    return {
        icon = icon or (node and node.data and node.data.icon) or "Interface\\Icons\\INV_Misc_QuestionMark",
        title = name or (node and node.data and node.data.name) or "Achievement",
        points = pointsValue,
        isFeat = isFeat,
        description = description or "",
        reward = rewardText or "",
        requirements = requirements,
    }
end

-- Convenience: populate the detail frame from an achievement id.
function MetaAchievementMapDetail_SetFromAchievementId(self, achievementId, node)
    if not self or not achievementId then
        return
    end
    if type(MetaAchievementMapDetail_SetData) ~= "function" then
        return
    end

    self._achievementId = achievementId
    local data = MetaAchievementMapDetail_BuildDataFromAchievementId(achievementId, node)
    MetaAchievementMapDetail_SetData(self, data)
end

function MetaAchievementMapRequirementRow_OnClick(row, button)
    ensureBus()
    local owner = row and row._owner or nil
    if not owner then
        return
    end
    local req = owner._requirements and owner._requirements[row._index] or nil
    if MetaAchievementUIBus and type(MetaAchievementUIBus.Emit) == "function" then
        MetaAchievementUIBus:Emit("MA_MAPDETAIL_REQUIREMENT_CLICKED", owner, row._index, req, button)
    end
end

