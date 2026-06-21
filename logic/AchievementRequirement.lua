AchievementRequirement = {}
AchievementRequirement.__index = AchievementRequirement


local function resolveEventId(requirement)
    if type(requirement) ~= "table" then
        return nil
    end
    if type(requirement.eventId) == "number" then
        return requirement.eventId
    end
    local worldEvent = requirement.worldEvent
    if type(worldEvent) == "table" and type(worldEvent.eventId) == "number" then
        return worldEvent.eventId
    end
    return nil
end

local function checkWorldEvent(eventId)
    if MetaAchievementWorldEventCalendar
        and type(MetaAchievementWorldEventCalendar.IsWorldEventActive) == "function" then
        return MetaAchievementWorldEventCalendar.IsWorldEventActive(eventId, true)
    end
    return true
end

local function checkActiveQuest(questId)
    return true
    --return C_TaskQuest.IsActive(questId)
end

local function checkFaction(requiredFaction)
    local playerFaction = UnitFactionGroup("player") -- Returns "Horde" or "Alliance"
    return playerFaction == requiredFaction
end

local SUPPORTED_ACHIEVEMENT_REQUIREMENTS = {
    eventId = checkWorldEvent,
    quest = checkActiveQuest,
    faction = checkFaction
}

function AchievementRequirement:new(requirement)
    local obj = setmetatable({}, AchievementRequirement)

    obj.requirements = {}

    local eventId = resolveEventId(requirement)
    if eventId then
        obj.requirements.eventId = eventId
    end

    for type, _ in pairs(SUPPORTED_ACHIEVEMENT_REQUIREMENTS) do
        if type ~= "eventId" and requirement[type] then
            obj.requirements[type] = requirement[type]
        end
    end

    return obj
end

function AchievementRequirement:HasSpecialRequirements()
    return next(self.requirements) ~= nil
end

function AchievementRequirement:AreRequirementsMet(opts)
    opts = opts or {}
    local returnValue = true

    for type, callback in pairs(SUPPORTED_ACHIEVEMENT_REQUIREMENTS) do
        if self.requirements[type] ~= nil then
            if opts.ignoreFaction and type == "faction" then
                -- Journal may show both faction branches; notifications still use full checks.
            else
                returnValue = returnValue and callback(self.requirements[type])
            end
        end
    end

    return returnValue
end

function AchievementRequirement:GetFactionRequirement()
    return self.requirements.faction
end
