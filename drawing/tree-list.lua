local ROW_HEIGHT = 20
local DEPTH_OFFSET = 15;

TreeView = {}
TreeView.__index = TreeView

function TreeView:new(parent, data, name)
    local obj = setmetatable({}, TreeView)
    obj.frame = CreateFrame("Frame", nil, parent)
    obj.frame:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -10)
    obj.frame:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -10, 10)
    obj.frame:SetWidth(parent:GetWidth() - 50)
    obj.frame:SetHeight(0)

    parent:HookScript("OnSizeChanged", function()
        obj.frame:SetWidth(parent:GetWidth() - 50)
    end)

    obj.dataList = data
    obj.name = name

    return obj
end

function TreeView:getFrame()
    return self.frame
end

function TreeView:getName()
    return self.name
end

local function clearTreeView(parent)
    for _, child in ipairs({ parent:GetChildren() }) do
        child:SetParent(nil)
        child:Hide()
        child = nil
    end
end

function TreeView:onToggleClick(node, button)
    self.dataList:toggleColapsed(node.id)
    self:draw()
end

function TreeView:draw()
    local prevRow = nil
    self.dataList:rescanData()
    local dataList = self.dataList:getFlatData()

    self.frame:SetHeight(#dataList * ROW_HEIGHT)

    clearTreeView(self.frame)

    for _, node in ipairs(dataList) do
        local row = CreateFrame("Frame", nil, self.frame, "BackdropTemplate")
        row:SetHeight(ROW_HEIGHT)
        row:SetPoint("RIGHT", self.frame, "RIGHT", 0, 0)

        -- Highlight

        local highlight = row:CreateTexture(nil, "HIGHLIGHT")
        highlight:SetAllPoints()
        if MetaAchievementConfigurationDB.colouredHightlight then
            if node.completed then
                highlight:SetColorTexture(0, 1, 0, 0.1) -- semi-transparent gren
            else
                highlight:SetColorTexture(1, 0, 0, 0.1) -- semi-transparent red
            end
            
        else
            highlight:SetColorTexture(1, 1, 1, 0.1) -- translucent
        end
        highlight:Hide()

        row:SetScript("OnEnter", function()
            highlight:Show()
        end)

        row:SetScript("OnLeave", function()
            highlight:Hide()
        end)

        -- Prev row shit

        if prevRow then
            row:SetPoint("TOPLEFT", prevRow, "BOTTOMLEFT", 0, 0)
        else
            row:SetPoint("TOPLEFT", self.frame, "TOPLEFT", -5, -5)
        end

        local depthOffset = node.depth * DEPTH_OFFSET

        -- Toggle icon
        if node.hasChildren then
            local toggle = CreateFrame("Button", nil, row, "UIPanelButtonTemplate")
            toggle:SetPoint("TOPLEFT", row, "TOPLEFT", depthOffset + 15, 0)
            toggle:SetSize(15, 15)
            local toggleText = node.colapsed and "+" or "-"
            toggle:SetText(node.hasChildren and toggleText)
            toggle.id = node.id

            toggle:SetScript("OnClick", function(frame, button)
                self:onToggleClick(frame, button)
            end)
        end

        -- Achievement icon
        local achievementButton = CreateFrame("Button", nil, row, "UIPanelButtonTemplate")
        achievementButton:SetSize(16, 16)
        achievementButton:SetPoint("TOPLEFT", row, "TOPLEFT", depthOffset + 35, 0)
        achievementButton:SetScript("OnClick", function ()
            OpenAchievementFrameToAchievement(node.id)
        end)

        local achievementIcon = achievementButton:CreateTexture(nil, "ARTWORK")
        achievementIcon:SetAllPoints()
        achievementIcon:SetTexture(node.icon)

        -- Text
        local text = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        text:SetPoint("TOPLEFT", achievementIcon, "TOPRIGHT", 5, -2)
        text:SetText(node.name)

        -- Completion icon
        local completionIcon = row:CreateTexture(nil, "ARTWORK")
        completionIcon:SetSize(16, 16)
        completionIcon:SetPoint("TOPRIGHT", row, "TOPRIGHT", 0, 0)
        completionIcon:SetTexture(node.completedIcon)
        if not node.completed then
            completionIcon:SetVertexColor(1, 0, 0)
        end

        prevRow = row
    end
end