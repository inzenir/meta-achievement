LightUpTheNightWaypoints = {
    -- Main achievement: Worldsoul-Searching (61451)
    [62386] = {
        helpText = "Releases on March 2, 2026, Midnight expansion.",
    },
    --- Forever song ()
    [61961] = { -- Runestone Rush
        criteria = {
            [111480] = {
                helpText = "Elrendar River Runestone. Need coordinates.",
                waypoints = {}
            },
            [111481] = {
                helpText = "Ath'ran Runestone (Commander Viskaj).",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_EversongWoods, x = 38.4, y = 55.8, title = "Ath'ran Runestone" } } } }
            },
            [111482] = {
                helpText = "Dawnstar Spire Runestone (Hal'nok the Trampler).",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_EversongWoods, x = 61.4, y = 62.8, title = "Dawnstar Spire Runestone" } } } }
            },
            [111483] = {
                helpText = "Sanctum of the Moon Runestone (Commander Gravok).",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_EversongWoods, x = 41.0, y = 73.8, title = "Sanctum of the Moon Runestone" } } } }
            },
            [111484] = {
                helpText = "Sunstrider Isle Runestone (Claw of the Void).",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_EversongWoods, x = 40.6, y = 13.6, title = "Sunstrider Isle Runestone" } } } }
            },
        }
    },
    [61507] = { -- A Bloody Song
        criteria = {
            [110166] = { helpText = "Warden of Weeds (pathing).", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_QuelThalas, x = 51.60, y = 74.63, title = "Warden of Weeds" } } } } },
            [110167] = { helpText = "Harried Hawkstrider.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_QuelThalas, x = 45.05, y = 78.25, title = "Harried Hawkstrider" } } } } },
            [110168] = { helpText = "Overfester Hydra.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_QuelThalas, x = 54.80, y = 60.23, title = "Overfester Hydra" } } } } },
            [110169] = { helpText = "Bloated Snapdragon.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_QuelThalas, x = 36.47, y = 63.74, title = "Bloated Snapdragon" } } } } },
            [110170] = { helpText = "Cre'van (pathing).", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_QuelThalas, x = 62.58, y = 49.48, title = "Cre'van" } } } } },
            [110171] = { helpText = "Coralfang.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_QuelThalas, x = 36.38, y = 36.37, title = "Coralfang" } } } } },
            [110172] = { helpText = "Lady Liminus.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_QuelThalas, x = 36.66, y = 77.16, title = "Lady Liminus" } } } } },
            [110173] = { helpText = "Terrinor.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_QuelThalas, x = 40.35, y = 85.20, title = "Terrinor" } } } } },
            [110174] = { helpText = "Bad Zed.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_QuelThalas, x = 48.94, y = 87.93, title = "Bad Zed" } } } } },
            [110175] = { helpText = "Waverly. Click the Lovely Sunflower to summon.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_QuelThalas, x = 34.81, y = 20.98, title = "Lovely Sunflower" } } } } },
            [110176] = { helpText = "Banuran.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_QuelThalas, x = 56.77, y = 77.07, title = "Banuran" } } } } },
            [110177] = { helpText = "Lost Guardian.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_QuelThalas, x = 59.36, y = 79.25, title = "Lost Guardian" } } } } },
            [110178] = { helpText = "Duskburn (pathing).", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_QuelThalas, x = 42.55, y = 69.09, title = "Duskburn" } } } } },
            [110179] = { helpText = "Malfunctioning Construct.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_QuelThalas, x = 51.54, y = 45.85, title = "Malfunctioning Construct" } } } } },
            [110180] = { helpText = "Dame Bloodshed (pathing).", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_QuelThalas, x = 44.99, y = 38.55, title = "Dame Bloodshed" } } } } },
        }
    },
    [61960] = { -- Treasures of Eversong Woods
        criteria = {
            [111471] = {
                helpText = "Rookery Cache. Requires Rookery Key. Buy Tasty Meat from Farstrider Aerieminder and place it at the Mischievous Chick.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_EversongWoods, x = 24.33, y = 69.29, title = "Rookery Cache" } } } }
            },
            [111472] = {
                helpText = "Triple-Locked Safebox. Requires 3x Battered Safebox Key. Grab the purple torch next to the chest.",
                waypoints = {
                    {
                        kind = "point",
                        coordinates = {
                            { mapId = MapZones.MIDNIGHT_ZONE_EversongWoods, x = 38.9, y = 76.07, title = "Triple-Locked Safebox" },
                            { mapId = MapZones.MIDNIGHT_ZONE_EversongWoods, x = 37.64, y = 74.84, title = "Battered Safebox Key" },
                            { mapId = MapZones.MIDNIGHT_ZONE_EversongWoods, x = 38.48, y = 73.43, title = "Battered Safebox Key" },
                            { mapId = MapZones.MIDNIGHT_ZONE_EversongWoods, x = 40.23, y = 75.81, title = "Battered Safebox Key" }
                        }
                    }
                }
            },
            [111473] = {
                helpText = "Gift of the Phoenix. Click the vessel, catch 5 cinders from phoenixes, and deliver them back to where you got the vessel.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_EversongWoods, x = 40.96, y = 19.47, title = "Gift of the Phoenix" } } } }
            },
            [111474] = {
                helpText = "Forgotten Ink and Quill.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_EversongWoods, x = 43.28, y = 69.5, title = "Forgotten Ink and Quill" } } } }
            },
            [111475] = {
                helpText = "Gilded Armillary Sphere.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_EversongWoods, x = 44.63, y = 45.55, title = "Gilded Armillary Sphere" } } } }
            },
            [111476] = {
                helpText = "Antique Nobleman's Signet Ring.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_EversongWoods, x = 52.35, y = 45.44, title = "Antique Nobleman's Signet Ring" } } } }
            },
            [111477] = {
                helpText = "Farstrider's Lost Quiver.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_EversongWoods, x = 60.68, y = 67.29, title = "Farstrider's Lost Quiver" } } } }
            },
            [111478] = {
                helpText = "Stone Vat of Wine. Grab 10 grapes nearby (main platform), jump around in the vat, buy instant yeast from nearby vendor (main platform).",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_EversongWoods, x = 40.48, y = 60.88, title = "Stone Vat of Wine" } } } }
            },
            [111479] = {
                helpText = "Burbling Paint Pot.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_EversongWoods, x = 48.74, y = 75.45, title = "Burbling Paint Pot" } } } }
            },
        }
    },
    --- Making and amani out of you ()
    [62122] = { -- Tallest Tree in the Forest
        criteria = {
            [111839] = { helpText = "Necrohexxer Raz'ka.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 34.27, y = 32.91, title = "Necrohexxer Raz'ka" } } } } },
            [111840] = { helpText = "The Snapping Scourge.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 51.61, y = 18.63, title = "The Snapping Scourge" } } } } },
            [111841] = { helpText = "Skullcrusher Harak.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 51.75, y = 72.76, title = "Skullcrusher Harak" } } } } },
            [111842] = { helpText = "Lightwood Borer (cave opening).", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 28.73, y = 24.03, title = "Lightwood Borer" } } } } },
            [111843] = { helpText = "Mrrlokk.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 50.90, y = 65.41, title = "Mrrlokk" } } } } },
            [111844] = { helpText = "Poacher Rav'ik.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 38.99, y = 50.01, title = "Poacher Rav'ik" } } } } },
            [111845] = { helpText = "Spinefrill.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 30.80, y = 45.12, title = "Spinefrill" } } } } },
            [111846] = { helpText = "Oophaga.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 46.45, y = 51.93, title = "Oophaga" } } } } },
            [111847] = { helpText = "Tiny Vermin.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 47.44, y = 34.35, title = "Tiny Vermin" } } } } },
            [111848] = { helpText = "Voidtouched Crustacean.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 21.48, y = 70.69, title = "Voidtouched Crustacean" } } } } },
            [111849] = { helpText = "The Devouring Invader (cave entrance; fly all the way down).", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 39.49, y = 20.32, title = "The Devouring Invader" } } } } },
            [111850] = { helpText = "Elder Oaktalon.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 33.47, y = 88.64, title = "Elder Oaktalon" } } } } },
            [111851] = { helpText = "Depthborn Eelamental.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 47.73, y = 20.73, title = "Depthborn Eelamental" } } } } },
            [111852] = { helpText = "The Decaying Diamondback.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 46.77, y = 43.85, title = "The Decaying Diamondback" } } } } },
            [111853] = { helpText = "Asha the Empowered.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 45.34, y = 41.79, title = "Asha the Empowered" } } } } },
        }
    },
    [62125] = { -- Treasures of Zul'Aman
        criteria = {
            [111854] = {
                helpText = "Abandoned Ritual Skull. Requires 1000 Vile Essence to open (drops from local mobs, low droprate). Contains Hexed Vilefeather Eagle.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 44.41, y = 43.65, title = "Abandoned Ritual Skull" } } } }
            },
            [111855] = {
                helpText = "Honored Warrior's Cache. Fly to the four urn locations, click the Honored Warrior's Urn and kill the spawned mob. Akil'zon's Chosen is bugged as of January 30, 2026 (build 65617). Cache contains Ancestral War Bear.",
                waypoints = {
                    {
                        kind = "point",
                        coordinates = {
                            { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 46.92, y = 82.25, title = "Honored Warrior's Cache (tree entrance)" },
                            { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 32.69, y = 83.50, title = "Nalorakk's Chosen (Urn)" },
                            { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 34.55, y = 33.46, title = "Halazzi's Chosen (Urn)" },
                            { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 54.78, y = 22.39, title = "Jan'alai's Chosen (Urn)" },
                            { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 51.58, y = 84.92, title = "Akil'zon's Chosen (Urn)" }
                        }
                    }
                }
            },
            [111856] = {
                helpText = "Sealed Twilight Blade Bounty. Solve puzzles on the ground floor of all four adjacent towers to unlock. Drops Arsenal: Twilight Blade.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 21.86, y = 77.37, title = "Sealed Twilight Blade Bounty" } } } }
            },
            [111857] = {
                helpText = "Bait and Tackle (cave opening).",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 21.12, y = 67.09, title = "Bait and Tackle" } } } }
            },
            [111858] = {
                helpText = "Burrow Bounty.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 42.02, y = 47.79, title = "Burrow Bounty" } } } }
            },
            [111859] = {
                helpText = "Mrruk's Mangy Trove. Guarded by Mrruk the Musclefin.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 52.33, y = 65.94, title = "Mrruk's Mangy Trove" } } } }
            },
            [111860] = {
                helpText = "Secret Formula. Contains Fetid Dartfrog Idol.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 40.45, y = 35.95, title = "Secret Formula" } } } }
            },
            [111861] = {
                helpText = "Abandoned Nest (on top of a tree). Drops Weathered Eagle Egg.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 42.62, y = 52.45, title = "Abandoned Nest" } } } }
            },
        }
    },
    --- that's aln folks ()
    [61263] = { -- Treasures of Harandar
        criteria = {
            [109033] = {
                helpText = "Failed Shroom Jumper's Satchel. Contains Shroom Jumper's Parachute.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 71.69, y = 31.04, title = "Failed Shroom Jumper's Satchel" } } } }
            },
            [109034] = {
                helpText = "Burning Branch of the World Tree (behind tent). Contains 350 Voidlight Marl.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 47.0, y = 50.33, title = "Burning Branch of the World Tree" } } } }
            },
            [109035] = {
                helpText = "Sporelord's Fight Prize. Contains Sporelord's Authority.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 73.63, y = 65.29, title = "Sporelord's Fight Prize" } } } }
            },
            [109036] = {
                helpText = "Reliquary's Lost Paintbrush. Contains Reliquary-Keeper's Lost Shortbow.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 62.92, y = 51.17, title = "Reliquary's Lost Paintbrush" } } } }
            },
            [109037] = {
                helpText = "Kemet's Simmering Cauldron. Contains Percival.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 55.69, y = 39.43, title = "Kemet's Simmering Cauldron" } } } }
            },
            [110254] = {
                helpText = "Gift of the Cycle. Need coordinates.",
                waypoints = {}
            },
            [110255] = {
                helpText = "Impenetrably Sealed Gourd. Collect Purple and Red Mysterious Fluid in the cave, mix at the upper level, then use Fizzing Fluid to unlock. Contains Perturbed Sporebat.",
                waypoints = {
                    {
                        kind = "point",
                        coordinates = {
                            { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 27.51, y = 67.97, title = "Impenetrably Sealed Gourd (cave entrance)" },
                            { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 26.54, y = 67.93, title = "Mixing spot (upper level)" }
                        }
                    }
                }
            },
            [110256] = {
                helpText = "Sporespawned Cache. Use Fungal Mallet buff from Fungara Village, ring the Mycelium Gong; treasure appears next to the gong. Contains Untainted Grove Crawler mount.",
                waypoints = {
                    {
                        kind = "point",
                        coordinates = {
                            { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 41.3, y = 67.9, title = "Fungal Mallet" },
                            { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 46.6, y = 67.8, title = "Mycelium Gong" }
                        }
                    }
                }
            },
            [110257] = {
                helpText = "Peculiar Cauldron. Needs 150 Crystalized Resin Fragment to unlock. Contains Ruddy Sporeglider mount.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 40.61, y = 27.99, title = "Peculiar Cauldron" } } } }
            },
        }
    },
    [61264] = {
        criteria = {
            [109039] = { helpText = "Rhazul", waypoints = {{ kind="point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 51.2, y = 45.3 } } }}},
            [109040] = { helpText = "Chironex", waypoints = {{ kind="point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 68.7, y = 40.6 } } }}},
            [109041] = { helpText = "Ha'kalawe", waypoints = {{ kind="point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 70.2, y = 60.9 } } }}},
            [109042] = { helpText = "Tallcap the Truthspreader", waypoints = {{ kind="point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 72.6, y = 69.4 } } }}},
            [109043] = { helpText = "Queen Lashtongue", waypoints = {{ kind="point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 60.2, y = 47.1 } } }}},
            [109044] = { helpText = "Chlorokyll", waypoints = {{ kind="point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 64.5, y = 47.7 } } }}},
            [109045] = { helpText = "Stumpy", waypoints = {{ kind="point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 65.3, y = 33.0 } } }}},
            [109046] = { helpText = "Serrasa", waypoints = {{ kind="point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 55.9, y = 31.6 } } }}},
            [109047] = { helpText = "Mindrot", waypoints = {{ kind="point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 46.1, y = 32.2 } } }}},
            [109048] = { helpText = "Dracaena", waypoints = {{ kind="point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 40.5, y = 43.3 } } }}},
            [109049] = { helpText = "Treetop", waypoints = { { kind="point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 36.3, y = 75.4 } } }}},
            [109050] = { helpText = "Oro'ohna", waypoints = {{ kind="point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 28.2, y = 81.8 } } }}},
            [109051] = { helpText = "Pterrock", waypoints = {{ kind="point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 27.4, y = 71.4 } } }}},
            [109052] = { helpText = "Ahl'ua'huhi", waypoints = {{ kind="point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 39.8, y = 60.2 } } }}},
            [109053] = { helpText = "Annulus the Worldshaker", waypoints = {{ kind="point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 43.8, y = 16.8 } } }}},
        }
    },
    [61052] = {
        helpText =
        "This achievement can be fully completed on renown 11. First group can be done at R1, but are visible on mini map on R2. Second group R4 and visible on R6. Third group R9 and visible on R11.",
        virtualCriteria = {
            [1] = {
                text = "Group 1",
                waypoints = {
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 36.4, y = 48.4 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 36.1, y = 26.4 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 49.9, y = 25.5 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 55.0, y = 27.6 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 66.3, y = 62.8 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 33.4, y = 63.5 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 33.4, y = 75.6 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 31.8, y = 81.8 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 42.2, y = 66.5 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 52.4, y = 80.8 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 59.4, y = 54.3 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 38.3, y = 47.4 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 34.0, y = 44.0 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 60.3, y = 48.6 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 43.2, y = 53.7 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 30.3, y = 73.4 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 32.6, y = 84.8 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 32.1, y = 67.1 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 52.9, y = 50.7 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 71.4, y = 58.6 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 46.4, y = 24.9 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 62.3, y = 37.1 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 55.1, y = 32.9 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 67.0, y = 56.6 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 53.8, y = 59.1 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 41.6, y = 40.1 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 47.6, y = 47.0 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 50.4, y = 33.6 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 68.7, y = 36.3 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 50.3, y = 69.7 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 49.3, y = 75.5 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 56.6, y = 47.7 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 40.4, y = 34.5 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 41.6, y = 27.4 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 50.6, y = 40.6 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 65.4, y = 27.1 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 69.0, y = 31.2 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 60.0, y = 43.1 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 67.7, y = 68.9 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 48.5, y = 55.4 } } },
                }
            },
            [2] = {
                text = "Group 2",
                waypoints = {
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 63.7, y = 41.5 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 61.3, y = 35.2 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 55.8, y = 66.6 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 55.6, y = 64.3 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 74.0, y = 57.2 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 71.7, y = 58.8 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 60.3, y = 17.8 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 44.0, y = 38.1 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 43.1, y = 39.5 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 44.8, y = 35.7 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 51.4, y = 20.3 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 58.7, y = 30.2 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 73.7, y = 68.3 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 73.7, y = 61.7 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 42.0, y = 37.7 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 43.3, y = 40.4 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 46.9, y = 48.5 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 61.4, y = 37.1 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 62.4, y = 40.9 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 41.3, y = 66.1 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 35.9, y = 74.3 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 30.8, y = 63.7 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 36.1, y = 81.4 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 51.9, y = 76.6 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 48.3, y = 50.6 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 61.2, y = 50.5 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 60.7, y = 45.4 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 62.5, y = 44.3 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 54.5, y = 38.9 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 37.0, y = 48.3 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 68.0, y = 20.0 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 54.5, y = 52.1 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 42.2, y = 22.3 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 72.9, y = 37.2 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 65.9, y = 44.7 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 64.0, y = 48.6 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 62.5, y = 58.7 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 65.3, y = 57.7 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 41.3, y = 68.1 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 39.1, y = 55.1 } } },
                }
            },
            [3] = {
                text = "Group 3",
                waypoints = {
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 47.2, y = 66.1 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 47.7, y = 32.9 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 52.4, y = 29.2 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 54.5, y = 31.8 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 71.2, y = 39.1 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 67.0, y = 48.4 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 45.0, y = 58.1 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 54.0, y = 73.0 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 50.1, y = 80.2 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 46.1, y = 71.8 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 53.0, y = 56.0 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 43.2, y = 27.3 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 66.5, y = 33.1 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 72.0, y = 33.1 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 68.3, y = 27.8 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 56.0, y = 24.5 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 48.5, y = 28.3 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 47.8, y = 23.4 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 34.6, y = 24.2 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 44.4, y = 45.2 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 27.4, y = 70.3 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 29.8, y = 87.7 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 65.1, y = 50.9 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 62.6, y = 64.6 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 71.7, y = 67.5 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 69.4, y = 62.9 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 48.6, y = 26.2 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 49.0, y = 70.7 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 34.6, y = 48.5 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 34.5, y = 69.0 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 39.2, y = 18.4 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 39.4, y = 61.4 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 56.6, y = 57.2 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 74.1, y = 53.4 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 62.5, y = 53.8 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 28.8, y = 66.9 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 40.9, y = 51.5 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 75.8, y = 50.2 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 69.4, y = 49.0 } } },
                    { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 41.1, y = 67.4 } } },
                }
            },
        }
    },
    --- yelling into the voidstorm (62256)
    [62130] = { -- The Ultimate Predator
        criteria = {
            [111877] = { helpText = "Sundreth the caller", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 46.4, y = 42.8 } } } } },
            [111879] = { helpText = "Tremora", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 35.7, y = 81.1 } } } } },
            [111881] = { helpText = "Bane of the Vilebloods", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 47.2, y = 79.8 } } } } },
            [111883] = { helpText = "Lotus Darkblossom", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 38.0, y = 71.6 } } } } },
            [111885] = { helpText = "Ravengerus", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 48.6, y = 53.6 } } } } },
            [111887] = { helpText = "Bilemaw the Gluttonous", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 35.6, y = 49.4 } } } } },
            [111889] = { helpText = "Nightbrood", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 40.1, y = 41.4 } } } } },
            [111878] = { helpText = "Territorial Voidscythe", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 34.1, y = 82.0 } } } } },
            [111880] = { helpText = "Screammara the Matriarch", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 43.9, y = 51.5 } } } } },
            [111882] = { helpText = "Aeonelle Blackstar", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 39.5, y = 64.6 } } } } },
            [111884] = { helpText = "Queen o' War", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 55.7, y = 79.5 } } } } },
            [111886] = { helpText = "Rakshur the Bonegrinder", waypoints = { { kind = "point", coordinates = { { mapId = 2444, x = 46.5, y = 41.0 } } } } },
            [111888] = { helpText = "Eruundi", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 39.2, y = 92.5 } } } } },
            [111890] = { helpText = "Far'thana the Mad", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 53.9, y = 62.8 } } } } },
        }
    },
    [62126] = { -- Treasures of Voidstorm
        criteria = {
            [111863] = { helpText = "Final Clutch of Predaxas", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 48.9, y = 78.3 } } } } },
            [111866] = { helpText = "Bloody Sack", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 64.5, y = 75.5 } } } } },
            [111868] = { helpText = "Stellar Stash", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 53.2, y = 32.2 } } } } },
            [111870] = { helpText = "Scout's Pack", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 49.1, y = 20.1 } } } } },
            [111872] = { helpText = "Quivering Egg", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 31.5, y = 44.5 } } } } },
            [111874] = { helpText = "Discarded Energy Pike", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 35.7, y = 41.4 } } } } },
            [111876] = { helpText = "Half-Digested Viscera", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 38.1, y = 68.8 } } } } },
            [111864] = { helpText = "Void-Shielded Tomb", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 25.8, y = 67.3 } } } } },
            [111867] = { helpText = "Malignant Chest", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 54.1, y = 43.9 } } } } },
            [111869] = { helpText = "Forgotten Researcher's Cache", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 48.0, y = 78.5 } } } } },
            [111871] = { helpText = "Embedded Spear", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 55.4, y = 75.4 } } } } },
            [111873] = { helpText = "Exaliburn", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 28.3, y = 72.9 } } } } },
            [111875] = { helpText = "Faindel's Quiver", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 43.0, y = 81.9 } } } } },
        }
    },
    [61857] = { -- Explore Voidstorm
        criteria = {
            [112402] = { helpText = "Nexus-Point Antius", waypoints = {} },
            [112403] = { helpText = "Shadowguard Point", waypoints = {} },
            [112404] = { helpText = "Howling Ridge", waypoints = {} },
            [112405] = { helpText = "Nexus-Point Mid'Ar", waypoints = {} },
            [112406] = { helpText = "Obscurion Citadel", waypoints = {} },
            [112407] = { helpText = "Slayer's Rise", waypoints = {} },
            [112408] = { helpText = "Stormarion Citadel", waypoints = {} },
            [112409] = { helpText = "The Ingress", waypoints = {} },
            [112410] = { helpText = "The Voidspire", waypoints = {} },
            [112411] = { helpText = "Nexus-Point Xenas", waypoints = {} },
        }
    }
}
