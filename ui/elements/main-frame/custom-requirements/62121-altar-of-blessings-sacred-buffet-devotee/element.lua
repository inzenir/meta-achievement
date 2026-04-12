--[[
  Map-detail requirements body for achievement 62121 (Altar of Blessings: Sacred Buffet Devotee).
  https://www.wowhead.com/achievement=62121

  Matrix: minor loa rows × greater loa columns. BLESSING_CRITERIA_IDS maps each pair to achievement
  criteria id (type 29 spell criteria per game data); pairing order follows Wowhead/community guides for 62121.
]]

local ELEMENT_NAME = "62121-altar-of-blessings-sacred-buffet-devotee"

--- Major loa column order (left → right). Spell id is what the achievement criteria check; fallback
--- is English label if the client cannot resolve the spell yet.
local MAJOR_LOA_SPELLS = {
    { id = 1246869, fallback = "Akil'zon, Loa of Victory" },
    { id = 1246931, fallback = "Halazzi, Loa of the Hunt" },
    { id = 1246932, fallback = "Jan'alai, Loa of Magic" },
    { id = 1246933, fallback = "Nalorakk, Loa of War" },
}

local MAJOR_COUNT = #MAJOR_LOA_SPELLS

--- Minor loa row order (top → bottom). Spell id is what criteria check; fallback if name not resolved.
local MINOR_LOA_SPELLS = {
    { id = 1246934, fallback = "Kulzi, Loa of Medicine" },
    { id = 1246935, fallback = "Filo, Loa of Childhood" },
    { id = 1246944, fallback = "Mot'amra, Loa of Pestilence" },
    { id = 1253437, fallback = "Wila'ma, Loa of Travelers" },
    { id = 1253438, fallback = "Shadra, Loa of Subterfuge" },
    { id = 1253439, fallback = "Dundun, Loa of Abundance" },
    { id = 1253440, fallback = "Puul, Loa of Peril" },
    { id = 1253441, fallback = "Oe, Loa of Growth" },
}

--- Achievement 62121 criteria ids by matrix position [minor row][major col]. `false` = no criterion for that pair (8 of 32 cells).
--- Pairing from Wowhead / guide: Akil'zon×Kulzi…Shadra (row order matches MINOR_LOA_SPELLS); Halazzi/Jan'alai/Nalorakk columns.
local BLESSING_CRITERIA_IDS = {
    { 112106, 112112, 112119, 112125 },
    { 112108, 112113, 112120, 112126 },
    { 112109, 112114, 112121, 112127 },
    { 112110, 112115, 112122, 112128 },
    { 112111, 112116, 112123, 112129 },
    { false, false, 112124, 112130 },
    { false, 112117, false, false },
    { false, 112118, false, false },
}

local BLESSING_ACHIEVEMENT_ID = 62121

local MINOR_COUNT = #MINOR_LOA_SPELLS

local function getSpellDisplayName(spellID, fallback)
    if C_Spell and C_Spell.GetSpellInfo then
        local info = C_Spell.GetSpellInfo(spellID)
        if info then
            if type(info) == "table" and info.name and info.name ~= "" then
                return info.name
            end
        end
    end
    if GetSpellInfo then
        local name = GetSpellInfo(spellID)
        if type(name) == "string" and name ~= "" then
            return name
        end
    end
    return fallback
end

--- Loa names use "Name, epithet"; break after the comma for row/column headers.
local function formatLoaNameForDisplay(name)
    if not name or name == "" then
        return name
    end
    local pos = string.find(name, ",", 1, true)
    if not pos then
        return name
    end
    local left = string.sub(name, 1, pos)
    local right = string.sub(name, pos + 1):gsub("^%s*", "")
    return left .. "\n" .. right
end

--- Localized criterion string (same pattern as `achievement-criteria.lua`).
local function getCriterionDisplayName(criteriaId)
    if not criteriaId or type(criteriaId) ~= "number" then
        return "—"
    end
    if C_AchievementInfo and C_AchievementInfo.GetCriteriaInfoByID then
        local info = C_AchievementInfo.GetCriteriaInfoByID(criteriaId)
        if info and type(info) == "table" then
            local n = info.name or info.criteriaName
            if type(n) == "string" and n ~= "" then
                return n
            end
        end
    end
    if type(GetAchievementCriteriaInfoByID) == "function" then
        local criteriaString = GetAchievementCriteriaInfoByID(BLESSING_ACHIEVEMENT_ID, criteriaId)
        if type(criteriaString) == "string" and criteriaString ~= "" then
            return criteriaString
        end
    end
    return tostring(criteriaId)
end

--- @return boolean completed when API reports done; false if unknown or error
local function isBlessingCriterionCompleted(criteriaId)
    if not criteriaId or type(criteriaId) ~= "number" then
        return false
    end
    if type(GetAchievementCriteriaInfoByID) == "function" then
        local ok, _, _, completed = pcall(GetAchievementCriteriaInfoByID, BLESSING_ACHIEVEMENT_ID, criteriaId)
        if ok and completed ~= nil then
            return completed == true
        end
    end
    if type(GetAchievementNumCriteria) == "function" and type(GetAchievementCriteriaInfo) == "function" then
        local num = GetAchievementNumCriteria(BLESSING_ACHIEVEMENT_ID) or 0
        for idx = 1, num do
            local _, _, completed, _, _, _, _, _, _, cid = GetAchievementCriteriaInfo(BLESSING_ACHIEVEMENT_ID, idx)
            if cid == criteriaId then
                return completed == true
            end
        end
    end
    return false
