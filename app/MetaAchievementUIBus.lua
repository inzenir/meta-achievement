-- Single global UI event bus: widgets Emit user intent; app layer Registers handlers.
-- Multiple handlers per event are supported (append order; each invoked with pcall).

MetaAchievementUIBus = MetaAchievementUIBus or {}

function MetaAchievementUIBus:Register(eventName, handler)
    self._listeners = self._listeners or {}
    self._listeners[eventName] = self._listeners[eventName] or {}
    self._listeners[eventName][#self._listeners[eventName] + 1] = handler
    return handler
end

function MetaAchievementUIBus:Emit(eventName, ...)
    local list = self._listeners and self._listeners[eventName]
    if not list then
        return
    end
    for _, handler in ipairs(list) do
        pcall(handler, ...)
    end
end
