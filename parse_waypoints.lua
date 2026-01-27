-- Temporary parser script to extract achievement and criteria structure
local file = io.open("achi-list/AWorldAwoken.lua", "r")
local content = file:read("*all")
file:close()

local achievements = {}
local current_achievement = nil
local in_criteria = false
local indent_level = 0

for line in content:gmatch("[^\r\n]+") do
    local achievement_id = line:match('%["id"%]%s*=%s*(%d+)')
    local criteria_marker = line:match('"criteria"')
    local children_marker = line:match('"children"')
    
    if criteria_marker then
        in_criteria = true
    elseif children_marker then
        in_criteria = false
    end
    
    if achievement_id then
        local id = tonumber(achievement_id)
        if id and id > 0 then
            if in_criteria and current_achievement then
                if not achievements[current_achievement].criteria then
                    achievements[current_achievement].criteria = {}
                end
                table.insert(achievements[current_achievement].criteria, id)
            else
                current_achievement = id
                if not achievements[id] then
                    achievements[id] = {}
                end
            end
        end
    end
end

-- Output structure
local output = "-- Waypoints and help text for A World Awoken achievements\n"
output = output .. "-- Structure: Keyed by achievement ID, with optional criteria-level data\n"
output = output .. "-- Note: Waypoints are structured with 'kind' (point/area) and 'coordinates' array\n\n"
output = output .. "AWorldAwokenWaypoints = {\n"

local sorted_achievements = {}
for id, _ in pairs(achievements) do
    table.insert(sorted_achievements, id)
end
table.sort(sorted_achievements)

for _, id in ipairs(sorted_achievements) do
    output = output .. string.format("    [%d] = {\n", id)
    output = output .. "        helpText = \"\",\n"
    
    if achievements[id].criteria and #achievements[id].criteria > 0 then
        output = output .. "        criteria = {\n"
        for _, criteria_id in ipairs(achievements[id].criteria) do
            output = output .. string.format("            [%d] = {\n", criteria_id)
            output = output .. "                helpText = \"\",\n"
            output = output .. "                waypoints = {}\n"
            output = output .. "            },\n"
        end
        output = output .. "        }\n"
    else
        output = output .. "        waypoints = {}\n"
    end
    
    output = output .. "    },\n\n"
end

output = output .. "}\n"

local outfile = io.open("achi-list/AWorldAwoken.waypoints.lua", "w")
outfile:write(output)
outfile:close()

print("Generated waypoint file with " .. #sorted_achievements .. " achievements")
