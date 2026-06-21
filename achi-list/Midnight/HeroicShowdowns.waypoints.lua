-- Meta criteria type 8 = complete another achievement (CRITERIA_TYPE_ACHIEVEMENT).
HeroicShowdownsWaypoints = {
    [63264] = {
        helpText = "Midnight meta achievement: heroic showdown requirements.",
        criteria = {
            [115267] = { name = "Heroic: Worlds Ahead", criteriaType = 8 },
            [115268] = { name = "Heroic: Power Creep", criteriaType = 8 },
            [115269] = { name = "Heroic: Pain of Command", criteriaType = 8 },
            [115270] = { name = "Heroic Climate Strange: Val", criteriaType = 8 },
            [115271] = { name = "Heroic Climate Strange: Naigtal", criteriaType = 8 },
            [115272] = { name = "Heroic Slugger", criteriaType = 8 },
        },
    },
    [62887] = {
        combineVirtualAndRegularCriteria = true,
        helpText = "Complete heroic world quests in Naigtal and Val.",
        virtualCriteria = {
            [0] = {
                text = "Heroic world quests completed",
                criteriaType = VirtualCriteriaTypes.ProgressBar,
                reqQuantity = 15,
            },
        },
        criteria = {
            [115101] = {
                name = "Mush-Vroom!",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Naigtal,
                    questId = 96293,
                },
            },
            [115102] = {
                name = "Mashing Mushroom Mana Machines",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Naigtal,
                    questId = 96272,
                },
            },
            [115103] = {
                name = "Scrubbing Troubles",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Naigtal,
                    questId = 96210,
                },
            },
            [115104] = {
                name = "Power Overload",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Naigtal,
                    questId = 96432,
                },
            },
            [115105] = {
                name = "Sporadic Power Drain",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Naigtal,
                    questId = 96217,
                },
            },
            [115106] = {
                name = "Marsh Mana Spores",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Naigtal,
                    questId = 96268,
                },
            },
            [115107] = {
                name = "Skiff Joyride",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Naigtal,
                    questId = 96000,
                },
            },
            [115108] = {
                name = "Forest Mana Spores",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Naigtal,
                    questId = 96575,
                },
            },
            [115109] = {
                name = "Crypt Culling",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Naigtal,
                    questId = 96600,
                },
            },
            [115110] = {
                name = "Weaken Their Forces",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Naigtal,
                    questId = 96547,
                },
            },
            [115111] = {
                name = "Lingering Corruption",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Val,
                    questId = 96400,
                },
            },
            [115112] = {
                name = "Freeze Range Eggs",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Val,
                    questId = 95404,
                },
            },
            [115113] = {
                name = "A Lingering Echo",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Val,
                    questId = 95403,
                },
            },
            [115114] = {
                name = "Ignoble Gas Collector",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Val,
                    questId = 95402,
                },
            },
            [115115] = {
                name = "Junction Dysfunction",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Val,
                    questId = 95401,
                },
            },
            [115116] = {
                name = "Solid Cold",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Val,
                    questId = 95400,
                },
            },
            [115117] = {
                name = "Shadowy Strategies",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Val,
                    questId = 95399,
                },
            },
            [115118] = {
                name = "Dissent and Divide",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Val,
                    questId = 95398,
                },
            },
            [115119] = {
                name = "Cold Reception",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Val,
                    questId = 95397,
                },
            },
            [115120] = {
                name = "Tainted Ritual",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Val,
                    questId = 95396,
                },
            },
            [115121] = {
                name = "Until it is Done",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Val,
                    questId = 95395,
                },
            },
            [115122] = {
                name = "Aberration Liberation",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Val,
                    questId = 95394,
                },
            },
            [115123] = {
                name = "Caver Saviour",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Val,
                    questId = 95393,
                },
            },
            [115124] = {
                name = "One Friend is Plenty",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Val,
                    questId = 95392,
                },
            },
            [116528] = {
                name = "Flying Debris",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Naigtal,
                    questId = 96557,
                },
            },
        },
    },
    [62901] = {
        helpText = "Heroic: Power Creep.",
    },
    [62909] = {
        helpText = "Heroic: Pain of Command.",
    },
    [62917] = {
        helpText = "Heroic Climate Strange: Val.",
    },
    [62919] = {
        combineVirtualAndRegularCriteria = true,
        helpText = "Heroic Climate Strange: Naigtal.",
        virtualCriteria = {
            [1] = {
                text = "Subdue the Spore Storm",
                hidden = true,
                criteriaType = VirtualCriteriaTypes.WorldQuest,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Naigtal,
                    questId = 96668,
                },
            },
        },
    },
    [63348] = {
        helpText = "Heroic Slugger.",
    },
}
