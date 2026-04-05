--[[
  Deterministic string key for waypoint-like tables (map integration dedup / remove).
  Replaces pairs()-order iteration so the same logical table always yields the same key.
]]

WaypointIdentity = WaypointIdentity or {}

local MAX_DEPTH = 64

local function sortedKeys(t)
    local keys = {}
    for k in pairs(t) do
        keys[#keys + 1] = k
    end
    table.sort(keys, function(a, b)
        return tostring(a) < tostring(b)
    end)
    return keys
end

local function serialize(obj, depth)
    depth = depth or 0
    if depth > MAX_DEPTH then
        return "..."
    end
    if type(obj) ~= "table" then
        return tostring(obj)
    end
    local keys = sortedKeys(obj)
    local parts = {}
    for i = 1, #keys do
        local k = keys[i]
        local v = obj[k]
        parts[i] = tostring(k) .. "=" .. serialize(v, depth + 1)
    end
    return "{" .. table.concat(parts, ",") .. "}"
end

--- Stable identity string for a waypoint table (nested tables use sorted keys).
function WaypointIdentity.getKey(obj)
    return serialize(obj, 0)
end
