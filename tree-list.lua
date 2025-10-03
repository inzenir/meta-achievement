local ROW_HEIGHT = 20
local DEPTH_OFFSET = 15;
local allRows = {}
local parentReference = nil

local function flattenData(data)
    local tmpItems = {}

    for _, item in ipairs(data) do
        tmpItems[#tmpItems+1] = item

        if item.colapsed == false then
            for i, tmpItem in ipairs(flattenData(item.children)) do
                tmpItems[#tmpItems+1] = tmpItem
            end
        end
    end

    return tmpItems
end

local function toggleColapsed(id, data)
    data = data or allRows
    for _, node in ipairs(data) do
        if node.id == id then
            node.colapsed = not node.colapsed
        end
        if node.children then
           toggleColapsed(id, node.children)
        end
    end
end


local function createTreeList(parent, data)
    parent = parent or parentReference
    data = data or flattenData(allRows)

    local prevRow = nil

    for _, child in ipairs({ parent:GetChildren()}) do
        child:SetParent(nil)
        child:Hide()
        child = nil
    end

    parent:SetHeight(#data * ROW_HEIGHT)

    for i, node in ipairs(data) do
        local row = CreateFrame("Frame", nil, parent, "BackdropTemplate")
        row:SetHeight(ROW_HEIGHT)
        row:SetPoint("RIGHT", parent, "RIGHT", 0, 0)

        -- Highlight

        local highlight = row:CreateTexture(nil, "HIGHLIGHT")
        highlight:SetAllPoints()
        highlight:SetColorTexture(1, 0, 0, 0.3) -- semi-transparent red
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
            row:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, -1 * ROW_HEIGHT)
        end

        local depthOffset = node.depth * DEPTH_OFFSET

        -- Toggle icon
        if node.hasChildren then
            local toggle = CreateFrame("Button", nil, row, "UIPanelButtonTemplate")
            toggle:SetPoint("TOPLEFT", row, "TOPLEFT", depthOffset + 15, 0)
            toggle:SetSize(15, 15)
            local toggleText = node.colapsed and "+" or "-"
            toggle:SetText(node.hasChildren and toggleText)

            toggle:SetScript("OnClick", function ()
                toggleColapsed(node.id)
                createTreeList()
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

local function initData(data, depth)
    depth = depth or 0
    local tmpItems = {}
    for _, item in ipairs(data) do
        local _, nodeName, _, nodeCompleted, _, _, _, _, _, nodeImageAchiement = GetAchievementInfo(item.id)
        local children = {}
        local nodeImageCompletion = "Interface\\Buttons\\UI-StopButton"
        if nodeCompleted or false then
            nodeImageCompletion = "Interface\\Buttons\\UI-CheckBox-Check"
        end
        if item.children then
            children = initData(item.children, depth + 1)
        end
        local tmpItem = {
            id = item.id,
            name = nodeName or item.name or "Unknown Achievement",
            icon = nodeImageAchiement or "Interface\\Icons\\INV_Misc_QuestionMark",
            completed = nodeCompleted,
            completedIcon = nodeImageCompletion,
            colapsed = false,
            children = children,
            hasChildren = #children > 0,
            depth = depth
        }

        tmpItems[#tmpItems+1] = tmpItem
    end

    return tmpItems
end

local function drawFrame()
    local flatData = flattenData(allRows)
    createTreeList(parentReference, flatData)

    parentReference:SetHeight(#flatData * ROW_HEIGHT)
end

function InitFrame(parent, data)
    local frame = CreateFrame("Frame", nil, parent)
    frame:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -10)
    frame:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -10, 10)
    frame:SetWidth(parent:GetWidth() - 50)
    frame:SetHeight(0)

    parent:HookScript("OnSizeChanged", function()
        frame:SetWidth(parent:GetWidth() - 50)
    end)

    parentReference = frame
    allRows = initData(data)

    createTreeList()

    return frame
end
