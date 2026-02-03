-- Waypoints and help text for A World Awoken achievements
-- Structure: Keyed by achievement ID, with optional criteria-level data
-- Note: Waypoints are structured with 'kind' (point/area) and 'coordinates' array

AWorldAwokenWaypoints = {
    -- Main achievement: A World Awoken (19458) - Dragonflight meta, rewards Good Boy's Leash (Taivan mount)
    [19458] = {
        helpText = "Complete all 14 required achievements across Dragonflight: 3 raids (Vault of the Incarnates, Aberrus, Amirdrassil), Myths of the Dragonflight Dungeons, Dragon Isles Pathfinder, Loremaster, Friend of the Dragon Isles, Dragon Quests, Oh My God They Were Clutchmates, Across the Isles, You Know How to Reach Me, Que Zara(lek) Zara(lek), Dream On, Now THIS is Dragon Racing! Reward: Good Boy's Leash (Taivan mount).",
    },
    
    -- Children achievements with criteria
    
    -- Achievement 16343: Vault of the Incarnates (raid)
    [16343] = {
        helpText = "Defeat all 8 bosses in Vault of the Incarnates on any difficulty. Raid entrance in Thaldraszus (Dragon Isles). Bosses: Eranog, Terros, The Primal Council, Sennarth, Dathea, Kurog Grimtotem, Broodkeeper Diurna, Raszageth the Storm-Eater.",
        criteria = {
            [55109] = {
                helpText = "Eranog",
                waypoints = {}
            },
            [55110] = {
                helpText = "",
                waypoints = {}
            },
            [55111] = {
                helpText = "",
                waypoints = {}
            },
            [55113] = {
                helpText = "",
                waypoints = {}
            },
            [55114] = {
                helpText = "",
                waypoints = {}
            },
            [55115] = {
                helpText = "",
                waypoints = {}
            },
            [55116] = {
                helpText = "",
                waypoints = {}
            },
            [55117] = {
                helpText = "",
                waypoints = {}
            },
        }
    },
    
    -- Achievement 18160: Aberrus, the Shadowed Crucible (raid)
    [18160] = {
        helpText = "Defeat all 9 bosses in Aberrus, the Shadowed Crucible on any difficulty. Raid entrance in Zaralek Cavern. Bosses: Kazzara, The Amalgamation Chamber, Assault of the Zaqali, Rashok, The Vigilant Steward, Magmorax, Echo of Neltharion, Scalecommander Sarkareth.",
        waypoints = {
            { mapId = MapZones.DF_ZONE_ZaralekCavern, x = 48.47, y = 10.36, title = "Aberrus, the Shadowed Crucible entrance" },
        },
        criteria = {
            [58866] = {
                helpText = "",
                waypoints = {}
            },
            [58867] = {
                helpText = "",
                waypoints = {}
            },
            [58868] = {
                helpText = "",
                waypoints = {}
            },
            [58869] = {
                helpText = "",
                waypoints = {}
            },
            [58870] = {
                helpText = "",
                waypoints = {}
            },
            [58871] = {
                helpText = "",
                waypoints = {}
            },
            [58881] = {
                helpText = "",
                waypoints = {}
            },
            [58882] = {
                helpText = "",
                waypoints = {}
            },
            [58883] = {
                helpText = "",
                waypoints = {}
            },
        }
    },
    
    -- Achievement 19331: Amirdrassil, the Dream's Hope (raid)
    [19331] = {
        helpText = "Defeat all 9 bosses in Amirdrassil, the Dream's Hope on any difficulty. Raid entrance in the Emerald Dream. Bosses: Gnarlroot, Igira the Cruel, Volcoross, Larodar, Council of Dreams, Nymue, Smolderon, Tindral Sageswift, Fyrakk the Blazing.",
        waypoints = {
            { mapId = MapZones.DF_ZONE_EmeraldDream, x = 27.30, y = 31.04, title = "Amirdrassil, the Dream's Hope entrance" },
        },
        criteria = {
            [63095] = {
                helpText = "",
                waypoints = {}
            },
            [63096] = {
                helpText = "",
                waypoints = {}
            },
            [63097] = {
                helpText = "",
                waypoints = {}
            },
            [63098] = {
                helpText = "",
                waypoints = {}
            },
            [63099] = {
                helpText = "",
                waypoints = {}
            },
            [63100] = {
                helpText = "",
                waypoints = {}
            },
            [63101] = {
                helpText = "",
                waypoints = {}
            },
            [63102] = {
                helpText = "",
                waypoints = {}
            },
            [63103] = {
                helpText = "",
                waypoints = {}
            },
        }
    },
    
    -- Achievement 16339: Myths of the Dragonflight Dungeons (meta)
    [16339] = {
        helpText = "Complete all 8 Dragonflight dungeons on Mythic or Mythic+ difficulty: Algeth'ar Academy, Halls of Infusion, Ruby Life Pools, The Nokhud Offensive, Brackenhide Hollow, Neltharus, The Azure Vault, Uldaman: Legacy of Tyr.",
        -- Children: 16271, 16257, 16262, 16265, 16268, 16274, 16277, 16280
    },
    
    -- Mythic: Brackenhide Hollow (16257) - Children of 16339
    [16257] = {
        helpText = "Defeat Decatriarch Wratheye in Brackenhide Hollow on Mythic or Mythic+ difficulty. Entrance in Iskaara, Azure Span.",
        waypoints = {
            { mapId = MapZones.DF_ZONE_TheAzureSpan, x = 11.57, y = 48.78, title = "Brackenhide Hollow entrance" },
        },
    },
    -- Mythic: Neltharus (16265) - Children of 16339
    [16265] = {
        helpText = "Complete Neltharus on Mythic or Mythic+ difficulty. Entrance at Obsidian Citadel, Waking Shores.",
        waypoints = {
            { mapId = MapZones.DF_ZONE_TheWakingShores, x = 25.57, y = 56.95, title = "Neltharus entrance" },
        },
    },
    -- Mythic: The Azure Vault (16277) - Children of 16339
    [16277] = {
        helpText = "Complete The Azure Vault on Mythic or Mythic+ difficulty. Entrance in Azure Archives, Azure Span.",
        waypoints = {
            { mapId = MapZones.DF_ZONE_TheAzureSpan, x = 38.89, y = 64.76, title = "The Azure Vault entrance" },
        },
    },
    -- Mythic: Uldaman: Legacy of Tyr (16280) - Children of 16339
    [16280] = {
        helpText = "Complete Uldaman: Legacy of Tyr on Mythic or Mythic+ difficulty. Entrance in the Badlands (upper path).",
        waypoints = {
            { mapId = MapZones.WOW_ZONE_Badlands, x = 41.10, y = 10.33, title = "Uldaman: Legacy of Tyr entrance" },
        },
    },
    
    -- Achievement 16585: Dragon Isles Pathfinder
    [16585] = {
        helpText = "Complete Dragon Isles exploration and Pathfinder achievements. Unlocks Dragonriding in the Dragon Isles. Requires: Explore the Dragon Isles, Loremaster of the Dragon Isles, Oh My God They Were Clutchmates, and Friend of the Dragon Isles.",
        -- Children: 16334, 16401, 15394, 16405, 16336, 16428, 16363, 16398
    },
    
    -- Explore the Dragon Isles (16334)
    [16334] = {
        helpText = "Discover all areas in the Dragon Isles. Explore Waking Shores, Ohn'ahran Plains, Azure Span, and Thaldraszus.",
        criteria = {
            -- Criteria IDs are 0 (placeholder), add actual IDs if known
        }
    },
    
    -- Mythic: Algeth'ar Academy (16401)
    [16401] = {
        helpText = "Complete Algeth'ar Academy on Mythic or Mythic+ difficulty. Dungeon in Thaldraszus.",
        criteria = {
            [55229] = {
                helpText = "",
                waypoints = {}
            },
            [55243] = {
                helpText = "",
                waypoints = {}
            },
            [55227] = {
                helpText = "",
                waypoints = {}
            },
            [55241] = {
                helpText = "",
                waypoints = {}
            },
            [55242] = {
                helpText = "",
                waypoints = {}
            },
        }
    },
    
    -- Mythic: Halls of Infusion (16405)
    [16405] = {
        helpText = "Complete Halls of Infusion on Mythic or Mythic+ difficulty. Dungeon in Tyrhold, Thaldraszus.",
        waypoints = {
            { mapId = MapZones.DF_ZONE_Thaldraszus, x = 59.24, y = 60.64, title = "Halls of Infusion entrance" },
        },
        criteria = {
            [55230] = {
                helpText = "",
                waypoints = {}
            },
            [55231] = {
                helpText = "",
                waypoints = {}
            },
            [55232] = {
                helpText = "",
                waypoints = {}
            },
            [55233] = {
                helpText = "",
                waypoints = {}
            },
            [55235] = {
                helpText = "",
                waypoints = {}
            },
            [55236] = {
                helpText = "",
                waypoints = {}
            },
            [55238] = {
                helpText = "",
                waypoints = {}
            },
            [55240] = {
                helpText = "",
                waypoints = {}
            },
        }
    },
    
    -- Mythic: Ruby Life Pools (16428)
    [16428] = {
        helpText = "Complete Ruby Life Pools on Mythic or Mythic+ difficulty. Dungeon in Waking Shores.",
        criteria = {
            [55335] = {
                helpText = "",
                waypoints = {}
            },
            [55336] = {
                helpText = "",
                waypoints = {}
            },
            [55337] = {
                helpText = "",
                waypoints = {}
            },
            [55338] = {
                helpText = "",
                waypoints = {}
            },
            [55339] = {
                helpText = "",
                waypoints = {}
            },
            [55340] = {
                helpText = "",
                waypoints = {}
            },
            [55341] = {
                helpText = "",
                waypoints = {}
            },
            [55342] = {
                helpText = "",
                waypoints = {}
            },
            [55343] = {
                helpText = "",
                waypoints = {}
            },
            [55344] = {
                helpText = "",
                waypoints = {}
            },
            [55345] = {
                helpText = "",
                waypoints = {}
            },
            [55346] = {
                helpText = "",
                waypoints = {}
            },
        }
    },
    
    -- Mythic: The Nokhud Offensive (16398)
    [16398] = {
        helpText = "Complete The Nokhud Offensive on Mythic or Mythic+ difficulty. Dungeon in Ohn'ahran Plains (Maruukai).",
        waypoints = {
            { mapId = MapZones.DF_ZONE_OhnahranPlains, x = 62.01, y = 42.44, title = "The Nokhud Offensive entrance" },
        },
        criteria = {
            [55213] = {
                helpText = "",
                waypoints = {}
            },
            [55214] = {
                helpText = "",
                waypoints = {}
            },
            [55215] = {
                helpText = "",
                waypoints = {}
            },
            [55216] = {
                helpText = "",
                waypoints = {}
            },
            [55217] = {
                helpText = "",
                waypoints = {}
            },
            [55218] = {
                helpText = "",
                waypoints = {}
            },
            [55219] = {
                helpText = "",
                waypoints = {}
            },
            [55220] = {
                helpText = "",
                waypoints = {}
            },
        }
    },
    
    -- Achievement 16808: You Know How to Reach Me (Forbidden Reach)
    [16808] = {
        helpText = "Complete exploration and activities in the Forbidden Reach. Part of A World Awoken. The Forbidden Reach is the dracthyr starting zone, accessible from the Dragon Isles.",
        criteria = {
            [57032] = {
                helpText = "",
                waypoints = {}
            },
            [57033] = {
                helpText = "",
                waypoints = {}
            },
            [57035] = {
                helpText = "",
                waypoints = {}
            },
            [57036] = {
                helpText = "",
                waypoints = {}
            },
            [57034] = {
                helpText = "",
                waypoints = {}
            },
            [57037] = {
                helpText = "",
                waypoints = {}
            },
        }
    },
    
    -- Achievement 19463: Dragon Quests
    [19463] = {
        helpText = "Complete Dragonflight campaign quest achievements: A Blue Dawn, Of the Tyr's Guard, In Tyr's Footsteps, Active Listening Skills, A New Beginning, Fringe Benefits. Quest through all Dragon Isles zones.",
        -- Children: 17773, 17734, 18958, 17546, 16683, 19507
    },
    
    -- A Blue Dawn (17773) - Dragon Quests child
    [17773] = {
        helpText = "Complete the A Blue Dawn quest line in the Waking Shores.",
    },
    
    -- Friend of the Dragon Isles (17734)
    [17734] = {
        helpText = "Reach Best Friends with Valdrakken Accord. Earn Renown through quests, world quests, and activities in Thaldraszus.",
        criteria = {
            [59094] = {
                helpText = "",
                waypoints = {}
            },
        }
    },
    
    -- In Tyr's Footsteps (18958) - Dragon Quests child
    [18958] = {
        helpText = "Complete the In Tyr's Footsteps quest line.",
    },
    
    -- Of the Tyr's Guard (17546) - Dragon Quests child
    [17546] = {
        helpText = "Complete the Of the Tyr's Guard quest line.",
    },
    
    -- Active Listening Skills (16683) - Dragon Quests child
    [16683] = {
        helpText = "Complete the Active Listening Skills achievement. Listen to dialogue across Dragon Isles campaign.",
    },
    
    -- Fringe Benefits (19507) - Dragon Quests child
    [19507] = {
        helpText = "Complete the Fringe Benefits questline. Part of Dragon Quests meta.",
        criteria = {
            [64642] = { helpText = "", waypoints = {} },
            [64643] = { helpText = "", waypoints = {} },
            [64644] = { helpText = "", waypoints = {} },
            [64645] = { helpText = "", waypoints = {} },
            [64646] = { helpText = "", waypoints = {} },
            [64647] = { helpText = "", waypoints = {} },
            [64648] = { helpText = "", waypoints = {} },
            [64649] = { helpText = "", waypoints = {} },
            [64650] = { helpText = "", waypoints = {} },
            [64651] = { helpText = "", waypoints = {} },
            [64654] = { helpText = "", waypoints = {} },
            [60757] = { helpText = "", waypoints = {} },
            [64657] = { helpText = "", waypoints = {} },
            [64658] = { helpText = "", waypoints = {} },
            [64659] = { helpText = "", waypoints = {} },
            [64660] = { helpText = "", waypoints = {} },
        }
    },
    
    -- Achievement 19466: Oh My God, They Were Clutchmates
    [19466] = {
        helpText = "Reach Best Friends with all 4 main Dragon Isles factions: Valdrakken Accord, Maruuk Centaur, Iskaara Tuskarr, and Dragonscale Expedition. Farm daily quests, world quests, and Renown to max.",
        -- Children: 41174, 41180, 41181, 41182, 41183, 41177, 18615, 16494, 16760, 16539, 16537, 17427
    },
    
    -- Valdrakken Accord Best Friends (41174)
    [41174] = {
        helpText = "Reach Best Friends (Renown 25) with Valdrakken Accord. Complete Thaldraszus quests and activities.",
        criteria = {
            [71186] = { helpText = "", waypoints = {} },
        }
    },
    [41180] = {
        helpText = "Reach Best Friends with Maruuk Centaur. Complete Ohn'ahran Plains activities.",
        criteria = {
            [71187] = { helpText = "", waypoints = {} },
        }
    },
    [41181] = {
        helpText = "Reach Best Friends with Iskaara Tuskarr. Complete Azure Span and Iskaara activities.",
        criteria = {
            [71185] = { helpText = "", waypoints = {} },
        }
    },
    [41182] = {
        helpText = "Reach Best Friends with Dragonscale Expedition. Complete Waking Shores and expedition activities.",
        criteria = {
            [71184] = { helpText = "", waypoints = {} },
        }
    },
    [41183] = {
        helpText = "Reach Best Friends with another Dragon Isles faction. Part of Oh My God They Were Clutchmates.",
        criteria = {
            [71183] = { helpText = "", waypoints = {} },
        }
    },
    [41177] = {
        helpText = "Reach Best Friends with a Dragon Isles faction. Part of Oh My God They Were Clutchmates.",
        criteria = {
            [71182] = { helpText = "", waypoints = {} },
        }
    },
    [17427] = {
        helpText = "Reach Best Friends with a Dragon Isles faction. Part of Oh My God They Were Clutchmates.",
        criteria = {
            [58373] = { helpText = "", waypoints = {} },
        }
    },
    
    -- Achievement 19307: Dragon Isles Pathfinder (Part 2 / 10.2)
    [19307] = {
        helpText = "Complete zone campaigns and exploration: Waking Hope (Waking Shores), Azure Spanner (Azure Span), Ohn'a'Roll (Ohn'ahran Plains), Just Don't Ask Me to Spell It (Thaldraszus), Embers of Neltharion (Zaralek Cavern), Dragon Isles Explorer, Explore Emerald Dream, Explore Zaralek Cavern. Unlocks regular flying in Dragon Isles.",
        -- Children: 16334, 15394, 16336, 16363, 17739, 16761, 17766, 19309
    },
    
    -- Zone campaigns / Dragon Isles Explorer (16761)
    [16761] = {
        helpText = "Complete zone campaign achievements for Waking Shores, Ohn'ahran Plains, Azure Span, and Thaldraszus. Part of Dragon Isles Pathfinder.",
        -- Children: 16400, 16457, 16460, 16518
    },
    
    -- Waking Hope / Waking Shores (16400)
    [16400] = {
        helpText = "Complete the Waking Shores zone campaign. Discover all areas and complete the main storyline.",
        criteria = {
            [55875] = { helpText = "", waypoints = {} },
            [55876] = { helpText = "", waypoints = {} },
            [55878] = { helpText = "", waypoints = {} },
            [55879] = { helpText = "", waypoints = {} },
            [55880] = { helpText = "", waypoints = {} },
            [55881] = { helpText = "", waypoints = {} },
            [55882] = { helpText = "", waypoints = {} },
            [55883] = { helpText = "", waypoints = {} },
            [55884] = { helpText = "", waypoints = {} },
            [55885] = { helpText = "", waypoints = {} },
            [55886] = { helpText = "", waypoints = {} },
            [55877] = { helpText = "", waypoints = {} },
        }
    },
    
    -- Ohn'a'Roll / Ohn'ahran Plains (16457)
    [16457] = {
        helpText = "Complete the Ohn'ahran Plains zone campaign. Part of Dragon Isles Pathfinder.",
        criteria = {
            [55434] = { helpText = "", waypoints = {} },
            [55435] = { helpText = "", waypoints = {} },
            [55436] = { helpText = "", waypoints = {} },
            [55437] = { helpText = "", waypoints = {} },
            [55438] = { helpText = "", waypoints = {} },
            [55439] = { helpText = "", waypoints = {} },
            [55440] = { helpText = "", waypoints = {} },
            [55441] = { helpText = "", waypoints = {} },
            [55442] = { helpText = "", waypoints = {} },
            [55443] = { helpText = "", waypoints = {} },
            [55444] = { helpText = "", waypoints = {} },
            [55445] = { helpText = "", waypoints = {} },
        }
    },
    
    -- Azure Spanner / Azure Span (16460)
    [16460] = {
        helpText = "Complete the Azure Span zone campaign. Part of Dragon Isles Pathfinder.",
        criteria = {
            [55450] = { helpText = "", waypoints = {} },
            [55451] = { helpText = "", waypoints = {} },
            [55452] = { helpText = "", waypoints = {} },
            [55453] = { helpText = "", waypoints = {} },
            [55454] = { helpText = "", waypoints = {} },
            [55455] = { helpText = "", waypoints = {} },
            [55456] = { helpText = "", waypoints = {} },
            [55457] = { helpText = "", waypoints = {} },
            [55458] = { helpText = "", waypoints = {} },
            [55459] = { helpText = "", waypoints = {} },
            [55460] = { helpText = "", waypoints = {} },
        }
    },
    
    -- Just Don't Ask Me to Spell It / Thaldraszus (16518)
    [16518] = {
        helpText = "Complete the Thaldraszus zone campaign. Part of Dragon Isles Pathfinder.",
        criteria = {
            [55635] = { helpText = "", waypoints = {} },
            [55636] = { helpText = "", waypoints = {} },
            [55637] = { helpText = "", waypoints = {} },
            [55638] = { helpText = "", waypoints = {} },
            [55639] = { helpText = "", waypoints = {} },
            [55640] = { helpText = "", waypoints = {} },
            [55641] = { helpText = "", waypoints = {} },
            [55643] = { helpText = "", waypoints = {} },
        }
    },
    
    [17766] = {
        helpText = "Complete the Zaralek Cavern campaign. Unlock by completing the Embers of Neltharion storyline.",
        criteria = {
            [59159] = { helpText = "", waypoints = {} },
            [59160] = { helpText = "", waypoints = {} },
            [59161] = { helpText = "", waypoints = {} },
            [59162] = { helpText = "", waypoints = {} },
            [59163] = { helpText = "", waypoints = {} },
            [59165] = { helpText = "", waypoints = {} },
            [59166] = { helpText = "", waypoints = {} },
            [59167] = { helpText = "", waypoints = {} },
        }
    },
    
    -- Explore Zaralek Cavern (19309)
    [19309] = {
        helpText = "Discover all areas in Zaralek Cavern. Access via the cave entrance in Ohn'ahran Plains or Valdrakken.",
        criteria = {
            [63051] = { helpText = "", waypoints = {} },
            [63052] = { helpText = "", waypoints = {} },
            [63053] = { helpText = "", waypoints = {} },
            [63054] = { helpText = "", waypoints = {} },
            [63055] = { helpText = "", waypoints = {} },
            [63056] = { helpText = "", waypoints = {} },
            [63057] = { helpText = "", waypoints = {} },
            [63058] = { helpText = "", waypoints = {} },
            [63059] = { helpText = "", waypoints = {} },
            [63060] = { helpText = "", waypoints = {} },
        }
    },
    
    -- Achievement 19486
    -- Achievement 19486: Across the Isles
    [19486] = {
        helpText = "Complete 9 achievements across Dragon Isles: Army of the Fed, Centaur of Attention, Flight Club, Wake Me Up, Into the Storm, Closing Time, Dream Shaper, Nothing Stops the Research, Through the Ashes and Flames. Reward: Stormtouched Bruffalon mount.",
        -- Children: 19479
    },
    
    -- Dream On / Emerald Dream meta (19479)
    [19479] = {
        helpText = "Complete Emerald Dream achievements. Part of Across the Isles. Includes exploration and zone activities.",
        -- Children: 16570, 16568, 16587, 16588, 15890, 16571, 16676, 16297
    },
    
    -- Explore Waking Shores (16570)
    [16570] = {
        helpText = "Discover all exploration areas in Waking Shores.",
        criteria = {
            [55758] = { helpText = "", waypoints = {} },
            [55759] = { helpText = "", waypoints = {} },
            [55771] = { helpText = "", waypoints = {} },
            [55772] = { helpText = "", waypoints = {} },
            [55773] = { helpText = "", waypoints = {} },
            [55774] = { helpText = "", waypoints = {} },
            [55775] = { helpText = "", waypoints = {} },
        }
    },
    
    [16568] = {
        helpText = "Discover exploration areas. Part of Dragon Isles exploration.",
        criteria = {
            [55756] = { helpText = "", waypoints = {} },
        }
    },
    
    -- Explore Emerald Dream (16676)
    [16676] = {
        helpText = "Discover all areas in the Emerald Dream. Access via the portal in Valdrakken.",
        criteria = {
            [56033] = { helpText = "", waypoints = {} },
            [56034] = { helpText = "", waypoints = {} },
            [56035] = { helpText = "", waypoints = {} },
            [56036] = { helpText = "", waypoints = {} },
            [56037] = { helpText = "", waypoints = {} },
            [56038] = { helpText = "", waypoints = {} },
            [56039] = { helpText = "", waypoints = {} },
            [56040] = { helpText = "", waypoints = {} },
            [56041] = { helpText = "", waypoints = {} },
            [56042] = { helpText = "", waypoints = {} },
            [56043] = { helpText = "", waypoints = {} },
            [56044] = { helpText = "", waypoints = {} },
            [56045] = { helpText = "", waypoints = {} },
            [56046] = { helpText = "", waypoints = {} },
            [56047] = { helpText = "", waypoints = {} },
            [56048] = { helpText = "", waypoints = {} },
            [56049] = { helpText = "", waypoints = {} },
            [56050] = { helpText = "", waypoints = {} },
            [56052] = { helpText = "", waypoints = {} },
            [56053] = { helpText = "", waypoints = {} },
            [56054] = { helpText = "", waypoints = {} },
            [56055] = { helpText = "", waypoints = {} },
            [56056] = { helpText = "", waypoints = {} },
            [56057] = { helpText = "", waypoints = {} },
            [56058] = { helpText = "", waypoints = {} },
            [56059] = { helpText = "", waypoints = {} },
            [56060] = { helpText = "", waypoints = {} },
            [56061] = { helpText = "", waypoints = {} },
            [56081] = { helpText = "", waypoints = {} },
            [56082] = { helpText = "", waypoints = {} },
            [56083] = { helpText = "", waypoints = {} },
            [56084] = { helpText = "", waypoints = {} },
            [56085] = { helpText = "", waypoints = {} },
            [56086] = { helpText = "", waypoints = {} },
            [56087] = { helpText = "", waypoints = {} },
            [56088] = { helpText = "", waypoints = {} },
            [56089] = { helpText = "", waypoints = {} },
            [56090] = { helpText = "", waypoints = {} },
            [56091] = { helpText = "", waypoints = {} },
            [56092] = { helpText = "", waypoints = {} },
            [56093] = { helpText = "", waypoints = {} },
            [56094] = { helpText = "", waypoints = {} },
            [56095] = { helpText = "", waypoints = {} },
            [56096] = { helpText = "", waypoints = {} },
            [56988] = { helpText = "", waypoints = {} },
            [56989] = { helpText = "", waypoints = {} },
            [57003] = { helpText = "", waypoints = {} },
        }
    },
    
    [16297] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [54698] = { helpText = "", waypoints = {} },
            [54699] = { helpText = "", waypoints = {} },
            [54713] = { helpText = "", waypoints = {} },
            [54701] = { helpText = "", waypoints = {} },
            [54702] = { helpText = "", waypoints = {} },
            [54703] = { helpText = "", waypoints = {} },
            [55403] = { helpText = "", waypoints = {} },
            [55448] = { helpText = "", waypoints = {} },
        }
    },
    
    -- Achievement 19481
    [19481] = {
        helpText = "Complete Emerald Dream or Across the Isles sub-achievement.",
        -- Children: 16540, 16541, 16545, 16542, 16543, 16424, 16677, 16299
    },
    
    [16540] = {
        helpText = "Explore areas in the Emerald Dream. Part of Dream On meta.",
        criteria = {
            [55677] = { helpText = "", waypoints = {} },
            [55678] = { helpText = "", waypoints = {} },
            [55679] = { helpText = "", waypoints = {} },
            [55680] = { helpText = "", waypoints = {} },
            [55681] = { helpText = "", waypoints = {} },
            [55682] = { helpText = "", waypoints = {} },
            [55683] = { helpText = "", waypoints = {} },
            [55684] = { helpText = "", waypoints = {} },
            [55685] = { helpText = "", waypoints = {} },
            [55686] = { helpText = "", waypoints = {} },
            [55687] = { helpText = "", waypoints = {} },
        }
    },
    
    [16542] = {
        helpText = "Explore areas in the Emerald Dream. Part of Dream On meta.",
        criteria = {
            [55692] = { helpText = "", waypoints = {} },
            [55693] = { helpText = "", waypoints = {} },
            [55694] = { helpText = "", waypoints = {} },
            [55695] = { helpText = "", waypoints = {} },
            [55696] = { helpText = "", waypoints = {} },
            [55697] = { helpText = "", waypoints = {} },
            [55698] = { helpText = "", waypoints = {} },
            [55699] = { helpText = "", waypoints = {} },
            [55700] = { helpText = "", waypoints = {} },
            [55701] = { helpText = "", waypoints = {} },
            [55702] = { helpText = "", waypoints = {} },
        }
    },
    
    [16543] = {
        helpText = "Explore areas in the Emerald Dream. Part of Dream On meta.",
        criteria = {
            [55746] = { helpText = "", waypoints = {} },
            [55747] = { helpText = "", waypoints = {} },
            [55748] = { helpText = "", waypoints = {} },
            [55749] = { helpText = "", waypoints = {} },
            [55750] = { helpText = "", waypoints = {} },
            [55751] = { helpText = "", waypoints = {} },
            [55752] = { helpText = "", waypoints = {} },
            [55753] = { helpText = "", waypoints = {} },
            [55754] = { helpText = "", waypoints = {} },
        }
    },
    
    [16541] = {
        helpText = "Emerald Dream exploration. Part of Dream On (19481).",
    },
    
    [16545] = {
        helpText = "Emerald Dream exploration. Part of Dream On (19481).",
    },
    
    [16424] = {
        helpText = "Complete Dragonflight zone content. Part of A World Awoken.",
        criteria = {
            [55348] = { helpText = "", waypoints = {} },
            [55316] = { helpText = "", waypoints = {} },
            [55329] = { helpText = "", waypoints = {} },
            [55326] = { helpText = "", waypoints = {} },
            [55317] = { helpText = "", waypoints = {} },
            [55321] = { helpText = "", waypoints = {} },
            [55315] = { helpText = "", waypoints = {} },
            [55320] = { helpText = "", waypoints = {} },
            [55327] = { helpText = "", waypoints = {} },
            [55323] = { helpText = "", waypoints = {} },
            [55331] = { helpText = "", waypoints = {} },
            [55328] = { helpText = "", waypoints = {} },
            [55319] = { helpText = "", waypoints = {} },
            [55330] = { helpText = "", waypoints = {} },
            [55347] = { helpText = "", waypoints = {} },
            [55325] = { helpText = "", waypoints = {} },
            [55318] = { helpText = "", waypoints = {} },
            [55322] = { helpText = "", waypoints = {} },
            [55324] = { helpText = "", waypoints = {} },
            [55314] = { helpText = "", waypoints = {} },
        }
    },
    
    [16677] = {
        helpText = "Explore the Emerald Dream. Part of Dream On meta.",
        criteria = {
            [56062] = { helpText = "", waypoints = {} },
            [56063] = { helpText = "", waypoints = {} },
            [56064] = { helpText = "", waypoints = {} },
            [56065] = { helpText = "", waypoints = {} },
            [56066] = { helpText = "", waypoints = {} },
            [56067] = { helpText = "", waypoints = {} },
            [56068] = { helpText = "", waypoints = {} },
            [56069] = { helpText = "", waypoints = {} },
            [56070] = { helpText = "", waypoints = {} },
            [56071] = { helpText = "", waypoints = {} },
            [56072] = { helpText = "", waypoints = {} },
            [56073] = { helpText = "", waypoints = {} },
            [56074] = { helpText = "", waypoints = {} },
            [56075] = { helpText = "", waypoints = {} },
            [56076] = { helpText = "", waypoints = {} },
            [56077] = { helpText = "", waypoints = {} },
            [56078] = { helpText = "", waypoints = {} },
            [56079] = { helpText = "", waypoints = {} },
            [56080] = { helpText = "", waypoints = {} },
            [56081] = { helpText = "", waypoints = {} },
            [56082] = { helpText = "", waypoints = {} },
            [56083] = { helpText = "", waypoints = {} },
            [56084] = { helpText = "", waypoints = {} },
            [56085] = { helpText = "", waypoints = {} },
            [56086] = { helpText = "", waypoints = {} },
            [56087] = { helpText = "", waypoints = {} },
            [56088] = { helpText = "", waypoints = {} },
            [56089] = { helpText = "", waypoints = {} },
            [56090] = { helpText = "", waypoints = {} },
            [56091] = { helpText = "", waypoints = {} },
            [56092] = { helpText = "", waypoints = {} },
            [56093] = { helpText = "", waypoints = {} },
            [56094] = { helpText = "", waypoints = {} },
            [56095] = { helpText = "", waypoints = {} },
            [56096] = { helpText = "", waypoints = {} },
        }
    },
    
    [16299] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [54707] = { helpText = "", waypoints = {} },
            [54708] = { helpText = "", waypoints = {} },
            [54700] = { helpText = "", waypoints = {} },
            [54709] = { helpText = "", waypoints = {} },
            [54710] = { helpText = "", waypoints = {} },
            [54711] = { helpText = "", waypoints = {} },
        }
    },
    
    -- Achievement 19482
    [19482] = {
        helpText = "Complete Emerald Dream or Across the Isles sub-achievement.",
        -- Children: 16443, 16444, 16317, 16553, 16563, 16580, 16678, 16300
    },
    
    [16443] = {
        helpText = "Complete Dragonflight zone or faction content. Part of A World Awoken.",
        criteria = {
            [55380] = { helpText = "", waypoints = {} },
        }
    },
    
    [16444] = {
        helpText = "Complete Dragonflight zone or faction content. Part of A World Awoken.",
        criteria = {
            [55381] = { helpText = "", waypoints = {} },
        }
    },
    
    [16317] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [54944] = { helpText = "", waypoints = {} },
            [55017] = { helpText = "", waypoints = {} },
            [55016] = { helpText = "", waypoints = {} },
        }
    },
    
    [16553] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [55710] = { helpText = "", waypoints = {} },
            [55711] = { helpText = "", waypoints = {} },
            [55712] = { helpText = "", waypoints = {} },
            [55713] = { helpText = "", waypoints = {} },
            [55023] = { helpText = "", waypoints = {} },
        }
    },
    
    [16563] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [55689] = { helpText = "", waypoints = {} },
        }
    },
    
    [16580] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [55822] = { helpText = "", waypoints = {} },
            [55823] = { helpText = "", waypoints = {} },
            [55824] = { helpText = "", waypoints = {} },
            [55825] = { helpText = "", waypoints = {} },
            [55826] = { helpText = "", waypoints = {} },
            [55827] = { helpText = "", waypoints = {} },
            [55828] = { helpText = "", waypoints = {} },
            [55829] = { helpText = "", waypoints = {} },
            [55830] = { helpText = "", waypoints = {} },
            [55831] = { helpText = "", waypoints = {} },
            [55832] = { helpText = "", waypoints = {} },
            [55833] = { helpText = "", waypoints = {} },
            [55834] = { helpText = "", waypoints = {} },
            [55835] = { helpText = "", waypoints = {} },
            [55836] = { helpText = "", waypoints = {} },
            [55837] = { helpText = "", waypoints = {} },
        }
    },
    
    [16678] = {
        helpText = "Complete Emerald Dream content. Part of Dream On meta.",
        criteria = {
            [56097] = { helpText = "", waypoints = {} },
            [56098] = { helpText = "", waypoints = {} },
            [56099] = { helpText = "", waypoints = {} },
            [56100] = { helpText = "", waypoints = {} },
            [56101] = { helpText = "", waypoints = {} },
            [56102] = { helpText = "", waypoints = {} },
            [56103] = { helpText = "", waypoints = {} },
            [56104] = { helpText = "", waypoints = {} },
            [56105] = { helpText = "", waypoints = {} },
            [56106] = { helpText = "", waypoints = {} },
            [56107] = { helpText = "", waypoints = {} },
            [56108] = { helpText = "", waypoints = {} },
            [56109] = { helpText = "", waypoints = {} },
            [56110] = { helpText = "", waypoints = {} },
            [56111] = { helpText = "", waypoints = {} },
            [56112] = { helpText = "", waypoints = {} },
            [56114] = { helpText = "", waypoints = {} },
            [56115] = { helpText = "", waypoints = {} },
            [56116] = { helpText = "", waypoints = {} },
            [56117] = { helpText = "", waypoints = {} },
            [56118] = { helpText = "", waypoints = {} },
            [56119] = { helpText = "", waypoints = {} },
            [56120] = { helpText = "", waypoints = {} },
            [56122] = { helpText = "", waypoints = {} },
            [56124] = { helpText = "", waypoints = {} },
            [56125] = { helpText = "", waypoints = {} },
            [56126] = { helpText = "", waypoints = {} },
            [56127] = { helpText = "", waypoints = {} },
            [56128] = { helpText = "", waypoints = {} },
            [56129] = { helpText = "", waypoints = {} },
            [56130] = { helpText = "", waypoints = {} },
        }
    },
    
    [16300] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [54804] = { helpText = "", waypoints = {} },
            [54805] = { helpText = "", waypoints = {} },
            [54806] = { helpText = "", waypoints = {} },
            [54807] = { helpText = "", waypoints = {} },
            [54808] = { helpText = "", waypoints = {} },
            [54809] = { helpText = "", waypoints = {} },
        }
    },
    
    -- Achievement 19483
    [19483] = {
        helpText = "",
        -- Children: 16411, 16410, 16412, 16497, 16495, 16496, 18384, 17782, 18383, 16679, 16301
    },
    
    [16410] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [55262] = { helpText = "", waypoints = {} },
        }
    },
    
    [16412] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [55264] = { helpText = "", waypoints = {} },
            [55266] = { helpText = "", waypoints = {} },
            [55265] = { helpText = "", waypoints = {} },
        }
    },
    
    [16497] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [55864] = { helpText = "", waypoints = {} },
            [57972] = { helpText = "", waypoints = {} },
        }
    },
    
    [16495] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [55865] = { helpText = "", waypoints = {} },
        }
    },
    
    [16496] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [57868] = { helpText = "", waypoints = {} },
            [56053] = { helpText = "", waypoints = {} },
            [56988] = { helpText = "", waypoints = {} },
            [56054] = { helpText = "", waypoints = {} },
        }
    },
    
    [18384] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [60132] = { helpText = "", waypoints = {} },
            [60133] = { helpText = "", waypoints = {} },
            [60134] = { helpText = "", waypoints = {} },
            [60135] = { helpText = "", waypoints = {} },
            [60136] = { helpText = "", waypoints = {} },
            [60137] = { helpText = "", waypoints = {} },
            [60138] = { helpText = "", waypoints = {} },
            [60139] = { helpText = "", waypoints = {} },
            [60140] = { helpText = "", waypoints = {} },
            [60141] = { helpText = "", waypoints = {} },
            [60142] = { helpText = "", waypoints = {} },
            [60143] = { helpText = "", waypoints = {} },
            [60144] = { helpText = "", waypoints = {} },
            [60145] = { helpText = "", waypoints = {} },
            [60146] = { helpText = "", waypoints = {} },
            [60147] = { helpText = "", waypoints = {} },
        }
    },
    
    [17782] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [59192] = { helpText = "", waypoints = {} },
            [59194] = { helpText = "", waypoints = {} },
            [59193] = { helpText = "", waypoints = {} },
            [59195] = { helpText = "", waypoints = {} },
            [59196] = { helpText = "", waypoints = {} },
        }
    },
    
    [18383] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [60127] = { helpText = "", waypoints = {} },
            [60128] = { helpText = "", waypoints = {} },
            [60129] = { helpText = "", waypoints = {} },
            [60130] = { helpText = "", waypoints = {} },
            [60131] = { helpText = "", waypoints = {} },
        }
    },
    
    [16679] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [56133] = { helpText = "", waypoints = {} },
            [56135] = { helpText = "", waypoints = {} },
            [56136] = { helpText = "", waypoints = {} },
            [56137] = { helpText = "", waypoints = {} },
            [56138] = { helpText = "", waypoints = {} },
            [56140] = { helpText = "", waypoints = {} },
            [56141] = { helpText = "", waypoints = {} },
            [56142] = { helpText = "", waypoints = {} },
            [56144] = { helpText = "", waypoints = {} },
            [56146] = { helpText = "", waypoints = {} },
            [56147] = { helpText = "", waypoints = {} },
            [56148] = { helpText = "", waypoints = {} },
            [56149] = { helpText = "", waypoints = {} },
            [56150] = { helpText = "", waypoints = {} },
            [56151] = { helpText = "", waypoints = {} },
            [56152] = { helpText = "", waypoints = {} },
            [56153] = { helpText = "", waypoints = {} },
            [56154] = { helpText = "", waypoints = {} },
            [56155] = { helpText = "", waypoints = {} },
            [56156] = { helpText = "", waypoints = {} },
            [56157] = { helpText = "", waypoints = {} },
            [56158] = { helpText = "", waypoints = {} },
        }
    },
    
    [16301] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [54810] = { helpText = "", waypoints = {} },
            [54811] = { helpText = "", waypoints = {} },
            [54812] = { helpText = "", waypoints = {} },
            [54813] = { helpText = "", waypoints = {} },
            [54814] = { helpText = "", waypoints = {} },
            [54815] = { helpText = "", waypoints = {} },
        }
    },
    
    -- Achievement 19485
    [19485] = {
        helpText = "",
        -- Children: 17342, 18635, 18637, 18636, 18638, 18639, 18640, 18641, 18703, 18704
    },
    
    [17342] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [57965] = { helpText = "", waypoints = {} },
            [57966] = { helpText = "", waypoints = {} },
        }
    },
    
    [18637] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [61885] = { helpText = "", waypoints = {} },
            [61884] = { helpText = "", waypoints = {} },
            [61886] = { helpText = "", waypoints = {} },
            [61887] = { helpText = "", waypoints = {} },
            [61888] = { helpText = "", waypoints = {} },
            [61889] = { helpText = "", waypoints = {} },
            [61890] = { helpText = "", waypoints = {} },
        }
    },
    
    [18636] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [60717] = { helpText = "", waypoints = {} },
        }
    },
    
    [18638] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [60718] = { helpText = "", waypoints = {} },
            [60719] = { helpText = "", waypoints = {} },
            [60751] = { helpText = "", waypoints = {} },
            [60720] = { helpText = "", waypoints = {} },
            [60721] = { helpText = "", waypoints = {} },
            [60722] = { helpText = "", waypoints = {} },
            [60723] = { helpText = "", waypoints = {} },
        }
    },
    
    [18640] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [60726] = { helpText = "", waypoints = {} },
            [60727] = { helpText = "", waypoints = {} },
            [60728] = { helpText = "", waypoints = {} },
            [60729] = { helpText = "", waypoints = {} },
            [60730] = { helpText = "", waypoints = {} },
            [60731] = { helpText = "", waypoints = {} },
        }
    },
    
    -- Achievement 16492
    [16492] = {
        helpText = "",
        -- Children: 16490
    },
    
    [16490] = {
        helpText = "",
        -- Children: 16468, 16476, 16484, 16489
    },
    
    [16468] = {
        helpText = "",
        -- Children: 16463, 16465, 16466, 16467
    },
    
    [16463] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [55483] = { helpText = "", waypoints = {} },
        }
    },
    
    [16465] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [55484] = { helpText = "", waypoints = {} },
        }
    },
    
    [16466] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [55494] = { helpText = "", waypoints = {} },
        }
    },
    
    [16467] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [55495] = { helpText = "", waypoints = {} },
        }
    },
    
    [16476] = {
        helpText = "",
        -- Children: 16475, 16477, 16478, 16479
    },
    
    [16475] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [55501] = { helpText = "", waypoints = {} },
        }
    },
    
    [16477] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [55502] = { helpText = "", waypoints = {} },
        }
    },
    
    [16478] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [55503] = { helpText = "", waypoints = {} },
        }
    },
    
    [16479] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [55504] = { helpText = "", waypoints = {} },
        }
    },
    
    [16484] = {
        helpText = "",
        -- Children: 16480, 16481, 16482, 16483
    },
    
    [16480] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [55509] = { helpText = "", waypoints = {} },
        }
    },
    
    [16481] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [55510] = { helpText = "", waypoints = {} },
        }
    },
    
    [16482] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [55511] = { helpText = "", waypoints = {} },
        }
    },
    
    [16483] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [55512] = { helpText = "", waypoints = {} },
        }
    },
    
    [16489] = {
        helpText = "",
        -- Children: 16485, 16486, 16487, 16488
    },
    
    [16485] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [55517] = { helpText = "", waypoints = {} },
        }
    },
    
    [16486] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [55518] = { helpText = "", waypoints = {} },
        }
    },
    
    [16487] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [55519] = { helpText = "", waypoints = {} },
        }
    },
    
    [16488] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [55520] = { helpText = "", waypoints = {} },
        }
    },
    
    [16461] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [55461] = { helpText = "", waypoints = {} },
            [55462] = { helpText = "", waypoints = {} },
            [55463] = { helpText = "", waypoints = {} },
            [55464] = { helpText = "", waypoints = {} },
            [55465] = { helpText = "", waypoints = {} },
            [55466] = { helpText = "", waypoints = {} },
            [55467] = { helpText = "", waypoints = {} },
            [55468] = { helpText = "", waypoints = {} },
            [55469] = { helpText = "", waypoints = {} },
            [55470] = { helpText = "", waypoints = {} },
            [55471] = { helpText = "", waypoints = {} },
            [55472] = { helpText = "", waypoints = {} },
            [55473] = { helpText = "", waypoints = {} },
            [55474] = { helpText = "", waypoints = {} },
            [55475] = { helpText = "", waypoints = {} },
            [55476] = { helpText = "", waypoints = {} },
            [55477] = { helpText = "", waypoints = {} },
            [55478] = { helpText = "", waypoints = {} },
        }
    },
    
    [16500] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [55531] = { helpText = "", waypoints = {} },
        }
    },
    
    [18209] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [59670] = { helpText = "", waypoints = {} },
        }
    },
    
    [18867] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [61623] = { helpText = "", waypoints = {} },
        }
    },
    
    [19008] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [62018] = { helpText = "", waypoints = {} },
        }
    },
    
    -- Achievement 17543
    [17543] = {
        helpText = "",
        -- Children: 17534, 17526, 17528, 17525, 17529, 17530, 17532, 17540, 17413, 17509, 17315
    },
    
    [17534] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [58510] = { helpText = "", waypoints = {} },
            [58511] = { helpText = "", waypoints = {} },
            [58512] = { helpText = "", waypoints = {} },
            [58513] = { helpText = "", waypoints = {} },
            [58514] = { helpText = "", waypoints = {} },
            [58515] = { helpText = "", waypoints = {} },
        }
    },
    
    [17526] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [58487] = { helpText = "", waypoints = {} },
            [58488] = { helpText = "", waypoints = {} },
            [58489] = { helpText = "", waypoints = {} },
            [58490] = { helpText = "", waypoints = {} },
            [58491] = { helpText = "", waypoints = {} },
            [58492] = { helpText = "", waypoints = {} },
            [58493] = { helpText = "", waypoints = {} },
            [58494] = { helpText = "", waypoints = {} },
            [58495] = { helpText = "", waypoints = {} },
            [58496] = { helpText = "", waypoints = {} },
            [58497] = { helpText = "", waypoints = {} },
            [58498] = { helpText = "", waypoints = {} },
        }
    },
    
    [17528] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [58499] = { helpText = "", waypoints = {} },
        }
    },
    
    [17525] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [58458] = { helpText = "", waypoints = {} },
            [58459] = { helpText = "", waypoints = {} },
            [58460] = { helpText = "", waypoints = {} },
            [58461] = { helpText = "", waypoints = {} },
            [58462] = { helpText = "", waypoints = {} },
            [58463] = { helpText = "", waypoints = {} },
            [58464] = { helpText = "", waypoints = {} },
            [58465] = { helpText = "", waypoints = {} },
            [58466] = { helpText = "", waypoints = {} },
            [58467] = { helpText = "", waypoints = {} },
            [58468] = { helpText = "", waypoints = {} },
            [58469] = { helpText = "", waypoints = {} },
            [58470] = { helpText = "", waypoints = {} },
            [58471] = { helpText = "", waypoints = {} },
            [58472] = { helpText = "", waypoints = {} },
            [58473] = { helpText = "", waypoints = {} },
            [58474] = { helpText = "", waypoints = {} },
            [58475] = { helpText = "", waypoints = {} },
            [58476] = { helpText = "", waypoints = {} },
            [58477] = { helpText = "", waypoints = {} },
            [58478] = { helpText = "", waypoints = {} },
            [58479] = { helpText = "", waypoints = {} },
            [58480] = { helpText = "", waypoints = {} },
            [58481] = { helpText = "", waypoints = {} },
            [58482] = { helpText = "", waypoints = {} },
            [58483] = { helpText = "", waypoints = {} },
            [58484] = { helpText = "", waypoints = {} },
            [58485] = { helpText = "", waypoints = {} },
            [58486] = { helpText = "", waypoints = {} },
            [58830] = { helpText = "", waypoints = {} },
        }
    },
    
    [17529] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [58500] = { helpText = "", waypoints = {} },
        }
    },
    
    [17530] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [58501] = { helpText = "", waypoints = {} },
            [58502] = { helpText = "", waypoints = {} },
            [58503] = { helpText = "", waypoints = {} },
            [58504] = { helpText = "", waypoints = {} },
            [58505] = { helpText = "", waypoints = {} },
            [58506] = { helpText = "", waypoints = {} },
            [58660] = { helpText = "", waypoints = {} },
            [58661] = { helpText = "", waypoints = {} },
            [58507] = { helpText = "", waypoints = {} },
        }
    },
    
    [17532] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [58508] = { helpText = "", waypoints = {} },
        }
    },
    
    [17540] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [58567] = { helpText = "", waypoints = {} },
            [58568] = { helpText = "", waypoints = {} },
            [58569] = { helpText = "", waypoints = {} },
            [58570] = { helpText = "", waypoints = {} },
        }
    },
    
    [17413] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [58209] = { helpText = "", waypoints = {} },
        }
    },
    
    -- Achievement 17785
    [17785] = {
        helpText = "",
        -- Children: 17739, 17783, 17781, 17766, 41183, 17786, 17832
    },
    
    [17783] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [59188] = { helpText = "", waypoints = {} },
            [59185] = { helpText = "", waypoints = {} },
            [59202] = { helpText = "", waypoints = {} },
            [59212] = { helpText = "", waypoints = {} },
            [59209] = { helpText = "", waypoints = {} },
            [59207] = { helpText = "", waypoints = {} },
            [59190] = { helpText = "", waypoints = {} },
            [59186] = { helpText = "", waypoints = {} },
            [59200] = { helpText = "", waypoints = {} },
            [59206] = { helpText = "", waypoints = {} },
            [59199] = { helpText = "", waypoints = {} },
            [59184] = { helpText = "", waypoints = {} },
            [59198] = { helpText = "", waypoints = {} },
            [59183] = { helpText = "", waypoints = {} },
            [59203] = { helpText = "", waypoints = {} },
            [59189] = { helpText = "", waypoints = {} },
            [59205] = { helpText = "", waypoints = {} },
            [59187] = { helpText = "", waypoints = {} },
            [59208] = { helpText = "", waypoints = {} },
            [59191] = { helpText = "", waypoints = {} },
            [59210] = { helpText = "", waypoints = {} },
        }
    },
    
    [17781] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [59179] = { helpText = "", waypoints = {} },
        }
    },
    
    [17786] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [59222] = { helpText = "", waypoints = {} },
            [59220] = { helpText = "", waypoints = {} },
            [59225] = { helpText = "", waypoints = {} },
            [59226] = { helpText = "", waypoints = {} },
            [59224] = { helpText = "", waypoints = {} },
            [59228] = { helpText = "", waypoints = {} },
            [59223] = { helpText = "", waypoints = {} },
            [59227] = { helpText = "", waypoints = {} },
            [59219] = { helpText = "", waypoints = {} },
        }
    },
    
    -- Achievement 19318
    [19318] = {
        helpText = "",
        -- Children: 19026, 19316, 19317, 19013, 19309, 19312
    },
    
    [19316] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [62929] = { helpText = "", waypoints = {} },
            [62930] = { helpText = "", waypoints = {} },
            [62931] = { helpText = "", waypoints = {} },
            [62932] = { helpText = "", waypoints = {} },
            [62933] = { helpText = "", waypoints = {} },
            [62934] = { helpText = "", waypoints = {} },
            [62935] = { helpText = "", waypoints = {} },
            [62936] = { helpText = "", waypoints = {} },
            [62937] = { helpText = "", waypoints = {} },
            [62938] = { helpText = "", waypoints = {} },
            [62939] = { helpText = "", waypoints = {} },
            [62940] = { helpText = "", waypoints = {} },
            [62941] = { helpText = "", waypoints = {} },
            [62942] = { helpText = "", waypoints = {} },
            [62943] = { helpText = "", waypoints = {} },
            [62944] = { helpText = "", waypoints = {} },
            [62945] = { helpText = "", waypoints = {} },
            [62947] = { helpText = "", waypoints = {} },
            [62948] = { helpText = "", waypoints = {} },
            [62949] = { helpText = "", waypoints = {} },
            [62950] = { helpText = "", waypoints = {} },
            [62951] = { helpText = "", waypoints = {} },
            [64492] = { helpText = "", waypoints = {} },
        }
    },
    
    [19317] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [62952] = { helpText = "", waypoints = {} },
            [62953] = { helpText = "", waypoints = {} },
            [62954] = { helpText = "", waypoints = {} },
            [62956] = { helpText = "", waypoints = {} },
            [62960] = { helpText = "", waypoints = {} },
            [62961] = { helpText = "", waypoints = {} },
            [62955] = { helpText = "", waypoints = {} },
            [62957] = { helpText = "", waypoints = {} },
            [62958] = { helpText = "", waypoints = {} },
            [62959] = { helpText = "", waypoints = {} },
        }
    },
    
    [19013] = {
        helpText = "Complete Dragonflight content. Part of A World Awoken.",
        criteria = {
            [62028] = { helpText = "", waypoints = {} },
            [62029] = { helpText = "", waypoints = {} },
            [62032] = { helpText = "", waypoints = {} },
            [62035] = { helpText = "", waypoints = {} },
            [62038] = { helpText = "", waypoints = {} },
            [62039] = { helpText = "", waypoints = {} },
            [62030] = { helpText = "", waypoints = {} },
            [62036] = { helpText = "", waypoints = {} },
            [62037] = { helpText = "", waypoints = {} },
            [62041] = { helpText = "", waypoints = {} },
            [62040] = { helpText = "", waypoints = {} },
            [62027] = { helpText = "", waypoints = {} },
            [62031] = { helpText = "", waypoints = {} },
            [62185] = { helpText = "", waypoints = {} },
            [62186] = { helpText = "", waypoints = {} },
            [62189] = { helpText = "", waypoints = {} },
            [62396] = { helpText = "", waypoints = {} },
            [62397] = { helpText = "", waypoints = {} },
        }
    },
    
    -- Achievement 19478
    [19478] = {
        helpText = "",
        -- Children: 15939, 17294, 17492, 19118, 16575, 16576, 16577, 16578, 17411, 18150, 19306
    },
    
    -- What a Long, Strange Trip It's Been (2144) - World events meta, rewards Violet Proto-Drake (mountId 267)
    [2144] = {
        helpText = "Complete all 8 world event meta achievements: To Honor One's Elders (Lunar Festival), Fool For Love (Love is in the Air), Noble Gardener (Noblegarden), For the Children (Children's Week), The Flame Keeper (Midsummer), Brewmaster (Brewfest), Hallowed Be Thy Name (Hallow's End), Merrymaker (Winter Veil). Reward: Violet Proto-Drake.",
    },
    [913] = {
        helpText = "To Honor One's Elders: Complete all Lunar Festival elder achievements. Visit elders in Eastern Kingdoms, Kalimdor, Northrend, Cataclysm zones, dungeons, and capital cities during Lunar Festival (event 327).",
    },
    [1693] = {
        helpText = "Fool For Love: Complete all Love is in the Air achievements (event 423): Shafted!, Lonely?, Dangerous Love, The Rocket's Pink Glare, Fistful of Love, Sweet Tooth, Be Mine!, My Love is Like a Red Red Rose, I Pitied The Fool.",
    },
    [2798] = {
        helpText = "Noble Gardener: Complete all Noblegarden achievements (event 181): I Found One!, Chocoholic, Desert Rose, Blushing Bride, Hard Boiled, Spring Fling, Noble Garden, Shake Your Bunny-Maker.",
    },
    [1793] = {
        helpText = "For the Children: Complete all Children's Week achievements (event 201): Home Alone, Bad Example, and other child-related objectives.",
    },
    [1039] = {
        helpText = "The Flame Keeper: Honor the flames of Kalimdor, Eastern Kingdoms, Outland, Northrend, and Cataclysm during Midsummer Fire Festival. Desecration of the Alliance is the Alliance equivalent.",
    },
    [1683] = {
        helpText = "Brewmaster: Complete all Brewfest achievements (event 372): The Brewfest Diet, Brew of the Month, Direbrewfest, Have Keg Will Travel, Does Your Wolpertinger Linger?.",
    },
    [1656] = {
        helpText = "Hallowed Be Thy Name: Complete all Hallow's End achievements (event 324): Trick or Treat!, Out With It, Don't Lose Your Head Man, The Savior of Hallow's End, That Sparkling Smile, Rotten Hallow, G.N.E.R.D. Rage, Check Your Head, The Masquerade, Sinister Calling, Tricks and Treats of Azeroth.",
    },
    [1691] = {
        helpText = "Merrymaker: Complete all Winter Veil achievements (event 141). Two are faction-specific: Scrooge (259 Horde / 1255 Alliance) and Holiday Bromance (1685 Horde / 1686 Alliance). Others: On Metzen!, With a Little Helper from My Friends, Fa-la-la-la-Ogri'la, 'Tis the Season, Simply Abominable, Let It Snow, The Winter Veil Gourmet, He Knows If You've Been Naughty, A Frosty Shake.",
    },
    
    -- A Farewell to Arms (40953): achievements from AFarewellToArms.lua
    -- A Farewell to Arms: achievement 11861
    [11861] = {
        helpText = "",
        criteria = {
            [36882] = { helpText = "", waypoints = {} },
            [40025] = { helpText = "", waypoints = {} },
            [38187] = { helpText = "", waypoints = {} },
            [38189] = { helpText = "", waypoints = {} },
            [37082] = { helpText = "", waypoints = {} },
            [38514] = { helpText = "", waypoints = {} },
            [36882] = { helpText = "", waypoints = {} },
            [40025] = { helpText = "", waypoints = {} },
            [38187] = { helpText = "", waypoints = {} },
            [38189] = { helpText = "", waypoints = {} },
            [37082] = { helpText = "", waypoints = {} },
            [38514] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 11868
    [11868] = {
        helpText = "",
        criteria = {
            [36955] = { helpText = "", waypoints = {} },
            [36956] = { helpText = "", waypoints = {} },
            [37971] = { helpText = "", waypoints = {} },
            [37970] = { helpText = "", waypoints = {} },
            [36957] = { helpText = "", waypoints = {} },
            [36958] = { helpText = "", waypoints = {} },
            [36979] = { helpText = "", waypoints = {} },
            [36978] = { helpText = "", waypoints = {} },
            [36955] = { helpText = "", waypoints = {} },
            [36956] = { helpText = "", waypoints = {} },
            [37971] = { helpText = "", waypoints = {} },
            [37970] = { helpText = "", waypoints = {} },
            [36957] = { helpText = "", waypoints = {} },
            [36958] = { helpText = "", waypoints = {} },
            [36979] = { helpText = "", waypoints = {} },
            [36978] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 12478
    [12478] = {
        helpText = "",
        criteria = {
            [40280] = { helpText = "", waypoints = {} },
            [40020] = { helpText = "", waypoints = {} },
            [40021] = { helpText = "", waypoints = {} },
            [40022] = { helpText = "", waypoints = {} },
            [40023] = { helpText = "", waypoints = {} },
            [40024] = { helpText = "", waypoints = {} },
            [40280] = { helpText = "", waypoints = {} },
            [40020] = { helpText = "", waypoints = {} },
            [40021] = { helpText = "", waypoints = {} },
            [40022] = { helpText = "", waypoints = {} },
            [40023] = { helpText = "", waypoints = {} },
            [40024] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 12479
    [12479] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 12480
    [12480] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 12481
    [12481] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 12482
    [12482] = {
        helpText = "",
        criteria = {
            [40037] = { helpText = "", waypoints = {} },
            [40041] = { helpText = "", waypoints = {} },
            [40045] = { helpText = "", waypoints = {} },
            [40038] = { helpText = "", waypoints = {} },
            [40042] = { helpText = "", waypoints = {} },
            [40046] = { helpText = "", waypoints = {} },
            [40039] = { helpText = "", waypoints = {} },
            [40043] = { helpText = "", waypoints = {} },
            [40047] = { helpText = "", waypoints = {} },
            [40040] = { helpText = "", waypoints = {} },
            [40044] = { helpText = "", waypoints = {} },
            [40048] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 12484
    [12484] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 12501
    [12501] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 12505
    [12505] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 12509
    [12509] = {
        helpText = "",
        criteria = {
            [40200] = { helpText = "", waypoints = {} },
            [40453] = { helpText = "", waypoints = {} },
            [40509] = { helpText = "", waypoints = {} },
            [40454] = { helpText = "", waypoints = {} },
            [40510] = { helpText = "", waypoints = {} },
            [40511] = { helpText = "", waypoints = {} },
            [40867] = { helpText = "", waypoints = {} },
            [40868] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 12521
    [12521] = {
        helpText = "",
        criteria = {
            [40246] = { helpText = "", waypoints = {} },
            [40247] = { helpText = "", waypoints = {} },
            [40223] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 12522
    [12522] = {
        helpText = "",
        criteria = {
            [40248] = { helpText = "", waypoints = {} },
            [40222] = { helpText = "", waypoints = {} },
            [40224] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 12523
    [12523] = {
        helpText = "",
        criteria = {
            [40220] = { helpText = "", waypoints = {} },
            [40221] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 12555
    [12555] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 12556
    [12556] = {
        helpText = "",
        criteria = {
            [41799] = { helpText = "", waypoints = {} },
            [41801] = { helpText = "", waypoints = {} },
            [41802] = { helpText = "", waypoints = {} },
            [41803] = { helpText = "", waypoints = {} },
            [41804] = { helpText = "", waypoints = {} },
            [41805] = { helpText = "", waypoints = {} },
            [41807] = { helpText = "", waypoints = {} },
            [41808] = { helpText = "", waypoints = {} },
            [41809] = { helpText = "", waypoints = {} },
            [41810] = { helpText = "", waypoints = {} },
            [41811] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 12557
    [12557] = {
        helpText = "",
        criteria = {
            [41685] = { helpText = "", waypoints = {} },
            [41686] = { helpText = "", waypoints = {} },
            [41687] = { helpText = "", waypoints = {} },
            [41688] = { helpText = "", waypoints = {} },
            [41689] = { helpText = "", waypoints = {} },
            [41690] = { helpText = "", waypoints = {} },
            [41691] = { helpText = "", waypoints = {} },
            [41692] = { helpText = "", waypoints = {} },
            [41693] = { helpText = "", waypoints = {} },
            [41694] = { helpText = "", waypoints = {} },
            [41695] = { helpText = "", waypoints = {} },
            [41696] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 12558
    [12558] = {
        helpText = "",
        criteria = {
            [40978] = { helpText = "", waypoints = {} },
            [40979] = { helpText = "", waypoints = {} },
            [40980] = { helpText = "", waypoints = {} },
            [40981] = { helpText = "", waypoints = {} },
            [40982] = { helpText = "", waypoints = {} },
            [40983] = { helpText = "", waypoints = {} },
            [40984] = { helpText = "", waypoints = {} },
            [40985] = { helpText = "", waypoints = {} },
            [40986] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 12559
    [12559] = {
        helpText = "",
        criteria = {
            [41731] = { helpText = "", waypoints = {} },
            [41734] = { helpText = "", waypoints = {} },
            [41735] = { helpText = "", waypoints = {} },
            [41737] = { helpText = "", waypoints = {} },
            [41738] = { helpText = "", waypoints = {} },
            [41740] = { helpText = "", waypoints = {} },
            [41741] = { helpText = "", waypoints = {} },
            [41743] = { helpText = "", waypoints = {} },
            [41744] = { helpText = "", waypoints = {} },
            [41746] = { helpText = "", waypoints = {} },
            [41747] = { helpText = "", waypoints = {} },
            [41749] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 12560
    [12560] = {
        helpText = "",
        criteria = {
            [41592] = { helpText = "", waypoints = {} },
            [41593] = { helpText = "", waypoints = {} },
            [41594] = { helpText = "", waypoints = {} },
            [41595] = { helpText = "", waypoints = {} },
            [41596] = { helpText = "", waypoints = {} },
            [41597] = { helpText = "", waypoints = {} },
            [41599] = { helpText = "", waypoints = {} },
            [41600] = { helpText = "", waypoints = {} },
            [41601] = { helpText = "", waypoints = {} },
            [41602] = { helpText = "", waypoints = {} },
            [41603] = { helpText = "", waypoints = {} },
            [41604] = { helpText = "", waypoints = {} },
            [41605] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 12561
    [12561] = {
        helpText = "",
        criteria = {
            [41526] = { helpText = "", waypoints = {} },
            [41527] = { helpText = "", waypoints = {} },
            [41528] = { helpText = "", waypoints = {} },
            [41530] = { helpText = "", waypoints = {} },
            [41534] = { helpText = "", waypoints = {} },
            [41531] = { helpText = "", waypoints = {} },
            [41529] = { helpText = "", waypoints = {} },
            [41532] = { helpText = "", waypoints = {} },
            [41533] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 12582
    [12582] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 12588
    [12588] = {
        helpText = "",
        criteria = {
            [40542] = { helpText = "", waypoints = {} },
            [40543] = { helpText = "", waypoints = {} },
            [40544] = { helpText = "", waypoints = {} },
            [40546] = { helpText = "", waypoints = {} },
            [40549] = { helpText = "", waypoints = {} },
            [40550] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 12591
    [12591] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 12593
    [12593] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 12595
    [12595] = {
        helpText = "",
        criteria = {
            [40563] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 12614 (Loa Expectations)
    [12614] = {
        helpText = "Loa Expectations: Have the following 6 Loa buffs cast on you in Zandalar: Boon of Gonk, Pa'ku, Akunda, Bwonsamdi, Kimbul, Krag'wa. Zandalari: use Embrace of the Loa at shrines in Dazar'alor. Non-Zandalari: obtain from world quests or Loa events.",
        criteria = {
            [40619] = { helpText = "Boon of Gonk - Shrine of Gonk (South, Dazar'alor)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Dazaralor, x = 50.3, y = 63.0, title = "Shrine of Gonk" } } } } },
            [40620] = { helpText = "Boon of Pa'ku - Shrine of Pa'ku (South, Dazar'alor)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Dazaralor, x = 49.3, y = 62.8, title = "Shrine of Pa'ku" } } } } },
            [40621] = { helpText = "Boon of Akunda - Shrine of Akunda (East, Dazar'alor)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Dazaralor, x = 58.3, y = 50.2, title = "Shrine of Akunda" } } } } },
            [40622] = { helpText = "Boon of Bwonsamdi - Shrine of Bwonsamdi (West, Dazar'alor)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Dazaralor, x = 41.6, y = 50.4, title = "Shrine of Bwonsamdi" } } } } },
            [40623] = { helpText = "Boon of Kimbul - Shrine of Kimbul (East, Dazar'alor)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Dazaralor, x = 57.0, y = 43.5, title = "Shrine of Kimbul" } } } } },
            [40624] = { helpText = "Boon of Krag'wa - Shrine of Krag'wa (West, Dazar'alor)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Dazaralor, x = 42.8, y = 43.4, title = "Shrine of Krag'wa" } } } } },
        }
    },

    -- A Farewell to Arms: achievement 12719
    [12719] = {
        helpText = "",
        criteria = {
            [40709] = { helpText = "", waypoints = {} },
            [40710] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 12771
    [12771] = {
        helpText = "",
        criteria = {
            [40857] = { helpText = "", waypoints = {} },
            [40858] = { helpText = "", waypoints = {} },
            [40859] = { helpText = "", waypoints = {} },
            [40860] = { helpText = "", waypoints = {} },
            [40861] = { helpText = "", waypoints = {} },
            [40862] = { helpText = "", waypoints = {} },
            [40863] = { helpText = "", waypoints = {} },
            [40864] = { helpText = "", waypoints = {} },
            [40865] = { helpText = "", waypoints = {} },
            [40866] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 12807
    [12807] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 12825
    [12825] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 12832
    [12832] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 12837
    [12837] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 12841
    [12841] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 12845
    [12845] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 12849 (Treasures of Vol'dun)
    -- Coordinates from HandyNotes_BattleForAzerothTreasures
    [12849] = {
        helpText = "Treasures of Vol'dun: Discover 10 hidden treasures in Vol'dun. Loot each chest to earn credit.",
        criteria = {
            [40966] = { helpText = "Ashvane Spoils - use mine cart to reach", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 46.59, y = 88.01, title = "Ashvane Spoils" } } } } },
            [40967] = { helpText = "Grayal's Last Offering - door on East side", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 48.18, y = 64.69, title = "Grayal's Last Offering" } } } } },
            [40968] = { helpText = "Lost Explorer's Bounty - climb the rock arch", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 49.78, y = 79.40, title = "Lost Explorer's Bounty" } } } } },
            [40969] = { helpText = "Sandfury Reserve - path from South side", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 47.19, y = 58.46, title = "Sandfury Reserve" } } } } },
            [40970] = { helpText = "Stranded Cache - climb fallen tree", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 44.50, y = 26.13, title = "Stranded Cache" } } } } },
            [40971] = { helpText = "Excavator's Greed", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 57.74, y = 64.64, title = "Excavator's Greed" } } } } },
            [40972] = { helpText = "Zem'lan's Buried Treasure - under Disturbed Sand", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 29.38, y = 87.42, title = "Zem'lan's Buried Treasure" } } } } },
            [41002] = { helpText = "Lost Offerings of Kimbul - enter at top of temple", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 57.06, y = 11.21, title = "Lost Offerings of Kimbul" } } } } },
            [41003] = { helpText = "Deadwood Chest", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 40.57, y = 85.74, title = "Deadwood Chest" } } } } },
            [41004] = { helpText = "Sandsunken Treasure - use Abandoned Bobber", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 26.48, y = 45.34, title = "Sandsunken Treasure" } } } } },
        }
    },

    -- A Farewell to Arms: achievement 12851
    [12851] = {
        helpText = "",
        criteria = {
            [40988] = { helpText = "", waypoints = {} },
            [40989] = { helpText = "", waypoints = {} },
            [40990] = { helpText = "", waypoints = {} },
            [40991] = { helpText = "", waypoints = {} },
            [40992] = { helpText = "", waypoints = {} },
            [40993] = { helpText = "", waypoints = {} },
            [40994] = { helpText = "", waypoints = {} },
            [40995] = { helpText = "", waypoints = {} },
            [40996] = { helpText = "", waypoints = {} },
            [40997] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 12852
    [12852] = {
        helpText = "",
        criteria = {
            [41012] = { helpText = "", waypoints = {} },
            [41013] = { helpText = "", waypoints = {} },
            [41014] = { helpText = "", waypoints = {} },
            [41015] = { helpText = "", waypoints = {} },
            [41016] = { helpText = "", waypoints = {} },
            [41017] = { helpText = "", waypoints = {} },
            [41018] = { helpText = "", waypoints = {} },
            [41019] = { helpText = "", waypoints = {} },
            [41020] = { helpText = "", waypoints = {} },
            [41021] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 12853 (Treasures of Stormsong Valley)
    -- Coordinates from Wowpedia (HandyNotes_BattleForAzerothTreasures)
    [12853] = {
        helpText = "Treasures of Stormsong Valley: Discover 10 hidden treasures in Stormsong Valley. Loot each chest to earn credit.",
        criteria = {
            [41061] = { helpText = "Frosty Treasure Chest - top level of mountain waterfalls", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 48.96, y = 84.07, title = "Frosty Treasure Chest" } } } } },
            [41062] = { helpText = "Hidden Scholar's Chest - on roof at Sagehold", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 59.91, y = 39.00, title = "Hidden Scholar's Chest" } } } } },
            [41063] = { helpText = "Old Ironbound Chest - inside cave with bears, Shepherd's Bluff", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 42.85, y = 47.23, title = "Old Ironbound Chest" } } } } },
            [41064] = { helpText = "Smuggler's Stash - under wooden platform, Highland Pass", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 58.60, y = 83.88, title = "Smuggler's Stash" } } } } },
            [41065] = { helpText = "Sunken Strongbox - under the ship at Port Fogtide", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 67.22, y = 43.21, title = "Sunken Strongbox" } } } } },
            [41066] = { helpText = "Venture Co. Supply Chest - use ladder to get on ship, Jeweled Coast", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 36.69, y = 23.23, title = "Venture Co. Supply Chest" } } } } },
            [41067] = { helpText = "Weathered Treasure Chest - underground cave hidden in trees", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 66.92, y = 12.03, title = "Weathered Treasure Chest" } } } } },
            [41068] = { helpText = "Carved Wooden Chest - on Thornheart platform", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 44.44, y = 73.53, title = "Carved Wooden Chest" } } } } },
            [41069] = { helpText = "Forgotten Chest - behind pillar, mountain near Warfang Hold", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 46.00, y = 30.69, title = "Forgotten Chest" } } } } },
            [41070] = { helpText = "Discarded Lunchbox - highest shelf in shed, Brennadam Square", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 58.21, y = 63.68, title = "Discarded Lunchbox" } } } } },
        }
    },

    -- A Farewell to Arms: achievement 12867
    [12867] = {
        helpText = "",
        criteria = {
            [41096] = { helpText = "", waypoints = {} },
            [41097] = { helpText = "", waypoints = {} },
            [41098] = { helpText = "", waypoints = {} },
            [41099] = { helpText = "", waypoints = {} },
            [41100] = { helpText = "", waypoints = {} },
            [41101] = { helpText = "", waypoints = {} },
            [41102] = { helpText = "", waypoints = {} },
            [41103] = { helpText = "", waypoints = {} },
            [41104] = { helpText = "", waypoints = {} },
            [41105] = { helpText = "", waypoints = {} },
            [41106] = { helpText = "", waypoints = {} },
            [41107] = { helpText = "", waypoints = {} },
            [41108] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 12869
    [12869] = {
        helpText = "",
        criteria = {
            [41163] = { helpText = "", waypoints = {} },
            [41164] = { helpText = "", waypoints = {} },
            [41165] = { helpText = "", waypoints = {} },
            [41166] = { helpText = "", waypoints = {} },
            [41167] = { helpText = "", waypoints = {} },
            [41168] = { helpText = "", waypoints = {} },
            [41169] = { helpText = "", waypoints = {} },
            [41170] = { helpText = "", waypoints = {} },
            [41171] = { helpText = "", waypoints = {} },
            [41172] = { helpText = "", waypoints = {} },
            [41173] = { helpText = "", waypoints = {} },
            [41174] = { helpText = "", waypoints = {} },
            [41175] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 12870
    [12870] = {
        helpText = "",
        criteria = {
            [41202] = { helpText = "", waypoints = {} },
            [41203] = { helpText = "", waypoints = {} },
            [41204] = { helpText = "", waypoints = {} },
            [41205] = { helpText = "", waypoints = {} },
            [41206] = { helpText = "", waypoints = {} },
            [41207] = { helpText = "", waypoints = {} },
            [41208] = { helpText = "", waypoints = {} },
            [41209] = { helpText = "", waypoints = {} },
            [41210] = { helpText = "", waypoints = {} },
            [41211] = { helpText = "", waypoints = {} },
            [41212] = { helpText = "", waypoints = {} },
            [41213] = { helpText = "", waypoints = {} },
            [41214] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 12872
    [12872] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 12873
    [12873] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 12891
    [12891] = {
        helpText = "",
        criteria = {
            [41138] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 12918
    [12918] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 12939 (Adventurer of Tiragarde Sound)
    [12939] = {
        helpText = "Adventurer of Tiragarde Sound: Complete 32 special encounters with rare elites in Tiragarde Sound.",
        criteria = {
            [41793] = { helpText = "Auditor Dolp", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 75.14, y = 78.48, title = "Auditor Dolp" } } } } },
            [41795] = { helpText = "Barman Bill", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 76.21, y = 83.05, title = "Barman Bill" } } } } },
            [41796] = { helpText = "Bashmu", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 34.01, y = 30.29, title = "Bashmu" } } } } },
            [41797] = { helpText = "Black-Eyed Bart", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 56.67, y = 69.94, title = "Black-Eyed Bart" } } } } },
            [41798] = { helpText = "Blackthorne", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 84.70, y = 73.85, title = "Blackthorne" } } } } },
            [41800] = { helpText = "Broodmother Razora", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 83.36, y = 44.13, title = "Broodmother Razora" } } } } },
            [41806] = { helpText = "Captain Wintersail", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 38.42, y = 20.66, title = "Captain Wintersail" } } } } },
            [41812] = { helpText = "Carla Smirk", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 72.83, y = 81.46, title = "Carla Smirk" } } } } },
            [41813] = { helpText = "Fowlmouth", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 89.78, y = 78.15, title = "Fowlmouth" } } } } },
            [41814] = { helpText = "Foxhollow Skyterror", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 59.98, y = 22.75, title = "Foxhollow Skyterror" } } } } },
            [41819] = { helpText = "Gulliver", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 57.72, y = 56.13, title = "Gulliver" } } } } },
            [41820] = { helpText = "Kulett the Ornery", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 48.07, y = 23.34, title = "Kulett the Ornery" } } } } },
            [41821] = { helpText = "Lumbergrasp Sentinel", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 68.35, y = 20.88, title = "Lumbergrasp Sentinel" } } } } },
            [41822] = { helpText = "Maison the Portable", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 58.09, y = 48.70, title = "Maison the Portable" } } } } },
            [41823] = { helpText = "Imperiled Merchants", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 64.29, y = 19.31, title = "Imperiled Merchants" } } } } },
            [41824] = { helpText = "Merianae", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 43.80, y = 17.71, title = "Merianae" } } } } },
            [41825] = { helpText = "P4-N73R4", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 65.17, y = 64.60, title = "P4-N73R4" } } } } },
            [41826] = { helpText = "Pack Leader Asenya", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 39.46, y = 15.17, title = "Pack Leader Asenya" } } } } },
            [41827] = { helpText = "Raging Swell", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 64.80, y = 58.93, title = "Raging Swell" } } } } },
            [41828] = { helpText = "Ranja", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 68.33, y = 63.62, title = "Ranja" } } } } },
            [41829] = { helpText = "Saurolisk Tamer Mugg", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 58.54, y = 15.13, title = "Saurolisk Tamer Mugg" } } } } },
            [41830] = { helpText = "Sawtooth", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 76.02, y = 28.87, title = "Sawtooth" }, { mapId = MapZones.BFA_ZONE_Boralus, x = 80.40, y = 35.00, title = "Sawtooth (Boralus)" } } } } },
            [41831] = { helpText = "Shiverscale the Toxic", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 55.70, y = 33.18, title = "Shiverscale the Toxic" } } } } },
            [41832] = { helpText = "Squacks", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 80.83, y = 82.77, title = "Squacks" } } } } },
            [41833] = { helpText = "Squirgle of the Depths", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 49.35, y = 36.13, title = "Squirgle of the Depths" } } } } },
            [41834] = { helpText = "Sythian the Swift", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 66.70, y = 14.27, title = "Sythian the Swift" } } } } },
            [41835] = { helpText = "Tempestria", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 60.80, y = 17.27, title = "Tempestria" } } } } },
            [41836] = { helpText = "Tentulos the Drifter", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 55.09, y = 50.56, title = "Tentulos the Drifter" } } } } },
            [41837] = { helpText = "Teres", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 63.73, y = 50.39, title = "Teres" } } } } },
            [41838] = { helpText = "Tort Jaw", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 70.03, y = 55.67, title = "Tort Jaw" } } } } },
            [41839] = { helpText = "Totes", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 46.39, y = 19.97, title = "Totes" } } } } },
            [41840] = { helpText = "Twin-hearted Construct", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 70.27, y = 12.83, title = "Twin-hearted Construct" } } } } },
        }
    },

    -- A Farewell to Arms: achievement 12940 (Adventurer of Stormsong Valley)
    -- Coordinates from WoWDB comment by Virag (HandyNotes_BattleForAzerothTreasures)
    [12940] = {
        helpText = "Adventurer of Stormsong Valley: Complete 33 special encounters with rare elites in Stormsong Valley. Defeat each rare to earn credit.",
        criteria = {
            [41753] = { helpText = "Song Mistress Dadalea", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 70.70, y = 33.28, title = "Song Mistress Dadalea" } } } } },
            [41754] = { helpText = "Severus the Outcast", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 22.15, y = 72.83, title = "Severus the Outcast" } } } } },
            [41755] = { helpText = "Seabreaker Skoloth", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 34.13, y = 38.44, title = "Seabreaker Skoloth" } } } } },
            [41756] = { helpText = "Sabertron", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 34.30, y = 32.20, title = "Sabertron" } } } } },
            [41757] = { helpText = "The Lichen King", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 51.79, y = 78.92, title = "The Lichen King" } } } } },
            [41758] = { helpText = "Ragna", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 41.11, y = 74.93, title = "Ragna" } } } } },
            [41759] = { helpText = "Slickspill", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 41.53, y = 28.50, title = "Slickspill" } } } } },
            [41760] = { helpText = "Broodmother (spider in Millstone Hamlet cellar)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 29.25, y = 69.45, title = "Broodmother" } } } } },
            [41761] = { helpText = "Galestorm", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 70.77, y = 54.64, title = "Galestorm" } } } } },
            [41762] = { helpText = "Whirlwing", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 46.80, y = 41.98, title = "Whirlwing" } } } } },
            [41763] = { helpText = "Kickers", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 31.48, y = 60.99, title = "Kickers" } } } } },
            [41765] = { helpText = "Foreman Scripps", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 64.50, y = 65.80, title = "Foreman Scripps" } } } } },
            [41769] = { helpText = "Poacher Zane", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 34.75, y = 67.98, title = "Poacher Zane" } } } } },
            [41772] = { helpText = "Pinku'shon", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 38.48, y = 52.33, title = "Pinku'shon" } } } } },
            [41774] = { helpText = "Grimscowl the Harebrained", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 62.21, y = 73.57, title = "Grimscowl the Harebrained" } } } } },
            [41775] = { helpText = "Deepfang", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 53.07, y = 50.63, title = "Deepfang" } } } } },
            [41776] = { helpText = "Croaker", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 62.67, y = 34.07, title = "Croaker" } } } } },
            [41777] = { helpText = "Corrupted Pod (Corrupted Tideskipper)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 66.48, y = 48.62, title = "Corrupted Pod" } } } } },
            [41778] = { helpText = "Crushtacean", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 51.44, y = 56.75, title = "Crushtacean" } } } } },
            [43470] = { helpText = "Dagrus the Scorned", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 68.30, y = 39.58, title = "Dagrus the Scorned" } } } } },
            [41782] = { helpText = "Vinespeaker Ratha", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 49.65, y = 70.05, title = "Vinespeaker Ratha" } } } } },
            [41787] = { helpText = "Strange Mushroom Ring", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 53.07, y = 69.09, title = "Strange Mushroom Ring" } } } } },
            [41815] = { helpText = "Haegol the Hammer", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 35.33, y = 78.26, title = "Haegol the Hammer" } } } } },
            [41816] = { helpText = "Squall", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 57.55, y = 74.32, title = "Squall" } } } } },
            [41817] = { helpText = "Ice Sickle", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 62.88, y = 83.99, title = "Ice Sickle" } } } } },
            [41818] = { helpText = "Captain Razorspine", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 47.27, y = 65.82, title = "Captain Razorspine" } } } } },
            [41841] = { helpText = "Whiplash", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 47.31, y = 65.89, title = "Whiplash" } } } } },
            [41842] = { helpText = "Sister Absinthe", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 62.24, y = 56.78, title = "Sister Absinthe" } } } } },
            [41843] = { helpText = "Wagga Snarltusk", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 42.41, y = 75.07, title = "Wagga Snarltusk" } } } } },
            [41844] = { helpText = "Nestmother Acada", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 43.35, y = 45.26, title = "Nestmother Acada" } } } } },
            [41845] = { helpText = "Osca the Bloodied", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 41.93, y = 62.39, title = "Osca the Bloodied" } } } } },
            [41846] = { helpText = "Sandfang", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 72.70, y = 60.54, title = "Sandfang" } } } } },
            [41847] = { helpText = "Doc Marrtens or Jakala the Cruel (complete either)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 53.35, y = 64.41, title = "Jakala the Cruel" } } } } },
        }
    },

    -- A Farewell to Arms: achievement 12941
    [12941] = {
        helpText = "",
        criteria = {
            [41706] = { helpText = "", waypoints = {} },
            [41707] = { helpText = "", waypoints = {} },
            [41708] = { helpText = "", waypoints = {} },
            [41709] = { helpText = "", waypoints = {} },
            [41711] = { helpText = "", waypoints = {} },
            [41712] = { helpText = "", waypoints = {} },
            [41713] = { helpText = "", waypoints = {} },
            [41714] = { helpText = "", waypoints = {} },
            [41715] = { helpText = "", waypoints = {} },
            [41717] = { helpText = "", waypoints = {} },
            [41718] = { helpText = "", waypoints = {} },
            [41719] = { helpText = "", waypoints = {} },
            [41720] = { helpText = "", waypoints = {} },
            [41721] = { helpText = "", waypoints = {} },
            [41722] = { helpText = "", waypoints = {} },
            [41723] = { helpText = "", waypoints = {} },
            [41724] = { helpText = "", waypoints = {} },
            [41725] = { helpText = "", waypoints = {} },
            [41726] = { helpText = "", waypoints = {} },
            [41727] = { helpText = "", waypoints = {} },
            [41728] = { helpText = "", waypoints = {} },
            [42342] = { helpText = "", waypoints = {} },
            [41729] = { helpText = "", waypoints = {} },
            [41730] = { helpText = "", waypoints = {} },
            [41732] = { helpText = "", waypoints = {} },
            [41733] = { helpText = "", waypoints = {} },
            [41736] = { helpText = "", waypoints = {} },
            [41739] = { helpText = "", waypoints = {} },
            [41742] = { helpText = "", waypoints = {} },
            [41745] = { helpText = "", waypoints = {} },
            [41748] = { helpText = "", waypoints = {} },
            [41750] = { helpText = "", waypoints = {} },
            [41751] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 12942 (Adventurer of Nazmir)
    -- Coordinates from HandyNotes_BattleForAzerothTreasures
    [12942] = {
        helpText = "Adventurer of Nazmir: Complete 32 special encounters with rare elites in Nazmir.",
        criteria = {
            [41440] = { helpText = "Ancient Jawbreaker", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 67.81, y = 29.72, title = "Ancient Jawbreaker" } } } } },
            [41444] = { helpText = "Azerite-Infused Elemental", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 54.13, y = 28.11, title = "Azerite-Infused Elemental" } } } } },
            [41447] = { helpText = "Azerite-Infused Slag", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 32.80, y = 26.90, title = "Azerite-Infused Slag" } } } } },
            [41448] = { helpText = "Blood Priest Xak'lar - in cave, behind waterfall", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 43.07, y = 90.11, title = "Cave entrance" }, { mapId = MapZones.BFA_ZONE_Nazmir, x = 43.19, y = 91.31, title = "Blood Priest Xak'lar" } } } } },
            [41450] = { helpText = "Uroku the Bound", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 44.22, y = 48.73, title = "Uroku the Bound" } } } } },
            [41451] = { helpText = "King Kooba", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 53.69, y = 42.87, title = "King Kooba" } } } } },
            [41452] = { helpText = "Chag's Challenge", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 68.10, y = 20.23, title = "Chag's Challenge" } } } } },
            [41453] = { helpText = "Corpse Bringer Yal'kar", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 41.67, y = 53.44, title = "Corpse Bringer Yal'kar" } } } } },
            [41454] = { helpText = "Cursed Chest", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 81.81, y = 30.57, title = "Cursed Chest" } } } } },
            [41455] = { helpText = "Gwugnug the Cursed", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 33.54, y = 87.08, title = "Gwugnug the Cursed" } } } } },
            [41456] = { helpText = "Glompmaw", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 68.96, y = 57.47, title = "Glompmaw" } } } } },
            [41457] = { helpText = "Gutrip", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 32.34, y = 43.32, title = "Gutrip" } } } } },
            [41458] = { helpText = "Queen Tzxi'kik", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 56.67, y = 69.32, title = "Queen Tzxi'kik" } } } } },
            [41459] = { helpText = "Infected Direhorn", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 24.97, y = 77.78, title = "Infected Direhorn" } } } } },
            [41460] = { helpText = "Jax'teb the Reanimated", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 45.38, y = 51.97, title = "Jax'teb the Reanimated" } } } } },
            [41461] = { helpText = "Juba the Scarred", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 27.82, y = 33.57, title = "Juba the Scarred" } } } } },
            [41462] = { helpText = "Kal'draxa", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 52.93, y = 13.40, title = "Kal'draxa" } } } } },
            [41463] = { helpText = "Krubbs", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 76.03, y = 36.54, title = "Krubbs" } } } } },
            [41464] = { helpText = "Lost Scroll", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 81.70, y = 61.05, title = "Lost Scroll" } } } } },
            [41466] = { helpText = "Bajiatha", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 42.81, y = 59.49, title = "Bajiatha" } } } } },
            [41467] = { helpText = "Scout Skrasniss", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 58.96, y = 38.93, title = "Scout Skrasniss" } } } } },
            [41468] = { helpText = "Scrounger Patriarch", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 58.43, y = 10.14, title = "Scrounger Patriarch" } } } } },
            [41469] = { helpText = "Tainted Guardian", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 31.44, y = 38.15, title = "Tainted Guardian" } } } } },
            [41470] = { helpText = "Totem Maker Jash'ga", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 49.45, y = 37.14, title = "Totem Maker Jash'ga" } } } } },
            [41472] = { helpText = "Urn of Agussu", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 38.10, y = 57.68, title = "Urn of Agussu" } } } } },
            [41473] = { helpText = "Venomjaw", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 29.71, y = 51.07, title = "Venomjaw" } } } } },
            [41474] = { helpText = "Wardrummer Zurula", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 48.99, y = 50.82, title = "Wardrummer Zurula" } } } } },
            [41475] = { helpText = "Xu'ba the Bone Collector", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 36.56, y = 50.53, title = "Xu'ba" } } } } },
            [41476] = { helpText = "Za'amar the Queen's Blade", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 38.72, y = 26.74, title = "Za'amar the Queen's Blade" } } } } },
            [41477] = { helpText = "Zanxib the Engorged", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 38.89, y = 71.48, title = "Zanxib the Engorged" } } } } },
            [41478] = { helpText = "Lo'kuno", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 78.08, y = 44.51, title = "Lo'kuno" } } } } },
            [41479] = { helpText = "Mala'kili and Rohnkor", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 52.61, y = 54.89, title = "Mala'kili and Rohnkor" } } } } },
        }
    },

    -- A Farewell to Arms: achievement 12943 (Adventurer of Vol'dun)
    -- Coordinates from HandyNotes_BattleForAzerothTreasures
    [12943] = {
        helpText = "Adventurer of Vol'dun: Complete 28 special encounters with rare elites in Vol'dun.",
        criteria = {
            [41606] = { helpText = "Ak'tar", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 50.38, y = 81.60, title = "Ak'tar" } } } } },
            [41607] = { helpText = "Ashmane", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 54.70, y = 15.17, title = "Ashmane" } } } } },
            [41608] = { helpText = "Azer'tor", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 49.06, y = 89.05, title = "Azer'tor" } } } } },
            [41609] = { helpText = "Bajiani the Slick", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 31.00, y = 81.09, title = "Bajiani the Slick" } } } } },
            [41610] = { helpText = "Bloated Krolusk", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 49.06, y = 49.89, title = "Bloated Krolusk" } } } } },
            [41611] = { helpText = "Bloodwing Bonepicker", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 56.10, y = 53.56, title = "Bloodwing Bonepicker" } } } } },
            [41612] = { helpText = "Captain Stef \"Marrow\" Quin", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 41.27, y = 24.49, title = "Captain Stef Marrow Quin" } } } } },
            [41613] = { helpText = "Commodore Calhoun", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 42.68, y = 92.45, title = "Commodore Calhoun" } } } } },
            [41614] = { helpText = "Enraged Krolusk", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 61.85, y = 37.88, title = "Enraged Krolusk" } } } } },
            [41615] = { helpText = "Gut-Gut the Glutton", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 64.00, y = 47.57, title = "Gut-Gut the Glutton" } } } } },
            [41616] = { helpText = "Hivemother Kraxi - in cave", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 53.84, y = 51.49, title = "Cave entrance" }, { mapId = MapZones.BFA_ZONE_Voldun, x = 53.69, y = 53.47, title = "Hivemother Kraxi" } } } } },
            [41617] = { helpText = "Jumbo Sandsnapper", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 37.43, y = 84.98, title = "Jumbo Sandsnapper" } } } } },
            [41618] = { helpText = "Jungleweb Hunter", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 60.56, y = 18.01, title = "Jungleweb Hunter" } } } } },
            [41619] = { helpText = "Kamid the Trapper", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 35.09, y = 51.83, title = "Kamid the Trapper" } } } } },
            [41620] = { helpText = "King Clickyclack - in cave", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 37.35, y = 40.50, title = "Cave entrance" }, { mapId = MapZones.BFA_ZONE_Voldun, x = 38.28, y = 41.38, title = "King Clickyclack" } } } } },
            [41621] = { helpText = "Nez'ara", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 43.76, y = 86.24, title = "Nez'ara" } } } } },
            [41622] = { helpText = "Relic Hunter Hazaak", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 49.02, y = 72.10, title = "Relic Hunter Hazaak" } } } } },
            [41623] = { helpText = "Scaleclaw Broodmother", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 44.54, y = 80.23, title = "Scaleclaw Broodmother" } } } } },
            [41624] = { helpText = "Scorpox", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 32.72, y = 65.22, title = "Scorpox" } } } } },
            [41625] = { helpText = "Sirokar", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 24.74, y = 68.50, title = "Sirokar" } } } } },
            [41626] = { helpText = "Skycaller Teskris - in cave", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 46.24, y = 27.14, title = "Cave entrance" }, { mapId = MapZones.BFA_ZONE_Voldun, x = 46.97, y = 25.18, title = "Skycaller Teskris" } } } } },
            [41627] = { helpText = "Skycarver Krakit", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 51.26, y = 36.45, title = "Skycarver Krakit" } } } } },
            [41628] = { helpText = "Songstress Nahjeen", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 66.89, y = 24.46, title = "Songstress Nahjeen" } } } } },
            [41629] = { helpText = "Vathikur", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 57.19, y = 73.49, title = "Vathikur" } } } } },
            [41630] = { helpText = "Warbringer Hozzik", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 37.08, y = 46.16, title = "Warbringer Hozzik" } } } } },
            [41631] = { helpText = "Warlord Zothix", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 30.12, y = 52.56, title = "Warlord Zothix" } } } } },
            [41632] = { helpText = "Warmother Captive", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 50.71, y = 30.86, title = "Warmother Captive" } } } } },
            [41633] = { helpText = "Zunashi the Exile - inside skeleton under the sand", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 43.99, y = 52.46, title = "Skeleton entrance" }, { mapId = MapZones.BFA_ZONE_Voldun, x = 43.92, y = 54.05, title = "Zunashi the Exile" } } } } },
        }
    },

    -- A Farewell to Arms: achievement 12944
    [12944] = {
        helpText = "",
        criteria = {
            [41850] = { helpText = "", waypoints = {} },
            [41851] = { helpText = "", waypoints = {} },
            [41852] = { helpText = "", waypoints = {} },
            [41853] = { helpText = "", waypoints = {} },
            [41869] = { helpText = "", waypoints = {} },
            [41870] = { helpText = "", waypoints = {} },
            [41871] = { helpText = "", waypoints = {} },
            [41872] = { helpText = "", waypoints = {} },
            [41873] = { helpText = "", waypoints = {} },
            [41874] = { helpText = "", waypoints = {} },
            [41875] = { helpText = "", waypoints = {} },
            [41876] = { helpText = "", waypoints = {} },
            [41877] = { helpText = "", waypoints = {} },
            [41855] = { helpText = "", waypoints = {} },
            [41856] = { helpText = "", waypoints = {} },
            [41858] = { helpText = "", waypoints = {} },
            [41859] = { helpText = "", waypoints = {} },
            [41863] = { helpText = "", waypoints = {} },
            [41864] = { helpText = "", waypoints = {} },
            [41865] = { helpText = "", waypoints = {} },
            [41866] = { helpText = "", waypoints = {} },
            [41867] = { helpText = "", waypoints = {} },
            [41868] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 12947
    [12947] = {
        helpText = "",
        criteria = {
            [42226] = { helpText = "", waypoints = {} },
            [42228] = { helpText = "", waypoints = {} },
            [42227] = { helpText = "", waypoints = {} },
            [41655] = { helpText = "", waypoints = {} },
            [43121] = { helpText = "", waypoints = {} },
            [43122] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 12988
    [12988] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 12991
    [12991] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 12993
    [12993] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 12995
    [12995] = {
        helpText = "",
        criteria = {
            [41697] = { helpText = "", waypoints = {} },
            [41698] = { helpText = "", waypoints = {} },
            [41699] = { helpText = "", waypoints = {} },
            [41700] = { helpText = "", waypoints = {} },
            [41701] = { helpText = "", waypoints = {} },
            [41702] = { helpText = "", waypoints = {} },
            [41703] = { helpText = "", waypoints = {} },
            [41704] = { helpText = "", waypoints = {} },
            [41705] = { helpText = "", waypoints = {} },
            [41752] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 12997
    [12997] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13009
    [13009] = {
        helpText = "",
        criteria = {
            [41335] = { helpText = "", waypoints = {} },
            [41336] = { helpText = "", waypoints = {} },
            [41337] = { helpText = "", waypoints = {} },
            [41338] = { helpText = "", waypoints = {} },
            [41339] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13011
    [13011] = {
        helpText = "",
        criteria = {
            [41341] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13016 (Scavenger of the Sands)
    -- Find 14 lost items scattered across Vol'dun. Coordinates from Wowhead/HandyNotes_BFA.
    [13016] = {
        helpText = "Scavenger of the Sands: Find 14 lost items scattered across Vol'dun. Each item belongs to a member of the Scavenger's crew. Click each item on the ground to collect it.",
        criteria = {
            [41342] = { helpText = "Jason's Rusty Blade - beneath the bridge next to a skeleton", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 56.31, y = 70.07, title = "Jason's Rusty Blade" } } } } },
            [41343] = { helpText = "Ian's Empty Bottle - in toppled crate next to Blackeye Gunt", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 36.21, y = 78.38, title = "Ian's Empty Bottle" } } } } },
            [41344] = { helpText = "Julie's Cracked Dish - on table next to Akunda the Patient", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 53.56, y = 89.80, title = "Julie's Cracked Dish" } } } } },
            [41345] = { helpText = "Brian's Broken Compass - underneath broken wall's brick", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 37.80, y = 30.46, title = "Brian's Broken Compass" } } } } },
            [41346] = { helpText = "Ofer's Bound Journal - on teal table near Zareen, first floor", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 26.79, y = 52.92, title = "Ofer's Bound Journal" } } } } },
            [41347] = { helpText = "Skye's Pet Rock - on a plate behind Jenoh", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 29.47, y = 59.37, title = "Skye's Pet Rock" } } } } },
            [41348] = { helpText = "Julien's Left Boot - near bones by the cliff", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 52.44, y = 14.41, title = "Julien's Left Boot" } } } } },
            [41349] = { helpText = "Navarro's Flask - on basket next to Zauljin", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 43.22, y = 76.99, title = "Navarro's Flask" } } } } },
            [41350] = { helpText = "Zach's Canteen - on crate next to Serrik", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 47.08, y = 75.79, title = "Zach's Canteen" } } } } },
            [41351] = { helpText = "Damarcus' Backpack - hanging from a tent", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 45.87, y = 30.68, title = "Damarcus' Backpack" } } } } },
            [41352] = { helpText = "Rachel's Flute - inside cave on wagon seat (entrance first)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 64.87, y = 36.10, title = "Cave entrance" }, { mapId = MapZones.BFA_ZONE_Voldun, x = 66.40, y = 35.90, title = "Rachel's Flute" } } } } },
            [41353] = { helpText = "Josh's Fang Necklace - inside cave at Vorrik's Sanctum by serpent pool", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 48.00, y = 36.40, title = "Vorrik's Sanctum cave entrance" }, { mapId = MapZones.BFA_ZONE_Voldun, x = 47.92, y = 36.71, title = "Josh's Fang Necklace" } } } } },
            [41354] = { helpText = "Portrait of Commander Martens - inside house on wall", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 45.22, y = 91.16, title = "Portrait of Commander Martens" } } } } },
            [41355] = { helpText = "Kurt's Ornate Key - on a crate, down from Tortaka Refuge", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 62.87, y = 22.68, title = "Kurt's Ornate Key" } } } } },
        }
    },

    -- A Farewell to Arms: achievement 13017
    [13017] = {
        helpText = "",
        criteria = {
            [41359] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13018
    [13018] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13020 (Bow to Your Masters)
    [13020] = {
        helpText = "Bow to Your Masters: /bow to all 9 Loa at their shrines in Zuldazar, Nazmir, Vol'dun. Rezan/Jani/Sethraliss may require storyline completion.",
        criteria = {
            [41525] = { helpText = "Rezan - Zuldazar", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Zuldazar, x = 43.74, y = 76.74, title = "Rezan Shrine" } } } } },
            [41495] = { helpText = "Jani - Mysterious Trashpiles", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Zuldazar, x = 48.54, y = 54.60, title = "Jani Trashpile" } } } } },
            [41497] = { helpText = "Gonk - Temple of the Prophet", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Zuldazar, x = 51.69, y = 28.25, title = "Shrine of Gonk" } } } } },
            [41498] = { helpText = "Krag'wa - Nazmir", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 58.92, y = 48.65, title = "Krag'wa's Burrow" } } } } },
            [41499] = { helpText = "Sethraliss - Vol'dun", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 27.0, y = 52.6, title = "Sanctuary of the Devoted" } } } } },
            [41500] = { helpText = "Pa'ku - Zuldazar", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Zuldazar, x = 49.00, y = 41.29, title = "Shrine of Pa'ku" } } } } },
            [41501] = { helpText = "Kimbul - Vol'dun", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 56.6, y = 10.4, title = "Temple of Kimbul" } } } } },
            [41502] = { helpText = "Akunda - Vol'dun", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 53.2, y = 90.2, title = "Temple of Akunda" } } } } },
            [41503] = { helpText = "Bwonsamdi - Nazmir", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 39.12, y = 38.65, title = "Bwonsamdi Shrine" } } } } },
        }
    },

    -- A Farewell to Arms: achievement 13021
    [13021] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13022
    [13022] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13023
    [13023] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13024
    [13024] = {
        helpText = "",
        criteria = {
            [41860] = { helpText = "", waypoints = {} },
            [41861] = { helpText = "", waypoints = {} },
            [41862] = { helpText = "", waypoints = {} },
            [42116] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13028 (Krag'wa's Ire - find 10 Lost Spawn of Krag'wa in Nazmir)
    [13028] = {
        helpText = "Krag'wa's Ire: Find and interact with 10 Lost Spawn of Krag'wa in Nazmir. Each spawn is tied to a quest.",
        criteria = {
            [41598] = {},
        },
        virtualCriteria = {
            [53417] = { criteriaType = 27, text = "Krag'wa #1", helpText = "Dive into the submerged cave at this location.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 65.6, y = 50.9, title = "Krag'wa #1" } } } } },
            [53418] = { criteriaType = 27, text = "Krag'wa #2", helpText = "Enter the underwater cave beneath the giant skeleton.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 69.1, y = 57.9, title = "Krag'wa #2" } } } } },
            [53419] = { criteriaType = 27, text = "Krag'wa #3", helpText = "Tucked away behind a large tree.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 56.1, y = 64.9, title = "Krag'wa #3" } } } } },
            [53422] = { criteriaType = 27, text = "Krag'wa #4", helpText = "In a cave inhabited by riverbeasts.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 45.6, y = 91.0, title = "Krag'wa #4" } } } } },
            [53423] = { criteriaType = 27, text = "Krag'wa #5", helpText = "Inside a cliff cave—follow the road up the mountain from the waypoint.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 26.8, y = 80.4, title = "Start of path—follow the road up the mountain" }, { mapId = MapZones.BFA_ZONE_Nazmir, x = 26.8, y = 80.4, title = "Krag'wa #5 (cave)" } } } } },
            [53424] = { criteriaType = 27, text = "Krag'wa #6", helpText = "Resting among the trees in the open.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 24.2, y = 91.6, title = "Krag'wa #6" } } } } },
            [53425] = { criteriaType = 27, text = "Krag'wa #7", helpText = "Along the riverbank.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 21.7, y = 69.3, title = "Krag'wa #7" } } } } },
            [53421] = { criteriaType = 27, text = "Krag'wa #8", helpText = "Inside a small cave at this spot.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 33.5, y = 61.6, title = "Krag'wa #8" } } } } },
            [53420] = { criteriaType = 27, text = "Krag'wa #9", helpText = "Concealed behind the seamoss.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 25.6, y = 40.6, title = "Krag'wa #9" } } } } },
            [53426] = { criteriaType = 27, text = "Krag'wa #10", helpText = "Inside the ruined building.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 52.8, y = 42.9, title = "Krag'wa #10" } } } } },
        }
    },

    -- A Farewell to Arms: achievement 13029 (Eating Out of the Palm of My Tiny Hand)
    [13029] = {
        helpText = "Eating Out of the Palm of My Tiny Hand: Feed brutosaurs in Zuldazar, Nazmir, and Vol'dun. Buy food from Golkada, Blind Wunja, Rikati respectively.",
        criteria = {
            [41575] = { helpText = "Zuldazar: Golkada → Extra-Dry Fruitcake → Irritable Maka'fon", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Zuldazar, x = 71.2, y = 29.5, title = "Golkada / Irritable Maka'fon" } } } } },
            [41578] = { helpText = "Nazmir: Blind Wunja (cave) → Primitive Watermelon → Goramor", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 34.6, y = 54.9, title = "Blind Wunja (vendor)" }, { mapId = MapZones.BFA_ZONE_Nazmir, x = 32.0, y = 35.0, title = "Goramor (brutosaur)" } } } } },
            [41580] = { helpText = "Vol'dun: Rikati → Snake on a Stick → Ol' Stompy", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 40.4, y = 55.3, title = "Rikati / Ol' Stompy" } } } } },
        }
    },

    -- A Farewell to Arms: achievement 13036 (A Loa of a Tale)
    [13036] = {
        helpText = "A Loa of a Tale: Find and read all 15 'Tales of de Loa' volumes across Zuldazar, Nazmir, and Vol'dun.",
        criteria = {
            [41564] = { helpText = "Tales of de Loa: Akunda - Vol'dun", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 42.22, y = 62.11, title = "Tales of de Loa: Akunda" } } } } },
            [41565] = { helpText = "Tales of de Loa: Bwonsamdi - Nazmir", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 39.12, y = 38.65, title = "Tales of de Loa: Bwonsamdi" } } } } },
            [41566] = { helpText = "Tales of de Loa: Gonk - Zuldazar", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Zuldazar, x = 51.69, y = 28.25, title = "Tales of de Loa: Gonk" } } } } },
            [41567] = { helpText = "Tales of de Loa: Gral - Zuldazar", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Zuldazar, x = 75.50, y = 67.60, title = "Tales of de Loa: Gral" } } } } },
            [41568] = { helpText = "Tales of de Loa: Hir'eek - Nazmir", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 39.57, y = 54.67, title = "Tales of de Loa: Hir'eek" } } } } },
            [41569] = { helpText = "Tales of de Loa: Jani - Zuldazar", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Zuldazar, x = 48.54, y = 54.60, title = "Tales of de Loa: Jani" } } } } },
            [41570] = { helpText = "Tales of de Loa: Kimbul - Vol'dun", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 27.70, y = 62.12, title = "Tales of de Loa: Kimbul" } } } } },
            [41571] = { helpText = "Tales of de Loa: Krag'wa - Nazmir", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 58.92, y = 48.65, title = "Tales of de Loa: Krag'wa" } } } } },
            [41572] = { helpText = "Tales of de Loa: Pa'ku - Zuldazar", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Zuldazar, x = 49.00, y = 41.29, title = "Tales of de Loa: Pa'ku" } } } } },
            [41573] = { helpText = "Tales of de Loa: Rezan - Zuldazar", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Zuldazar, x = 43.74, y = 76.74, title = "Tales of de Loa: Rezan" } } } } },
            [41574] = { helpText = "Tales of de Loa: Sethraliss - Vol'dun", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Voldun, x = 49.57, y = 24.57, title = "Tales of de Loa: Sethraliss" } } } } },
            [41576] = { helpText = "Tales of de Loa: Shadra - Zuldazar", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Zuldazar, x = 47.84, y = 28.84, title = "Tales of de Loa: Shadra" } } } } },
            [41577] = { helpText = "Tales of de Loa: Torcali - Zuldazar", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Zuldazar, x = 67.28, y = 17.62, title = "Tales of de Loa: Torcali" } } } } },
            [41579] = { helpText = "Tales of de Loa: Torga - Nazmir", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Nazmir, x = 72.85, y = 7.60, title = "Tales of de Loa: Torga" } } } } },
            [41581] = { helpText = "Tales of de Loa: Zandalar - Zuldazar or Dazar'alor", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Zuldazar, x = 57.70, y = 31.70, title = "Tales of de Loa: Zandalar" }, { mapId = MapZones.BFA_ZONE_Dazaralor, x = 53.23, y = 9.40, title = "Tales of de Loa: Zandalar (Dazar'alor)" } } } } },
        }
    },

    -- A Farewell to Arms: achievement 13038 (Raptari Rider)
    [13038] = {
        helpText = "Raptari Rider: Maintain Speed of Gonk for 3 minutes in Zuldazar. Choose Gonk in 'Picking a Side' quest first. Run between Gonk totems in Dazar'alor to refresh the buff.",
        waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Dazaralor, x = 50.3, y = 63.0, title = "Lair of Gonk / Gonk totems" } } } },
    },

    -- A Farewell to Arms: achievement 13045
    [13045] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13046 (These Hills Sing)
    -- Coordinates from HandyNotes_BattleForAzerothTreasures
    [13046] = {
        helpText = "These Hills Sing: Enjoy an Unforgettable Luncheon at a special location in Stormsong Valley. Buy Unforgettable Luncheon from an innkeeper, or loot one from the Discarded Lunchbox treasure in Brennadam. Use the item at the picnic spot.",
        waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 58.21, y = 63.68, title = "Discarded Lunchbox (loot Unforgettable Luncheon)" }, { mapId = MapZones.BFA_ZONE_StormsongValley, x = 41.25, y = 69.50, title = "Unforgettable Luncheon spot" } } } },
    },

    -- A Farewell to Arms: achievement 13047
    [13047] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13049
    [13049] = {
        helpText = "",
        criteria = {
            [41668] = { helpText = "", waypoints = {} },
            [41669] = { helpText = "", waypoints = {} },
            [41670] = { helpText = "", waypoints = {} },
            [41671] = { helpText = "", waypoints = {} },
            [41666] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13050
    [13050] = {
        helpText = "",
        criteria = {
            [41662] = { helpText = "", waypoints = {} },
            [41663] = { helpText = "", waypoints = {} },
            [41664] = { helpText = "", waypoints = {} },
            [41665] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13051 (Legends of the Tidesages)
    -- Find 8 Ancient Tidesage scrolls hanging from shrines/monuments in Stormsong Valley. Some hidden in mountains.
    -- Coordinates from warcraft.blizzplanet.com
    [13051] = {
        helpText = "Legends of the Tidesages: Discover 8 large Tidesage scrolls hanging from shrines or monuments throughout Stormsong Valley. Some are well hidden in the mountains.",
        criteria = {
            [41425] = { helpText = "Legends of the Tidesages Part 1 - scroll at shrine/monument", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 49.52, y = 80.91, title = "Legends of the Tidesages Part 1" } } } } },
            [41426] = { helpText = "Legends of the Tidesages Part 2 - scroll at shrine/monument", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 31.93, y = 72.92, title = "Legends of the Tidesages Part 2" } } } } },
            [41427] = { helpText = "Legends of the Tidesages Part 3 - scroll at shrine/monument", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 59.01, y = 59.55, title = "Legends of the Tidesages Part 3" } } } } },
            [41428] = { helpText = "Legends of the Tidesages Part 4 - scroll at shrine/monument", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 44.20, y = 36.62, title = "Legends of the Tidesages Part 4" } } } } },
            [41429] = { helpText = "Legends of the Tidesages Part 5 - scroll at shrine/monument", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 56.05, y = 38.49, title = "Legends of the Tidesages Part 5" } } } } },
            [41430] = { helpText = "Legends of the Tidesages Part 6 - scroll at shrine/monument", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 62.06, y = 30.24, title = "Legends of the Tidesages Part 6" } } } } },
            [41431] = { helpText = "Legends of the Tidesages Part 7 - scroll at shrine/monument", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 75.06, y = 31.09, title = "Legends of the Tidesages Part 7" } } } } },
            [41432] = { helpText = "Legends of the Tidesages Part 8 - scroll at shrine/monument", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 33.81, y = 33.21, title = "Legends of the Tidesages Part 8" } } } } },
        }
    },

    -- A Farewell to Arms: achievement 13053
    [13053] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13057 (Sailed in Sea Minor)
    [13057] = {
        helpText = "Sailed in Sea Minor: Find all 6 Forbidden Sea Shanties in Tiragarde Sound and Boralus.",
        criteria = {
            [41541] = { helpText = "Shanty of the Lively Men", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 74.40, y = 35.40, title = "Shanty of the Lively Men" }, { mapId = MapZones.BFA_ZONE_Boralus, x = 72.61, y = 68.53, title = "Shanty of the Lively Men (Boralus)" } } } } },
            [41542] = { helpText = "Shanty of Fruit Counting - in cave", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 43.38, y = 25.85, title = "Shanty of Fruit Counting" } } } } },
            [41543] = { helpText = "Shanty of Inebriation", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 70.60, y = 22.70, title = "Shanty of Inebriation" }, { mapId = MapZones.BFA_ZONE_Boralus, x = 53.14, y = 17.67, title = "Shanty of Inebriation (Boralus)" } } } } },
            [41544] = { helpText = "Shanty of Josephus - from Barman Bill", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 76.21, y = 83.06, title = "Barman Bill" } } } } },
            [41545] = { helpText = "Shanty of the Black Sphere - from Black-Eyed Bart", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 56.70, y = 69.90, title = "Black-Eyed Bart" } } } } },
            [41546] = { helpText = "Shanty of the Horse - Ring of Booty", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 73.20, y = 84.10, title = "Shanty of the Horse" } } } } },
        }
    },

    -- A Farewell to Arms: achievement 13058
    [13058] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13061 (Three Sheets to the Wind)
    [13061] = {
        helpText = "Three Sheets to the Wind: Purchase all 22 Kul Tiran drinks from bartenders in Boralus, Tiragarde Sound, Drustvar, and Stormsong Valley.",
        criteria = {
            [41396] = { helpText = "Harold Atkey (Boralus)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Boralus, x = 75.38, y = 14.44, title = "Harold Atkey" } } } } },
            [41397] = { helpText = "Ruddy the Rat (Boralus)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Boralus, x = 69.42, y = 29.89, title = "Ruddy the Rat" } } } } },
            [41398] = { helpText = "Joseph Stephens (Boralus)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Boralus, x = 47.57, y = 47.37, title = "Joseph Stephens" } } } } },
            [41399] = { helpText = "Nicolas Moal (Boralus)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Boralus, x = 58.23, y = 70.24, title = "Nicolas Moal" } } } } },
            [41400] = { helpText = "Sarella Griffin (Tiragarde Sound)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 49.78, y = 25.19, title = "Sarella Griffin" } } } } },
            [41401] = { helpText = "Barkeep Cotner (Drustvar)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Drustvar, x = 21.08, y = 66.08, title = "Barkeep Cotner" } } } } },
            [41402] = { helpText = "Linda Deepwater (Drustvar)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Drustvar, x = 21.18, y = 43.85, title = "Linda Deepwater" } } } } },
            [41403] = { helpText = "Emma Haribull (Stormsong Valley)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 44.43, y = 54.18, title = "Emma Haribull" } } } } },
            [41404] = { helpText = "Harold Atkey (Boralus)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Boralus, x = 75.38, y = 14.44, title = "Harold Atkey" } } } } },
            [41405] = { helpText = "Ruddy the Rat (Boralus)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Boralus, x = 69.42, y = 29.89, title = "Ruddy the Rat" } } } } },
            [41406] = { helpText = "Joseph Stephens (Boralus)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Boralus, x = 47.57, y = 47.37, title = "Joseph Stephens" } } } } },
            [41407] = { helpText = "Nicolas Moal (Boralus)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Boralus, x = 58.23, y = 70.24, title = "Nicolas Moal" } } } } },
            [41408] = { helpText = "Sarella Griffin (Tiragarde Sound)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 49.78, y = 25.19, title = "Sarella Griffin" } } } } },
            [41409] = { helpText = "Barkeep Cotner (Drustvar)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Drustvar, x = 21.08, y = 66.08, title = "Barkeep Cotner" } } } } },
            [41410] = { helpText = "Linda Deepwater (Drustvar)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Drustvar, x = 21.18, y = 43.85, title = "Linda Deepwater" } } } } },
            [41411] = { helpText = "Emma Haribull (Stormsong Valley)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_StormsongValley, x = 44.43, y = 54.18, title = "Emma Haribull" } } } } },
            [41412] = { helpText = "Harold Atkey (Boralus)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Boralus, x = 75.38, y = 14.44, title = "Harold Atkey" } } } } },
            [41413] = { helpText = "Ruddy the Rat (Boralus)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Boralus, x = 69.42, y = 29.89, title = "Ruddy the Rat" } } } } },
            [41414] = { helpText = "Joseph Stephens (Boralus)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Boralus, x = 47.57, y = 47.37, title = "Joseph Stephens" } } } } },
            [41415] = { helpText = "Nicolas Moal (Boralus)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Boralus, x = 58.23, y = 70.24, title = "Nicolas Moal" } } } } },
            [41416] = { helpText = "Sarella Griffin (Tiragarde Sound)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_TiragardeSound, x = 49.78, y = 25.19, title = "Sarella Griffin" } } } } },
            [41417] = { helpText = "Drustvar/Stormsong vendors", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.BFA_ZONE_Drustvar, x = 21.08, y = 66.08, title = "Barkeep Cotner" }, { mapId = MapZones.BFA_ZONE_Drustvar, x = 21.18, y = 43.85, title = "Linda Deepwater" }, { mapId = MapZones.BFA_ZONE_StormsongValley, x = 44.43, y = 54.18, title = "Emma Haribull" } } } } },
        }
    },

    -- A Farewell to Arms: achievement 13062
    [13062] = {
        helpText = "",
        criteria = {
            [41634] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13064
    [13064] = {
        helpText = "",
        criteria = {
            [41436] = { helpText = "", waypoints = {} },
            [41437] = { helpText = "", waypoints = {} },
            [41438] = { helpText = "", waypoints = {} },
            [41439] = { helpText = "", waypoints = {} },
            [41441] = { helpText = "", waypoints = {} },
            [41442] = { helpText = "", waypoints = {} },
            [41443] = { helpText = "", waypoints = {} },
            [41445] = { helpText = "", waypoints = {} },
            [41446] = { helpText = "", waypoints = {} },
            [41449] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13082
    [13082] = {
        helpText = "",
        criteria = {
            [41636] = { helpText = "", waypoints = {} },
            [41637] = { helpText = "", waypoints = {} },
            [41638] = { helpText = "", waypoints = {} },
            [41639] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13087
    [13087] = {
        helpText = "",
        criteria = {
            [41649] = { helpText = "", waypoints = {} },
            [41648] = { helpText = "", waypoints = {} },
            [41650] = { helpText = "", waypoints = {} },
            [41651] = { helpText = "", waypoints = {} },
            [41652] = { helpText = "", waypoints = {} },
            [41653] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13094
    [13094] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13097
    [13097] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13101
    [13101] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13105
    [13105] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13109
    [13109] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13113
    [13113] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13116
    [13116] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13122
    [13122] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13124
    [13124] = {
        helpText = "",
        criteria = {
            [41934] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13125
    [13125] = {
        helpText = "",
        criteria = {
            [41935] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13126
    [13126] = {
        helpText = "",
        criteria = {
            [41936] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13127
    [13127] = {
        helpText = "",
        criteria = {
            [41937] = { helpText = "", waypoints = {} },
            [41938] = { helpText = "", waypoints = {} },
            [41939] = { helpText = "", waypoints = {} },
            [41940] = { helpText = "", waypoints = {} },
            [41941] = { helpText = "", waypoints = {} },
            [41942] = { helpText = "", waypoints = {} },
            [41943] = { helpText = "", waypoints = {} },
            [41944] = { helpText = "", waypoints = {} },
            [41945] = { helpText = "", waypoints = {} },
            [41946] = { helpText = "", waypoints = {} },
            [41947] = { helpText = "", waypoints = {} },
            [41948] = { helpText = "", waypoints = {} },
            [41949] = { helpText = "", waypoints = {} },
            [41950] = { helpText = "", waypoints = {} },
            [41951] = { helpText = "", waypoints = {} },
            [41952] = { helpText = "", waypoints = {} },
            [41953] = { helpText = "", waypoints = {} },
            [41954] = { helpText = "", waypoints = {} },
            [41955] = { helpText = "", waypoints = {} },
            [41956] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13128
    [13128] = {
        helpText = "",
        criteria = {
            [41984] = { helpText = "", waypoints = {} },
            [41983] = { helpText = "", waypoints = {} },
            [41982] = { helpText = "", waypoints = {} },
            [41981] = { helpText = "", waypoints = {} },
            [41980] = { helpText = "", waypoints = {} },
            [41979] = { helpText = "", waypoints = {} },
            [41978] = { helpText = "", waypoints = {} },
            [41977] = { helpText = "", waypoints = {} },
            [41976] = { helpText = "", waypoints = {} },
            [41975] = { helpText = "", waypoints = {} },
            [41974] = { helpText = "", waypoints = {} },
            [41973] = { helpText = "", waypoints = {} },
            [41972] = { helpText = "", waypoints = {} },
            [41971] = { helpText = "", waypoints = {} },
            [41970] = { helpText = "", waypoints = {} },
            [41969] = { helpText = "", waypoints = {} },
            [41968] = { helpText = "", waypoints = {} },
            [41967] = { helpText = "", waypoints = {} },
            [41966] = { helpText = "", waypoints = {} },
            [41965] = { helpText = "", waypoints = {} },
            [41964] = { helpText = "", waypoints = {} },
            [41963] = { helpText = "", waypoints = {} },
            [41962] = { helpText = "", waypoints = {} },
            [41961] = { helpText = "", waypoints = {} },
            [41960] = { helpText = "", waypoints = {} },
            [41959] = { helpText = "", waypoints = {} },
            [41958] = { helpText = "", waypoints = {} },
            [41957] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13132
    [13132] = {
        helpText = "",
        criteria = {
            [42041] = { helpText = "", waypoints = {} },
            [42042] = { helpText = "", waypoints = {} },
            [42043] = { helpText = "", waypoints = {} },
            [42044] = { helpText = "", waypoints = {} },
            [42045] = { helpText = "", waypoints = {} },
            [42046] = { helpText = "", waypoints = {} },
            [42047] = { helpText = "", waypoints = {} },
            [42048] = { helpText = "", waypoints = {} },
            [42049] = { helpText = "", waypoints = {} },
            [42050] = { helpText = "", waypoints = {} },
            [42051] = { helpText = "", waypoints = {} },
            [42052] = { helpText = "", waypoints = {} },
            [42053] = { helpText = "", waypoints = {} },
            [42054] = { helpText = "", waypoints = {} },
            [42055] = { helpText = "", waypoints = {} },
            [42056] = { helpText = "", waypoints = {} },
            [42057] = { helpText = "", waypoints = {} },
            [42058] = { helpText = "", waypoints = {} },
            [42059] = { helpText = "", waypoints = {} },
            [42060] = { helpText = "", waypoints = {} },
            [42061] = { helpText = "", waypoints = {} },
            [42062] = { helpText = "", waypoints = {} },
            [42063] = { helpText = "", waypoints = {} },
            [42064] = { helpText = "", waypoints = {} },
            [42065] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13134
    [13134] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13135
    [13135] = {
        helpText = "",
        criteria = {
            [42087] = { helpText = "", waypoints = {} },
            [42088] = { helpText = "", waypoints = {} },
            [42089] = { helpText = "", waypoints = {} },
            [42090] = { helpText = "", waypoints = {} },
            [42091] = { helpText = "", waypoints = {} },
            [42092] = { helpText = "", waypoints = {} },
            [42093] = { helpText = "", waypoints = {} },
            [42094] = { helpText = "", waypoints = {} },
            [42095] = { helpText = "", waypoints = {} },
            [42096] = { helpText = "", waypoints = {} },
            [42097] = { helpText = "", waypoints = {} },
            [42098] = { helpText = "", waypoints = {} },
            [42099] = { helpText = "", waypoints = {} },
            [42100] = { helpText = "", waypoints = {} },
            [42101] = { helpText = "", waypoints = {} },
            [42102] = { helpText = "", waypoints = {} },
            [42103] = { helpText = "", waypoints = {} },
            [42104] = { helpText = "", waypoints = {} },
            [44170] = { helpText = "", waypoints = {} },
            [44171] = { helpText = "", waypoints = {} },
            [44172] = { helpText = "", waypoints = {} },
            [45344] = { helpText = "", waypoints = {} },
            [45345] = { helpText = "", waypoints = {} },
            [45346] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13144
    [13144] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13251
    [13251] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13263
    [13263] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13284
    [13284] = {
        helpText = "",
        criteria = {
            [43642] = { helpText = "", waypoints = {} },
            [43684] = { helpText = "", waypoints = {} },
            [43685] = { helpText = "", waypoints = {} },
            [43686] = { helpText = "", waypoints = {} },
            [43687] = { helpText = "", waypoints = {} },
            [43688] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13289
    [13289] = {
        helpText = "",
        criteria = {
            [43867] = { helpText = "", waypoints = {} },
            [43875] = { helpText = "", waypoints = {} },
            [43876] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13290
    [13290] = {
        helpText = "",
        criteria = {
            [43869] = { helpText = "", waypoints = {} },
            [43870] = { helpText = "", waypoints = {} },
            [43871] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13291
    [13291] = {
        helpText = "",
        criteria = {
            [43872] = { helpText = "", waypoints = {} },
            [43873] = { helpText = "", waypoints = {} },
            [43874] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13294
    [13294] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13296
    [13296] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13385
    [13385] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13395
    [13395] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13398
    [13398] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13414
    [13414] = {
        helpText = "",
        criteria = {
            [44051] = { helpText = "", waypoints = {} },
            [44052] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13433
    [13433] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13437
    [13437] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13466
    [13466] = {
        helpText = "",
        criteria = {
            [44256] = { helpText = "", waypoints = {} },
            [44257] = { helpText = "", waypoints = {} },
            [44258] = { helpText = "", waypoints = {} },
            [44256] = { helpText = "", waypoints = {} },
            [44257] = { helpText = "", waypoints = {} },
            [44258] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13467
    [13467] = {
        helpText = "",
        criteria = {
            [44260] = { helpText = "", waypoints = {} },
            [44261] = { helpText = "", waypoints = {} },
            [44262] = { helpText = "", waypoints = {} },
            [44263] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13470
    [13470] = {
        helpText = "",
        criteria = {
            [45117] = { helpText = "", waypoints = {} },
            [45118] = { helpText = "", waypoints = {} },
            [45119] = { helpText = "", waypoints = {} },
            [45121] = { helpText = "", waypoints = {} },
            [45122] = { helpText = "", waypoints = {} },
            [45123] = { helpText = "", waypoints = {} },
            [45124] = { helpText = "", waypoints = {} },
            [45125] = { helpText = "", waypoints = {} },
            [45126] = { helpText = "", waypoints = {} },
            [45127] = { helpText = "", waypoints = {} },
            [45128] = { helpText = "", waypoints = {} },
            [45129] = { helpText = "", waypoints = {} },
            [45130] = { helpText = "", waypoints = {} },
            [45131] = { helpText = "", waypoints = {} },
            [45132] = { helpText = "", waypoints = {} },
            [45133] = { helpText = "", waypoints = {} },
            [45134] = { helpText = "", waypoints = {} },
            [45135] = { helpText = "", waypoints = {} },
            [45136] = { helpText = "", waypoints = {} },
            [45137] = { helpText = "", waypoints = {} },
            [45138] = { helpText = "", waypoints = {} },
            [45145] = { helpText = "", waypoints = {} },
            [45146] = { helpText = "", waypoints = {} },
            [45157] = { helpText = "", waypoints = {} },
            [45152] = { helpText = "", waypoints = {} },
            [45153] = { helpText = "", waypoints = {} },
            [45154] = { helpText = "", waypoints = {} },
            [45155] = { helpText = "", waypoints = {} },
            [45156] = { helpText = "", waypoints = {} },
            [45158] = { helpText = "", waypoints = {} },
            [45373] = { helpText = "", waypoints = {} },
            [45374] = { helpText = "", waypoints = {} },
            [45410] = { helpText = "", waypoints = {} },
            [45411] = { helpText = "", waypoints = {} },
            [45433] = { helpText = "", waypoints = {} },
            [45691] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13474
    [13474] = {
        helpText = "",
        criteria = {
            [44403] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13477
    [13477] = {
        helpText = "",
        criteria = {
            [44292] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13479
    [13479] = {
        helpText = "",
        criteria = {
            [46287] = { helpText = "", waypoints = {} },
            [44313] = { helpText = "", waypoints = {} },
            [44314] = { helpText = "", waypoints = {} },
            [44315] = { helpText = "", waypoints = {} },
            [44316] = { helpText = "", waypoints = {} },
            [44317] = { helpText = "", waypoints = {} },
            [44318] = { helpText = "", waypoints = {} },
            [44319] = { helpText = "", waypoints = {} },
            [44320] = { helpText = "", waypoints = {} },
            [44321] = { helpText = "", waypoints = {} },
            [44322] = { helpText = "", waypoints = {} },
            [44323] = { helpText = "", waypoints = {} },
            [44324] = { helpText = "", waypoints = {} },
            [44325] = { helpText = "", waypoints = {} },
            [44327] = { helpText = "", waypoints = {} },
            [44328] = { helpText = "", waypoints = {} },
            [44330] = { helpText = "", waypoints = {} },
            [44331] = { helpText = "", waypoints = {} },
            [44332] = { helpText = "", waypoints = {} },
            [44333] = { helpText = "", waypoints = {} },
            [45308] = { helpText = "", waypoints = {} },
            [45326] = { helpText = "", waypoints = {} },
            [45324] = { helpText = "", waypoints = {} },
            [45325] = { helpText = "", waypoints = {} },
            [45327] = { helpText = "", waypoints = {} },
            [44329] = { helpText = "", waypoints = {} },
            [44334] = { helpText = "", waypoints = {} },
            [44335] = { helpText = "", waypoints = {} },
            [44336] = { helpText = "", waypoints = {} },
            [44337] = { helpText = "", waypoints = {} },
            [44338] = { helpText = "", waypoints = {} },
            [44340] = { helpText = "", waypoints = {} },
            [44341] = { helpText = "", waypoints = {} },
            [44342] = { helpText = "", waypoints = {} },
            [44343] = { helpText = "", waypoints = {} },
            [44326] = { helpText = "", waypoints = {} },
            [45323] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13513
    [13513] = {
        helpText = "",
        criteria = {
            [44856] = { helpText = "", waypoints = {} },
            [44857] = { helpText = "", waypoints = {} },
            [44858] = { helpText = "", waypoints = {} },
            [44859] = { helpText = "", waypoints = {} },
            [44860] = { helpText = "", waypoints = {} },
            [44861] = { helpText = "", waypoints = {} },
            [44862] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13517
    [13517] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13541
    [13541] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13556
    [13556] = {
        helpText = "",
        criteria = {
            [45246] = { helpText = "", waypoints = {} },
            [45248] = { helpText = "", waypoints = {} },
            [45249] = { helpText = "", waypoints = {} },
            [45250] = { helpText = "", waypoints = {} },
            [45251] = { helpText = "", waypoints = {} },
            [45252] = { helpText = "", waypoints = {} },
            [45253] = { helpText = "", waypoints = {} },
            [45258] = { helpText = "", waypoints = {} },
            [45255] = { helpText = "", waypoints = {} },
            [45633] = { helpText = "", waypoints = {} },
            [45256] = { helpText = "", waypoints = {} },
            [45257] = { helpText = "", waypoints = {} },
            [45259] = { helpText = "", waypoints = {} },
            [45263] = { helpText = "", waypoints = {} },
            [45264] = { helpText = "", waypoints = {} },
            [45368] = { helpText = "", waypoints = {} },
            [45369] = { helpText = "", waypoints = {} },
            [45370] = { helpText = "", waypoints = {} },
            [45371] = { helpText = "", waypoints = {} },
            [45403] = { helpText = "", waypoints = {} },
            [45405] = { helpText = "", waypoints = {} },
            [45406] = { helpText = "", waypoints = {} },
            [45409] = { helpText = "", waypoints = {} },
            [45609] = { helpText = "", waypoints = {} },
            [45644] = { helpText = "", waypoints = {} },
            [45643] = { helpText = "", waypoints = {} },
            [45645] = { helpText = "", waypoints = {} },
            [45646] = { helpText = "", waypoints = {} },
            [45647] = { helpText = "", waypoints = {} },
            [45648] = { helpText = "", waypoints = {} },
            [45694] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13559
    [13559] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13571
    [13571] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13572
    [13572] = {
        helpText = "",
        criteria = {
            [45334] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13579
    [13579] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13583
    [13583] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13585
    [13585] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13635
    [13635] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13638
    [13638] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13686
    [13686] = {
        helpText = "",
        criteria = {
            [45493] = { helpText = "", waypoints = {} },
            [45494] = { helpText = "", waypoints = {} },
            [45495] = { helpText = "", waypoints = {} },
            [45496] = { helpText = "", waypoints = {} },
            [45497] = { helpText = "", waypoints = {} },
            [45498] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13690
    [13690] = {
        helpText = "",
        criteria = {
            [45504] = { helpText = "", waypoints = {} },
            [45505] = { helpText = "", waypoints = {} },
            [45506] = { helpText = "", waypoints = {} },
            [45507] = { helpText = "", waypoints = {} },
            [45508] = { helpText = "", waypoints = {} },
            [45509] = { helpText = "", waypoints = {} },
            [45510] = { helpText = "", waypoints = {} },
            [45511] = { helpText = "", waypoints = {} },
            [45512] = { helpText = "", waypoints = {} },
            [45513] = { helpText = "", waypoints = {} },
            [45514] = { helpText = "", waypoints = {} },
            [45515] = { helpText = "", waypoints = {} },
            [45516] = { helpText = "", waypoints = {} },
            [45517] = { helpText = "", waypoints = {} },
            [45518] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13691
    [13691] = {
        helpText = "",
        criteria = {
            [45519] = { helpText = "", waypoints = {} },
            [45520] = { helpText = "", waypoints = {} },
            [45521] = { helpText = "", waypoints = {} },
            [45524] = { helpText = "", waypoints = {} },
            [45525] = { helpText = "", waypoints = {} },
            [45527] = { helpText = "", waypoints = {} },
            [45528] = { helpText = "", waypoints = {} },
            [45529] = { helpText = "", waypoints = {} },
            [45530] = { helpText = "", waypoints = {} },
            [45531] = { helpText = "", waypoints = {} },
            [45532] = { helpText = "", waypoints = {} },
            [45533] = { helpText = "", waypoints = {} },
            [45534] = { helpText = "", waypoints = {} },
            [45535] = { helpText = "", waypoints = {} },
            [45536] = { helpText = "", waypoints = {} },
            [45537] = { helpText = "", waypoints = {} },
            [45538] = { helpText = "", waypoints = {} },
            [45539] = { helpText = "", waypoints = {} },
            [45540] = { helpText = "", waypoints = {} },
            [45541] = { helpText = "", waypoints = {} },
            [45543] = { helpText = "", waypoints = {} },
            [45544] = { helpText = "", waypoints = {} },
            [45545] = { helpText = "", waypoints = {} },
            [45546] = { helpText = "", waypoints = {} },
            [45547] = { helpText = "", waypoints = {} },
            [45548] = { helpText = "", waypoints = {} },
            [45549] = { helpText = "", waypoints = {} },
            [45550] = { helpText = "", waypoints = {} },
            [45551] = { helpText = "", waypoints = {} },
            [45553] = { helpText = "", waypoints = {} },
            [45554] = { helpText = "", waypoints = {} },
            [45555] = { helpText = "", waypoints = {} },
            [45556] = { helpText = "", waypoints = {} },
            [45557] = { helpText = "", waypoints = {} },
            [45558] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13699
    [13699] = {
        helpText = "",
        criteria = {
            [45678] = { helpText = "", waypoints = {} },
            [45679] = { helpText = "", waypoints = {} },
            [45680] = { helpText = "", waypoints = {} },
            [45681] = { helpText = "", waypoints = {} },
            [45682] = { helpText = "", waypoints = {} },
            [45683] = { helpText = "", waypoints = {} },
            [45684] = { helpText = "", waypoints = {} },
            [45685] = { helpText = "", waypoints = {} },
            [45686] = { helpText = "", waypoints = {} },
            [45687] = { helpText = "", waypoints = {} },
            [45688] = { helpText = "", waypoints = {} },
            [45689] = { helpText = "", waypoints = {} },
            [45690] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13700
    [13700] = {
        helpText = "",
        criteria = {
            [46294] = { helpText = "", waypoints = {} },
            [46304] = { helpText = "", waypoints = {} },
            [46305] = { helpText = "", waypoints = {} },
            [46306] = { helpText = "", waypoints = {} },
            [46307] = { helpText = "", waypoints = {} },
            [46308] = { helpText = "", waypoints = {} },
            [46309] = { helpText = "", waypoints = {} },
            [46310] = { helpText = "", waypoints = {} },
            [46311] = { helpText = "", waypoints = {} },
            [46312] = { helpText = "", waypoints = {} },
            [45706] = { helpText = "", waypoints = {} },
            [45707] = { helpText = "", waypoints = {} },
            [45708] = { helpText = "", waypoints = {} },
            [45709] = { helpText = "", waypoints = {} },
            [45710] = { helpText = "", waypoints = {} },
            [45711] = { helpText = "", waypoints = {} },
            [45712] = { helpText = "", waypoints = {} },
            [45713] = { helpText = "", waypoints = {} },
            [46294] = { helpText = "", waypoints = {} },
            [46304] = { helpText = "", waypoints = {} },
            [46305] = { helpText = "", waypoints = {} },
            [46306] = { helpText = "", waypoints = {} },
            [46307] = { helpText = "", waypoints = {} },
            [46308] = { helpText = "", waypoints = {} },
            [46309] = { helpText = "", waypoints = {} },
            [46310] = { helpText = "", waypoints = {} },
            [46311] = { helpText = "", waypoints = {} },
            [46312] = { helpText = "", waypoints = {} },
            [45706] = { helpText = "", waypoints = {} },
            [45707] = { helpText = "", waypoints = {} },
            [45708] = { helpText = "", waypoints = {} },
            [45709] = { helpText = "", waypoints = {} },
            [45710] = { helpText = "", waypoints = {} },
            [45711] = { helpText = "", waypoints = {} },
            [45712] = { helpText = "", waypoints = {} },
            [45713] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13707
    [13707] = {
        helpText = "",
        criteria = {
            [45924] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13709
    [13709] = {
        helpText = "",
        criteria = {
            [45756] = { helpText = "", waypoints = {} },
            [45757] = { helpText = "", waypoints = {} },
            [45758] = { helpText = "", waypoints = {} },
            [45756] = { helpText = "", waypoints = {} },
            [45757] = { helpText = "", waypoints = {} },
            [45758] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13711
    [13711] = {
        helpText = "",
        criteria = {
            [45763] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13712
    [13712] = {
        helpText = "",
        criteria = {
            [46048] = { helpText = "", waypoints = {} },
            [46049] = { helpText = "", waypoints = {} },
            [46050] = { helpText = "", waypoints = {} },
            [46051] = { helpText = "", waypoints = {} },
            [46052] = { helpText = "", waypoints = {} },
            [46053] = { helpText = "", waypoints = {} },
            [46054] = { helpText = "", waypoints = {} },
            [46055] = { helpText = "", waypoints = {} },
            [46056] = { helpText = "", waypoints = {} },
            [46057] = { helpText = "", waypoints = {} },
            [46058] = { helpText = "", waypoints = {} },
            [46059] = { helpText = "", waypoints = {} },
            [46060] = { helpText = "", waypoints = {} },
            [46061] = { helpText = "", waypoints = {} },
            [46062] = { helpText = "", waypoints = {} },
            [46063] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13713
    [13713] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13718
    [13718] = {
        helpText = "",
        criteria = {
            [45786] = { helpText = "", waypoints = {} },
            [45787] = { helpText = "", waypoints = {} },
            [45788] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13719
    [13719] = {
        helpText = "",
        criteria = {
            [45794] = { helpText = "", waypoints = {} },
            [45795] = { helpText = "", waypoints = {} },
            [45796] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13722
    [13722] = {
        helpText = "",
        criteria = {
            [45792] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13725
    [13725] = {
        helpText = "",
        criteria = {
            [45797] = { helpText = "", waypoints = {} },
            [45798] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13750
    [13750] = {
        helpText = "",
        criteria = {
            [45735] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13756
    [13756] = {
        helpText = "",
        criteria = {
            [45734] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13757
    [13757] = {
        helpText = "",
        criteria = {
            [45736] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13761
    [13761] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13763
    [13763] = {
        helpText = "",
        criteria = {
            [45846] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13764
    [13764] = {
        helpText = "",
        criteria = {
            [45847] = { helpText = "", waypoints = {} },
            [45848] = { helpText = "", waypoints = {} },
            [45849] = { helpText = "", waypoints = {} },
            [45850] = { helpText = "", waypoints = {} },
            [45851] = { helpText = "", waypoints = {} },
            [45852] = { helpText = "", waypoints = {} },
            [45853] = { helpText = "", waypoints = {} },
            [45854] = { helpText = "", waypoints = {} },
            [45855] = { helpText = "", waypoints = {} },
            [45856] = { helpText = "", waypoints = {} },
            [45857] = { helpText = "", waypoints = {} },
            [45858] = { helpText = "", waypoints = {} },
            [45859] = { helpText = "", waypoints = {} },
            [45860] = { helpText = "", waypoints = {} },
            [45861] = { helpText = "", waypoints = {} },
            [45862] = { helpText = "", waypoints = {} },
            [45863] = { helpText = "", waypoints = {} },
            [45864] = { helpText = "", waypoints = {} },
            [45865] = { helpText = "", waypoints = {} },
            [45866] = { helpText = "", waypoints = {} },
            [45867] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13765
    [13765] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13771
    [13771] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13777
    [13777] = {
        helpText = "",
        criteria = {
            [45958] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13790
    [13790] = {
        helpText = "",
        criteria = {
            [46003] = { helpText = "", waypoints = {} },
            [45999] = { helpText = "", waypoints = {} },
            [46000] = { helpText = "", waypoints = {} },
            [46001] = { helpText = "", waypoints = {} },
            [46002] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13791
    [13791] = {
        helpText = "",
        criteria = {
            [46004] = { helpText = "", waypoints = {} },
            [46005] = { helpText = "", waypoints = {} },
            [46006] = { helpText = "", waypoints = {} },
            [46007] = { helpText = "", waypoints = {} },
            [46008] = { helpText = "", waypoints = {} },
            [46009] = { helpText = "", waypoints = {} },
            [46010] = { helpText = "", waypoints = {} },
            [46011] = { helpText = "", waypoints = {} },
            [46012] = { helpText = "", waypoints = {} },
            [46013] = { helpText = "", waypoints = {} },
            [46014] = { helpText = "", waypoints = {} },
            [46015] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 13836
    [13836] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13924
    [13924] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 13994
    [13994] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 14058
    [14058] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 14059
    [14059] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 14060
    [14060] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 14061
    [14061] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 14066
    [14066] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 14067
    [14067] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 14153
    [14153] = {
        helpText = "",
        criteria = {
            [47201] = { helpText = "", waypoints = {} },
            [47202] = { helpText = "", waypoints = {} },
            [47203] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 14154
    [14154] = {
        helpText = "",
        criteria = {
            [47204] = { helpText = "", waypoints = {} },
            [47205] = { helpText = "", waypoints = {} },
            [47206] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 14155
    [14155] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 14156
    [14156] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 14157
    [14157] = {
        helpText = "",
        criteria = {
            [47209] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 14158
    [14158] = {
        helpText = "",
        criteria = {
            [47210] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 14159
    [14159] = {
        helpText = "",
        criteria = {
            [47211] = { helpText = "", waypoints = {} },
            [47212] = { helpText = "", waypoints = {} },
            [47213] = { helpText = "", waypoints = {} },
            [47214] = { helpText = "", waypoints = {} },
            [47215] = { helpText = "", waypoints = {} },
            [47216] = { helpText = "", waypoints = {} },
            [47217] = { helpText = "", waypoints = {} },
            [47218] = { helpText = "", waypoints = {} },
            [47219] = { helpText = "", waypoints = {} },
            [47220] = { helpText = "", waypoints = {} },
            [47221] = { helpText = "", waypoints = {} },
            [47222] = { helpText = "", waypoints = {} },
            [47223] = { helpText = "", waypoints = {} },
            [47224] = { helpText = "", waypoints = {} },
            [47225] = { helpText = "", waypoints = {} },
            [47226] = { helpText = "", waypoints = {} },
            [47227] = { helpText = "", waypoints = {} },
            [47228] = { helpText = "", waypoints = {} },
            [47229] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 14161
    [14161] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 14193
    [14193] = {
        helpText = "",
        criteria = {
            [46693] = { helpText = "", waypoints = {} },
            [46694] = { helpText = "", waypoints = {} },
            [46695] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 14194
    [14194] = {
        helpText = "",
        criteria = {
            [46696] = { helpText = "", waypoints = {} },
            [46697] = { helpText = "", waypoints = {} },
            [46698] = { helpText = "", waypoints = {} },
            [46699] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 14195
    [14195] = {
        helpText = "",
        criteria = {
            [46700] = { helpText = "", waypoints = {} },
            [46701] = { helpText = "", waypoints = {} },
            [46702] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 14196
    [14196] = {
        helpText = "",
        criteria = {
            [46703] = { helpText = "", waypoints = {} },
            [46704] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 14730
    [14730] = {
        helpText = "",
        criteria = {
            [50236] = { helpText = "", waypoints = {} },
            [50237] = { helpText = "", waypoints = {} },
            [50238] = { helpText = "", waypoints = {} },
            [50239] = { helpText = "", waypoints = {} },
            [50240] = { helpText = "", waypoints = {} },
            [50241] = { helpText = "", waypoints = {} },
            [50242] = { helpText = "", waypoints = {} },
            [50243] = { helpText = "", waypoints = {} },
            [50245] = { helpText = "", waypoints = {} },
            [50244] = { helpText = "", waypoints = {} },
            [50246] = { helpText = "", waypoints = {} },
            [50247] = { helpText = "", waypoints = {} },
        }
    },

    -- A Farewell to Arms: achievement 40953
    [40953] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 40955
    [40955] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 40956
    [40956] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 40957
    [40957] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 40958
    [40958] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 40959
    [40959] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 40960
    [40960] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 40961
    [40961] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 40962
    [40962] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 40963
    [40963] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 41202
    [41202] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 41203
    [41203] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 41204
    [41204] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 41205
    [41205] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 41206
    [41206] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 41207
    [41207] = {
        helpText = "",
    },

    -- A Farewell to Arms: achievement 41209
    [41209] = {
        helpText = "",
    },


    
    -- Note: This file contains waypoint structures for all achievements with criteria found in AWorldAwoken.lua
    -- Achievements with only children (no criteria) are listed but don't have criteria sections
    -- Add waypoints and helpText as needed for each achievement/criteria
}
