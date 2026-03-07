function dumpRecursive(map, depth)
    depth = depth or 0
    local prefix = string.rep(" ", depth * 2)
    for i, v in pairs(map) do
        if type(v) == "table" then
            print(prefix .. i .. " is table:")
            dumpRecursive(v, depth+1)
        elseif type(v) == "boolean" then
            print(prefix .. i .. " - " .. (v and "true" or "false"))
        elseif type(v) =="function" then
            print(prefix .. i .. " - function")
        else
            print(prefix .. i .. " - " .. v)
        end
    end
end

function countItemsInTable(table)
    local count = 0
    for _, _ in pairs(table) do
        count = count + 1
    end
    return count
end