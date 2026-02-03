-- Framework for checking achievement criteria completion by type.
-- Storage of handlers, registration, and a global dispatch function.
-- No built-in completion logic; handlers determine completion.

local criteriaCompletionHandlers = {}

--- Register a handler for a criteria type.
--- @param criteriaType number WoW criteria type (e.g. CRITERIA_TYPE_ACHIEVEMENT=8, CompletingAQuest=27)
--- @param handler function(achievementId, criteriaId) -> boolean
function RegisterCriteriaCompletionHandler(criteriaType, handler)
    if type(criteriaType) == "number" and type(handler) == "function" then
        criteriaCompletionHandlers[criteriaType] = handler
    end
end

--- Check if a criteria is completed. Dispatches to the registered handler for the criteria type.
--- @param achievementId number
--- @param criteriaId number
--- @param criteriaType number Required; used to select the handler
--- @return boolean|nil completed boolean for completion, nil if no handler registered
function IsAchievementCriteriaCompleted(achievementId, criteriaId, criteriaType)
    local handler = criteriaCompletionHandlers[criteriaType]
    if not handler then
        return nil
    end
    return handler(achievementId, criteriaId)
end