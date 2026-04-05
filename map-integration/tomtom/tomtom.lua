TomTomMap = setmetatable({}, { __index = MapIntegrationBase })
TomTomMap.__index = TomTomMap

TOMTOM_INTEGRATION_NAME = "tomtom"

--- Handles returned by TomTom:AddWaypoint (numeric uids are saved in SavedVariables for reload cleanup).
local function persistTomTomHandles(handles)
    if not MetaAchievementSettings then
        return
    end
    if not MetaAchievementSettings:Get("preserveWaypoints") then
        local db = MetaAchievementSettings:Get("mapIntegration") or {}
        db.tomTomWaypointHandles = nil
        MetaAchievementSettings:Set("mapIntegration", db)
        return
    end
    local db = MetaAchievementSettings:Get("mapIntegration") or {}
    db.tomTomWaypointHandles = handles
    MetaAchievementSettings:Set("mapIntegration", db)
end

--- Remove waypoints from a previous session (after /reload) using saved handles; pcall-safe.
local function removePersistedTomTomHandles()
    if not TomTom or type(TomTom.RemoveWaypoint) ~= "function" then
        return
    end
    if not MetaAchievementSettings then
        return
    end
    local db = MetaAchievementSettings:Get("mapIntegration") or {}
    local handles = db.tomTomWaypointHandles
    if type(handles) ~= "table" then
        return
    end
    for _, h in ipairs(handles) do
        pcall(TomTom.RemoveWaypoint, TomTom, h)
    end
end

function TomTomMap:new()
    local obj = setmetatable({}, self)

    -- stored waypoints that are TomTom waypoints. They are stored in the TomTom waypoints table.
    obj.storedWaypoints = {}

    return obj
end

function TomTomMap:OnLoaded()
end

function TomTomMap:OnTomTomLoaded()
end

--- Full resync: remove last session's uids (if any), clear in-memory handles, add from filtered list.
--- AddWaypoint uses persistent=false + cleardistance=0 so we do not stack TomTom profile pins with our login batch.
--- waypointsByAchievement: { [achievementId] = { waypoint1, waypoint2, ... }, ... }
function TomTomMap:UpdateWaypoints(waypointsByAchievement)
    if not TomTom or type(TomTom.RemoveWaypoint) ~= "function" or type(TomTom.AddWaypoint) ~= "function" then
        return
    end

    -- 1) After /reload, in-memory handles are gone but TomTom may still show persistent pins — remove using SavedVariables.
    removePersistedTomTomHandles()

    -- 2) Remove handles from this session.
    for _, wp in pairs(self.storedWaypoints) do
        pcall(TomTom.RemoveWaypoint, TomTom, wp)
    end
    self.storedWaypoints = {}

    if not waypointsByAchievement or type(waypointsByAchievement) ~= "table" then
        persistTomTomHandles(nil)
        return
    end

    for _, waypoints in pairs(waypointsByAchievement) do
        if waypoints and type(waypoints) == "table" and #waypoints > 0 then
            for _, wp in pairs(waypoints) do
                local handle = TomTom:AddWaypoint(TomTomWaypoint:createFromWaypoint(wp):toArgs())
                if handle ~= nil then
                    self.storedWaypoints[#self.storedWaypoints + 1] = handle
                end
            end
        end
    end

    -- Only persist numeric uids (SavedVariables cannot store userdata/lightuserdata handles).
    local serializable = {}
    for _, h in ipairs(self.storedWaypoints) do
        if type(h) == "number" then
            serializable[#serializable + 1] = h
        end
    end
    if MetaAchievementSettings and MetaAchievementSettings:Get("preserveWaypoints") then
        persistTomTomHandles(serializable)
    else
        persistTomTomHandles(nil)
    end
end

MapIntegrationBase.RequestIntegration(function(mi)
    if not TomTom then return end
    mi:RegisterMapIntegration(TOMTOM_INTEGRATION_NAME, "TomTom", TomTomMap:new())
end)
