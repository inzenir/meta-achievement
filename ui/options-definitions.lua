--[[
    Option definitions for the addon Settings panel (Options -> AddOns).
    Edit variable, name, tooltip, varType, and group here.
    Add a default for each new variable in DefaultSettings() in logic/settings.lua.

    Categories: define groups in MetaAchievementOptionsGroups (key -> display name) and
    MetaAchievementOptionsGroupOrder (list of keys for display order). Each option can
    set group = "key" to appear under that category; the text separator shows the
    category name at the start of each section.
]]
-- Category key -> display name (used as separator text at the start of each section)
MetaAchievementOptionsGroups = {
    general = "",
    map = "Map and Waypoints",
}
-- Order of categories in the panel (optional; if missing, order follows first use in definitions)
MetaAchievementOptionsGroupOrder = { "general", "map" }

-- varType: "boolean" = checkbox; "select" = dropdown (pass options table with value/label)
-- group: key from MetaAchievementOptionsGroups (default "general")
MetaAchievementOptionsDefinitions = {
    {
        variable = "waypointIntegration",
        name = "Waypoint integration",
        tooltip = "Which system to use for achievement waypoints. Native uses the game map; TomTom requires the TomTom addon.",
        varType = "select",
        group = "map",
        optionsSource = "waypointIntegration",  -- resolved when panel is built (after mapIntegration instance exists)
    },
    {
        variable = "hideCompleted",
        name = "Hide completed achievements",
        tooltip = "If checked, completed achievements will be hidden, unless they have uncompleted sub-achievements.",
        varType = "boolean",
        group = "general",
    },
    {
        variable = "showCompletedScreenWhenTopDone",
        name = "Show completed screen when top achievement is done",
        tooltip = "If checked, the completed screen is shown whenever the top achievement is completed, even if it has uncompleted sub-achievements.",
        varType = "boolean",
        group = "general",
    },
    {
        variable = "removeCompletedWaypoints",
        name = "Remove waypoints for completed achievements",
        tooltip = "When adding waypoints to the map, remove waypoints for achievements that are already completed.",
        varType = "boolean",
        group = "map",
    },
    {
        variable = "addWpsOnlyForUncompletedAchis",
        name = "Add waypoints only to unfinished parts of achievement",
        tooltip = "When adding waypoints, only add them for criteria that are not yet completed.",
        varType = "boolean",
        group = "map",
    },
    {
        variable = "preserveWaypoints",
        name = "Preserve waypoints",
        tooltip = "If checked, waypoints you add are saved and restored after logout/login. If unchecked, waypoints are session-only.",
        varType = "boolean",
        group = "map",
    },
}
