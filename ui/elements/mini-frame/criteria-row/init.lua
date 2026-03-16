--[[
    Dispatches to the correct criteria line type: regular (text + check) or progress (text + check + bar).
    Mirrors main-frame requirement-rows/init.lua; different display depending on criteria type.
]]

MiniCriteriaRows = MiniCriteriaRows or {}

local HEADER_ROW_HEIGHT = 16

function MiniCriteriaRows.ApplyHeader(frame, completed, total)
    if not frame then return end
    if not frame.Text and frame.GetRegions then
        for _, r in ipairs({ frame:GetRegions() }) do
            if r and r.GetObjectType and r:GetObjectType() == "FontString" then
                frame.Text = r
                break
            end
        end
    end
    if frame.SetHeight then frame:SetHeight(HEADER_ROW_HEIGHT) end
    if frame.Text and frame.Text.SetText then
        frame.Text:SetText((total and total > 0) and ("Criteria: " .. (completed or 0) .. "/" .. total) or "Criteria: 0/0")
    end
    if frame.Text then frame.Text:Show() end
    frame:Show()
end

function MiniCriteriaRows.ApplyLine(frame, criterion)
    if not frame or not criterion then return end

    if frame.Check and not frame.Check.SetTexture then
        local name = frame:GetName()
        if name then frame.Check = frame.Check or _G[name .. "Check"] end
        if not frame.Check and frame.GetRegions then
            for _, r in ipairs({ frame:GetRegions() }) do
                if r and r.GetObjectType and r:GetObjectType() == "Texture" then
                    frame.Check = r
                    break
                end
            end
        end
    end

    if criterion.reqQuantity and criterion.reqQuantity > 1 and criterion.quantity ~= nil and MiniCriteriaRowProgress and MiniCriteriaRowProgress.Apply then
        MiniCriteriaRowProgress.Apply(frame, criterion)
    elseif MiniCriteriaRowRegular and MiniCriteriaRowRegular.Apply then
        MiniCriteriaRowRegular.Apply(frame, criterion)
    else
        if MiniCriteriaRowRegular and MiniCriteriaRowRegular.Apply then
            MiniCriteriaRowRegular.Apply(frame, criterion)
        end
    end
end
