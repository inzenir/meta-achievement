--[[
  Seasonal world events (calendar holidays): detect active festivals via C_Calendar.
  Holidays.dbc event IDs used by meta achievement gating in WhatALongStrangeTripItsBeen.
]]

MetaAchievementWorldEventCalendar = MetaAchievementWorldEventCalendar or {}

local calendarReady = false
local calendarLoadAttempted = false
local calendarOpenRequested = false
local monthSyncedOnce = false

local cachedHolidayRows = nil
local calendarUpdateCoalesce = 0

function MetaAchievementWorldEventCalendar.IsCalendarReady()
    return calendarReady == true
end

local function invalidateHolidayCache()
    cachedHolidayRows = nil
end

local function notifyCalendarReady()
    if calendarReady then
        return
    end
    calendarReady = true
    if DataList and type(DataList.MarkAllTreesDirty) == "function" then
        DataList.MarkAllTreesDirty()
    end
    if MetaAchievementWorldEventScan_TryRefresh then
        MetaAchievementWorldEventScan_TryRefresh()
    end
end

MetaAchievementWorldEventCalendar.KNOWN_HOLIDAYS = {
    [327] = "Lunar Festival",
    [423] = "Love is in the Air",
    [181] = "Noblegarden",
    [201] = "Children's Week",
    [341] = "Midsummer Fire Festival",
    [372] = "Brewfest",
    [324] = "Hallow's End",
    [141] = "Feast of Winter Veil",
}

local function normalizeEventId(raw)
    if type(raw) == "number" then
        return raw
    end
    if type(raw) == "string" then
        return tonumber(raw)
    end
    return nil
end

local function ensureCalendarLoaded()
    if calendarLoadAttempted then
        return
    end
    calendarLoadAttempted = true
    if type(C_AddOns) == "table" and type(C_AddOns.IsAddOnLoaded) == "function" then
        if not C_AddOns.IsAddOnLoaded("Blizzard_Calendar") and type(C_AddOns.LoadAddOn) == "function" then
            pcall(C_AddOns.LoadAddOn, "Blizzard_Calendar")
        end
    elseif type(LoadAddOn) == "function" then
        pcall(LoadAddOn, "Blizzard_Calendar")
    end
end

local function syncCalendarMonthOnce()
    if monthSyncedOnce then
        return
    end
    monthSyncedOnce = true
    if C_DateAndTime and C_Calendar and type(C_Calendar.SetAbsMonth) == "function" then
        local calendar = C_DateAndTime.GetCurrentCalendarTime()
        if type(calendar) == "table" then
            pcall(C_Calendar.SetAbsMonth, calendar.month, calendar.year)
        end
    end
end

local function requestCalendarRefresh()
    ensureCalendarLoaded()
    syncCalendarMonthOnce()
    if calendarOpenRequested then
        return
    end
    calendarOpenRequested = true
    if C_Calendar and type(C_Calendar.OpenCalendar) == "function" then
        pcall(C_Calendar.OpenCalendar)
    end
end

local function getTodayCalendarContext()
    if not C_DateAndTime or type(C_DateAndTime.GetCurrentCalendarTime) ~= "function" then
        return nil
    end
    if not C_Calendar or type(C_Calendar.GetMonthInfo) ~= "function" then
        return nil
    end
    local now = C_DateAndTime.GetCurrentCalendarTime()
    if type(now) ~= "table" then
        return nil
    end
    if monthSyncedOnce then
        return now, 0
    end
    local monthInfo = C_Calendar.GetMonthInfo()
    if type(monthInfo) ~= "table" then
        return now, 0
    end
    local monthOffset = -12 * (monthInfo.year - now.year) + now.month - monthInfo.month
    return now, monthOffset
end

local function isSequenceActive(event, now)
    if type(event) ~= "table" or type(now) ~= "table" then
        return false
    end
    local seq = event.sequenceType
    if seq == nil or seq == "" then
        return true
    end
    if seq == "ONGOING" then
        return true
    end
    if seq == "START" and type(event.startTime) == "table" then
        local sh, sm = event.startTime.hour or 0, event.startTime.minute or 0
        local h, m = now.hour or 0, now.minute or 0
        return h > sh or (h == sh and m >= sm)
    end
    if seq == "END" and type(event.endTime) == "table" then
        local eh, em = event.endTime.hour or 23, event.endTime.minute or 59
        local h, m = now.hour or 0, now.minute or 0
        return h < eh or (h == eh and m <= em)
    end
    return false
