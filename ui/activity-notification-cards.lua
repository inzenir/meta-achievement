--[[
  On-screen toast cards for activity notifications (DEV-030).
  Implements MetaAchievementActivityCardNotify.TryShow; invoked from logic/activity-notification.lua
  when activityNotifyDeliveryMode is cards or both.
]]

MetaAchievementActivityCardNotify = MetaAchievementActivityCardNotify or {}

local active = {}
local pool = {}
local container = nil

local function getCorner()
    local c = MetaAchievementSettings and MetaAchievementSettings:Get("activityNotifyCardCorner")
    if c == "TOPLEFT" or c == "TOPRIGHT" or c == "BOTTOMLEFT" or c == "BOTTOMRIGHT" then
        return c
    end
    return "TOPLEFT"
end

local function getNumSetting(key, defaultNum)
    local n = MetaAchievementSettings and MetaAchievementSettings:Get(key)
    if type(n) == "string" then
        n = tonumber(n)
    end
    if type(n) == "number" and n >= 1 then
        return math.floor(n)
    end
    return defaultNum
end

local function getMaxVisible()
    return getNumSetting("activityNotifyCardMaxVisible", 5)
end

--- Positive: seconds until auto-dismiss. -1 (or any negative): never by timer.
local function getDurationSec()
    local n = MetaAchievementSettings and MetaAchievementSettings:Get("activityNotifyCardDurationSec")
    if type(n) == "string" then
        n = tonumber(n)
    end
    if type(n) == "number" then
        if n < 0 then
            return -1
        end
        if n >= 1 then
            return math.floor(n)
        end
    end
    return 15
end

local function neverAutoDismiss()
    return getDurationSec() < 0
end

local function ensureContainer()
    if container then
        return
    end
    container = CreateFrame("Frame", "MetaAchievementActivityCardAnchor", UIParent)
    container:SetFrameStrata("HIGH")
    container:SetFrameLevel(2000)
    container:SetSize(320, 800)
end

local function positionAnchor()
    if not container then
        return
    end
    local corner = getCorner()
    local margin = 12
    container:ClearAllPoints()
    if corner == "TOPLEFT" then
        container:SetPoint("TOPLEFT", UIParent, "TOPLEFT", margin, -margin)
    elseif corner == "TOPRIGHT" then
        container:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -margin, -margin)
    elseif corner == "BOTTOMLEFT" then
        container:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", margin, margin)
    else
        container:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -margin, margin)
    end
    container:Show()
end

local function cardFrameTotalHeight(f)
    if not f or not f.titleMeta or not f.titleAch or not f.textDesc then
        return 44
    end
    local topPad = 8
    local gap1 = 4
    local gap2 = 6
    local botPad = 8
    local h1 = f.titleMeta:GetStringHeight()
    local h2 = f.titleAch:GetStringHeight()
    local h3 = f.textDesc:GetStringHeight()
    local h = topPad + h1 + gap1 + h2 + gap2 + h3 + botPad
    if h < 56 then
        h = 56
    end
    return h
end

local function layoutStack()
    if not container then
        return
    end
    local corner = getCorner()
    local gap = 6
    local w = 280
    for i, entry in ipairs(active) do
        local f = entry.frame
        f:ClearAllPoints()
        f:SetWidth(w)
        if corner == "TOPLEFT" then
            if i == 1 then
                f:SetPoint("TOPLEFT", container, "TOPLEFT", 0, 0)
            else
                f:SetPoint("TOPLEFT", active[i - 1].frame, "BOTTOMLEFT", 0, -gap)
            end
        elseif corner == "TOPRIGHT" then
            if i == 1 then
                f:SetPoint("TOPRIGHT", container, "TOPRIGHT", 0, 0)
            else
                f:SetPoint("TOPRIGHT", active[i - 1].frame, "BOTTOMRIGHT", 0, -gap)
            end
        elseif corner == "BOTTOMLEFT" then
            if i == 1 then
                f:SetPoint("BOTTOMLEFT", container, "BOTTOMLEFT", 0, 0)
            else
                f:SetPoint("BOTTOMLEFT", active[i - 1].frame, "TOPLEFT", 0, gap)
            end
        else
            if i == 1 then
                f:SetPoint("BOTTOMRIGHT", container, "BOTTOMRIGHT", 0, 0)
            else
                f:SetPoint("BOTTOMRIGHT", active[i - 1].frame, "TOPRIGHT", 0, gap)
            end
        end
        local h = cardFrameTotalHeight(f)
        f:SetHeight(h)
    end
end

