--[[
  Plugin-owned settings stored under MetaAchievementConfigurationDB.plugins[pluginId].
  Plugins register an options provider so the core can render Blizzard settings UI and
  read/write values while plugins keep their own defaults and definitions.
]]

MetaAchievementPluginOptionsProvider = MetaAchievementPluginOptionsProvider or {}
MetaAchievementPluginOptionsProvider.__index = MetaAchievementPluginOptionsProvider

MetaAchievementPlugins = MetaAchievementPlugins or {}

local function shallowCopy(source)
    local copy = {}
    if type(source) ~= "table" then
        return copy
    end
    for key, value in pairs(source) do
        copy[key] = value
    end
    return copy
end

local function getPluginDbRoot()
    MetaAchievementConfigurationDB = MetaAchievementConfigurationDB or {}
    MetaAchievementConfigurationDB.plugins = MetaAchievementConfigurationDB.plugins or {}
    return MetaAchievementConfigurationDB.plugins
end

function MetaAchievementPluginOptionsProvider:EnsureDefaults()
    local db = self:GetDbTable()
    for key, value in pairs(self._defaults or {}) do
        if db[key] == nil then
            db[key] = value
        end
    end
end

function MetaAchievementPluginOptionsProvider:GetDbTable()
    local root = getPluginDbRoot()
    local pluginId = self.pluginId
    if type(pluginId) ~= "string" or pluginId == "" then
        return {}
    end
    if not root[pluginId] then
        root[pluginId] = {}
    end
    return root[pluginId]
end

function MetaAchievementPluginOptionsProvider:GetDefaults()
    return shallowCopy(self._defaults)
end

function MetaAchievementPluginOptionsProvider:GetDefinitions()
    return self._definitions or {}
end

function MetaAchievementPluginOptionsProvider:Get(key)
    if key == nil then
        return nil
    end
    local db = self:GetDbTable()
    if db[key] ~= nil then
        return db[key]
    end
    if self._defaults then
        return self._defaults[key]
    end
    return nil
end

function MetaAchievementPluginOptionsProvider:GetAll()
    local merged = self:GetDefaults()
    local db = self:GetDbTable()
    for key, value in pairs(db) do
        merged[key] = value
    end
    return merged
end

function MetaAchievementPluginOptionsProvider:Set(key, value)
    if key == nil then
        return
    end
    local db = self:GetDbTable()
    local oldValue = db[key]
    if oldValue == nil and self._defaults then
        oldValue = self._defaults[key]
    end
    db[key] = value
    self:EmitChange(key, value, oldValue)
end

function MetaAchievementPluginOptionsProvider:RegisterListener(key, callback)
    if type(callback) ~= "function" then
        return
    end
    self._listeners = self._listeners or {}
    local bucket = key or "*"
    self._listeners[bucket] = self._listeners[bucket] or {}
    self._listeners[bucket][#self._listeners[bucket] + 1] = callback
end

function MetaAchievementPluginOptionsProvider:UnregisterListener(key, callback)
    local bucket = self._listeners and self._listeners[key or "*"]
    if not bucket then
        return
    end
    for i = #bucket, 1, -1 do
        if bucket[i] == callback then
            table.remove(bucket, i)
            break
        end
    end
end

function MetaAchievementPluginOptionsProvider:EmitChange(key, newValue, oldValue)
    local listeners = self._listeners or {}
    for _, callback in ipairs(listeners[key] or {}) do
        pcall(callback, key, newValue, oldValue)
    end
    for _, callback in ipairs(listeners["*"] or {}) do
        pcall(callback, key, newValue, oldValue)
    end
end

--- @param spec table { pluginId: string, defaults?: table, definitions?: table[] }
function MetaAchievementPlugins.CreateOptionsProvider(spec)
    if type(spec) ~= "table" or type(spec.pluginId) ~= "string" or spec.pluginId == "" then
        return nil
    end
    local provider = setmetatable({
        pluginId = spec.pluginId,
        _defaults = shallowCopy(spec.defaults),
        _definitions = spec.definitions or {},
        _listeners = {},
    }, MetaAchievementPluginOptionsProvider)
    provider:EnsureDefaults()
    return provider
end
