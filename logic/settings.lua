--[[
    User settings: get/set with defaults, and events when a setting changes.
    Use MetaAchievementSettings:Get(key), :Set(key, value), and :RegisterListener(key, callback).
    Nested keys (e.g. mainFrame, mapIntegration) are still read/written via Get("mainFrame") returning
    the table; listeners fire only when using :Set(key, value) for top-level keys.
]]

local function getDefaults()
    return {
        waypointIntegration = "native",
        achievementLinkSource = "none",
        showSettingsButton = true,
        hideCompleted = false,
        colouredHightlight = false,
        removeCompletedWaypoints = false,
        addWpsOnlyForUncompletedAchis = true,
        showCompletedScreenWhenTopDone = true,
        preserveWaypoints = true,
        miniJournalLockPosition = false,
        miniJournalEscapeDoesNotClose = false,
        miniJournalHideCompletedCriteria = false,
        mapIntegration = {},
        mainFrame = {
            closed = false,
            height = nil,
            width = nil,
            anchor = nil,
            x = nil,
            y = nil
        },
        -- LibDBIcon: minimap position (minimapPos) and visibility (hide)
        minimapIcon = {
            hide = false,
        },
        -- Hidden: which window was last open ("main" or "mini"). Restored on load.
        lastOpenWindow = "main",
        -- Hidden: selected achievement list key for mini (and main) so mini can show same list.
        selectedSourceKey = "worldSoulSearching",
        -- Hidden: selected achievement id in that list so mini shows same achievement.
        selectedAchievementId = nil,
        dataList = {},
        tmp1 = {}
    }
end

-- Legacy: keep DefaultSettings() for code that calls it by name (e.g. options panel, entrypoint).
function DefaultSettings()
    return getDefaults()
end

function UpdateSettings()
    if not MetaAchievementConfigurationDB then
        return
    end
    local defaults = getDefaults()
    for key, value in pairs(defaults) do
        if MetaAchievementConfigurationDB[key] == nil then
            MetaAchievementConfigurationDB[key] = value
        end
    end
end

-- Flush all simple (non-table) settings into the DB on logout so they persist even if the Blizzard Settings UI didn't call our setter.
local function flushSettingsToDB()
    if not MetaAchievementConfigurationDB or not MetaAchievementSettings then return end
    local defaults = getDefaults()
    for key, defaultVal in pairs(defaults) do
        if type(defaultVal) ~= "table" then
            MetaAchievementConfigurationDB[key] = MetaAchievementSettings:Get(key)
        end
    end
end

local flushFrame = CreateFrame("Frame")
flushFrame:RegisterEvent("PLAYER_LOGOUT")
flushFrame:SetScript("OnEvent", function(_, event)
    if event == "PLAYER_LOGOUT" then
        flushSettingsToDB()
    end
end)

-- Settings class: single source for reading/writing and change events
MetaAchievementSettings = {}
MetaAchievementSettings._listeners = {}  -- key -> { callback1, ... }; key "*" = any key

function MetaAchievementSettings:Get(key)
    if not MetaAchievementConfigurationDB then
        local d = getDefaults()
        return d[key]
    end
    if MetaAchievementConfigurationDB[key] ~= nil then
        return MetaAchievementConfigurationDB[key]
    end
    local d = getDefaults()
    return d[key]
end

function MetaAchievementSettings:Set(key, value)
    if not MetaAchievementConfigurationDB then return end
    local oldValue = MetaAchievementConfigurationDB[key]
    
    MetaAchievementConfigurationDB[key] = value
    self:EmitChange(key, value, oldValue)
end

--- Register a listener for when a setting changes. callback(key, newValue, oldValue).
--- key: setting key (e.g. "waypointIntegration"); use "*" to listen for any key.
function MetaAchievementSettings:RegisterListener(key, callback)
    if not key or type(callback) ~= "function" then return end
    self._listeners[key] = self._listeners[key] or {}
    self._listeners[key][#self._listeners[key] + 1] = callback
end

--- Remove a previously registered listener (same function reference).
function MetaAchievementSettings:UnregisterListener(key, callback)
    if not self._listeners[key] then return end
    for i = #self._listeners[key], 1, -1 do
        if self._listeners[key][i] == callback then
            table.remove(self._listeners[key], i)
            break
        end
    end
end

function MetaAchievementSettings:EmitChange(key, newValue, oldValue)
    for _, cb in ipairs(self._listeners[key] or {}) do
        pcall(cb, key, newValue, oldValue)
    end
    for _, cb in ipairs(self._listeners["*"] or {}) do
        pcall(cb, key, newValue, oldValue)
    end
end
