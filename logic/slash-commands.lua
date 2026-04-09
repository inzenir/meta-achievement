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
    -- First token only so subcommands work: e.g. /wss help → key "help", msg unchanged.
    local key = type(msg) == "string" and msg:match("^%s*(%S+)") or msg
    if key and REGISTERED_COMMANDS[key] then
        -- Dot call (not colon): callback is a plain function; colon would pass the registry table as arg1.
        REGISTERED_COMMANDS[key].callback(msg, editbox)
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
