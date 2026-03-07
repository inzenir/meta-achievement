
MapIntegrationBase = {}
MapIntegrationBase.__index = MapIntegrationBase
MapIntegrationBase._registrationCallbacks = {}
MapIntegrationBase._map_integration_instance = nil
MapIntegrationBase._default_integration = "native"


function MapIntegrationBase:new()
    local obj = setmetatable({}, self)

    obj.integrations = {}
    obj.previousIntegration = nil
    obj.activeIntegration = MetaAchievementSettings and MetaAchievementSettings:Get("waypointIntegration") or nil

    obj:SetActiveIntegration(obj.activeIntegration)

    return obj
end


-- changing integrations
function MapIntegrationBase:SetActiveIntegration(name)
    if name == self.activeIntegration then return end
    
    self.previousIntegration = self.activeIntegration
    if self.integrations[self.previousIntegration] then
        self.integrations[self.previousIntegration].integration:UpdateWaypoints({})
    end

    self.activeIntegration = name
    self:NotifyWaypointsUpdate()
end

function MapIntegrationBase:GetActiveIntegration()
    local returnIntegration = self.integrations[MapIntegrationBase._default_integration].integration
    if self.integrations[self.activeIntegration] then
        return self.integrations[self.activeIntegration].integration
    end
    return returnIntegration
end

-- notifying waypoints update

function MapIntegrationBase:NotifyWaypointsUpdate(clearWaypoints)
    if not MapIntegrationBase._map_integration_instance then return end

    clearWaypoints = clearWaypoints or false

    local passWaypoints = {}
    if not clearWaypoints then
        passWaypoints = MapIntegrationBase._map_integration_instance:GetWaypoints()
    end

    local activeIntegration = self:GetActiveIntegration() or nil
    activeIntegration:UpdateWaypoints(passWaypoints)
end

-- basic waypoints operations

function MapIntegrationBase.ToggleWaypointsForAchievement(id, waypoints)
    if not MapIntegrationBase._map_integration_instance then return end
    MapIntegrationBase._map_integration_instance:ToggleWaypointsForAchievement(id, waypoints)
end

function MapIntegrationBase.AddWaypointsForAchievement(id, waypoints)
    if not MapIntegrationBase._map_integration_instance then return end
    MapIntegrationBase._map_integration_instance:AddWaypointsForAchievement(id, waypoints)
end

function MapIntegrationBase.RemoveWaypointsForAchievement(id, waypoints)
    if not MapIntegrationBase._map_integration_instance then return end
    MapIntegrationBase._map_integration_instance:RemoveWaypointsForAchievement(id, waypoints)
end

function MapIntegrationBase.RemoveAllWaypoints()
    if not MapIntegrationBase._map_integration_instance then return end
    MapIntegrationBase._map_integration_instance:RemoveAllWaypoints()
end

--- Request integration registration. Callback(mi) will be invoked on PLAYER_ENTERING_WORLD; callback then does proper registration (RegisterMapIntegration, SetActiveIntegration, etc.).
function MapIntegrationBase.RequestIntegration(callback)
    if type(callback) == "function" then
        MapIntegrationBase._registrationCallbacks[#MapIntegrationBase._registrationCallbacks + 1] = callback
    end
end


--- Run registration callbacks so integrations are registered (e.g. for options panel dropdown). Safe to call multiple times.
function MapIntegrationBase.RunRegistrationCallbacks(instance)
    if #MapIntegrationBase._registrationCallbacks == 0 then return end

    local mi = instance or MapIntegrationBase._instance
    if not mi then return end
    for i, cb in ipairs(MapIntegrationBase._registrationCallbacks) do
        pcall(cb, mi)
    end
    MapIntegrationBase._registrationCallbacks = {}

    
end

--- Initialize map integration singleton. Run registration callbacks so integrations (Native, TomTom) are available for the options panel; re-run on PLAYER_ENTERING_WORLD for late loaders.
function MapIntegrationBase.Init()
    local self = MapIntegrationBase:new()
    MapIntegrationBase._instance = self
    MapIntegrationBase._map_integration_instance = MapIntegration:new(self)

    local function runRegistrations()
        MapIntegrationBase.RunRegistrationCallbacks(MapIntegrationBase._instance)
    end

    if MetaAchievementSettings and MetaAchievementSettings.RegisterListener then
        MetaAchievementSettings:RegisterListener("waypointIntegration", function(_, newValue, oldValue)
            if newValue and newValue ~= "_no_integrations_" then
                MapIntegrationBase.GetInstance():SetActiveIntegration(newValue)
            end
        end)
    end

    -- Run once now so integrations register even if PLAYER_ENTERING_WORLD already fired before we loaded.
    runRegistrations()

    local frame = CreateFrame("Frame")
    frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    frame:SetScript("OnEvent", function()
        runRegistrations()
        MapIntegrationBase.GetInstance():OnLoaded()
    end)
end

function MapIntegrationBase:GetIntegrationIfActive(integration)
    if integration == self.activeIntegration then
        local entry = self.integrations[integration]
        return entry and entry.integration or nil
    end
    return nil
end

function MapIntegrationBase:OnLoaded()
    local name = self:GetWaypointIntegrationName()
    local entry = name and self.integrations and self.integrations[name]
    if entry and entry.integration then
        entry.integration:OnLoaded()
    end
    MapIntegrationBase.GetInstance():NotifyWaypointsUpdate()
end

function MapIntegrationBase:RegisterMapIntegration(name, label, integration)
    local wasAlreadyRegistered = self.integrations[name] ~= nil
    self.integrations[name] = {
        label = label,
        integration = integration,
    }
    -- Only notify when adding a NEW integration. getOptions() calls RunRegistrationCallbacks every time the dropdown refreshes, so Native/TomTom re-register every time; notifying each time caused an infinite refresh loop.
    if not wasAlreadyRegistered and Settings and Settings.NotifyUpdate then
        C_Timer.After(0, function()
            Settings.NotifyUpdate("waypointIntegration")
            Settings.NotifyUpdate("MetaAchievement_waypointIntegration")
        end)
    end
end


function MapIntegrationBase:GetIntegrationList()
    local list = {}
    local integrations = self.integrations
    if not integrations then return list end
    for name, integration in pairs(integrations) do
        list[#list+1] = {
            name = name,
            label = integration.label,
        }
    end
    return list
end


function MapIntegrationBase:HasActiveIntegration()
    return self.activeIntegration ~= nil
end

--- Integration to use for waypoint operations: follows waypointIntegration setting if set and registered, else activeIntegration.
function MapIntegrationBase:GetWaypointIntegrationName()
    local fromSettings = MetaAchievementSettings and MetaAchievementSettings:Get("waypointIntegration")
    if fromSettings and self.integrations and self.integrations[fromSettings] then
        return fromSettings
    end
    return self.activeIntegration
end

function MapIntegrationBase.GetInstance()
    return MapIntegrationBase._instance
end