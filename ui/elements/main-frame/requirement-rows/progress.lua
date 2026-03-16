--[[
    Progress requirement row using Blizzard's built-in progress bar.
    Creates StatusBar with CreateFrame(..., "UIWidgetTemplateStatusBar") when needed.
]]

RequirementRowProgress = RequirementRowProgress or {}

local PROGRESS_ROW_HEIGHT = 41
local PROGRESS_BAR_INSET = 48
local BAR_HEIGHT = 12

local COLOR_COMPLETE = { 0.2, 0.75, 0.2, 1 }
local COLOR_INCOMPLETE = { 0.3, 0.55, 0.9, 1 }

local BLIZZARD_BAR_TEMPLATE = "UIWidgetTemplateStatusBar"
local BORDER_INSET = 2  -- gap between bar fill and border
local BAR_BG_COLOR = { 0.08, 0.08, 0.1, 0.5 }  -- dark background for entire bar (track)

local BORDER_BACKDROP = {
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    edgeSize = 8,
    insets = { left = 2, right = 2, top = 2, bottom = 2 },
}

local function applyBorder(container)
    if not container or container._borderApplied then return end
    if Mixin and BackdropTemplateMixin then
        Mixin(container, BackdropTemplateMixin)
    end
    if container.SetBackdrop then
        container:SetBackdrop(BORDER_BACKDROP)
        if container.SetBackdropBorderColor then
            container:SetBackdropBorderColor(0.2, 0.2, 0.25, 1)
        end
        container._borderApplied = true
    end
end

-- Resolve the bar's text label (template may provide one, or we use bar.Label from fallback).
local function getBarLabel(bar)
    if not bar then return nil end
    if bar.Label and bar.Label.SetText then return bar.Label end
    local name = bar.GetName and bar:GetName()
    if name then
        local fs = _G[name .. "Label"] or _G[name .. "Text"]
        if fs and fs.SetText then return fs end
    end
    for _, r in ipairs({ bar:GetRegions() }) do
        if r and r.SetText and r.GetObjectType and r:GetObjectType() == "FontString" then
            return r
        end
    end
    return nil
end

-- Get or create the container and Blizzard status bar for this row (created in Lua, not XML).
local function getOrCreateBar(frame)
    if frame.ProgressBar and frame.ProgressBar.SetMinMaxValues then
        if frame.ProgressBarContainer then
            applyBorder(frame.ProgressBarContainer)
        end
        return frame.ProgressBar
    end
    local container = CreateFrame("Frame", nil, frame)
    container:SetHeight(BAR_HEIGHT + BORDER_INSET * 2)
    container:ClearAllPoints()
    container:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", PROGRESS_BAR_INSET, 9)
    container:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -PROGRESS_BAR_INSET, 9)
    applyBorder(container)
    frame.ProgressBarContainer = container

    local barBg = container:CreateTexture(nil, "BACKGROUND")
    barBg:SetAllPoints(container)
    barBg:SetColorTexture(BAR_BG_COLOR[1], BAR_BG_COLOR[2], BAR_BG_COLOR[3], BAR_BG_COLOR[4])

    local bar = CreateFrame("StatusBar", nil, container, BLIZZARD_BAR_TEMPLATE)
    if not bar or not bar.SetMinMaxValues then
        bar = CreateFrame("StatusBar", nil, container)
        if bar then
            bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
            bar:SetStatusBarColor(COLOR_COMPLETE[1], COLOR_COMPLETE[2], COLOR_COMPLETE[3], COLOR_COMPLETE[4])
        end
    end
    if not bar then return nil end
    -- Template may not set a fill texture; set it so the bar is visible
    if bar.SetStatusBarTexture then
        bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    end
    -- Ensure bar has a label (template may or may not provide one)
    if not getBarLabel(bar) and bar.CreateFontString then
        local label = bar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        label:SetPoint("CENTER", bar, "CENTER", 0, 0)
        label:SetJustifyH("CENTER")
        label:SetJustifyV("MIDDLE")
        bar.Label = label
    end
    bar:SetHeight(BAR_HEIGHT)
    bar:ClearAllPoints()
    bar:SetPoint("TOPLEFT", container, "TOPLEFT", BORDER_INSET, -BORDER_INSET)
    bar:SetPoint("BOTTOMRIGHT", container, "BOTTOMRIGHT", -BORDER_INSET, BORDER_INSET)
    frame.ProgressBar = bar
    return bar
end