local function poolFrame(f)
    if not f then
        return
    end
    f:Hide()
    f:ClearAllPoints()
    f:SetScript("OnUpdate", nil)
    f._toastEntry = nil
    pool[#pool + 1] = f
end

local function dismissEntry(entry)
    if not entry or not entry.frame then
        return
    end
    entry.dismissed = true
    entry.frame._dismissToken = nil
    for i = #active, 1, -1 do
        if active[i] == entry then
            table.remove(active, i)
            break
        end
    end
    poolFrame(entry.frame)
    layoutStack()
    if #active == 0 and container then
        container:Hide()
    end
end

local function acquireCard()
    while true do
        local p = table.remove(pool)
        if not p then
            break
        end
        if p.titleMeta and p.titleAch and p.textDesc then
            p._dismissToken = nil
            p._toastEntry = nil
            return p
        end
    end

    ensureContainer()
    f = CreateFrame("Frame", nil, container, "BackdropTemplate")
    f:SetWidth(280)
    f:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 },
    })
    f:SetBackdropColor(0.08, 0.08, 0.12, 0.94)
    f:SetBackdropBorderColor(0.35, 0.35, 0.45, 1)

    local closeBtn = CreateFrame("Button", nil, f)
    closeBtn:SetSize(16, 16)
    closeBtn:SetPoint("TOPRIGHT", f, "TOPRIGHT", -2, -2)
    closeBtn:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    local closeBg = closeBtn:CreateTexture(nil, "BACKGROUND")
    closeBg:SetAllPoints()
    closeBg:SetColorTexture(0.35, 0.06, 0.06, 0.92)
    closeBtn._closeBg = closeBg
    local closeHi = closeBtn:CreateTexture(nil, "HIGHLIGHT")
    closeHi:SetAllPoints()
    closeHi:SetColorTexture(1, 0.35, 0.35, 0.35)
    closeBtn:SetHighlightTexture(closeHi)
    local closeLabel = closeBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    closeLabel:SetPoint("CENTER", 0, 0)
    closeLabel:SetText("×")
    closeLabel:SetTextColor(1, 0.35, 0.35)
    closeBtn:SetScript("OnClick", function(btn)
        local parent = btn:GetParent()
        local e = parent and parent._toastEntry
        if e then
            dismissEntry(e)
        end
    end)
    closeBtn:SetScript("OnEnter", function(self)
        if GameTooltip and GameTooltip.SetOwner then
            GameTooltip:SetOwner(self, "ANCHOR_LEFT")
            if GameTooltip.ClearLines then
                GameTooltip:ClearLines()
            end
            GameTooltip:AddLine("Dismiss notification", 1, 1, 1)
            GameTooltip:Show()
        end
    end)
    closeBtn:SetScript("OnLeave", function()
        if GameTooltip then
            GameTooltip:Hide()
        end
    end)
    f.closeBtn = closeBtn

    f.titleMeta = f:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    f.titleMeta:SetPoint("TOPLEFT", f, "TOPLEFT", 8, -8)
    f.titleMeta:SetPoint("TOPRIGHT", f, "TOPRIGHT", -22, -8)
    f.titleMeta:SetJustifyH("LEFT")
    f.titleMeta:SetJustifyV("TOP")
    f.titleMeta:SetWordWrap(true)
    f.titleMeta:SetTextColor(1, 0.82, 0.1)

    f.titleAch = f:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    f.titleAch:SetPoint("TOPLEFT", f.titleMeta, "BOTTOMLEFT", 0, -4)
    f.titleAch:SetPoint("TOPRIGHT", f.titleMeta, "BOTTOMRIGHT", 0, -4)
    f.titleAch:SetJustifyH("LEFT")
    f.titleAch:SetJustifyV("TOP")
    f.titleAch:SetWordWrap(true)

    f.textDesc = f:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    f.textDesc:SetPoint("TOPLEFT", f.titleAch, "BOTTOMLEFT", 0, -6)
    f.textDesc:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -8, 8)
    f.textDesc:SetJustifyH("LEFT")
    f.textDesc:SetJustifyV("TOP")
    f.textDesc:SetWordWrap(true)

    return f
end

--- opts: message (chat fallback), metaTitle, achievementTitle, description (plain lines); feature, achievementId, dedupeKey
function MetaAchievementActivityCardNotify.TryShow(opts)
    if type(opts) ~= "table" then
        return
    end
    local msg = opts.message
    if type(msg) ~= "string" or msg == "" then
        return
    end
    local metaTitle = opts.metaTitle
    local achTitle = opts.achievementTitle
    local desc = opts.description
    if type(metaTitle) ~= "string" then
        metaTitle = ""
    end
    if type(achTitle) ~= "string" then
        achTitle = ""
    end
    if type(desc) ~= "string" then
        desc = ""
    end
    if metaTitle == "" and achTitle == "" and desc == "" then
        desc = MetaAchievementActivityNotify and type(MetaAchievementActivityNotify.StripMarkupForPlainText) == "function"
            and MetaAchievementActivityNotify.StripMarkupForPlainText(msg)
            or msg
        metaTitle = MetaAchievementTitle or "Meta Achievement Tracker"
        achTitle = "Activity"
    end

    ensureContainer()
    positionAnchor()

    local maxVis = getMaxVisible()
    while #active >= maxVis do
        dismissEntry(active[1])
    end

    local f = acquireCard()
    f.titleMeta:SetText(metaTitle ~= "" and metaTitle or "?")
    f.titleAch:SetText(achTitle ~= "" and achTitle or "?")
    f.textDesc:SetText(desc ~= "" and desc or "?")

    local entry = { frame = f, dismissed = false }
    f._toastEntry = entry
    local token = {}
    f._dismissToken = token

    if not neverAutoDismiss() then
        local dur = getDurationSec()
        if C_Timer and C_Timer.After then
            C_Timer.After(dur, function()
                if not f._dismissToken or f._dismissToken ~= token then
                    return
                end
                if entry.dismissed then
                    return
                end
                dismissEntry(entry)
            end)
        else
            local elapsed = 0
            f:SetScript("OnUpdate", function(self, et)
                elapsed = elapsed + et
                if elapsed >= dur then
                    self:SetScript("OnUpdate", nil)
                    if not entry.dismissed then
                        dismissEntry(entry)
                    end
                end
            end)
        end
    end

    active[#active + 1] = entry
    f:Show()
    layoutStack()
end

local function onCornerOrLayoutSettingChanged()
    if not container or #active == 0 then
        return
    end
    positionAnchor()
    layoutStack()
end

if MetaAchievementSettings and type(MetaAchievementSettings.RegisterListener) == "function" then
    MetaAchievementSettings:RegisterListener("activityNotifyCardCorner", onCornerOrLayoutSettingChanged)
    MetaAchievementSettings:RegisterListener("activityNotifyCardMaxVisible", onCornerOrLayoutSettingChanged)
end
