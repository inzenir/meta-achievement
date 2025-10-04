DataList = {}
DataList.__index = DataList

local function scanData(inputData, depth)
    local tmpItems = {}
    for _, item in ipairs(inputData) do
        local _, nodeName, _, nodeCompleted, _, _, _, _, _, nodeImageAchiement = GetAchievementInfo(item.id)
        local children = {}
        local nodeImageCompletion = "Interface\\Buttons\\UI-StopButton"
        if nodeCompleted or false then
            nodeImageCompletion = "Interface\\Buttons\\UI-CheckBox-Check"
        end
        if item.children then
            children = scanData(item.children, depth + 1)
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

function DataList:new(achievementItems)
    local obj = setmetatable({}, DataList)
    obj.achievements = achievementItems
    obj.items = scanData(obj.achievements, 0)

    return obj
end

function DataList:rescanData()
    self.items = scanData(self.achievements, 0)
end

local function flatData(input)
    local tmpItems = {}

    for _, item in ipairs(input) do
        tmpItems[#tmpItems+1] = item

        if item.colapsed == false then
            for i, tmpItem in ipairs(flatData(item.children)) do
                tmpItems[#tmpItems+1] = tmpItem
            end
        end
    end

    return tmpItems
end

function DataList:getFlatData()
    return flatData(self.items)
end

local function toggleColapsed(id, data)
    for i, node in ipairs(data) do
        if node.id == id then
            node.colapsed = not node.colapsed
        end
        if node.children then
            toggleColapsed(id, node.children)
        end
    end
end

function DataList:toggleColapsed(id)
    toggleColapsed(id, self.items)
end