end

local function readTodayHolidayEventsUncached()
    ensureCalendarLoaded()

    local now, monthOffset = getTodayCalendarContext()
    if not now then
        return {}
    end
    if type(C_Calendar.GetNumDayEvents) ~= "function" or type(C_Calendar.GetDayEvent) ~= "function" then
        return {}
    end

    local numEvents = C_Calendar.GetNumDayEvents(monthOffset, now.monthDay) or 0
    local rows = {}

    for i = 1, numEvents do
        local event = C_Calendar.GetDayEvent(monthOffset, now.monthDay, i)
        if type(event) == "table" and event.calendarType == "HOLIDAY" then
            rows[#rows + 1] = {
                eventId = normalizeEventId(event.eventID or event.eventId),
                title = event.title,
                sequenceType = event.sequenceType or "",
                isActive = isSequenceActive(event, now),
            }
        end
    end

    return rows
end

local function readTodayHolidayEvents()
    if cachedHolidayRows then
        return cachedHolidayRows
    end
    cachedHolidayRows = readTodayHolidayEventsUncached()
    return cachedHolidayRows
end

local function collectActiveHolidaysForToday()
    local rows = readTodayHolidayEvents()
    local active = {}
    local seenById = {}
    local seenByTitle = {}

    for i = 1, #rows do
        local row = rows[i]
        if row.isActive then
            local eventId = row.eventId
            local title = row.title
                or (eventId and MetaAchievementWorldEventCalendar.KNOWN_HOLIDAYS[eventId])
                or (eventId and ("Holiday #" .. tostring(eventId)))
                or "Unknown holiday"

            if type(eventId) == "number" and not seenById[eventId] then
                seenById[eventId] = true
                active[#active + 1] = {
                    eventId = eventId,
                    title = MetaAchievementWorldEventCalendar.KNOWN_HOLIDAYS[eventId] or title,
                }
            elseif not eventId and title ~= "" and not seenByTitle[title] then
                seenByTitle[title] = true
                active[#active + 1] = {
                    eventId = nil,
                    title = title,
                }
            end
        end
    end

    table.sort(active, function(a, b)
        return (a.title or "") < (b.title or "")
    end)
    return active
end

function MetaAchievementWorldEventCalendar.GetActiveHolidays()
    return collectActiveHolidaysForToday()
end

function MetaAchievementWorldEventCalendar.IsHolidayActive(eventId)
    if type(eventId) ~= "number" then
        return false
    end
    for _, row in ipairs(collectActiveHolidaysForToday()) do
        if row.eventId == eventId then
            return true
        end
    end
    return false
end

--- Journal gating and other checks that should not hide seasonal metas before C_Calendar loads.
--- Notifications pass failOpenIfCalendarNotReady = false so alerts only fire once the calendar is ready.
function MetaAchievementWorldEventCalendar.IsWorldEventActive(eventId, failOpenIfCalendarNotReady)
    if type(eventId) ~= "number" then
        return false
    end
    if failOpenIfCalendarNotReady ~= false and not calendarReady then
        return true
    end
    return MetaAchievementWorldEventCalendar.IsHolidayActive(eventId)
end

function MetaAchievementWorldEventCalendar.GetTodayHolidayRows(refresh)
    if refresh then
        invalidateHolidayCache()
        requestCalendarRefresh()
    end
    return readTodayHolidayEvents()
end

local initFrame

local function handleCalendarUpdateEventList()
    calendarUpdateCoalesce = calendarUpdateCoalesce + 1
    local token = calendarUpdateCoalesce
    C_Timer.After(0.05, function()
        if token ~= calendarUpdateCoalesce then
            return
        end
        invalidateHolidayCache()
        notifyCalendarReady()
    end)
end

function MetaAchievementWorldEventCalendar.Init()
    if initFrame then
        return
    end

    initFrame = CreateFrame("Frame")
    initFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    initFrame:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST")
    initFrame:SetScript("OnEvent", function(_, event)
        if event == "PLAYER_ENTERING_WORLD" then
            invalidateHolidayCache()
            requestCalendarRefresh()
        elseif event == "CALENDAR_UPDATE_EVENT_LIST" then
            handleCalendarUpdateEventList()
        end
    end)
end
