--[[
    Progress requirement row: text with quantity/reqQuantity + check icon + Blizzard-style StatusBar.
    Uses StatusBar API when frame.ProgressBar exists; falls back to texture-based bar for legacy template.
]]

RequirementRowProgress = RequirementRowProgress or {}

local BAR_WIDTH = 40
local PROGRESS_ROW_HEIGHT = 41  -- text line + progress bar on new line
local PROGRESS_BAR_INSET = 48   -- base inset each side; 25% narrower = larger effective inset

-- Blizzard-like bar colors
local COLOR_COMPLETE = { 0.2, 0.75, 0.2, 1 }   -- green
local COLOR_INCOMPLETE = { 0.3, 0.55, 0.9, 1 } -- blue

-- Strong dark border (like the example); larger edge and dark color
local ROUNDED_BORDER_BACKDROP = {
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    edgeSize = 10,
    insets = { left = 3, right = 3, top = 3, bottom = 3 },
}

local function applyRoundedBorder(container)
    if not container or container._backdropApplied then return end
    if Mixin and BackdropTemplateMixin then
        Mixin(container, BackdropTemplateMixin)
    end
    if container.SetBackdrop then
        container:SetBackdrop(ROUNDED_BORDER_BACKDROP)
        -- Strong dark border so it's clearly visible
        if container.SetBackdropBorderColor then
            container:SetBackdropBorderColor(0.12, 0.12, 0.15, 1)
        end
        container._backdropApplied = true
    end
end

local function getOrCreateBarLabel(bar)
    if not bar then return nil end
    if bar.Label then return bar.Label end
    local name = bar.GetName and bar:GetName()
    if name then
        bar.Label = _G[name .. "Text"]
        if bar.Label then return bar.Label end
    end
    for _, r in ipairs({ bar:GetRegions() }) do
        if r and r.SetText and r.GetObjectType and r:GetObjectType() == "FontString" then
            bar.Label = r
            return r
        end
    end
    -- Create label as child of bar so it draws on top of the fill
    if bar.CreateFontString then
        bar.Label = bar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        if bar.Label then
            bar.Label:SetJustifyH("CENTER")
            bar.Label:SetJustifyV("MIDDLE")
            return bar.Label
        end
    end
    return nil
end

function RequirementRowProgress.Apply(frame, req)
    if not frame or not req then return end

    -- Force two-line layout: set row height and keep text on first line, bar on second
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
        local displayText = req.text or ""
        if req.reqQuantity and req.reqQuantity > 0 and req.quantity ~= nil then
            if type(req.quantityString) == "string" and req.quantityString ~= "" then
                displayText = displayText .. " (" .. req.quantityString .. ")"
            else
                displayText = displayText .. " (" .. tostring(req.quantity) .. " / " .. tostring(req.reqQuantity) .. ")"
            end
        end
        frame.Text:SetText(displayText)
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

    -- Blizzard StatusBar inside ProgressBarContainer (border is on the container)
    if frame.ProgressBar and frame.ProgressBar.SetMinMaxValues and req.reqQuantity and req.reqQuantity > 0 and req.quantity ~= nil then
        -- No highlight on hover for progress rows
        local highlight = frame.GetHighlightTexture and frame:GetHighlightTexture()
        if highlight then highlight:SetAlpha(0) end
        local container = frame.ProgressBarContainer
        local bar = frame.ProgressBar
        -- Position container on second line; another 25% narrower (bar = 56.25% of original width)
        if container and container.ClearAllPoints and container.SetPoint then
            container:ClearAllPoints()
            local w = frame:GetWidth()
            local inset = (w and w > 0) and (0.21875 * w + 27) or PROGRESS_BAR_INSET
            inset = math.max(PROGRESS_BAR_INSET, math.floor(inset))
            container:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", inset, 11)
            container:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -inset, 11)
        end
        applyRoundedBorder(container)
        -- Keep fill texture inside bar bounds (no tile bleed); leave default draw layer so fill is visible
        local fillTex = bar.GetStatusBarTexture and bar:GetStatusBarTexture()
        if fillTex and fillTex.SetVertTile and fillTex.SetHorizTile then
            fillTex:SetVertTile(false)
            fillTex:SetHorizTile(false)
        end
        bar:SetMinMaxValues(0, req.reqQuantity)
        bar:SetValue(req.quantity)
        if bar.SetStatusBarColor then
            local c = req.completed == true and COLOR_COMPLETE or COLOR_INCOMPLETE
            bar:SetStatusBarColor(c[1], c[2], c[3], c[4])
        end
        local label = getOrCreateBarLabel(bar)
        if label and label.SetText then
            if type(req.quantityString) == "string" and req.quantityString ~= "" then
                label:SetText(req.quantityString)
            else
                label:SetText(tostring(req.quantity) .. " / " .. tostring(req.reqQuantity))
            end
            if label.ClearAllPoints then label:ClearAllPoints() end
            if label.SetPoint then label:SetPoint("CENTER", bar, "CENTER", 0, 0) end
            if label.SetDrawLayer then label:SetDrawLayer("OVERLAY", 0) end
            if label.SetFrameLevel and bar.GetFrameLevel then
                label:SetFrameLevel(bar:GetFrameLevel() + 10)
            end
            label:Show()
        end
        if container then container:Show() end
        bar:Show()
        if frame.ProgressBarBg then frame.ProgressBarBg:Hide() end
        if frame.ProgressBarFill then frame.ProgressBarFill:Hide() end
        return
    end

    -- Legacy texture-based bar (row.xml fallback)
    if frame.ProgressBarBg and frame.ProgressBarFill and req.reqQuantity and req.reqQuantity > 0 and req.quantity ~= nil then
        if frame.ProgressBarContainer then frame.ProgressBarContainer:Hide() end
        if frame.ProgressBar then frame.ProgressBar:Hide() end
        if frame.ProgressBarBg.ClearAllPoints and frame.ProgressBarBg.SetPoint then
            frame.ProgressBarBg:ClearAllPoints()
            frame.ProgressBarBg:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 26, 4)
            frame.ProgressBarBg:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -6, 4)
        end
        frame.ProgressBarBg:Show()
        frame.ProgressBarFill:Show()
        if frame.ProgressBarBg.SetColorTexture then
            frame.ProgressBarBg:SetColorTexture(0.2, 0.2, 0.25, 1)
        end
        if frame.ProgressBarFill.ClearAllPoints and frame.ProgressBarFill.SetPoint then
            frame.ProgressBarFill:ClearAllPoints()
            frame.ProgressBarFill:SetPoint("LEFT", frame.ProgressBarBg, "LEFT", 0, 0)
        end
        local ratio = math.min(1, math.max(0, req.quantity / req.reqQuantity))
        local barWidth = (frame.ProgressBarBg.GetWidth and frame.ProgressBarBg:GetWidth()) or BAR_WIDTH
        local fillW = math.max(1, math.floor(ratio * barWidth))
        frame.ProgressBarFill:SetWidth(fillW)
        if frame.ProgressBarFill.SetColorTexture then
            local c = req.completed == true and COLOR_COMPLETE or COLOR_INCOMPLETE
            frame.ProgressBarFill:SetColorTexture(c[1], c[2], c[3], c[4])
        end
    else
        if frame.ProgressBarContainer then frame.ProgressBarContainer:Hide() end
        if frame.ProgressBar then frame.ProgressBar:Hide() end
        if frame.ProgressBarBg then frame.ProgressBarBg:Hide() end
        if frame.ProgressBarFill then frame.ProgressBarFill:Hide() end
    end
end
