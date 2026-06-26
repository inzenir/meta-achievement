--[[
  Main-window plugin registry. Plugins replace the journal content area with custom UI
  and appear as tabs when at least one plugin is registered.

  Register before or after the main frame loads; tab bar refreshes when the frame exists.
]]

MetaAchievementPlugins = MetaAchievementPlugins or {}
MetaAchievementPlugins.API_VERSION = 2

local pluginsById = {}
local pluginOrder = {}

local function attachOptionsProvider(spec)
    local provider = spec.optionsProvider
    if not provider then
        return
    end
    if provider.pluginId ~= spec.id then
        provider.pluginId = spec.id
    end
    if type(provider.EnsureDefaults) == "function" then
        provider:EnsureDefaults()
    end
    if RegisterMetaAchievementPluginOptions then
        RegisterMetaAchievementPluginOptions(provider, spec.title or spec.id)
    end
end

local function sortPlugins()
    table.sort(pluginOrder, function(a, b)
        local pa, pb = pluginsById[a], pluginsById[b]
        local oa = (pa and pa.order) or 100
        local ob = (pb and pb.order) or 100
        if oa ~= ob then
            return oa < ob
        end
        return (pa and pa.title or a) < (pb and pb.title or b)
    end)
end

--- @param spec table { id: string, title: string, order?: number, optionsProvider?: table, onShow?: function, onHide?: function }
function MetaAchievementPlugins.Register(spec)
    if type(spec) ~= "table" or type(spec.id) ~= "string" or spec.id == "" then
        return false
    end
    if type(spec.title) ~= "string" or spec.title == "" then
        spec.title = spec.id
    end

    local id = spec.id
    if not pluginsById[id] then
        pluginOrder[#pluginOrder + 1] = id
    end
    pluginsById[id] = spec
    sortPlugins()
    attachOptionsProvider(spec)

    if MetaAchievementMainWindowPlugins and type(MetaAchievementMainWindowPlugins.OnPluginRegistryChanged) == "function" then
        MetaAchievementMainWindowPlugins.OnPluginRegistryChanged()
    end
    return true
end

function MetaAchievementPlugins.Unregister(pluginId)
    if type(pluginId) ~= "string" or not pluginsById[pluginId] then
        return false
    end
    pluginsById[pluginId] = nil
    for i = #pluginOrder, 1, -1 do
        if pluginOrder[i] == pluginId then
            table.remove(pluginOrder, i)
            break
        end
    end

    if MetaAchievementMainWindowPlugins and type(MetaAchievementMainWindowPlugins.OnPluginRegistryChanged) == "function" then
        MetaAchievementMainWindowPlugins.OnPluginRegistryChanged()
    end
    return true
end

function MetaAchievementPlugins.Get(pluginId)
    return pluginsById[pluginId]
end

function MetaAchievementPlugins.GetOrderedIds()
    local copy = {}
    for i = 1, #pluginOrder do
        copy[i] = pluginOrder[i]
    end
    return copy
end

function MetaAchievementPlugins.Count()
    return #pluginOrder
end

function MetaAchievementPlugins.HasPlugins()
    return #pluginOrder > 0
end

function MetaAchievementPlugins.GetOptionsProvider(pluginId)
    local spec = pluginsById[pluginId]
    return spec and spec.optionsProvider or nil
end
