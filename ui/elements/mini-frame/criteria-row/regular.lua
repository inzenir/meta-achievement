--[[
    Compact criteria line: text + check icon (completed / not completed). No progress bar.
    Mirrors main-frame requirement-rows/regular.lua for criteria type display.
]]

MiniCriteriaRowRegular = MiniCriteriaRowRegular or {}

local ROW_HEIGHT = 16

function MiniCriteriaRowRegular.Apply(frame, criterion)
    if not frame or not criterion then return end
    if frame.SetHeight then frame:SetHeight(ROW_HEIGHT) end

    if frame.Text and frame.Text.SetText then
        frame.Text:SetText(criterion.text or "")
    end
    if frame.Text then
        frame.Text:Show()
        -- Reset anchors after a progress row reused this frame (progress.lua offsets text +6).
        if frame.Text.ClearAllPoints then
            frame.Text:ClearAllPoints()
            frame.Text:SetPoint("LEFT", frame, "LEFT", 36, 0)
            frame.Text:SetPoint("RIGHT", frame, "RIGHT", -8, 0)
        end
    end

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

    if frame.ProgressBarContainer then frame.ProgressBarContainer:Hide() end
    if frame.ProgressBar then frame.ProgressBar:Hide() end
end
