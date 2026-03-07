--[[
    Logic for MetaAchievementSettingsSeparatorTemplate.
    Sets the label text from element data .text (when the Settings list calls Init/SetElementData),
    or keeps the XML default if data is never passed.
]]

function MetaAchievementSettingsSeparator_OnLoad(frame)
    local function getLabel()
        if frame.Text then return frame.Text end
        local name = frame.GetName and frame:GetName()
        if name and _G[name.."Text"] then return _G[name.."Text"] end
        for i = 1, frame:GetNumChildren() or 0 do
            local child = select(i, frame:GetChildren())
            if child and child.SetText then return child end
        end
        return nil
    end

    local function setText(text)
        if text == nil then return end
        local label = getLabel()
        if label then label:SetText(tostring(text)) end
    end

    local function setTextFromData(data)
        if not data then return end
        local t = (type(data.GetData) == "function" and data:GetData()) or data
        if not t or t.text == nil then return end
        frame._separatorText = tostring(t.text)
        setText(frame._separatorText)
    end

    frame.Init = function(_, data) setTextFromData(data) end
    frame.SetElementData = function(_, data) setTextFromData(data) end
    frame:SetScript("OnShow", function()
        if frame._separatorText then
            setText(frame._separatorText)
        else
            local data = frame.elementData or frame.data
            if data then setTextFromData(data) end
        end
    end)
end
