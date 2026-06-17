-- Meta criteria type 8 = complete another achievement (CRITERIA_TYPE_ACHIEVEMENT).
ATripAroundTheStarsWaypoints = {
    [62873] = {
        helpText = "Midnight meta achievement: Val storyline.",
        criteria = {
            [115476] = { name = "Into the Stars", criteriaType = 8 },
            [115478] = { name = "Prepared for a Showdown", criteriaType = 8 },
            [115477] = { name = "Frosty Domanaar Politics", criteriaType = 8 },
            [115479] = { name = "Climate Strange: Val", criteriaType = 8 },
            [115480] = { name = "Showdown Slugger: Val", criteriaType = 8 },
            [115481] = { name = "Showdown Success: Val", criteriaType = 8 },
        },
    },
    [63383] = {
        helpText = "Into the Stars.",
    },
    [63384] = {
        helpText = "Prepared for a Showdown.",
    },
    [63386] = {
        helpText = "Frosty Domanaar Politics.",
    },
    [62903] = {
        helpText = "Climate Strange: Val.",
    },
    [62881] = {
        helpText = "Defeat 6 rare creatures in Val.",
        -- waypoints = {
        --     {
        --         kind = "point",
        --         coordinates = {
        --             { mapId = MapZones.MIDNIGHT_ZONE_Val, x = 62, y = 15, title = "Umbral Base Camp" },
        --             { mapId = MapZones.MIDNIGHT_ZONE_Val, x = 49, y = 90, title = "Imperator Pertinax" },
        --         },
        --     },
        -- },
        criteria = {
            [113995] = {
                name = "Sleet-Rune",
                criteriaType = 0,
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Val, x = 54, y = 67, title = "Sleet-Rune" } } } },
            },
            [113996] = {
                name = "Atomus",
                criteriaType = 0,
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Val, x = 37, y = 76, title = "Atomus" } } } },
            },
            [113997] = {
                name = "Glacial Broodmother",
                criteriaType = 0,
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Val, x = 39, y = 39, title = "Blackstar Legion" } } } },
            },
            [113998] = {
                name = "Mercilus",
                criteriaType = 0,
                waypoints = {
                    {
                        kind = "point",
                        coordinates = {
                            { mapId = MapZones.MIDNIGHT_ZONE_Val, x = 49, y = 78, title = "Mercilus" },
                            { mapId = MapZones.MIDNIGHT_ZONE_Val, x = 49, y = 97, title = "Portal to Void Acropolis Interior" },
                        },
                    },
                },
            },
            [113999] = {
                name = "Xirah",
                criteriaType = 0,
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Val, x = 28, y = 73, title = "Xirah" } } } },
            },
            [114001] = {
                name = "Opprimius",
                criteriaType = 0,
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Val, x = 33, y = 42, title = "Opprimius" } } } },
            },
            [114002] = {
                name = "Nelgothar",
                criteriaType = 0,
                helpText = "Forgotten Depths.",
                waypoints = {
                    {
                        kind = "point",
                        coordinates = {
                            { mapId = MapZones.MIDNIGHT_ZONE_Val, x = 33, y = 57, title = "Nelgothar (Forgotten Depths)" },
                            { mapId = MapZones.MIDNIGHT_ZONE_Val, x = 42, y = 71, title = "Portal to the Forgotten Depths" },
                            { mapId = MapZones.MIDNIGHT_ZONE_Val, x = 33, y = 75, title = "Transit Platform Portal" },
                        },
                    },
                },
            },
            [114003] = {
                name = "The Horror Below",
                criteriaType = 0,
                waypoints = {
                    {
                        kind = "point",
                        coordinates = {
                            { mapId = MapZones.MIDNIGHT_ZONE_Val, x = 23, y = 41, title = "The Horror Below" },
                            { mapId = MapZones.MIDNIGHT_ZONE_Val, x = 42, y = 71, title = "Portal to the Forgotten Depths" },
                        },
                    },
                },
            },
            [114000] = { name = "Krilkan", criteriaType = 0 },
            [114004] = { name = "Shadowguard Destroyer", criteriaType = 0 },
        },
    },
    [62880] = {
        helpText = "Complete 8 different World Quests in Val.",
        criteria = {
            [113981] = {
                name = "Lingering Corruption",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Val,
                    questId = 96400,
                },
            },
            [113982] = {
                name = "Freeze Range Eggs",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Val,
                    questId = 95404,
                },
            },
            [113983] = {
                name = "A Lingering Echo",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Val,
                    questId = 95403,
                },
            },
            [113984] = {
                name = "Ignoble Gas Collector",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Val,
                    questId = 95402,
                },
            },
            [113985] = {
                name = "Junction Dysfunction",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Val,
                    questId = 95401,
                },
            },
            [113986] = {
                name = "Solid Cold",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Val,
                    questId = 95400,
                },
            },
            [113987] = {
                name = "Shadowy Strategies",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Val,
                    questId = 95399,
                },
            },
            [113988] = {
                name = "Dissent and Divide",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Val,
                    questId = 95398,
                },
            },
            [113989] = {
                name = "Cold Reception",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Val,
                    questId = 95397,
                },
            },
            [113990] = {
                name = "Tainted Ritual",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Val,
                    questId = 95396,
                },
            },
            [113991] = {
                name = "Until it is Done",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Val,
                    questId = 95395,
                },
            },
            [113992] = {
                name = "Aberration Liberation",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Val,
                    questId = 95394,
                },
            },
            [113993] = {
                name = "Caver Saviour",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Val,
                    questId = 95393,
                },
            },
            [113994] = {
                name = "One Friend is Plenty",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Val,
                    questId = 95392,
                },
            },
        },
    },
}