end

--- Incomplete / empty slots: grey (`|cff808080`); completed: default font colour (no escape).
local function formatCellTextByCompletion(displayText, completed)
    if completed then
        return displayText
    end
    return "|cff808080" .. displayText .. "|r"
end

local function applyBlessingMatrixCells(frame)
    if not frame or not frame._cells then
        return
    end
    for r = 1, MINOR_COUNT do
        for c = 1, MAJOR_COUNT do
            local cell = frame._cells[r][c]
            if cell then
                local critId = BLESSING_CRITERIA_IDS[r] and BLESSING_CRITERIA_IDS[r][c]
                if critId == false or critId == nil then
                    cell:SetText(formatCellTextByCompletion("—", false))
                else
                    local name = getCriterionDisplayName(critId)
                    cell:SetText(formatCellTextByCompletion(name, isBlessingCriterionCompleted(critId)))
                end
            end
        end
    end
end

--- Vertical space per matrix row (~2/3 of prior 40px; wrapped GameFontHighlightSmall).
local ROW_HEIGHT = 27
--- Space reserved below major column titles for the first data row (wrapped header text).
local MAJOR_HEADER_BAND = 48
--- Horizontal padding inside the scroll child (Requirements host already reserves right inset for chrome alignment).
local H_PAD = 6
--- Minor label column + one column per greater loa; each is 1 / MATRIX_COL_COUNT of usable matrix width (e.g. 20% when 5 cols).
local MATRIX_COL_COUNT = MAJOR_COUNT + 1
--- Inset from top of scroll content to the matrix header row (no separate legend; spell ids stay in code only).
local MATRIX_TOP_PAD = 4

--- Viewport width: plain ScrollFrame (no template scrollbar) uses full client width.
local function getViewportContentWidth(scroll, content, outer)
    local w = 0
    if scroll and scroll.GetWidth then
        w = scroll:GetWidth() or 0
    end
    if w < 1 and outer and outer.GetWidth then
        w = outer:GetWidth() or 0
    end
    if w < 1 and content and content.GetWidth then
        w = content:GetWidth() or 0
    end
    if w < 40 then
        w = 280
    end
    return w
end

local function layoutTable(frame)
    if not frame or not frame._content or not frame._cells then
        return
    end
    local content = frame._content
    local scroll = frame._scroll
    local w = getViewportContentWidth(scroll, content, frame)
    content:SetWidth(w)

    local yMajorTop = MATRIX_TOP_PAD
    local HEADER_MAJOR_Y = -yMajorTop
    local HEADER_EXTRA = yMajorTop + MAJOR_HEADER_BAND

    local pad = H_PAD
    local usable = w - pad * 2
    if usable < 50 then
        pad = 2
        usable = w - pad * 2
    end
    local colW = usable / MATRIX_COL_COUNT
    if frame._corner and frame._corner.SetWidth then
        frame._corner:SetWidth(colW - 1)
    end
    for c = 1, MAJOR_COUNT do
        local h = frame._majorHeaders[c]
        if h and h.SetWidth then
            h:SetWidth(colW - 1)
            if h.SetHeight then
                h:SetHeight(MAJOR_HEADER_BAND)
            end
            h:SetPoint("TOPLEFT", content, "TOPLEFT", pad + c * colW, HEADER_MAJOR_Y)
        end
    end
    if frame._corner and frame._corner.SetPoint then
        frame._corner:SetPoint("TOPLEFT", content, "TOPLEFT", pad, HEADER_MAJOR_Y)
    end
    for r = 1, MINOR_COUNT do
        local ml = frame._minorLabels[r]
        if ml and ml.SetWidth then
            ml:SetWidth(colW - 1)
            if ml.SetHeight then
                ml:SetHeight(ROW_HEIGHT)
            end
            ml:SetPoint("TOPLEFT", content, "TOPLEFT", pad, -HEADER_EXTRA - (r - 1) * ROW_HEIGHT)
        end
        for c = 1, MAJOR_COUNT do
            local cell = frame._cells[r][c]
            if cell and cell.SetWidth then
                cell:SetWidth(colW - 2)
                if cell.SetHeight then
                    cell:SetHeight(ROW_HEIGHT)
                end
                cell:SetPoint(
                    "TOPLEFT",
                    content,
                    "TOPLEFT",
                    pad + c * colW,
                    -HEADER_EXTRA - (r - 1) * ROW_HEIGHT
                )
            end
        end
    end
    content:SetHeight(HEADER_EXTRA + MINOR_COUNT * ROW_HEIGHT + 8)
end

