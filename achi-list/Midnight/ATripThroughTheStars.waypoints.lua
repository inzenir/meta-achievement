-- Meta criteria type 8 = complete another achievement (CRITERIA_TYPE_ACHIEVEMENT).
ATripThroughTheStarsWaypoints = {
    [62874] = {
        helpText = "Midnight meta achievement: Naigtal storyline.",
        criteria = {
            [115476] = { name = "Into the Stars", criteriaType = 8 },
            [115478] = { name = "Prepared for a Showdown", criteriaType = 8 },
            [115482] = { name = "A Hal'hadar Walks into a Swamp", criteriaType = 8 },
            [115483] = { name = "Climate Strange: Naigtal", criteriaType = 8 },
            [115484] = { name = "Showdown Slugger: Naigtal", criteriaType = 8 },
            [115485] = { name = "Showdown Success: Naigtal", criteriaType = 8 },
        },
    },
    [63383] = {
        helpText = "Into the Stars.",
    },
    [63384] = {
        helpText = "Prepared for a Showdown.",
    },
    [63385] = {
        helpText = "A Hal'hadar Walks into a Swamp.",
    },
    [62904] = {
        combineVirtualAndRegularCriteria = true,
        helpText = "Climate Strange: Naigtal.",
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
    [62883] = {
        combineVirtualAndRegularCriteria = true,
        helpText = "Defeat 6 rare creatures in Naigtal.",
        virtualCriteria = {
            [0] = {
                text = "Rare creatures defeated",
                criteriaType = VirtualCriteriaTypes.ProgressBar,
                reqQuantity = 6,
            },
        },
        criteria = {
            [114005] = {
                name = "Interminable Uarn",
                criteriaType = 0,
                helpText = "Patrol.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Naigtal, x = 38, y = 63, title = "Interminable Uarn" } } } },
            },
            [114006] = {
                name = "Broxion",
                criteriaType = 0,
                helpText = "Patrol.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Naigtal, x = 45, y = 52, title = "Broxion" } } } },
            },
            [114007] = {
                name = "Swalewing Matriarch",
                criteriaType = 0,
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Naigtal, x = 77, y = 38, title = "Flickering Swalewing" } } } },
            },
            [114008] = {
                name = "Lomelith",
                criteriaType = 0,
                helpText = "Patrol.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Naigtal, x = 65, y = 60, title = "Lomelith" } } } },
            },
            [114009] = {
                name = "Auredar",
                criteriaType = 0,
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Naigtal, x = 29, y = 63, title = "Auredar" } } } },
            },
            [114010] = {
                name = "Warp Agent Xi'grivr",
                criteriaType = 0,
                waypoints = {
                    {
                        kind = "point",
                        coordinates = {
                            { mapId = MapZones.MIDNIGHT_ZONE_Naigtal, x = 70, y = 76, title = "Xi'Grivr" },
                            { mapId = MapZones.MIDNIGHT_ZONE_Naigtal, x = 49, y = 59, title = "Warp Riders (Patrol)" },
                        },
                    },
                },
            },
            [114011] = {
                name = "Indomitable Mk XII",
                criteriaType = 0,
                helpText = "Patrol.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Naigtal, x = 53, y = 50, title = "Indomitable Mk XII" } } } },
            },
            [114012] = {
                name = "Slaipaan",
                criteriaType = 0,
                helpText = "Patrol.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Naigtal, x = 57, y = 63, title = "Slaipaan" } } } },
            },
        },
    },
    [62882] = {
        combineVirtualAndRegularCriteria = true,
        helpText = "Complete 8 different World Quests in Naigtal.",
        virtualCriteria = {
            [0] = {
                text = "World quests completed",
                criteriaType = VirtualCriteriaTypes.ProgressBar,
                reqQuantity = 8,
            },
        },
        criteria = {
            [114013] = { 
                name = "Mush-Vroom!",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Naigtal,
                    questId = 96293,
                }
            },
            [114014] = { 
                name = "Mashing Mushroom Mana Machines", 
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Naigtal,
                    questId = 96272,
                }
            },
            [114015] = { 
                name = "Scrubbing Troubles", 
                criteriaType = 27,  
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Naigtal,
                    questId = 96210,
                }
            },
            [114017] = { 
                name = "Power Overload", 
                criteriaType = 27,  
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Naigtal,
                    questId = 96432,
                }
            },
            [114018] = { 
                name = "Sporadic Power Drain", 
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Naigtal,
                    questId = 96217,
                }
            },
            [114019] = { 
                name = "Marsh Mana Spores", 
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Naigtal,
                    questId = 96268,
                } 
            },
            [114020] = {
                name = "Skiff Joyride",
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Naigtal,
                    questId = 96000,
                },
            },
            [114021] = { 
                name = "Forest Mana Spores", 
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Naigtal,
                    questId = 96575,
                }
            },
            [114045] = { 
                name = "Crypt Culling", 
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Naigtal,
                    questId = 96600,
                }
            },
            [114046] = { 
                name = "Weaken Their Forces", 
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Naigtal,
                    questId = 96547,
                }
            },
            [115236] = { 
                name = "Capsized Compost", 
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Naigtal,
                    questId = 96623,
                } 
            },
            [116529] = { 
                name = "Flying Debris", 
                criteriaType = 27,
                worldQuest = {
                    mapId = MapZones.MIDNIGHT_ZONE_Naigtal,
                    questId = 96557,
                } 
            },
        },
    },
}
