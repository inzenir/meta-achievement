-- Parse AFarewellToArms.lua and output waypoint entries for AWorldAwoken.waypoints.lua
local file = io.open("achi-list/AFarewellToArms.lua", "r")
local content = file:read("*all")
file:close()

local achievements = {}
local current_achievement = nil
local in_criteria = false

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

local sorted = {}
for id, _ in pairs(achievements) do
    table.insert(sorted, id)
end
table.sort(sorted)

local output = ""
for _, id in ipairs(sorted) do
    output = output .. string.format("    -- A Farewell to Arms: achievement %d\n", id)
    output = output .. string.format("    [%d] = {\n", id)
    output = output .. "        helpText = \"\",\n"
    if achievements[id].criteria and #achievements[id].criteria > 0 then
        output = output .. "        criteria = {\n"
        for _, cid in ipairs(achievements[id].criteria) do
            output = output .. string.format("            [%d] = { helpText = \"\", waypoints = {} },\n", cid)
        end
        output = output .. "        }\n"
    end
    output = output .. "    },\n\n"
end

local outfile = io.open("achi-list/AFarewellToArms_waypoints_output.txt", "w")
outfile:write(output)
outfile:close()

print("Parsed " .. #sorted .. " achievements from A Farewell to Arms")
for _, id in ipairs(sorted) do
    print("  " .. id .. (#(achievements[id].criteria or {}) > 0 and (" (" .. #achievements[id].criteria .. " criteria)") or "")
end
