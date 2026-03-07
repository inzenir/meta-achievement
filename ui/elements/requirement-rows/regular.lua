--[[
    Regular requirement row: text + check icon (completed / not completed).
    No progress bar.
]]

RequirementRowRegular = RequirementRowRegular or {}

local ROW_HEIGHT = 20

function RequirementRowRegular.Apply(frame, req)
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
        if frame.Check.ClearAllPoints and frame.Check.SetPoint then
            frame.Check:ClearAllPoints()
            frame.Check:SetPoint("LEFT", frame, "LEFT", 6, 0)
        end
        frame.Check:Show()
        if req.completed == true then
            frame.Check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
            frame.Check:SetVertexColor(1, 1, 1)
        else
            frame.Check:SetTexture("Interface\\Buttons\\UI-StopButton")
            frame.Check:SetVertexColor(1, 0, 0)
        end
    end
    if frame.ProgressBarContainer then frame.ProgressBarContainer:Hide() end
    if frame.ProgressBar then frame.ProgressBar:Hide() end
    if frame.ProgressBarBg then frame.ProgressBarBg:Hide() end
    if frame.ProgressBarFill then frame.ProgressBarFill:Hide() end
end
