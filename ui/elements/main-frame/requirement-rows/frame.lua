--[[
    Resolves row frame references (Text, Check, ProgressBarContainer + ProgressBar, or ProgressBarBg/ProgressBarFill).
    ProgressBarContainer = wrapper that gets the rounded border; ProgressBar = StatusBar inside it.
]]

RequirementRowsFrame = RequirementRowsFrame or {}

local function findProgressBarInContainer(container)
    if not container or not container.GetChildren then return nil end
    local children = { container:GetChildren() }
    for _, c in ipairs(children) do
        if c and c.SetMinMaxValues and c.SetValue then
            return c
        end
    end
    return nil
end

function RequirementRowsFrame.EnsureRefs(frame)
    if not frame then return end
    local name = frame:GetName()
    if name then
        frame.Text = frame.Text or _G[name .. "Text"]
        frame.Check = frame.Check or _G[name .. "Check"]
        frame.ProgressBarContainer = frame.ProgressBarContainer or _G[name .. "ProgressBarContainer"]
        frame.ProgressBar = frame.ProgressBar or (frame.ProgressBarContainer and findProgressBarInContainer(frame.ProgressBarContainer))
        frame.ProgressBarBg = frame.ProgressBarBg or _G[name .. "ProgressBarBg"]
        frame.ProgressBarFill = frame.ProgressBarFill or _G[name .. "ProgressBarFill"]
    else
        frame.ProgressBarContainer = frame.ProgressBarContainer or nil
        frame.ProgressBar = frame.ProgressBar or nil
        local children = { frame:GetChildren() }
        for _, c in ipairs(children) do
            local bar = findProgressBarInContainer(c)
            if bar then
                frame.ProgressBarContainer = c
                frame.ProgressBar = bar
                break
            end
        end
    end
    if frame.Text and frame.Check and (frame.ProgressBar or ((frame.ProgressBarBg and frame.ProgressBarFill) or not frame.CreateTexture)) then
        -- Don't create legacy bar if we have StatusBar
        if not frame.ProgressBar then
            if not frame.ProgressBarBg and frame.CreateTexture and frame.Check then
                frame.ProgressBarBg = frame:CreateTexture(nil, "ARTWORK")
                frame.ProgressBarBg:SetSize(40, 8)
                frame.ProgressBarBg:SetPoint("RIGHT", frame, "RIGHT", -6, 0)
                frame.ProgressBarBg:Hide()
            end
            if not frame.ProgressBarFill and frame.CreateTexture and frame.ProgressBarBg then
                frame.ProgressBarFill = frame:CreateTexture(nil, "ARTWORK")
                frame.ProgressBarFill:SetSize(1, 8)
                frame.ProgressBarFill:SetPoint("LEFT", frame.ProgressBarBg, "LEFT", 0, 0)
                frame.ProgressBarFill:Hide()
            end
        end
        return
    end
    if not name then
        if not frame.Text then
            local highlightTex = frame.GetHighlightTexture and frame:GetHighlightTexture()
            local function isHighlightTexture(tex)
                if not tex or tex == highlightTex then return true end
                local path = tex.GetTexture and tex:GetTexture()
                if type(path) == "string" and path:find("QuestTitleHighlight", 1, true) then return true end
                return false
            end
            for _, r in ipairs({ frame:GetRegions() }) do
                if r and r.GetObjectType then
                    if r:GetObjectType() == "FontString" then
                        frame.Text = r
                    elseif r:GetObjectType() == "Texture" and not isHighlightTexture(r) and not frame.Check then
                        frame.Check = r
                    end
                end
            end
        end
    end
    if not frame.ProgressBar and not frame.ProgressBarBg and frame.CreateTexture and frame.Check then
        frame.ProgressBarBg = frame:CreateTexture(nil, "ARTWORK")
        frame.ProgressBarBg:SetSize(40, 8)
        frame.ProgressBarBg:SetPoint("RIGHT", frame, "RIGHT", -6, 0)
        frame.ProgressBarBg:Hide()
    end
    if not frame.ProgressBar and not frame.ProgressBarFill and frame.CreateTexture and frame.ProgressBarBg then
        frame.ProgressBarFill = frame:CreateTexture(nil, "ARTWORK")
        frame.ProgressBarFill:SetSize(1, 8)
        frame.ProgressBarFill:SetPoint("LEFT", frame.ProgressBarBg, "LEFT", 0, 0)
        frame.ProgressBarFill:Hide()
    end
end
