--[[
    Option definitions for the addon Settings panel (Options -> AddOns).
    Edit variable, name, tooltip, and varType here. Keeps options-panel.lua generic
    and makes it easy to add i18n or new control types (e.g. dropdown when varType changes).
    Add a default for each new variable in DefaultSettings() in logic/settings.lua.
]]
-- varType: "boolean" = checkbox; future: "number", "string", "enum" (dropdown)
MetaAchievementOptionsDefinitions = {
    {
        variable = "hideCompleted",
        name = "Hide completed",
        tooltip = "If checked, completed achievements will be hidden, unless they have uncompleted sub-achievements.",
        varType = "boolean",
    },
--[[    {
        variable = "colouredHightlight",
        name = "Coloured highlight",
        tooltip = "If checked, hovering on an achievement will be green/red depending on whether it is completed.",
        varType = "boolean",
    }, ]]
    {
        variable = "removeCompletedWaypoints",
        name = "Remove waypoints for completed achievements",
        tooltip = "When adding waypoints to the map, remove waypoints for achievements that are already completed.",
        varType = "boolean",
    },
    {
        variable = "addWpsOnlyForUncompletedAchis",
        name = "Add waypoints only to unfinished parts of achievement",
        tooltip = "When adding waypoints, only add them for criteria that are not yet completed.",
        varType = "boolean",
    },
}