function RequirementRowProgress.Apply(frame, req)
    if not frame or not req then return end

    if frame.SetHeight then
        frame:SetHeight(PROGRESS_ROW_HEIGHT)
    end
    if frame.Text and frame.Text.ClearAllPoints and frame.Text.SetPoint then
        frame.Text:ClearAllPoints()
        frame.Text:SetPoint("TOPLEFT", frame, "TOPLEFT", 26, 0)
        frame.Text:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -6, 0)
    end
    if frame.Check and frame.Check.ClearAllPoints and frame.Check.SetPoint then
        frame.Check:ClearAllPoints()
        frame.Check:SetPoint("TOPLEFT", frame, "TOPLEFT", 6, 0)
    end

    if frame.Text and frame.Text.SetText then
        frame.Text:SetText(req.text or "")
    end
    if frame.Check then
        frame.Check:Show()
        if req.completed == true then
            frame.Check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
            frame.Check:SetVertexColor(1, 1, 1)
        else
            frame.Check:SetTexture("Interface\\Buttons\\UI-StopButton")
            frame.Check:SetVertexColor(1, 0, 0)
        end
    end

    if not req.reqQuantity or req.reqQuantity <= 0 or req.quantity == nil then
        if frame.ProgressBar then frame.ProgressBar:Hide() end
        if frame.ProgressBarContainer then frame.ProgressBarContainer:Hide() end
        if frame.ProgressBarBg then frame.ProgressBarBg:Hide() end
        if frame.ProgressBarFill then frame.ProgressBarFill:Hide() end
        return
    end

    local bar = getOrCreateBar(frame)
    if not bar then
        -- Fallback: use legacy texture bar if present
        if frame.ProgressBarBg and frame.ProgressBarFill then
            if frame.ProgressBar then frame.ProgressBar:Hide() end
            frame.ProgressBarBg:ClearAllPoints()
            frame.ProgressBarBg:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 26, 4)
            frame.ProgressBarBg:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -6, 4)
            frame.ProgressBarBg:Show()
            frame.ProgressBarFill:Show()
            if frame.ProgressBarBg.SetColorTexture then
                frame.ProgressBarBg:SetColorTexture(BAR_BG_COLOR[1], BAR_BG_COLOR[2], BAR_BG_COLOR[3], BAR_BG_COLOR[4])
            end
            frame.ProgressBarFill:ClearAllPoints()
            frame.ProgressBarFill:SetPoint("LEFT", frame.ProgressBarBg, "LEFT", 0, 0)
            local ratio = math.min(1, math.max(0, req.quantity / req.reqQuantity))
            local w = (frame.ProgressBarBg.GetWidth and frame.ProgressBarBg:GetWidth()) or 40
            frame.ProgressBarFill:SetWidth(math.max(1, math.floor(ratio * w)))
            if frame.ProgressBarFill.SetColorTexture then
                local c = req.completed == true and COLOR_COMPLETE or COLOR_INCOMPLETE
                frame.ProgressBarFill:SetColorTexture(c[1], c[2], c[3], c[4])
            end
        end
        return
    end

    local highlight = frame.GetHighlightTexture and frame:GetHighlightTexture()
    if highlight then highlight:SetAlpha(0) end

    -- Resize container (and bar) with optional width inset
    local w = frame:GetWidth()
    local inset = (w and w > 0) and math.max(PROGRESS_BAR_INSET, math.floor(0.21875 * w + 27)) or PROGRESS_BAR_INSET
    local container = frame.ProgressBarContainer
    if container and container.ClearAllPoints and container.SetPoint then
        container:ClearAllPoints()
        container:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", inset, 9)
        container:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -inset, 9)
        container:Show()
    end

    -- Ensure the bar has a fill texture (template may not set one)
    if bar.SetStatusBarTexture then
        bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    end
    -- WoW's StatusBar requires finite numbers in valid range; virtual criteria may have nil quantity/reqQuantity.
    local function validNumber(n) return type(n) == "number" and n == n and n >= 0 end  -- exclude nil, NaN
    local maxVal = validNumber(req.reqQuantity) and req.reqQuantity or 1
    local val = validNumber(req.quantity) and req.quantity or 0
    val = math.min(val, maxVal)
    bar:SetMinMaxValues(0, maxVal)
    bar:SetValue(val)
    if bar.SetStatusBarColor then
        local c = req.completed == true and COLOR_COMPLETE or COLOR_INCOMPLETE
        bar:SetStatusBarColor(c[1], c[2], c[3], c[4])
    end

    local label = getBarLabel(bar)
    if label and label.SetText then
        if type(req.quantityString) == "string" and req.quantityString ~= "" then
            label:SetText(req.quantityString)
        else
            label:SetText(tostring(val) .. " / " .. tostring(maxVal))
        end
        if label.ClearAllPoints and label.SetPoint then
            label:ClearAllPoints()
            label:SetPoint("CENTER", bar, "CENTER", 0, 1)
        end
        label:Show()
    end

    bar:Show()
    if frame.ProgressBarBg then frame.ProgressBarBg:Hide() end
    if frame.ProgressBarFill then frame.ProgressBarFill:Hide() end
end
