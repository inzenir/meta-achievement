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
    notifications = "Activity notifications",
    map = "Map and Waypoints",
    miniJournal = "Mini Journal",
}
-- Order of categories in the panel (optional; if missing, order follows first use in definitions)
MetaAchievementOptionsGroupOrder = { "general", "notifications", "miniJournal", "map" }

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
        variable = "_clearAllWaypoints",
        name = "Clear all waypoints",
        buttonText = "Clear",
        tooltip = "Remove all achievement waypoints from the map.",
        varType = "button",
        group = "map",
        action = "clearAllWaypoints",  -- dispatched in options-panel to the real handler
    },
    {
        variable = "achievementLinkSource",
        name = "Achievement link source",
        tooltip = "Choose where achievement links open: None, Wowhead, or WowDB.",
        varType = "select",
        group = "general",
        options = {
            { value = "none", label = "None" },
            { value = "wowhead", label = "Wowhead" },
            { value = "wowdb", label = "WowDB" },
        },
    },
    {
        variable = "showSettingsButton",
        name = "Show settings button",
        tooltip = "If checked, the settings (cog) button is shown next to the close button on the journal.",
        varType = "boolean",
        group = "general",
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
        variable = "enableWorldQuestNotifications",
        name = "World quest alerts",
        tooltip = "Tell you when a world quest you still need for an unfinished achievement is on your map.",
        varType = "boolean",
        group = "notifications",
    },
    {
        variable = "enableDelveStoryNotifications",
        name = "Delve story alerts",
        tooltip = "Tell you when a delve story you still need for an unfinished achievement is active today.",
        varType = "boolean",
        group = "notifications",
    },
    {
        variable = "activityNotifyDeliveryMode",
        name = "Activity notification delivery",
        tooltip = "Where to show activity alerts: chat only, on-screen cards only, or both. Cards stack from the chosen screen corner — top corners grow downward, bottom corners grow upward.",
        varType = "select",
        group = "notifications",
        options = {
            { value = "chat", label = "Chat only" },
            { value = "cards", label = "On-screen cards only" },
            { value = "both", label = "Chat and cards" },
        },
    },
    {
        variable = "activityNotifyCardCorner",
        name = "Card anchor corner",
        tooltip = "Corner used for on-screen notification cards. TOP corners: new cards stack downward. BOTTOM corners: new cards stack upward.",
        varType = "select",
        group = "notifications",
        options = {
            { value = "TOPLEFT", label = "Top left" },
            { value = "TOPRIGHT", label = "Top right" },
            { value = "BOTTOMLEFT", label = "Bottom left" },
            { value = "BOTTOMRIGHT", label = "Bottom right" },
        },
    },
    {
        variable = "activityNotifyCardMaxVisible",
        name = "Max visible cards",
        tooltip = "Oldest card is removed when a new one arrives and the stack is full.",
        varType = "select",
        group = "notifications",
        -- Values must be numbers: Settings.RegisterAddOnSetting uses type(default) == "number" for these keys.
        options = {
            { value = 3, label = "3" },
            { value = 5, label = "5" },
            { value = 8, label = "8" },
            { value = 10, label = "10" },
        },
    },
    {
        variable = "activityNotifyCardDurationSec",
        name = "Card auto-dismiss (seconds)",
        tooltip = "How long each card stays on screen. Choose \"Never\" to keep cards until they scroll off (max visible) or you reload the UI.",
        varType = "select",
        group = "notifications",
        -- Values must be numbers; -1 = never dismiss by timer.
        options = {
            { value = 5, label = "5" },
            { value = 8, label = "8" },
            { value = 12, label = "12" },
            { value = 15, label = "15" },
            { value = -1, label = "Never" },
        },
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
    {
        variable = "miniJournalLockPosition",
        name = "Lock position",
        tooltip = "If checked, the mini journal window cannot be moved.",
        varType = "boolean",
        group = "miniJournal",
    },
    {
        variable = "miniJournalEscapeDoesNotClose",
        name = "Escape does not close",
        tooltip = "Pressing escape button does not close mini window. It behaves like regular escape press.",
        varType = "boolean",
        group = "miniJournal",
    },
    {
        variable = "miniJournalHideCompletedCriteria",
        name = "Hide completed criteria",
        tooltip = "If checked, completed criteria are hidden in the mini journal list; only incomplete criteria are shown.",
        varType = "boolean",
        group = "miniJournal",
    },
}
