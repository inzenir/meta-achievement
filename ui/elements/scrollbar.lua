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

local function clamp(v, minV, maxV)
    if v < minV then return minV end
    if v > maxV then return maxV end
    return v
end

-- Modern trim-style look: reuse MinimalScrollBarTemplate's track/buttons and restyle them.
-- MinimalScrollBarTemplate provides: ThumbTexture, Track (or trackBG), ScrollUpButton, ScrollDownButton.
local function applyModernScrollBarStyle(bar)
    bar:SetOrientation("VERTICAL")

    local step = bar._step or 40

    -- Track: style template's track (Track or trackBG) with dark recessed look
    local track = bar.Track or bar.trackBG
    if track and track.CreateTexture then
        local tex = track:CreateTexture(nil, "BACKGROUND")
        if tex then
            if tex.SetColorTexture then
                tex:SetColorTexture(0.12, 0.12, 0.15, 0.98)
            end
            tex:SetAllPoints(track)
        end
    end

    -- Thumb: lighter grey
    local thumb = bar:GetThumbTexture()
    if thumb then
        if thumb.SetColorTexture then
            thumb:SetColorTexture(0.35, 0.35, 0.42, 1)
        end
        local _, _, _, h = thumb:GetRect()
        if h and h < 20 and thumb.SetHeight then
            thumb:SetHeight(20)
        end
    else
        thumb = bar:CreateTexture(nil, "ARTWORK")
        if thumb.SetColorTexture then
            thumb:SetColorTexture(0.35, 0.35, 0.42, 1)
        end
        thumb:SetSize(12, 24)
        bar:SetThumbTexture(thumb)
    end

    -- Up/down: reuse template's ScrollUpButton / ScrollDownButton, restyle and wire to our scroll
    local up = bar.ScrollUpButton
    local down = bar.ScrollDownButton
    if up and down then
        local upBg = up:CreateTexture(nil, "BACKGROUND")
        if upBg and upBg.SetColorTexture then
            upBg:SetColorTexture(0.22, 0.22, 0.26, 1)
            upBg:SetAllPoints(up)
        end
        local downBg = down:CreateTexture(nil, "BACKGROUND")
        if downBg and downBg.SetColorTexture then
            downBg:SetColorTexture(0.22, 0.22, 0.26, 1)
            downBg:SetAllPoints(down)
        end
        up:SetScript("OnClick", function()
            local sf = bar._scrollFrame
            if sf then
                local r = sf:GetVerticalScrollRange() or 0
                local c = sf:GetVerticalScroll() or 0
                sf:SetVerticalScroll(clamp(c - step, 0, r))
            end
        end)
        down:SetScript("OnClick", function()
            local sf = bar._scrollFrame
            if sf then
                local r = sf:GetVerticalScrollRange() or 0
                local c = sf:GetVerticalScroll() or 0
                sf:SetVerticalScroll(clamp(c + step, 0, r))
            end
        end)
    else
        -- Fallback: create our own up/down when template doesn't provide them
        local w, ah = 16, 20
        up = CreateFrame("Button", bar:GetName() and (bar:GetName() .. "Up") or nil, bar)
        up:SetSize(w, ah)
        up:SetPoint("TOPLEFT", 0, 0)
        up:SetPoint("TOPRIGHT", 0, 0)
        local upBg = up:CreateTexture(nil, "BACKGROUND")
        if upBg.SetColorTexture then upBg:SetColorTexture(0.22, 0.22, 0.26, 1) end
        upBg:SetAllPoints(up)
        up:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall"):SetText("▲"):SetPoint("CENTER")
        up:SetScript("OnClick", function()
            local sf = bar._scrollFrame
            if sf then
                local r = sf:GetVerticalScrollRange() or 0
                local c = sf:GetVerticalScroll() or 0
                sf:SetVerticalScroll(clamp(c - step, 0, r))
            end
        end)
        down = CreateFrame("Button", bar:GetName() and (bar:GetName() .. "Down") or nil, bar)
        down:SetSize(w, ah)
        down:SetPoint("BOTTOMLEFT", 0, 0)
        down:SetPoint("BOTTOMRIGHT", 0, 0)
        local downBg = down:CreateTexture(nil, "BACKGROUND")
        if downBg.SetColorTexture then downBg:SetColorTexture(0.22, 0.22, 0.26, 1) end
        downBg:SetAllPoints(down)
        down:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall"):SetText("▼"):SetPoint("CENTER")
        down:SetScript("OnClick", function()
            local sf = bar._scrollFrame
            if sf then
                local r = sf:GetVerticalScrollRange() or 0
                local c = sf:GetVerticalScroll() or 0
                sf:SetVerticalScroll(clamp(c + step, 0, r))
            end
        end)
    end
    bar._upBtn, bar._downBtn = up, down
end

function MetaAchievementScrollBar_OnLoad(self)
    self._attached = false
    self._updating = false
    self._scrollFrame = nil
    self._step = 40

    self:SetMinMaxValues(0, 0)
    self:SetValue(0)
    applyModernScrollBarStyle(self)
    self:Hide()
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

