DataList = {}
DataList.__index = DataList

NODE_ICON_COMPLETED = "Interface\\Buttons\\UI-CheckBox-Check"
NODE_ICON_NOT_COMPLETED = "Interface\\Buttons\\UI-StopButton"

local function scanData(inputData, depth, colapsedItems, parentRequirements)
    local tmpItems = {}
    for _, item in ipairs(inputData or {}) do
        local achiObj = Achievement:new(item, parentRequirements)

        -- Skip achievements whose requirements are not met (e.g., wrong faction)
        local shouldInclude = true
        if achiObj.requirements and achiObj.requirements.AreRequirementsMet then
            shouldInclude = achiObj.requirements:AreRequirementsMet()
        end

        if shouldInclude then
            local tmpItem = {
                id = item.id,
                data = achiObj,
                completedIcon = achiObj.completed and NODE_ICON_COMPLETED or NODE_ICON_NOT_COMPLETED,
                colapsed = colapsedItems[item.id] or false,
                children = scanData(item.children or {}, depth + 1, colapsedItems, achiObj.requirements),
                allChildrenCompleted = achiObj.chidrenCompleted,
                depth = depth,
                waypoints = item.waypoints
            }

            tmpItems[#tmpItems+1] = tmpItem
        end
    end

    return tmpItems
end

function DataList:new(achievementItems)
    local obj = setmetatable({}, DataList)

    achievementItems = achievementItems or {}
    local first = achievementItems[1]
    -- Empty list: no [1]; avoid indexing nil (topAchievementId stays nil).
    obj.topAchievementId = first and first.id or nil
    obj.achievements = achievementItems

    obj.colapsedItems = {}
    if obj.topAchievementId
        and MetaAchievementConfigurationDB.mapIntegration
        and MetaAchievementConfigurationDB.mapIntegration[obj.topAchievementId]
        and MetaAchievementConfigurationDB.mapIntegration[obj.topAchievementId].colapsedItems
    then
        obj.colapsedItems = MetaAchievementConfigurationDB.mapIntegration[obj.topAchievementId].colapsedItems
    end

    obj.items = scanData(obj.achievements, 0, obj.colapsedItems)
    -- Tree matches static data + collapse state; skip rescan on source tab switch unless marked dirty.
    obj._treeDirty = false

    return obj
end

function DataList:rescanData()
    self.items = scanData(self.achievements, 0, self.colapsedItems)
    self._treeDirty = false
end

function DataList:getFlatData()
    local hideCompleted = MetaAchievementSettings and MetaAchievementSettings:Get("hideCompleted")
    return MetaAchievementFlatList.flatten(self.items, hideCompleted)
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

    if not MetaAchievementConfigurationDB["mapIntegration"] then
        MetaAchievementConfigurationDB["mapIntegration"] = {}
    end
    if not MetaAchievementConfigurationDB["mapIntegration"][self.topAchievementId] then
        MetaAchievementConfigurationDB["mapIntegration"][self.topAchievementId] = {}
    end
    MetaAchievementConfigurationDB["mapIntegration"][self.topAchievementId].colapsedItems = self.colapsedItems
    self._treeDirty = true
end

--- Registry for optional global invalidation (e.g. achievement earned); keyed by journal source id.
DataList._registryBySourceKey = DataList._registryBySourceKey or {}

function DataList.RegisterForSourceKey(key, list)
    if type(key) == "string" and key ~= "" and list then
        DataList._registryBySourceKey[key] = list
    end
end

function DataList.MarkAllTreesDirty()
    for _, list in pairs(DataList._registryBySourceKey) do
        if list then
            list._treeDirty = true
        end
    end
end
