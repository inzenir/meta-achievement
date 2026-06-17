-- Waypoints and help text for Back From The Beyond achievements (Shadowlands meta 20501)
-- Structure: Keyed by achievement ID, with optional criteria-level data
-- Note: Waypoints are structured with 'kind' (point/area) and 'coordinates' array

BackFromTheBeyondWaypoints = {
    -- Main achievement: Back from the Beyond (20501) - Shadowlands meta
    [20501] = {
        helpText = "Complete all required achievements across Shadowlands: Castle Nathria, Chains of Domination, Dead Men Tell Some Tales, From A to Zereth, Myths of the Shadowlands Dungeons, On the Offensive, Re-Re-Re-Renowned, Sanctum Superior, Sanctum of Domination, Sepulcher of the First Ones, Shadowlands Dilettante, Tower Ranger, Walking in Maw-mphis, and more. Reward: Reins of the Dominant Gloomcharger.",
    },

    -- Castle Nathria (14715) - raid
    [14715] = {
        helpText = "Defeat all 10 bosses in Castle Nathria on any difficulty. Raid entrance in Revendreth (Shadowlands). Bosses: Shriekwing, Huntsman Altimor, Sun King's Salvation, Artificer Xy'mox, Hungering Destroyer, Lady Inerva Darkvein, The Council of Blood, Sludgefist, Stone Legion Generals, Sire Denathrius.",
        criteria = {
            [48950] = { helpText = "Shriekwing", waypoints = {} },
            [48951] = { helpText = "Huntsman Altimor", waypoints = {} },
            [48954] = { helpText = "Sun King's Salvation", waypoints = {} },
            [48953] = { helpText = "Artificer Xy'mox", waypoints = {} },
            [48952] = { helpText = "Hungering Destroyer", waypoints = {} },
            [48955] = { helpText = "Lady Inerva Darkvein", waypoints = {} },
            [48956] = { helpText = "The Council of Blood", waypoints = {} },
            [48957] = { helpText = "Sludgefist", waypoints = {} },
            [48958] = { helpText = "Stone Legion Generals", waypoints = {} },
            [48959] = { helpText = "Sire Denathrius", waypoints = {} },
        },
    },

    -- Chains of Domination (14961) - questline
    [14961] = {
        helpText = "Complete the Chains of Domination campaign. Questline chapters: Battle of Ardenweald, Maw Walkers, Focusing the Eye, The Last Sigil, An Army of Bone and Steel, The Unseen Guests, The Power of Night, A New Path, What Lies Ahead.",
        criteria = {
            [51692] = { helpText = "Battle of Ardenweald", waypoints = {} },
            [51693] = { helpText = "Maw Walkers", waypoints = {} },
            [52490] = { helpText = "Focusing the Eye", waypoints = {} },
            [51694] = { helpText = "The Last Sigil", waypoints = {} },
            [51695] = { helpText = "An Army of Bone and Steel", waypoints = {} },
            [51696] = { helpText = "The Unseen Guests", waypoints = {} },
            [51697] = { helpText = "The Power of Night", waypoints = {} },
            [52457] = { helpText = "A New Path", waypoints = {} },
            [52235] = { helpText = "What Lies Ahead", waypoints = {} },
        },
    },

    -- Dead Men Tell Some Tales (15647)
    [15647] = {
        helpText = "Complete all four Covenant campaigns: Kyrian, Necrolords, Night Fae, and Venthyr. Earn campaign progress in each covenant's questline.",
    },

    -- Fake It 'Til You Make It (15178)
    [15178] = {
        helpText = "Use the Disguise Kit toy to fool NPCs in Shadowlands. Obtain from Torghast (Layer 8+) or Broker in Oribos. Use in covenant zones.",
    },

    -- From A to Zereth (15336) - meta
    [15336] = {
        helpText = "Complete Zereth Mortis content: Secrets of the First Ones, Treasures of Zereth Mortis, Dune Dominance, Adventurer of Zereth Mortis, Cyphers of the First Ones, Synthe-fived!, and The Enlightened.",
    },

    -- Secrets of the First Ones (15259) - Zereth Mortis questline
    [15259] = {
        helpText = "Complete the Secrets of the First Ones campaign in Zereth Mortis. Chapters: Into the Unknown, We Battle Onward, Forming an Understanding, Forging a New Path, Crown of Wills, A Means to an End, Starting Over.",
        criteria = {
            [52701] = { helpText = "Into the Unknown", waypoints = {} },
            [52703] = { helpText = "We Battle Onward", waypoints = {} },
            [52702] = { helpText = "Forming an Understanding", waypoints = {} },
            [52704] = { helpText = "Forging a New Path", waypoints = {} },
            [52705] = { helpText = "Crown of Wills", waypoints = {} },
            [52706] = { helpText = "A Means to an End", waypoints = {} },
            [52707] = { helpText = "Starting Over", waypoints = {} },
        },
    },

    -- Treasures of Zereth Mortis (15331)
    [15331] = {
        helpText = "Loot 27 unique treasures across Zereth Mortis (map 13536). Easy-mode treasures need no unlocks; some require Venthyr teleport, Cypher Console, or Protoform Synthesis.",
        criteria = {
            [52887] = {
                helpText = "Library Vault - Cave entrance 59/82. Click left tablet to unlock. Drops Schematic: Viperid Menace.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_ZerethMortis, x = 59, y = 82, title = "Library Vault (cave entrance)" } } } },
            },
            [52964] = {
                helpText = "Submerged Chest - Lexical Glade 59/73. Get Dangerous Orb at 60/77, run to pump to raise chest.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_ZerethMortis, x = 59, y = 73, title = "Submerged Chest" }, { mapId = MapZones.SL_ZONE_ZerethMortis, x = 60, y = 77, title = "Dangerous Orb" } } } },
            },
            [52965] = {
                helpText = "Damaged Jiro Stash - Terrace of Formation, northwest Zereth Mortis.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_ZerethMortis, x = 38, y = 37, title = "Damaged Jiro Stash" } } } },
            },
            [52966] = {
                helpText = "Template Archive - Cave entrance 58/44. Click left ball to open passage.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_ZerethMortis, x = 58, y = 44, title = "Template Archive (cave)" } } } },
            },
            [52967] = {
                helpText = "Forgotten Proto-Vault - South-east mountains. Start at 64/71, Venthyr teleport up.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_ZerethMortis, x = 64, y = 71, title = "Forgotten Proto-Vault (start)" } } } },
            },
            [52968] = {
                helpText = "Symphonic Vault - Cave entrance 52/63. Click objects in sequence to unlock.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_ZerethMortis, x = 52, y = 63, title = "Symphonic Vault (cave)" } } } },
            },
            [52969] = {
                helpText = "Mawsworn Cache - Area full of enemies.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_ZerethMortis, x = 60, y = 40, title = "Mawsworn Cache" } } } },
            },
            [52970] = {
                helpText = "Stolen Relic - Near Haven 38/65. Jumping puzzle; Venthyr helps.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_ZerethMortis, x = 38, y = 65, title = "Stolen Relic" } } } },
            },
            [53016] = {
                helpText = "Fallen Vault - Antecedent Isle. Portal at 46/22 to island, east side.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_ZerethMortis, x = 46.08, y = 21.68, title = "Portal to Antecedent Isle" }, { mapId = MapZones.SL_ZONE_ZerethMortis, x = 52, y = 10, title = "Fallen Vault" } } } },
            },
            [53017] = {
                helpText = "Gnawed Valise - Rocks 39/73. Venthyr teleport up.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_ZerethMortis, x = 39, y = 73, title = "Gnawed Valise" } } } },
            },
            [53018] = {
                helpText = "Domination Cache - Elites area. Key from Mawsworn Inquisitors (low drop).",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_ZerethMortis, x = 52, y = 30, title = "Domination Cache area" } } } },
            },
            [53052] = {
                helpText = "Filched Artifact - South 50/87. Jumping puzzle; Venthyr helps.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_ZerethMortis, x = 50, y = 87, title = "Filched Artifact" } } } },
            },
            [53053] = {
                helpText = "Architect's Reserve - Requires Sopranian Understanding + Finding Tahli questline.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_ZerethMortis, x = 55, y = 45, title = "Architect's Reserve" } } } },
            },
            [53054] = {
                helpText = "Crushed Supply Crate - Get repair kit from stone above, give to Jiro Hiu Fi.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_ZerethMortis, x = 57, y = 64, title = "Crushed Supply Crate" } } } },
            },
            [53056] = {
                helpText = "Overgrown Protofruit - Behind Firim's flight path. Jump on orb.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_ZerethMortis, x = 35, y = 55, title = "Overgrown Protofruit" } } } },
            },
            [53060] = {
                helpText = "Mistaken Ovoid - Cave 52/74. Find 5 eggs for chicken to move.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_ZerethMortis, x = 52, y = 74, title = "Mistaken Ovoid (cave)" } } } },
            },
            [53061] = {
                helpText = "Drowned Broker Supplies - Near Haven 35/71. Requires Dealic Understanding (Pocopoc).",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_ZerethMortis, x = 35, y = 71, title = "Drowned Broker Supplies" } } } },
            },
            [53062] = {
                helpText = "Offering to the First Ones - Simple treasure.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_ZerethMortis, x = 36, y = 57, title = "Offering to the First Ones" } } } },
            },
            [53063] = {
                helpText = "Protomineral Extractor - Pillar 47/31. Venthyr teleport required.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_ZerethMortis, x = 47, y = 31, title = "Protomineral Extractor" } } } },
            },
            [53064] = {
                helpText = "Pilfered Curio - Pillar 61/43. Venthyr teleport required.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_ZerethMortis, x = 61, y = 43, title = "Pilfered Curio" } } } },
            },
            [53065] = {
                helpText = "Stolen Scroll - Cave entrance 34.68 near Haven. Venthyr teleport up.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_ZerethMortis, x = 34.68, y = 65, title = "Stolen Scroll" } } } },
            },
            [53066] = {
                helpText = "Grateful Boon - South mountains. Click animals to sit, treasure spawns.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_ZerethMortis, x = 52, y = 90, title = "Grateful Boon area" } } } },
            },
            [53067] = {
                helpText = "Protoflora Harvester - Tree 53/71. Venthyr helps reach it.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_ZerethMortis, x = 53, y = 71, title = "Protoflora Harvester" } } } },
            },
            [53068] = {
                helpText = "Syntactic Vault - Island cave 41/67. Click 6 runes in 6 min.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_ZerethMortis, x = 41, y = 67, title = "Syntactic Vault (cave)" } } } },
            },
            [53069] = {
                helpText = "Ripened Protopear - Cave 63/73. Sopranian Understanding + Mysterious Greenery. Grow with 3 gas clouds.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_ZerethMortis, x = 63, y = 73, title = "Ripened Protopear (cave)" } } } },
            },
            [53070] = {
                helpText = "Undulating Foliage - Cave entrance 50/78. Multi-step teleporter puzzle.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_ZerethMortis, x = 50, y = 78, title = "Undulating Foliage (cave)" } } } },
            },
            [53071] = {
                helpText = "Bushel of Progenitor Produce - South. Kill 5 Nascent Servitors for 5 stacks, open door fast.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_ZerethMortis, x = 52, y = 92, title = "Bushel of Progenitor Produce" } } } },
            },
        },
    },

    -- Dune Dominance (15392)
    [15392] = {
        helpText = "Defeat three world bosses in Zereth Mortis: Iska Outrider of Ruin, High Reaver Damaris, Reanimatrox Marzan.",
        criteria = {
            [52992] = { helpText = "Iska, Outrider of Ruin", waypoints = {} },
            [52993] = { helpText = "High Reaver Damaris", waypoints = {} },
            [52994] = { helpText = "Reanimatrox Marzan", waypoints = {} },
        },
    },

    -- Adventurer of Zereth Mortis (15391)
    [15391] = {
        helpText = "Defeat 25 rare elites in Zereth Mortis: Gluttonous Overgrowth, Otiosen, Feasting, Destabilized Core, Sand Matriarch Ileus, Xy'rath the Covetous, Akkaris, Chitali the Eldest, Tahkwitz, Sorranos, Orixal, Euv'ouk, Vitiane, Hadeon the Stonebreaker, General Zarathura, Gorkek, Tethos, Shifting Stargorger, Protector of the First Ones, Mother Phestis, Garudeon, Furidian, Hirukon, Zatojin, Otaris the Provoked, Corrupted Architect, Helmix, Vexis, The Engulfer.",
        criteria = {
            [52971] = { helpText = "Gluttonous Overgrowth", waypoints = {} },
            [52972] = { helpText = "Otiosen", waypoints = {} },
            [52973] = { helpText = "Feasting", waypoints = {} },
            [52974] = { helpText = "Destabilized Core", waypoints = {} },
            [52975] = { helpText = "Sand Matriarch Ileus", waypoints = {} },
            [52976] = { helpText = "Xy'rath the Covetous", waypoints = {} },
            [52977] = { helpText = "Akkaris", waypoints = {} },
            [52978] = { helpText = "Chitali the Eldest", waypoints = {} },
            [52979] = { helpText = "Tahkwitz", waypoints = {} },
            [52980] = { helpText = "Sorranos", waypoints = {} },
            [52981] = { helpText = "Orixal", waypoints = {} },
            [52982] = { helpText = "Euv'ouk", waypoints = {} },
            [52983] = { helpText = "Vitiane", waypoints = {} },
            [52984] = { helpText = "Hadeon the Stonebreaker", waypoints = {} },
            [52985] = { helpText = "General Zarathura", waypoints = {} },
            [52986] = { helpText = "Gorkek", waypoints = {} },
            [52987] = { helpText = "Tethos", waypoints = {} },
            [52988] = { helpText = "Shifting Stargorger", waypoints = {} },
            [52989] = { helpText = "Protector of the First Ones", waypoints = {} },
            [53020] = { helpText = "Mother Phestis", waypoints = {} },
            [53025] = { helpText = "Garudeon", waypoints = {} },
            [53031] = { helpText = "Furidian", waypoints = {} },
            [52990] = { helpText = "Hirukon", waypoints = {} },
            [53044] = { helpText = "Zatojin", waypoints = {} },
            [53046] = { helpText = "Otaris the Provoked", waypoints = {} },
            [53047] = { helpText = "Corrupted Architect", waypoints = {} },
            [53048] = { helpText = "Helmix", waypoints = {} },
            [53049] = { helpText = "Vexis", waypoints = {} },
            [53050] = { helpText = "The Engulfer", waypoints = {} },
        },
    },

    -- Cyphers of the First Ones (15402)
    [15402] = {
        helpText = "Research all Metrial, Aealic, Dealic, and Trebalim Cyphers in Zereth Mortis. Unlock via Cypher Console progression.",
    },

    -- Synthe-fived! (15407)
    [15407] = {
        helpText = "Create a genesis mote in Zereth Mortis using the Synthesis Forge. Requires Protoform Synthesis unlocked. Forge near Haven.",
        waypoints = {
            { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_ZerethMortis, x = 35, y = 65, title = "Synthesis Forge (near Haven)" } } },
        },
    },

    -- The Enlightened (15220)
    [15220] = {
        helpText = "Reach Exalted with The Enlightened in Zereth Mortis. Earn reputation through dailies, weeklies, and content.",
    },

    -- Many, Many Things (15079)
    [15079] = {
        helpText = "Research all Command Table talents for your covenant. Requires completing all Command Table upgrade tiers.",
    },

    -- Myths of the Shadowlands Dungeons (15651)
    [15651] = {
        helpText = "Complete all 8 Shadowlands dungeons plus Tazavesh on Mythic or Mythic+: The Necrotic Wake, Plaguefall, Mists of Tirna Scithe, Halls of Atonement, Spires of Ascension, Theater of Pain, De Other Side, Sanguine Depths, Tazavesh the Veiled Market.",
    },

    -- On the Offensive (15035)
    [15035] = {
        helpText = "Complete Maw assaults, open caches, defeat rares, and complete various Maw activities: United Front, Jailer's Personal Stash, This Army, Up For Grabs, The Zovaal Shuffle, Hoarder of Torghast, A Sly Fox, Tea for the Troubled, Krrprripripkraak's Heroes.",
    },

    -- United Front (15000)
    [15000] = {
        helpText = "Complete covenant assaults in The Maw: Necrolord, Venthyr, Night Fae, and Kyrian assaults.",
        criteria = {
            [51720] = { helpText = "Necrolord Assault", waypoints = {} },
            [51721] = { helpText = "Venthyr Assault", waypoints = {} },
            [51722] = { helpText = "Night Fae Assault", waypoints = {} },
            [51723] = { helpText = "Kyrian Assault", waypoints = {} },
        },
    },

    -- Jailer's Personal Stash (15001)
    [15001] = {
        helpText = "Open Rift Hidden Caches in The Maw. Caches appear during assaults.",
    },

    -- This Army (15037)
    [15037] = {
        helpText = "Defeat five rares in The Maw: Cutter Fin, Kearnen the Blade, Winslow Swan, Boil Master Yetch, Flytrap.",
        criteria = {
            [52044] = { helpText = "Cutter Fin", waypoints = {} },
            [52045] = { helpText = "Kearnen the Blade", waypoints = {} },
            [52046] = { helpText = "Winslow Swan", waypoints = {} },
            [52047] = { helpText = "Boil Master Yetch", waypoints = {} },
            [52048] = { helpText = "Flytrap", waypoints = {} },
        },
    },

    -- Up For Grabs (15039)
    [15039] = {
        helpText = "Open Mawsworn Caches in The Maw. Found during assaults.",
    },

    -- The Zovaal Shuffle (15041)
    [15041] = {
        helpText = "Dance near five different Forges in Zovaal's Cauldron while holding a Mawproof Parasol (Night Fae covenant). Zovaal's Cauldron at 38.8, 41.3.",
        waypoints = {
            { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 38.8, y = 41.3, title = "Zovaal's Cauldron", note = "Find 5 forges, /dance with Mawproof Parasol" } } },
        },
    },

    -- Hoarder of Torghast (15043)
    [15043] = {
        helpText = "Collect ten items that Fangcrack pulls out of the Portal to Torghast. Find Fangcrack in Korthia (Chamber of First Reflection area).",
        waypoints = {
            { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_Korthia, x = 50, y = 50, title = "Fangcrack (near Portal to Torghast)" } } },
        },
    },

    -- A Sly Fox (15004)
    [15004] = {
        criteria = { [51734] = { helpText = "", waypoints = {} } },
    },

    -- Tea for the Troubled (15042)
    [15042] = {
        helpText = "Rescue souls in Torghast: Simone, Laurent, Archivist Fane, The Countess, Kael'thas Sunstrider, Lost Sybille, Vulca, Iven.",
        criteria = {
            [52065] = { helpText = "Simone", waypoints = {} },
            [52066] = { helpText = "Laurent", waypoints = {} },
            [52067] = { helpText = "Archivist Fane", waypoints = {} },
            [52068] = { helpText = "The Countess", waypoints = {} },
            [52069] = { helpText = "Kael'thas Sunstrider", waypoints = {} },
            [52070] = { helpText = "Lost Sybille", waypoints = {} },
            [52071] = { helpText = "Vulca", waypoints = {} },
            [52072] = { helpText = "Iven", waypoints = {} },
        },
    },

    -- Krrprripripkraak's Heroes (15044)
    [15044] = {
        helpText = "Rescue souls in Torghast: Elder Gwenna, Foreman Thorodir, Te'zan, Warden Casad, Kivarr, Guardian Kota.",
        criteria = {
            [52078] = { helpText = "Elder Gwenna", waypoints = {} },
            [52079] = { helpText = "Foreman Thorodir", waypoints = {} },
            [52080] = { helpText = "Te'zan", waypoints = {} },
            [52081] = { helpText = "Warden Casad", waypoints = {} },
            [52082] = { helpText = "Kivarr", waypoints = {} },
            [52083] = { helpText = "Guardian Kota", waypoints = {} },
        },
    },

    -- Re-Re-Re-Renowned (15646)
    [15646] = {
        helpText = "Reach Renown 80 with all four covenants: Kyrian, Necrolords, Night Fae, Venthyr.",
    },

    -- Sanctum Superior (15025)
    [15025] = {
        helpText = "Defeat Sylvanas Windrunner in Sanctum of Domination on Mythic difficulty.",
    },

    -- Sanctum of Domination (15126)
    [15126] = {
        helpText = "Defeat all 10 bosses in Sanctum of Domination on any difficulty. Raid in The Maw. Bosses: The Tarragrue, The Eye of the Jailer, The Nine, Remnant of Ner'zhul, Soulrender Dormazain, Painsmith Raznal, Guardian of the First Ones, Fatescribe Roh-Kalo, Kel'Thuzad, Sylvanas Windrunner.",
        criteria = {
            [52471] = { helpText = "The Tarragrue", waypoints = {} },
            [52473] = { helpText = "The Eye of the Jailer", waypoints = {} },
            [52475] = { helpText = "The Nine", waypoints = {} },
            [52477] = { helpText = "Remnant of Ner'zhul", waypoints = {} },
            [52479] = { helpText = "Soulrender Dormazain", waypoints = {} },
            [52481] = { helpText = "Painsmith Raznal", waypoints = {} },
            [52483] = { helpText = "Guardian of the First Ones", waypoints = {} },
            [52485] = { helpText = "Fatescribe Roh-Kalo", waypoints = {} },
            [52487] = { helpText = "Kel'Thuzad", waypoints = {} },
            [52489] = { helpText = "Sylvanas Windrunner", waypoints = {} },
        },
    },

    -- Sepulcher of the First Ones (15417)
    [15417] = {
        helpText = "Defeat all 11 bosses in Sepulcher of the First Ones on any difficulty. Raid in Zereth Mortis. Bosses: Vigilant Guardian, Skolex, Artificer Xy'mox, Dausegne, Prototype Pantheon, Lihuvim, Halondrus, Anduin Wrynn, Lords of Dread, Rygelon, The Jailer.",
        criteria = {
            [53151] = { helpText = "Vigilant Guardian", waypoints = {} },
            [53152] = { helpText = "Skolex", waypoints = {} },
            [53153] = { helpText = "Artificer Xy'mox", waypoints = {} },
            [53154] = { helpText = "Dausegne", waypoints = {} },
            [53155] = { helpText = "Prototype Pantheon", waypoints = {} },
            [53156] = { helpText = "Lihuvim", waypoints = {} },
            [53157] = { helpText = "Halondrus", waypoints = {} },
            [53158] = { helpText = "Anduin Wrynn", waypoints = {} },
            [53148] = { helpText = "Lords of Dread", waypoints = {} },
            [53149] = { helpText = "Rygelon", waypoints = {} },
            [53150] = { helpText = "The Jailer", waypoints = {} },
        },
    },

    -- Shadowlands Dilettante (15649)
    [15649] = {
        helpText = "Complete covenant guest quests: Pursuing Loyalty (Kyrian rares), Be Our Guest (covenant guests), Things To Do When You're Dead (Torghast abominations/wardrobe/gang), Mush Appreciated.",
    },

    -- Tower Ranger (15324)
    [15324] = {
        helpText = "Complete Torghast achievements: Flawless Master Layer 16, Adamant Vaults, Twisting Corridors Layer 8, Jailer's Gauntlet Layer 4, Master of Torment.",
    },

    -- Walking in Maw-mphis (15648)
    [15648] = {
        helpText = "Complete Maw exploration and activities: 'Ghast Five (anima powers), Better to Be Lucky Than Dead (rares), It's About Sending a Message (rares), Hunting Party, Trading Partners, Soulkeeper's Burden, Explore The Maw.",
    },

    -- 'Ghast Five (14895)
    [14895] = {
        helpText = "Collect 14 anima powers in Torghast: Vessel of Unfortunate Spirits, Extradimensional Pockets, Encased Riftwalker Essence, Animated Levitating Chain, Animaflow Stabilizer, Soul-Stabilizing Salve, Ritual Prism of Fortune, Bangle of Seniority, Talisman of Destined Defiance, Rank Insignia: Acquisitionist, Possibility Matrix, Loupe of Unusual Charm, Broker Traversal Enhancer.",
        criteria = {
            [51251] = { helpText = "Vessel of Unfortunate Spirits", waypoints = {} },
            [51253] = { helpText = "Extradimensional Pockets", waypoints = {} },
            [51255] = { helpText = "Encased Riftwalker Essence", waypoints = {} },
            [51254] = { helpText = "Animated Levitating Chain", waypoints = {} },
            [51258] = { helpText = "Animaflow Stabilizer", waypoints = {} },
            [51256] = { helpText = "Soul-Stabilizing Salve", waypoints = {} },
            [51252] = { helpText = "Ritual Prism of Fortune", waypoints = {} },
            [51248] = { helpText = "Bangle of Seniority", waypoints = {} },
            [51257] = { helpText = "Talisman of Destined Defiance", waypoints = {} },
            [51249] = { helpText = "Rank Insignia: Acquisitionist", waypoints = {} },
            [51464] = { helpText = "Possibility Matrix", waypoints = {} },
            [51250] = { helpText = "Loupe of Unusual Charm", waypoints = {} },
            [51573] = { helpText = "Broker Traversal Enhancer", waypoints = {} },
        },
    },

    -- Better to Be Lucky Than Dead (14744) - Maw/Torghast rares
    [14744] = {
        helpText = "Defeat 21 rare elites in The Maw. Some require achievements (Make it Double!, Prepare for Trouble!) or 4 players to summon (Heralds).",
        criteria = {
            [49841] = {
                helpText = "Adjutant Dekaris - On tall rock. Path at 23.5, 34.7",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 25.8, y = 31.3, title = "Adjutant Dekaris" }, { mapId = MapZones.SL_ZONE_TheMaw, x = 23.5, y = 34.7, title = "Path start" } } } },
            },
            [49842] = {
                helpText = "Apholeias, Herald of Loss - 4 players, Convocation on platform corners.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 19.4, y = 41.4, title = "Apholeias" } } } },
            },
            [49843] = {
                helpText = "Borr-Geth - Drops Borr-Geth's Fiery Brimstone toy (20%).",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 39.6, y = 41.2, title = "Borr-Geth" } } } },
            },
            [49844] = {
                helpText = "Conjured Death",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 27.8, y = 13.4, title = "Conjured Death" } } } },
            },
            [49845] = {
                helpText = "Darithis the Bleak - Cave entrance 59.3, 51.7. Needs Make it Double!",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 60.8, y = 47.8, title = "Darithis the Bleak" }, { mapId = MapZones.SL_ZONE_TheMaw, x = 59.3, y = 51.7, title = "Cave entrance" } } } },
            },
            [49846] = {
                helpText = "Darklord Taraxis - Needs Make it Double!",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 48.7, y = 81.4, title = "Darklord Taraxis" } } } },
            },
            [49847] = {
                helpText = "Dolos - Needs Prepare for Trouble! to open gate.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 28.1, y = 60.5, title = "Dolos" } } } },
            },
            [49848] = {
                helpText = "Eketra",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 23.7, y = 53.1, title = "Eketra" } } } },
            },
            [49849] = {
                helpText = "Ekphoras, Herald of Grief - 4 players, Convocation.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 42.1, y = 21.2, title = "Ekphoras" } } } },
            },
            [49850] = {
                helpText = "Eternas the Tormentor - Drops Contained Essence of Dread pet (20%). Spawns at 2 locations.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 19.2, y = 46.4, title = "Eternas (spawn 1)" }, { mapId = MapZones.SL_ZONE_TheMaw, x = 27.4, y = 49.4, title = "Eternas (spawn 2)" } } } },
            },
            [49851] = {
                helpText = "Exos, Herald of Domination - Summon with Domination's Calling (combine 3 etchings). Altar of Domination.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 46, y = 47.7, title = "Exos summon spot" } } } },
            },
            [49852] = {
                helpText = "Morguliax - Drops Ancient Elethium Coin toy (13%).",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 16.6, y = 50.7, title = "Morguliax" } } } },
            },
            [49853] = {
                helpText = "Nascent Devourer - Cave east of 46.2, 74.4. Needs Make it Double!",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 46.2, y = 74.4, title = "Nascent Devourer (cave)" } } } },
            },
            [49854] = {
                helpText = "Obolos",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 48.5, y = 18.4, title = "Obolos" } } } },
            },
            [49855] = {
                helpText = "Orophea - Get Eurydea's Amulet, channel on Orophea. Drops Orophea's Lyre toy (50%).",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 23.6, y = 21.6, title = "Orophea" } } } },
            },
            [49856] = {
                helpText = "Shadeweaver Zeris - Needs Prepare for Trouble!",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 32.8, y = 66.6, title = "Shadeweaver Zeris" } } } },
            },
            [49857] = {
                helpText = "Soulforger Rhovus",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 36, y = 41.6, title = "Soulforger Rhovus" } } } },
            },
            [49858] = {
                helpText = "Talaporas, Herald of Pain - 4 players, Convocation. Drops Dominion Etching: Pain.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 28.9, y = 11.6, title = "Talaporas" } } } },
            },
            [49859] = {
                helpText = "Thanassos - Needs Prepare for Trouble! Gate. Tough to solo.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 27.4, y = 71.7, title = "Thanassos" } } } },
            },
            [49860] = {
                helpText = "Yero the Skittish - Friendly at first. Follow to cave 38.7, 58.6.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 37.9, y = 61.4, title = "Yero start" }, { mapId = MapZones.SL_ZONE_TheMaw, x = 38.7, y = 58.6, title = "Cave" } } } },
            },
            [50621] = {
                helpText = "Ikras the Devourer - Patrols between Perdition Hold and Cocyrus. Interrupt poison.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 32.5, y = 51.8, title = "Ikras the Devourer" } } } },
            },
        },
    },

    -- It's About Sending a Message (14660) - Maw rares (different set from Better to Be Lucky Than Dead)
    [14660] = {
        helpText = "Defeat 19 rare elites in The Maw. Different rares from Better to Be Lucky Than Dead. Follow-up to Handling His Henchmen.",
        criteria = {
            [49475] = {
                helpText = "Drifting Sorrow",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 32, y = 21, title = "Drifting Sorrow" } } } },
            },
            [49476] = {
                helpText = "Dartanos",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 25.8, y = 14.8, title = "Dartanos" } } } },
            },
            [49479] = {
                helpText = "Razkazzar",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 26.4, y = 37.4, title = "Razkazzar" } } } },
            },
            [49480] = { helpText = "Orrholyn", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 24, y = 35, title = "Orrholyn" } } } } },
            [49481] = { helpText = "Huwerath", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 30, y = 40, title = "Huwerath" } } } } },
            [49482] = { helpText = "Soulsmith Yol-Mattar", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 28, y = 45, title = "Soulsmith Yol-Mattar" } } } } },
            [49484] = { helpText = "Cyrixia", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 35, y = 50, title = "Cyrixia" } } } } },
            [49485] = { helpText = "Agonix", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 40, y = 55, title = "Agonix" } } } } },
            [49486] = { helpText = "Krala", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 45, y = 60, title = "Krala" } } } } },
            [49487] = { helpText = "Akros", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 50, y = 55, title = "Akros" } } } } },
            [49488] = { helpText = "Malevolent Stygia", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 42, y = 65, title = "Malevolent Stygia" } } } } },
            [49489] = { helpText = "Sanngror the Torturer", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 38, y = 70, title = "Sanngror the Torturer" } } } } },
            [49490] = { helpText = "Houndmaster Vasanok", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 55, y = 65, title = "Houndmaster Vasanok" } } } } },
            [49491] = { helpText = "Skittering Broodmother", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 48, y = 72, title = "Skittering Broodmother" } } } } },
            [49492] = { helpText = "Valis the Cruel", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 52, y = 75, title = "Valis the Cruel" } } } } },
            [50408] = { helpText = "Odalrik", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 36, y = 58, title = "Odalrik" } } } } },
            [50409] = { helpText = "Stygian Incinerator", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 44, y = 48, title = "Stygian Incinerator" } } } } },
            [50410] = { helpText = "Dath Rezara", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 30, y = 62, title = "Dath Rezara" } } } } },
            [51058] = { helpText = "Ratgusher", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 34, y = 54, title = "Ratgusher" } } } } },
        },
    },

    -- Explore The Maw (14663)
    [14663] = {
        helpText = "Discover 12 subzones in The Maw (map 11400). Use /way coordinates to find each area. Requires level 60 and Torghast unlocked.",
        criteria = {
            [49501] = {
                helpText = "Calcis",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 23.85, y = 36.7, title = "Calcis" } } } },
            },
            [49502] = {
                helpText = "Cocyrus",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 44, y = 41.7, title = "Cocyrus" } } } },
            },
            [49503] = {
                helpText = "Crucible of the Damned",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 21.5, y = 43.2, title = "Crucible of the Damned" } } } },
            },
            [49504] = {
                helpText = "Desmotaeron",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 55.2, y = 62.1, title = "Desmotaeron" } } } },
            },
            [49505] = {
                helpText = "Gorgoa: River of Souls",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 31.35, y = 33.7, title = "Gorgoa: River of Souls" } } } },
            },
            [49506] = {
                helpText = "Marrow's Coppice",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 47, y = 80.9, title = "Marrow's Coppice" } } } },
            },
            [49507] = {
                helpText = "Perdition Hold",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 32.9, y = 66.55, title = "Perdition Hold" } } } },
            },
            [49508] = {
                helpText = "Planes of Torment",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 33.6, y = 22.9, title = "Planes of Torment" } } } },
            },
            [49509] = {
                helpText = "Ravener's Lament",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 62.5, y = 66.85, title = "Ravener's Lament" } } } },
            },
            [49510] = {
                helpText = "The Altar of Domination",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 23.15, y = 68.4, title = "The Altar of Domination" } } } },
            },
            [49511] = {
                helpText = "The Beastwarrens",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 49.55, y = 63.3, title = "The Beastwarrens" } } } },
            },
            [49512] = {
                helpText = "Zovaal's Cauldron",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.SL_ZONE_TheMaw, x = 38.8, y = 41.3, title = "Zovaal's Cauldron" } } } },
            },
        },
    },
}
