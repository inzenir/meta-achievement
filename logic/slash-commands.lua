local REGISTERED_COMMANDS = {}

function helpCommand(unknownCommand)
    if type(unknownCommand) == "boolean" and unknownCommand == true then
        print("Unknown command. Please use the following:")
    else
        print("Addon usage:")
    end

    for name, command in pairs(REGISTERED_COMMANDS) do
        -- Use the actual slash command prefix ("/wss"), not an escaped string.
        print("  /wss " .. name .. " - " .. command.description)
    end
end

function LoadSlashCommands(msg, editbox)
    local key = type(msg) == "string" and msg:match("^%s*(.-)%s*$") or msg
    if key and REGISTERED_COMMANDS[key] then
        REGISTERED_COMMANDS[key]:callback(msg, editbox)
    else
        helpCommand(true)
    end
end

function RegisterSlashCommand(eventName, callback, description)
    if not REGISTERED_COMMANDS[eventName] then
        REGISTERED_COMMANDS[eventName] = {
            callback = callback,
            description = description
        }
    end
end

RegisterSlashCommand("help", helpCommand, "Prints this helpful message")

local function getAddonMetadata(field)
    local addon = "Worldsoul_Searching"
    if C_AddOns and C_AddOns.GetAddOnMetadata then
        return C_AddOns.GetAddOnMetadata(addon, field)
    end
    if GetAddOnMetadata then
        return GetAddOnMetadata(addon, field)
    end
    return nil
end

RegisterSlashCommand("status", function()
    local title = getAddonMetadata("Title") or "Worldsoul Searching"
    local version = getAddonMetadata("Version")
    print(string.format("%s: loaded.", title))
    if version and version ~= "" then
        print("  Version: " .. version)
    end
    print("  MetaAchievementWindowCoordinator: " .. (MetaAchievementWindowCoordinator and "yes" or "no"))
    print("  MetaAchievementUIBus: " .. (MetaAchievementUIBus and "yes" or "no"))
end, "Print addon load status (version, coordinator, bus)")
