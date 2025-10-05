DataList = {}
DataList.__index = DataList

local function scanData(inputData, depth, colapsedItems)
    local hasMapIntegration = false
    if MetaAchievementDB ~= nil then
        hasMapIntegration = MetaAchievementDB.mapIntegration:HasActiveIntegration()
    end

    local tmpItems = {}
    for _, item in ipairs(inputData) do
        local _, nodeName, _, nodeCompleted, _, _, _, _, _, nodeImageAchiement = GetAchievementInfo(item.id)
        local children = {}
        local nodeImageCompletion = "Interface\\Buttons\\UI-StopButton"
        local allChildrenCompleted = false

        -- map integration
        if hasMapIntegration and MetaAchievementConfigurationDB.removeCompletedWaypoints and nodeCompleted then
            MetaAchievementDB.mapIntegration:RemoveWaypointsForAchievement(item.id)
        end


        if nodeCompleted or false then
            nodeImageCompletion = "Interface\\Buttons\\UI-CheckBox-Check"
        end

        if item.children then
            children = scanData(item.children, depth + 1, colapsedItems)
            allChildrenCompleted = true
            for _, child in pairs(children) do
                allChildrenCompleted = allChildrenCompleted and child.allChildrenCompleted
            end
        else
            allChildrenCompleted = nodeCompleted
        end

        local tmpItem = {
            id = item.id,
            name = nodeName or item.name or "Unknown Achievement",
            icon = nodeImageAchiement or item.icon or "Interface\\Icons\\INV_Misc_QuestionMark",
            completed = nodeCompleted,
            completedIcon = nodeImageCompletion,
            colapsed = colapsedItems[item.id] or false,
            children = children,
            hasChildren = #children > 0,
            depth = depth,
            allChildrenCompleted = allChildrenCompleted,
            waypoints = item.waypoints
        }

        tmpItems[#tmpItems+1] = tmpItem
    end

    return tmpItems
end

function DataList:new(achievementItems)
    local obj = setmetatable({}, DataList)
    obj.achievements = achievementItems
    obj.colapsedItems = {}
    obj.items = scanData(obj.achievements, 0, obj.colapsedItems)

    return obj
end

function DataList:rescanData()
    self.items = scanData(self.achievements, 0, self.colapsedItems)
end

local function flatData(input)
    local tmpItems = {}

    for _, item in ipairs(input) do
        if not (item.allChildrenCompleted and MetaAchievementConfigurationDB.hideCompleted) then
            tmpItems[#tmpItems+1] = item

            if item.colapsed == false then
                for _, tmpItem in ipairs(flatData(item.children)) do
                    tmpItems[#tmpItems+1] = tmpItem
                end
            end
        end
    end

    return tmpItems
end

function DataList:getFlatData()
    return flatData(self.items)
end

function DataList:toggleColapsed(id)
    if self.colapsedItems[id] then
        local tmpColapsed = {}
        for key, _ in pairs(self.colapsedItems) do
            if key ~= id then
                tmpColapsed[key] = true
            end
        end
        self.colapsedItems = tmpColapsed
    else
        self.colapsedItems[id] = true
    end
end