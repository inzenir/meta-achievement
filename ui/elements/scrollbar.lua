-- Standalone scrollbar element + tiny event bus.
-- The scrollbar attaches to a ScrollFrame and communicates via MetaAchievementUIBus events.

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

function MetaAchievementScrollBar_OnLoad(self)
    self._attached = false
    self._updating = false
    self._scrollFrame = nil
    self._step = 40

    self:SetMinMaxValues(0, 0)
    self:SetValue(0)
    self:Hide()
end

local function clamp(v, minV, maxV)
    if v < minV then
        return minV
    end
    if v > maxV then
        return maxV
    end
    return v
end

function MetaAchievementScrollBar_Attach(scrollBar, scrollFrame)
    if not scrollBar or not scrollFrame or scrollBar._attached then
        return
    end

    scrollBar._attached = true
    scrollBar._scrollFrame = scrollFrame
    scrollFrame:EnableMouseWheel(true)

    local function updateRange()
        local range = scrollFrame:GetVerticalScrollRange() or 0
        local current = scrollFrame:GetVerticalScroll() or 0

        scrollBar._updating = true
        scrollBar:SetMinMaxValues(0, range)
        scrollBar:SetValue(clamp(current, 0, range))
        scrollBar._updating = false

        scrollBar:SetShown(range > 0)
    end

    scrollFrame:HookScript("OnScrollRangeChanged", updateRange)

    scrollFrame:HookScript("OnVerticalScroll", function(_, offset)
        if scrollBar._updating then
            return
        end
        local range = scrollFrame:GetVerticalScrollRange() or 0
        scrollBar._updating = true
        scrollBar:SetValue(clamp(offset or 0, 0, range))
        scrollBar._updating = false

        MetaAchievementUIBus:Emit("MA_SCROLLFRAME_VERTICAL_SCROLL", scrollBar, scrollFrame, offset)
    end)

    scrollFrame:HookScript("OnMouseWheel", function(_, delta)
        local range = scrollFrame:GetVerticalScrollRange() or 0
        local current = scrollFrame:GetVerticalScroll() or 0
        local newValue = clamp(current - (delta * (scrollBar._step or 40)), 0, range)
        scrollFrame:SetVerticalScroll(newValue)
    end)

    updateRange()
end

function MetaAchievementScrollBar_OnValueChanged(self, value)
    if self._updating or not self._scrollFrame then
        return
    end

    local scrollFrame = self._scrollFrame
    local range = scrollFrame:GetVerticalScrollRange() or 0

    self._updating = true
    scrollFrame:SetVerticalScroll(clamp(value or 0, 0, range))
    self._updating = false

    MetaAchievementUIBus:Emit("MA_SCROLLBAR_VALUE_CHANGED", self, scrollFrame, value)
end

