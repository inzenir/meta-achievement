--[[
    ActiveAchievementState: single source of truth for registered achievement sources
    and the currently active achievement (source + item). Syncs with MetaAchievementSettings
    so mini frame and other consumers can read selectedSourceKey / selectedAchievementId.
]]

ActiveAchievementState = ActiveAchievementState or {}
ActiveAchievementState.__index = ActiveAchievementState

local function safeCall(fn, ...)
    if type(fn) == "function" then
        return fn(...)
    end
end

--- Create or get the singleton instance.
function ActiveAchievementState:New()
    if self ~= ActiveAchievementState then
        return setmetatable({}, ActiveAchievementState)
    end
    local o = setmetatable({}, self)
    o._sources = {}
    o._sourceOrder = {}
    o._activeSourceKey = nil
    o._activeAchievementId = nil
    o._cachedList = nil
    o._cachedSourceKey = nil
    --- Per-source flat list snapshot for tab revisits (DEV-012). Cleared on InvalidateList.
    o._cachedListByKey = nil
    return o
end

--- Register an achievement source (list tab).
--- @param key string Unique key (e.g. "worldSoulSearching")
--- @param displayName string Display name for UI
--- @param provider table Must have GetList() and topAchievementId
function ActiveAchievementState:RegisterSource(key, displayName, provider)
    if type(key) ~= "string" or key == "" then
        return
    end
    if type(displayName) ~= "string" or displayName == "" then
        displayName = key
    end
    if type(provider) ~= "table" then
        provider = {}
    end
    self._sources = self._sources or {}
    self._sourceOrder = self._sourceOrder or {}
    if not self._sources[key] then
        self._sourceOrder[#self._sourceOrder + 1] = key
    end
    self._sources[key] = {
        key = key,
        name = displayName,
        provider = provider,
    }
end

--- Return registered sources in registration order.
function ActiveAchievementState:GetRegisteredSources()
    self._sources = self._sources or {}
    self._sourceOrder = self._sourceOrder or {}
    local list = {}
    for _, k in ipairs(self._sourceOrder) do
        local src = self._sources[k]
        if src then
            list[#list + 1] = src
        end
    end
    return list
end

--- Get source by key.
function ActiveAchievementState:GetSource(key)
    if not key then return nil end
    self._sources = self._sources or {}
    return self._sources[key]
end

--- Build and cache the list for the active source. Reuses per-source snapshot when revisiting a tab (same hideCompleted).
function ActiveAchievementState:RefreshList()
    local key = self._activeSourceKey
    if not key then
        self._cachedList = nil
        self._cachedSourceKey = nil
        return nil
    end
    if self._cachedSourceKey == key and self._cachedList ~= nil then
        return self._cachedList
    end
    local hideCompleted = MetaAchievementSettings and MetaAchievementSettings:Get("hideCompleted")
    local byKey = self._cachedListByKey
    if type(byKey) == "table" then
        local entry = byKey[key]
        if entry and entry.list and entry.hideCompleted == hideCompleted then
            self._cachedList = entry.list
            self._cachedSourceKey = key
            return self._cachedList
        end
    end
    local src = self:GetSource(key)
    if not src or not src.provider then
        self._cachedList = nil
        self._cachedSourceKey = nil
        return nil
    end
    local list = safeCall(src.provider.GetList, src.provider) or safeCall(src.provider.getList, src.provider) or {}
    if type(list) ~= "table" then
        list = {}
    end
    self._cachedList = list
    self._cachedSourceKey = key
    if not self._cachedListByKey then
        self._cachedListByKey = {}
    end
    self._cachedListByKey[key] = {
        list = list,
        hideCompleted = hideCompleted,
    }
    return list
end

--- Set the active source (tab). Loads list and sets active achievement to first item or nil. Syncs to settings.
function ActiveAchievementState:SetActiveSource(key)
    if not key or not self:GetSource(key) then
        return
    end
    self._activeSourceKey = key
    -- Clear active pointer only; per-source snapshots remain in _cachedListByKey for revisits.
    self._cachedList = nil
    self._cachedSourceKey = nil
    local list = self:RefreshList()
    if list and list[1] then
        self._activeAchievementId = AchievementListUtils.resolveIdFromNode(list[1])
    else
        self._activeAchievementId = nil
    end
    if MetaAchievementSettings then
        MetaAchievementSettings:Set("selectedSourceKey", key)
        MetaAchievementSettings:Set("selectedAchievementId", self._activeAchievementId)
    end
end

--- Set active achievement by index in the current list (1-based). Syncs to settings.
function ActiveAchievementState:SetActiveAchievementByIndex(index)
    local list = self:RefreshList()
    if not list or not index or index < 1 or index > #list then
        return
    end
    local item = list[index]
    local id = AchievementListUtils.resolveIdFromNode(item)
    self._activeAchievementId = id
    if MetaAchievementSettings and id then
        MetaAchievementSettings:Set("selectedAchievementId", id)
    end
end

--- Set active achievement by achievement id. Finds index in current list and sets. Syncs to settings.
function ActiveAchievementState:SetActiveAchievementById(id)
    local wantId = AchievementListUtils.normalizeAchievementId(id)
    if not wantId then return end
    local list = self:RefreshList()
    if not list then return end
    local idx = AchievementListUtils.findIndexForAchievementId(list, wantId)
    if idx then
        self:SetActiveAchievementByIndex(idx)
    end
end

--- Load state from settings (e.g. on addon load). Call after sources are registered.
function ActiveAchievementState:LoadFromSettings()
    if not MetaAchievementSettings then return end
    local key = MetaAchievementSettings:Get("selectedSourceKey")
    local id = MetaAchievementSettings:Get("selectedAchievementId")
    if key and self:GetSource(key) then
        self._activeSourceKey = key
        self._cachedList = nil
        self._cachedSourceKey = nil
        self:RefreshList()
        local list = self._cachedList
        if id then
            local wantId = AchievementListUtils.normalizeAchievementId(id)
            local idx = AchievementListUtils.findIndexForAchievementId(list or {}, wantId)
            if idx then
                self._activeAchievementId = wantId
                return
            end
        end
        self._activeAchievementId = AchievementListUtils.resolveIdFromNode(list and list[1])
    end
end

--- Get the active source key.
function ActiveAchievementState:GetActiveSourceKey()
    return self._activeSourceKey
end

--- Get the active source table { key, name, provider }.
function ActiveAchievementState:GetActiveSource()
    return self:GetSource(self._activeSourceKey)
end

--- Get the flat list for the active source (cached).
function ActiveAchievementState:GetList()
    return self:RefreshList() or {}
end

--- Get the active achievement id (numeric or from first item).
function ActiveAchievementState:GetActiveAchievementId()
    return self._activeAchievementId
end

--- Get the 1-based index of the active achievement in the current list.
function ActiveAchievementState:GetActiveIndex()
    local list = self:RefreshList()
    local id = self._activeAchievementId
    if not list or not id then return nil end
    return AchievementListUtils.findIndexForAchievementId(list, id)
end

--- Get the active item (node) from the current list.
function ActiveAchievementState:GetActiveItem()
    local idx = self:GetActiveIndex()
    local list = self:RefreshList()
    if not list or not idx or idx < 1 or idx > #list then
        return nil
    end
    return list[idx]
end

--- Invalidate cached list (e.g. after expand/collapse, achievement earned, hideCompleted change).
function ActiveAchievementState:InvalidateList()
    self._cachedList = nil
    self._cachedSourceKey = nil
    self._cachedListByKey = nil
end

-- Singleton instance
local _instance = nil
function ActiveAchievementState:GetInstance()
    if not _instance then
        _instance = ActiveAchievementState:New()
    end
    return _instance
end
