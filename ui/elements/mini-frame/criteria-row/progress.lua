--[[
    Compact criteria line with progress bar: text + check + quantity bar (like main-frame requirement-rows/progress.lua).
]]

MiniCriteriaRowProgress = MiniCriteriaRowProgress or {}

local ROW_HEIGHT = 28
local BAR_HEIGHT = 8
local BAR_INSET = 36
local COLOR_COMPLETE = { 0.2, 0.75, 0.2, 1 }
local COLOR_INCOMPLETE = { 0.3, 0.55, 0.9, 1 }

local function getOrCreateBar(frame)
    if frame.ProgressBar and frame.ProgressBar.SetMinMaxValues then
        return frame.ProgressBar
    end
    local container = CreateFrame("Frame", nil, frame)
    container:SetHeight(BAR_HEIGHT + 2)
    container:ClearAllPoints()
    container:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", BAR_INSET, 2)
    container:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -8, 2)
    frame.ProgressBarContainer = container

    local barBg = container:CreateTexture(nil, "BACKGROUND")
    barBg:SetAllPoints(container)
    barBg:SetColorTexture(0.08, 0.08, 0.1, 0.5)

    local bar = CreateFrame("StatusBar", nil, container, "UIWidgetTemplateStatusBar")
    if not bar or not bar.SetMinMaxValues then
        bar = CreateFrame("StatusBar", nil, container)
        if bar then
            bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
            bar:SetStatusBarColor(COLOR_COMPLETE[1], COLOR_COMPLETE[2], COLOR_COMPLETE[3], COLOR_COMPLETE[4])
        end
    end
    if not bar then return nil end
    if bar.SetStatusBarTexture then
        bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    end
    bar:SetHeight(BAR_HEIGHT)
    bar:ClearAllPoints()
    bar:SetPoint("TOPLEFT", container, "TOPLEFT", 1, -1)
    bar:SetPoint("BOTTOMRIGHT", container, "BOTTOMRIGHT", -1, 1)
    frame.ProgressBar = bar
    return bar
end

function MiniCriteriaRowProgress.Apply(frame, criterion)
    if not frame or not criterion then return end

    if frame.SetHeight then frame:SetHeight(ROW_HEIGHT) end

    if frame.Text and frame.Text.SetText then
        frame.Text:SetText(criterion.text or "")
    end
    if frame.Text then frame.Text:Show() end

    if frame.Check then
        frame.Check:Show()
        if criterion.completed == true then
            frame.Check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
            frame.Check:SetVertexColor(1, 1, 1)
        else
            frame.Check:SetTexture("Interface\\Buttons\\UI-StopButton")
            frame.Check:SetVertexColor(1, 0, 0)
        end
    end

    local reqQ = criterion.reqQuantity
    local qty = criterion.quantity
    if not reqQ or reqQ <= 0 or qty == nil then
        if frame.ProgressBar then frame.ProgressBar:Hide() end
        if frame.ProgressBarContainer then frame.ProgressBarContainer:Hide() end
        return
    end

    local bar = getOrCreateBar(frame)
    if not bar then
        if frame.ProgressBarContainer then frame.ProgressBarContainer:Hide() end
        return
    end

    local maxVal = math.max(1, reqQ)
    local val = math.min(math.max(0, qty), maxVal)
    bar:SetMinMaxValues(0, maxVal)
    bar:SetValue(val)
    if bar.SetStatusBarColor then
        local c = criterion.completed == true and COLOR_COMPLETE or COLOR_INCOMPLETE
        bar:SetStatusBarColor(c[1], c[2], c[3], c[4])
    end
    frame.ProgressBarContainer:Show()
    bar:Show()
end
