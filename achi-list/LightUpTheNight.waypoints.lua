LightUpTheNightWaypoints = {
    -- Main achievement: Worldsoul-Searching (61451)
    [62386] = {
        helpText = "Releases on March 2, 2026, Midnight expansion.",
    },
    --- Forever song ()
    [61961] = { -- Runestone Rush (wowhead.com/achievement=61961; Eversong Woods uiMapID 2395)
        helpText = "Defend all 5 runestones in Eversong Woods. After Saltheril's Soiree, charge each with Latent Arcana (3 per use, from dailies and small treasures); fill the bar, then defeat the stage-2 boss.",
        criteria = {
            [111480] = {
                helpText = "Elrendar River Runestone. Charge with Latent Arcana, defend the event, then defeat the boss.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 47.36, y = 58.64, title = "Elrendar River Runestone" } } } }
            },
            [111481] = {
                helpText = "Ath'ran Runestone (Commander Viskaj).",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 39.13, y = 56.85, title = "Ath'ran Runestone" } } } }
            },
            [111482] = {
                helpText = "Dawnstar Spire Runestone (Hal'nok the Trampler).",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 57.70, y = 53.59, title = "Dawnstar Spire Runestone" } } } }
            },
            [111483] = {
                helpText = "Sanctum of the Moon Runestone (Commander Gravok).",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 41.15, y = 73.81, title = "Sanctum of the Moon Runestone" } } } }
            },
            [111484] = {
                helpText = "Sunstrider Isle Runestone (Claw of the Void).",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 40.46, y = 13.59, title = "Sunstrider Isle Runestone" } } } }
            },
        }
    },
    -- Eversong Woods uiMapID 2395; coords from Wowhead achievement=61507 (varenne /way #2395 list).
    [61507] = { -- A Bloody Song — https://www.wowhead.com/achievement=61507
        criteria = {
            [110166] = { helpText = "Warden of Weeds (pathing).", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 52.61, y = 75.34, title = "Warden of Weeds" } } } } },
            [110167] = { helpText = "Harried Hawkstrider.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 44.64, y = 78.72, title = "Harried Hawkstrider" } } } } },
            [110168] = { helpText = "Overfester Hydra.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 54.71, y = 60.19, title = "Overfester Hydra" } } } } },
            [110169] = { helpText = "Bloated Snapdragon.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 36.56, y = 64.07, title = "Bloated Snapdragon" } } } } },
            [110170] = { helpText = "Cre'van (pathing).", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 63.26, y = 48.10, title = "Cre'van" } } } } },
            [110171] = { helpText = "Coralfang.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 36.33, y = 36.36, title = "Coralfang" } } } } },
            [110172] = { helpText = "Lady Liminus.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 36.65, y = 77.19, title = "Lady Liminus" } } } } },
            [110173] = { helpText = "Terrinor.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 40.25, y = 85.36, title = "Terrinor" } } } } },
            [110174] = { helpText = "Bad Zed.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 49.04, y = 87.77, title = "Bad Zed" } } } } },
            [110175] = { helpText = "Waverly. Click the Lovely Sunflower to summon.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 34.81, y = 20.98, title = "Lovely Sunflower" } } } } },
            [110176] = { helpText = "Banuran.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 56.42, y = 77.60, title = "Banuran" } } } } },
            [110177] = { helpText = "Lost Guardian.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 59.10, y = 79.24, title = "Lost Guardian" } } } } },
            [110178] = { helpText = "Duskburn (pathing).", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 42.43, y = 69.06, title = "Duskburn" } } } } },
            [110179] = { helpText = "Malfunctioning Construct.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 51.69, y = 46.01, title = "Malfunctioning Construct" } } } } },
            [110180] = { helpText = "Dame Bloodshed (pathing).", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 45.65, y = 38.84, title = "Dame Bloodshed" } } } } },
        }
    },
    -- Coords + map split from Wowhead achievement 61960 (varenne /way block: Rookery Cache #2393, rest #2395).
    [61960] = { -- Treasures of Eversong Woods — https://www.wowhead.com/achievement=61960
        criteria = {
            [111471] = {
                helpText = "Rookery Cache. Requires Rookery Key. Buy Tasty Meat from Farstrider Aerieminder and place it at the Mischievous Chick.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_MidnightSilvermoon, x = 24.38, y = 69.58, title = "Rookery Cache" } } } }
            },
            [111472] = {
                helpText = "Triple-Locked Safebox. Requires 3x Tarnished Safebox Key (torch). Grab the torch next to the chest.",
                waypoints = {
                    {
                        kind = "point",
                        coordinates = {
                            { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 38.89, y = 76.09, title = "Triple-Locked Safebox" },
                            { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 40.23, y = 75.83, title = "Tarnished Safebox Key" },
                            { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 37.64, y = 74.83, title = "Tarnished Safebox Key" },
                            { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 38.44, y = 73.45, title = "Tarnished Safebox Key" }
                        }
                    }
                }
            },
            [111473] = {
                helpText = "Gift of the Phoenix. Click the vessel, catch 5 cinders from phoenixes, and deliver them back to where you got the vessel.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 40.96, y = 19.45, title = "Gift of the Phoenix" } } } }
            },
            [111474] = {
                helpText = "Forgotten Ink and Quill.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 43.28, y = 69.48, title = "Forgotten Ink and Quill" } } } }
            },
            [111475] = {
                helpText = "Gilded Armillary Sphere.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 44.62, y = 45.55, title = "Gilded Armillary Sphere" } } } }
            },
            [111476] = {
                helpText = "Antique Nobleman's Signet Ring.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 52.34, y = 45.43, title = "Antique Nobleman's Signet Ring" } } } }
            },
            [111477] = {
                helpText = "Farstrider's Lost Quiver.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 60.69, y = 67.29, title = "Farstrider's Lost Quiver" } } } }
            },
            [111478] = {
                helpText = "Stone Vat of Wine. Grab 10 grapes nearby (main platform), jump around in the vat, buy instant yeast from nearby vendor (main platform).",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 40.44, y = 60.90, title = "Stone Vat of Wine" } } } }
            },
            [111479] = {
                helpText = "Burbling Paint Pot.",
                waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 48.74, y = 75.44, title = "Burbling Paint Pot" } } } }
            },
        }
    },
    [61855] = { -- Explore Eversong Woods
        helpText = "Reveal the covered areas of the world map. Visit each named subzone to discover it.",
        criteria = {
            [112430] = { helpText = "Amani Pass", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 54.03, y = 81.16, title = "Amani Pass" } } } } },
            [112431] = { helpText = "Brightwing Estate", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 62.96, y = 34.32, title = "Brightwing Estate" } } } } },
            [112432] = { helpText = "Fairbreeze Village", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 46.57, y = 43.26, title = "Fairbreeze Village" } } } } },
            [112433] = { helpText = "Goldenmist Village", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 39.36, y = 57.14, title = "Goldenmist Village" } } } } },
            [112434] = { helpText = "Silvermoon City", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_MidnightSilvermoon, x = 50, y = 50, title = "Silvermoon City" } } } } },
            [112435] = { helpText = "Suncrown Village", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 52.41, y = 61.87, title = "Suncrown Village" } } } } },
            [112436] = { helpText = "Sunstrider Isle", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 42.91, y = 20.97, title = "Sunstrider Isle" } } } } },
            [112437] = { helpText = "Tranquillien", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 48.46, y = 63.39, title = "Tranquillien" } } } } },
            [112438] = { helpText = "Windrunner Spire", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 36.80, y = 79.79, title = "Windrunner Spire" } } } } },
        }
    },
    [62185] = { -- Ever Painting (easel pins: Eversong Woods uiMapID 2395)
        helpText = "Discover all painter's easels found outdoors in Eversong Woods.",
        criteria = {
            [111993] = { helpText = "Sway of Red and Gold", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 53.96, y = 75.61, title = "Sway of Red and Gold" } } } } },
            [112030] = { helpText = "Lost Lamppost", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 41.81, y = 56.34, title = "Lost Lamppost" } } } } },
            [112031] = { helpText = "Anar'alah Belore", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 50.75, y = 41.26, title = "Anar'alah Belore" } } } } },
            [112032] = { helpText = "Light Consuming (on platform)", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 55.14, y = 59.67, title = "Light Consuming (on platform)" } } } } },
            [112033] = { helpText = "Babble and Brook", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 46.06, y = 64.28, title = "Babble and Brook" } } } } },
            [112034] = { helpText = "Memories of Ghosts", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 39.00, y = 78.23, title = "Memories of Ghosts" } } } } },
            [112035] = { helpText = "Elrendar's Song", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Eversong_Woods, x = 42.63, y = 62.63, title = "Elrendar's Song" } } } } },
        }
    },
    -- Altar of Blessings: Sacred Buffet Devotee — https://www.wowhead.com/achievement=62121
    -- Custom requirements body: major/minor blessing table (see custom-requirements module). Criteria unchanged in data.
    [62121] = {
        requirementsBodyOverrideElement = "62121-altar-of-blessings-sacred-buffet-devotee",
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
    [61856] = { -- Explore Zul'Aman
        helpText = "Reveal the covered areas of the Zul'Aman zone map.",
        criteria = {
            [112392] = { helpText = "Atal'Aman", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 25.74, y = 47.30, title = "Atal'Aman" } } } } },
            [112393] = { helpText = "Amani'Zar Village", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 43.50, y = 66.89, title = "Amani'Zar Village" } } } } },
            [112394] = { helpText = "Temple of Akil'zon", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 51.77, y = 80.10, title = "Temple of Akil'zon" } } } } },
            [112396] = { helpText = "Temple of Halazzi", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 33.09, y = 32.71, title = "Temple of Halazzi" } } } } },
            [112397] = { helpText = "Temple of Jan'alai", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 51.14, y = 24.06, title = "Temple of Jan'alai" } } } } },
            [112399] = { helpText = "Den of Nalorakk", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 31.58, y = 83.86, title = "Den of Nalorakk" } } } } },
            [112401] = { helpText = "Witherbark Bluffs", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 38.09, y = 26.84, title = "Witherbark Bluffs" } } } } },
            [112395] = { helpText = "Broken Throne", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 29.86, y = 77.36, title = "Broken Throne" } } } } },
            [112398] = { helpText = "Maisara Deeps", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 43.39, y = 42.95, title = "Maisara Deeps" } } } } },
            [112400] = { helpText = "Strait of Hexx'alor", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_ZulAman, x = 53.13, y = 54.45, title = "Strait of Hexx'alor" } } } } },
        }
    },
    -- uiMapID 2413; coords from Wowhead achievement=61520 (purrfecttofu / Selket /way Harandar / #2413).
    [61520] = { -- Explore Harandar — https://www.wowhead.com/achievement=61520
        helpText = "Reveal the covered areas of the world map. Visit each named subzone to discover it.",
        criteria = {
            [219434] = { helpText = "Har'kuai", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 66.38, y = 26.92, title = "Har'kuai" } } } } },
            [222971] = { helpText = "The Den of Echoes", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 37.27, y = 46.91, title = "The Den of Echoes" } } } } },
            [222972] = { helpText = "Fungara Village", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 43.83, y = 64.29, title = "Fungara Village" } } } } },
            [222973] = { helpText = "Vale of Mists (can be stubborn; fly around this area until it discovers).", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 60.79, y = 47.48, title = "Vale of Mists" } } } } },
            [222974] = { helpText = "Gloom Mire", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 51.33, y = 67.80, title = "Gloom Mire" } } } } },
            [222975] = { helpText = "Har'alnor", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 32.50, y = 65.93, title = "Har'alnor" } } } } },
            [222976] = { helpText = "Blooming Lattice", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 55.03, y = 29.66, title = "Blooming Lattice" } } } } },
            [222977] = { helpText = "Har'mara", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 36.52, y = 25.63, title = "Har'mara" } } } } },
            [222978] = { helpText = "Har'athir", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 69.90, y = 51.98, title = "Har'athir" } } } } },
            [222979] = { helpText = "The Den", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 51.12, y = 50.82, title = "The Den" } } } } },
            [222980] = { helpText = "The Grudge Pit", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 70.60, y = 65.32, title = "The Grudge Pit" } } } } },
            [222981] = { helpText = "The Blinding Bloom", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 32.87, y = 76.32, title = "The Blinding Bloom" } } } } },
            [222982] = { helpText = "The Rift of Aln", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 61.61, y = 58.93, title = "The Rift of Aln" } } } } },
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
                helpText = "Meditate at each altar near The Den; NPCs describe items to find. Loot Tattered Ball, Lost Hunting Knife, Rolled Up Pillow, return each to its altar, then open the treasure at the bottom of the pool in The Den. Rewards the Gift of the Cycle toy.",
                waypoints = {
                    {
                        kind = "point",
                        coordinates = {
                            { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 51.13, y = 47.57, title = "Altar of Innocence" },
                            { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 51.12, y = 50.55, title = "Tattered Ball" },
                            { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 47.19, y = 53.12, title = "Altar of Vigor" },
                            { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 45.11, y = 54.12, title = "Lost Hunting Knife" },
                            { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 51.14, y = 58.50, title = "Altar of Wisdom" },
                            { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 51.39, y = 56.00, title = "Rolled Up Pillow" },
                            { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 47.24, y = 50.77, title = "Gift of the Cycle (pool, The Den)" },
                        }
                    }
                }
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
        combineVirtualAndRegularCriteria = true,
        helpText =
        "This achievement can be fully completed on renown 11. First group can be done at R1, but are visible on mini map on R2. Second group R4 and visible on R6. Third group R9 and visible on R11.",
        -- criteriaType 27 = CompletingAQuest; keys are quest IDs (use numeric type: AchievementCriteriaTypes is nil at file load)
        -- Lines sorted ascending by quest id ([92196] … [92316]); map-detail iterates numeric keys in sorted order
        virtualCriteria = {
            [92196] = { text = "Moth 1 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 36.35, y = 48.39, title = "Moth 1"} } } } },
            [92197] = { text = "Moth 2 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 36.11, y = 26.39, title = "Moth 2"} } } } },
            [92198] = { text = "Moth 3 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 49.88, y = 25.51, title = "Moth 3"} } } } },
            [92199] = { text = "Moth 4 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 55.0, y = 27.55, title = "Moth 4"} } } } },
            [92200] = { text = "Moth 5 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 66.3, y = 62.82, title = "Moth 5"} } } } },
            [92201] = { text = "Moth 6 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 33.37, y = 63.49, title = "Moth 6"} } } } },
            [92202] = { text = "Moth 7 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 33.37, y = 75.61, title = "Moth 7"} } } } },
            [92203] = { text = "Moth 8 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 31.84, y = 81.76, title = "Moth 8"} } } } },
            [92204] = { text = "Moth 9 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 42.19, y = 66.51, title = "Moth 9"} } } } },
            [92205] = { text = "Moth 10 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 52.41, y = 80.78, title = "Moth 10"} } } } },
            [92206] = { text = "Moth 11 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 59.44, y = 54.33, title = "Moth 11"} } } } },
            [92207] = { text = "Moth 12 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 38.33, y = 47.44, title = "Moth 12"} } } } },
            [92208] = { text = "Moth 13 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 33.95, y = 44.04, title = "Moth 13"} } } } },
            [92209] = { text = "Moth 14 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 60.34, y = 48.58, title = "Moth 14"} } } } },
            [92210] = { text = "Moth 15 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 43.21, y = 53.65, title = "Moth 15"} } } } },
            [92211] = { text = "Moth 16 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 30.31, y = 73.39, title = "Moth 16"} } } } },
            [92212] = { text = "Moth 17 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 32.62, y = 84.77, title = "Moth 17"} } } } },
            [92213] = { text = "Moth 18 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 32.06, y = 67.08, title = "Moth 18"} } } } },
            [92214] = { text = "Moth 19 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 52.93, y = 50.65, title = "Moth 19"} } } } },
            [92215] = { text = "Moth 20 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 71.38, y = 58.63, title = "Moth 20"} } } } },
            [92216] = { text = "Moth 21 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 63.74, y = 41.45, title = "Moth 21"} } } } },
            [92217] = { text = "Moth 22 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 61.28, y = 35.17, title = "Moth 22"} } } } },
            [92218] = { text = "Moth 23 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 55.79, y = 66.64, title = "Moth 23"} } } } },
            [92219] = { text = "Moth 24 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 55.61, y = 64.29, title = "Moth 24"} } } } },
            [92220] = { text = "Moth 25 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 74.0, y = 57.23, title = "Moth 25"} } } } },
            [92221] = { text = "Moth 26 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 71.71, y = 58.82, title = "Moth 26"} } } } },
            [92222] = { text = "Moth 27 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 60.34, y = 17.77, title = "Moth 27"} } } } },
            [92223] = { text = "Moth 28 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 44.02, y = 38.12, title = "Moth 28"} } } } },
            [92224] = { text = "Moth 29 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 43.06, y = 39.45, title = "Moth 29"} } } } },
            [92225] = { text = "Moth 30 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 46.38, y = 24.88, title = "Moth 30"} } } } },
            [92226] = { text = "Moth 31 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 62.34, y = 37.14, title = "Moth 31"} } } } },
            [92227] = { text = "Moth 32 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 55.14, y = 32.88, title = "Moth 32"} } } } },
            [92228] = { text = "Moth 33 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 66.96, y = 56.57, title = "Moth 33"} } } } },
            [92229] = { text = "Moth 34 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 53.76, y = 59.1, title = "Moth 34"} } } } },
            [92230] = { text = "Moth 35 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 41.61, y = 40.12, title = "Moth 35"} } } } },
            [92231] = { text = "Moth 36 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 47.63, y = 46.96, title = "Moth 36"} } } } },
            [92232] = { text = "Moth 37 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 50.35, y = 33.6, title = "Moth 37"} } } } },
            [92233] = { text = "Moth 38 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 68.69, y = 36.33, title = "Moth 38"} } } } },
            [92234] = { text = "Moth 39 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 50.26, y = 69.66, title = "Moth 39"} } } } },
            [92235] = { text = "Moth 40 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 49.26, y = 75.52, title = "Moth 40"} } } } },
            [92236] = { text = "Moth 41 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 44.78, y = 35.69, title = "Moth 41"} } } } },
            [92237] = { text = "Moth 42 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 51.38, y = 20.32, title = "Moth 42"} } } } },
            [92238] = { text = "Moth 43 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 58.67, y = 30.2, title = "Moth 43"} } } } },
            [92239] = { text = "Moth 44 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 73.71, y = 68.3, title = "Moth 44"} } } } },
            [92240] = { text = "Moth 45 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 73.71, y = 61.73, title = "Moth 45"} } } } },
            [92241] = { text = "Moth 46 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 41.95, y = 37.72, title = "Moth 46"} } } } },
            [92242] = { text = "Moth 47 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 43.26, y = 40.35, title = "Moth 47"} } } } },
            [92243] = { text = "Moth 48 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 46.86, y = 48.47, title = "Moth 48"} } } } },
            [92244] = { text = "Moth 49 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 61.42, y = 37.12, title = "Moth 49"} } } } },
            [92245] = { text = "Moth 50 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 62.43, y = 40.85, title = "Moth 50"} } } } },
            [92246] = { text = "Moth 51 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 41.34, y = 66.13, title = "Moth 51"} } } } },
            [92247] = { text = "Moth 52 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 35.89, y = 74.26, title = "Moth 52"} } } } },
            [92248] = { text = "Moth 53 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 30.8, y = 63.65, title = "Moth 53"} } } } },
            [92249] = { text = "Moth 54 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 36.09, y = 81.44, title = "Moth 54"} } } } },
            [92250] = { text = "Moth 55 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 51.88, y = 76.62, title = "Moth 55"} } } } },
            [92251] = { text = "Moth 56 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 48.27, y = 50.58, title = "Moth 56"} } } } },
            [92252] = { text = "Moth 57 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 61.24, y = 50.46, title = "Moth 57"} } } } },
            [92253] = { text = "Moth 58 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 60.72, y = 45.4, title = "Moth 58"} } } } },
            [92254] = { text = "Moth 59 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 62.49, y = 44.32, title = "Moth 59"} } } } },
            [92255] = { text = "Moth 60 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 54.49, y = 38.85, title = "Moth 60"} } } } },
            [92256] = { text = "Moth 61 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 36.97, y = 48.3, title = "Moth 61"} } } } },
            [92257] = { text = "Moth 62 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 67.97, y = 19.99, title = "Moth 62"} } } } },
            [92258] = { text = "Moth 63 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 54.49, y = 52.06, title = "Moth 63"} } } } },
            [92259] = { text = "Moth 64 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 42.19, y = 22.26, title = "Moth 64"} } } } },
            [92260] = { text = "Moth 65 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 72.87, y = 37.19, title = "Moth 65"} } } } },
            [92261] = { text = "Moth 66 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 65.89, y = 44.71, title = "Moth 66"} } } } },
            [92262] = { text = "Moth 67 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 63.99, y = 48.63, title = "Moth 67"} } } } },
            [92263] = { text = "Moth 68 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 62.49, y = 58.67, title = "Moth 68"} } } } },
            [92264] = { text = "Moth 69 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 65.3, y = 57.74, title = "Moth 69"} } } } },
            [92265] = { text = "Moth 70 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 41.34, y = 68.07, title = "Moth 70"} } } } },
            [92266] = { text = "Moth 71 (Renown 4)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 39.09, y = 55.1, title = "Moth 71"} } } } },
            [92267] = { text = "Moth 72 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 47.24, y = 66.1, title = "Moth 72"} } } } },
            [92268] = { text = "Moth 73 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 47.73, y = 32.85, title = "Moth 73"} } } } },
            [92269] = { text = "Moth 74 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 52.42, y = 29.21, title = "Moth 74"} } } } },
            [92270] = { text = "Moth 75 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 54.54, y = 31.76, title = "Moth 75"} } } } },
            [92271] = { text = "Moth 76 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 71.17, y = 39.1, title = "Moth 76"} } } } },
            [92272] = { text = "Moth 77 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 67.04, y = 48.39, title = "Moth 77"} } } } },
            [92273] = { text = "Moth 78 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 45.01, y = 58.08, title = "Moth 78"} } } } },
            [92274] = { text = "Moth 79 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 54.0, y = 73.03, title = "Moth 79"} } } } },
            [92275] = { text = "Moth 80 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 50.1, y = 80.17, title = "Moth 80"} } } } },
            [92276] = { text = "Moth 81 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 46.1, y = 71.84, title = "Moth 81"} } } } },
            [92277] = { text = "Moth 82 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 53.01, y = 55.98, title = "Moth 82"} } } } },
            [92278] = { text = "Moth 83 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 43.18, y = 27.34, title = "Moth 83"} } } } },
            [92279] = { text = "Moth 84 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 66.5, y = 33.1, title = "Moth 84"} } } } },
            [92280] = { text = "Moth 85 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 72.04, y = 33.14, title = "Moth 85"} } } } },
            [92281] = { text = "Moth 86 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 68.25, y = 27.78, title = "Moth 86"} } } } },
            [92282] = { text = "Moth 87 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 56.02, y = 24.52, title = "Moth 87"} } } } },
            [92283] = { text = "Moth 88 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 48.49, y = 28.27, title = "Moth 88"} } } } },
            [92284] = { text = "Moth 89 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 47.76, y = 23.38, title = "Moth 89"} } } } },
            [92285] = { text = "Moth 90 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 34.63, y = 24.22, title = "Moth 90"} } } } },
            [92286] = { text = "Moth 91 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 44.43, y = 45.18, title = "Moth 91"} } } } },
            [92287] = { text = "Moth 92 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 27.39, y = 70.32, title = "Moth 92"} } } } },
            [92288] = { text = "Moth 93 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 29.84, y = 87.65, title = "Moth 93"} } } } },
            [92289] = { text = "Moth 94 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 65.14, y = 50.85, title = "Moth 94"} } } } },
            [92290] = { text = "Moth 95 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 62.57, y = 64.63, title = "Moth 95"} } } } },
            [92291] = { text = "Moth 96 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 71.73, y = 67.45, title = "Moth 96"} } } } },
            [92292] = { text = "Moth 97 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 69.35, y = 62.94, title = "Moth 97"} } } } },
            [92293] = { text = "Moth 98 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 48.55, y = 26.23, title = "Moth 98"} } } } },
            [92294] = { text = "Moth 99 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 49.04, y = 70.69, title = "Moth 99"} } } } },
            [92295] = { text = "Moth 100 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 34.61, y = 48.54, title = "Moth 100"} } } } },
            [92296] = { text = "Moth 101 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 34.48, y = 68.99, title = "Moth 101"} } } } },
            [92297] = { text = "Moth 102 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 39.21, y = 18.35, title = "Moth 102"} } } } },
            [92299] = { text = "Moth 103 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 56.58, y = 47.65, title = "Moth 103"} } } } },
            [92300] = { text = "Moth 104 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 40.44, y = 34.46, title = "Moth 104"} } } } },
            [92301] = { text = "Moth 105 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 41.59, y = 27.44, title = "Moth 105"} } } } },
            [92302] = { text = "Moth 106 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 50.63, y = 40.62, title = "Moth 106"} } } } },
            [92303] = { text = "Moth 107 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 65.43, y = 27.12, title = "Moth 107"} } } } },
            [92304] = { text = "Moth 108 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 69.03, y = 31.2, title = "Moth 108"} } } } },
            [92305] = { text = "Moth 109 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 59.98, y = 43.05, title = "Moth 109"} } } } },
            [92306] = { text = "Moth 110 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 67.73, y = 68.86, title = "Moth 110"} } } } },
            [92307] = { text = "Moth 111 (Renown 1)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 48.54, y = 55.35, title = "Moth 111"} } } } },
            [92308] = { text = "Moth 112 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 39.36, y = 61.37, title = "Moth 112"} } } } },
            [92309] = { text = "Moth 113 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 56.58, y = 57.16, title = "Moth 113"} } } } },
            [92310] = { text = "Moth 114 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 74.09, y = 53.39, title = "Moth 114"} } } } },
            [92311] = { text = "Moth 115 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 62.51, y = 53.75, title = "Moth 115"} } } } },
            [92312] = { text = "Moth 116 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 28.83, y = 66.91, title = "Moth 116"} } } } },
            [92313] = { text = "Moth 117 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 40.88, y = 51.52, title = "Moth 117"} } } } },
            [92314] = { text = "Moth 118 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 41.06, y = 67.35, title = "Moth 118"} } } } },
            [92315] = { text = "Moth 119 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 69.44, y = 48.98, title = "Moth 119"} } } } },
            [92316] = { text = "Moth 120 (Renown 9)", criteriaType = 27, waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Harandar, x = 75.83, y = 50.15, title = "Moth 120"} } } } },
        }
    },
    --- yelling into the voidstorm (62256)
    -- Criterion IDs from Wowhead data-criteria-id; coords from achievement=62130 (varenne /way #2405, Slayer's Rise #2444).
    [62130] = { -- The Ultimate Predator — https://www.wowhead.com/achievement=62130
        criteria = {
            [222083] = { helpText = "Sundereth the Caller.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 29.51, y = 50.08, title = "Sundereth the Caller" } } } } },
            [222084] = { helpText = "Territorial Voidscythe.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 34.05, y = 82.06, title = "Territorial Voidscythe" } } } } },
            [222085] = { helpText = "Tremora (cave entrance).", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 35.62, y = 81.08, title = "Tremora" } } } } },
            [222086] = { helpText = "Screammaxa the Matriarch.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 43.68, y = 51.51, title = "Screammaxa the Matriarch" } } } } },
            [222087] = { helpText = "Bane of the Vilebloods.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 47.05, y = 80.63, title = "Bane of the Vilebloods" } } } } },
            [222088] = { helpText = "Aeonelle Blackstar (cave entrance).", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 39.49, y = 64.64, title = "Aeonelle Blackstar" } } } } },
            [222089] = { helpText = "Lotus Darkblossom.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 37.88, y = 71.78, title = "Lotus Darkblossom" } } } } },
            [222090] = { helpText = "Queen o' War. Click Crown of the Lost Queen to spawn.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 55.72, y = 79.45, title = "Queen o' War" } } } } },
            [222091] = { helpText = "Ravengerus.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 48.81, y = 53.17, title = "Ravengerus" } } } } },
            [222092] = { helpText = "Rakshur the Bonegrinder (Slayer's Rise).", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Slayers_Rise, x = 46.38, y = 40.93, title = "Rakshur the Bonegrinder" } } } } },
            [222093] = { helpText = "Bilemaw the Gluttonous (cave entrance).", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 35.58, y = 49.30, title = "Bilemaw the Gluttonous" } } } } },
            [222094] = { helpText = "Eruundi (pathing; Slayer's Rise).", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Slayers_Rise, x = 41.64, y = 93.18, title = "Eruundi" } } } } },
            [222095] = { helpText = "Nightbrood.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 40.15, y = 41.19, title = "Nightbrood" } } } } },
            [222096] = { helpText = "Far'thana the Mad.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 53.94, y = 62.72, title = "Far'thana the Mad" } } } } },
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
    [61857] = { -- Explore Voidstorm (coords from Method.gg /way #2405; Slayer's Rise #2444)
        helpText = "Reveal all named subzones on the Voidstorm map. Fly through each marker area.",
        criteria = {
            [112402] = { helpText = "Nexus-Point Antius", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 29.58, y = 53.58, title = "Nexus-Point Antius" } } } } },
            [112403] = { helpText = "Shadowguard Point", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 37.75, y = 47.07, title = "Shadowguard Point" } } } } },
            [112404] = { helpText = "Howling Ridge", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 51.78, y = 70.03, title = "Howling Ridge" } } } } },
            [112405] = { helpText = "Nexus-Point Mid'Ar", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 39.82, y = 83.32, title = "Nexus-Point Mid'Ar" } } } } },
            [112406] = { helpText = "Obscurion Citadel", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 55.74, y = 77.01, title = "Obscurion Citadel" } } } } },
            [112407] = { helpText = "Slayer's Rise", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Slayers_Rise, x = 47.30, y = 72.08, title = "Slayer's Rise" } } } } },
            [112408] = { helpText = "Stormarion Citadel", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 26.52, y = 67.09, title = "Stormarion Citadel" } } } } },
            [112409] = { helpText = "The Ingress", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 35.87, y = 57.89, title = "The Ingress" } } } } },
            [112410] = { helpText = "The Voidspire", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 51.41, y = 56.06, title = "The Voidspire" } } } } },
            [112411] = { helpText = "Nexus-Point Xenas", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.MIDNIGHT_ZONE_Voidstorm, x = 64.00, y = 61.77, title = "Nexus-Point Xenas" } } } } },
        }
    }
}
