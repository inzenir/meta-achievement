Achievement = {}
Achievement.__index = Achievement

ACHIEVEMENT_DEFAULT_ICON = "Interface\\Icons\\INV_Misc_QuestionMark"
ACHIEVEMENT_DEFAULT_NAME = "Unknown Achievement"

local function loadCriteria(achievementId, criteriaList)
    local returnValue = {}

    for _, item in pairs(criteriaList) do
        returnValue[#returnValue+1] = AchievementCriteria:new(achievementId, item)
    end

    return returnValue
end

local function figureOutIfChildrenAreCompleted(achievementEntry)
    local _, _, _, completed, _, _, _, _, _, _ = GetAchievementInfo(achievementEntry.id)
    if not completed then
        return false
    end

    for _, achi in pairs(achievementEntry.children or {}) do
        if figureOutIfChildrenAreCompleted(achi) == false then
            return false
        end
    end

    return true
end

local function getAchievementWaypoints(achi)
    local returnValue = {}
    for _, item in pairs(achi.waypoints) do
        returnValue[#returnValue+1] = Waypoint:new(item)
    end

    return returnValue
end

function Achievement:new(achievementEntry)
    local obj = setmetatable({}, Achievement)

    obj.id = achievementEntry.id

    local _, name, _, completed, _, _, _, _, _, icon = GetAchievementInfo(obj.id)

    local waypoints = {}
    for _, wp in pairs(achievementEntry.waypoints or {}) do
        waypoints[#waypoints+1] = Waypoint:new(wp)
    end

    obj.children = achievementEntry.children or {}
    obj.waypoints = waypoints
    obj.criteria = loadCriteria(obj.id, achievementEntry.criteria or {})
    obj.completed = completed
    obj.name = name or achievementEntry.name or ACHIEVEMENT_DEFAULT_NAME
    obj.icon = icon or achievementEntry.icon or ACHIEVEMENT_DEFAULT_ICON
    obj.chidrenCompleted = figureOutIfChildrenAreCompleted(achievementEntry)

    return obj
end

function Achievement:GetAllWaypoints()
    local returnValue = getAchievementWaypoints(self)

    for _, criteria in pairs(self.criteria) do
        local tmp = criteria:GetWaypoint()

        if tmp then
            returnValue[#returnValue+1] = tmp
        end
    end

    return returnValue
end

function Achievement:GetFilteredWaypoints()
    local returnValue = getAchievementWaypoints({ waypoints = self.waypoints })

    for _, criteria in pairs(self.criteria or {}) do
        local tmp = criteria:GetFilteredWaypoint()

        if tmp then
            returnValue[#returnValue+1] = tmp
        end
    end

    return returnValue
end
