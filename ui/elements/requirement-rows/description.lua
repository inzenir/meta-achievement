--[[
    Description row: virtual requirement that only shows achievement description text.
    No check icon, no progress bar, click does nothing (handled in map-detail).
]]

RequirementRowDescription = RequirementRowDescription or {}

local ROW_HEIGHT = 20

function RequirementRowDescription.Apply(frame, req)
    if not frame or not req then return end
    if frame.SetHeight then frame:SetHeight(ROW_HEIGHT) end
    if frame.Text then
        if frame.Text.ClearAllPoints and frame.Text.SetPoint then
            frame.Text:ClearAllPoints()
            frame.Text:SetPoint("LEFT", frame, "LEFT", 26, 0)
            frame.Text:SetPoint("RIGHT", frame, "RIGHT", -6, 0)
        end
        if frame.Text.SetText then frame.Text:SetText(req.text or "") end
    end
    if frame.Check then
        frame.Check:Hide()
    end
    if frame.ProgressBarContainer then frame.ProgressBarContainer:Hide() end
    if frame.ProgressBar then frame.ProgressBar:Hide() end
    if frame.ProgressBarBg then frame.ProgressBarBg:Hide() end
    if frame.ProgressBarFill then frame.ProgressBarFill:Hide() end
end