local function create(parent, mapDetail)
    local f = CreateFrame("Frame", nil, parent)
    f:SetAllPoints()

    local scroll = CreateFrame("ScrollFrame", nil, f)
    scroll:SetPoint("TOPLEFT", 0, 0)
    scroll:SetPoint("BOTTOMRIGHT", 0, 0)
    scroll:EnableMouse(true)
    scroll:EnableMouseWheel(true)
    scroll:SetScript("OnMouseWheel", function(self, delta)
        local range = self:GetVerticalScrollRange()
        if range <= 0 then
            return
        end
        local step = math.max(18, math.min(48, math.floor(range / 12)))
        local nextScroll = self:GetVerticalScroll() - delta * step
        if nextScroll < 0 then
            nextScroll = 0
        elseif nextScroll > range then
            nextScroll = range
        end
        self:SetVerticalScroll(nextScroll)
    end)

    local content = CreateFrame("Frame", nil, scroll)
    content:SetSize(1, 600)

    local corner = content:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    corner:SetPoint("TOPLEFT", H_PAD, -100)
    corner:SetWidth(96)
    corner:SetJustifyH("LEFT")
    corner:SetText("")

    local majorHeaders = {}
    for c = 1, MAJOR_COUNT do
        local h = content:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
        h:SetPoint("TOPLEFT", content, "TOPLEFT", 104 + (c - 1) * 56, -100)
        h:SetWidth(52)
        h:SetJustifyH("CENTER")
        h:SetJustifyV("MIDDLE")
        if h.SetWordWrap then
            h:SetWordWrap(true)
        end
        if h.SetHeight then
            h:SetHeight(MAJOR_HEADER_BAND)
        end
        majorHeaders[c] = h
    end

    local minorLabels = {}
    local cells = {}
    for r = 1, MINOR_COUNT do
        local ml = content:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
        ml:SetPoint("TOPLEFT", H_PAD, -200)
        ml:SetWidth(96)
        ml:SetJustifyH("CENTER")
        ml:SetJustifyV("MIDDLE")
        if ml.SetWordWrap then
            ml:SetWordWrap(true)
        end
        if ml.SetHeight then
            ml:SetHeight(ROW_HEIGHT)
        end
        minorLabels[r] = ml
        cells[r] = {}
        for c = 1, MAJOR_COUNT do
            local cellFs = content:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
            cellFs:SetPoint("TOPLEFT", content, "TOPLEFT", 104 + (c - 1) * 56, -200)
            cellFs:SetWidth(52)
            cellFs:SetJustifyH("CENTER")
            cellFs:SetJustifyV("MIDDLE")
            if cellFs.SetWordWrap then
                cellFs:SetWordWrap(true)
            end
            if cellFs.SetHeight then
                cellFs:SetHeight(ROW_HEIGHT)
            end
            cells[r][c] = cellFs
        end
    end

    f._content = content
    f._corner = corner
    f._majorHeaders = majorHeaders
    f._minorLabels = minorLabels
    f._cells = cells
    f._scroll = scroll
    scroll:SetScrollChild(content)

    scroll:SetScript("OnSizeChanged", function()
        layoutTable(f)
    end)
    content:SetScript("OnSizeChanged", function()
        layoutTable(f)
    end)
    f:SetScript("OnSizeChanged", function()
        layoutTable(f)
    end)
    f:RegisterEvent("CRITERIA_UPDATE")
    f:RegisterEvent("ACHIEVEMENT_EARNED")
    f:SetScript("OnEvent", function(self, event)
        if event == "CRITERIA_UPDATE" or event == "ACHIEVEMENT_EARNED" then
            if self._cells and self:IsVisible() then
                applyBlessingMatrixCells(self)
            end
        end
    end)
    layoutTable(f)

    return f
end

local function setContext(frame, mapDetail)
    if not frame or not frame._cells then
        return
    end
    for c = 1, MAJOR_COUNT do
        local entry = MAJOR_LOA_SPELLS[c]
        local h = frame._majorHeaders[c]
        if h and entry then
            h:SetText(formatLoaNameForDisplay(getSpellDisplayName(entry.id, entry.fallback)))
        end
    end
    for r = 1, MINOR_COUNT do
        local mEntry = MINOR_LOA_SPELLS[r]
        local ml = frame._minorLabels[r]
        if ml and mEntry then
            local minorText = formatLoaNameForDisplay(getSpellDisplayName(mEntry.id, mEntry.fallback))
            ml:SetText("|cffffd200" .. minorText .. "|r")
        end
    end
    applyBlessingMatrixCells(frame)
    layoutTable(frame)
end

local function release(frame)
    if frame then
        frame:UnregisterEvent("CRITERIA_UPDATE")
        frame:UnregisterEvent("ACHIEVEMENT_EARNED")
        frame:SetScript("OnEvent", nil)
        frame:Hide()
    end
end

if MetaAchievementCustomRequirements and type(MetaAchievementCustomRequirements.RegisterBodyElement) == "function" then
    MetaAchievementCustomRequirements.RegisterBodyElement(ELEMENT_NAME, {
        Create = create,
        SetContext = setContext,
        Release = release,
    })
end
