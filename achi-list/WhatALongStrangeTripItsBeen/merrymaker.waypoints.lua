-- Waypoints for "Merrymaker" (1691) - Winter Veil (event 141)
-- Part of What a Long, Strange Trip It's Been (2144)

WhatALongStrangeTripItsBeen_MerrymakerWaypoints = {
    [1691] = {
        helpText = "Merrymaker: Complete all Winter Veil achievements (event 141). Two achievements are faction-specific: Scrooge (259 Horde / 1255 Alliance) and Holiday Bromance (1685 Horde / 1686 Alliance). Others: On Metzen!, With a Little Helper from My Friends, Fa-la-la-la-Ogri'la, 'Tis the Season, Simply Abominable, Let It Snow, The Winter Veil Gourmet, He Knows If You've Been Naughty, A Frosty Shake.",
    },
    [259] = {
        helpText = "Scrooge (Horde): Throw a snowball at Baine Bloodhoof in Thunder Bluff during Winter Veil. Get snowballs from snow mounds.",
        waypoints = { { kind = "point", coordinates = { { mapId = MapZones.WOW_ZONE_ThunderBluff, x = 60, y = 51, title = "Baine Bloodhoof (Scrooge - Horde)" } } } },
    },
    [1255] = {
        helpText = "Scrooge (Alliance): Throw a snowball at King Magni Bronzebeard in Ironforge during Winter Veil. Get snowballs from snow mounds.",
        waypoints = { { kind = "point", coordinates = { { mapId = MapZones.WOW_ZONE_Ironforge, x = 39, y = 56, title = "King Magni Bronzebeard (Scrooge - Alliance)" } } } },
    },
    [1685] = {
        helpText = "Holiday Bromance (Horde): Use Mistletoe on Brother Malach (Undercity), Durkot Wolfbrother (Warsong Hold, Borean Tundra), and Brother Keltan (Icecrown). Get Mistletoe by /kiss on Winter Revelers under mistletoe.",
        criteria = {
            [6225] = { helpText = "Brother Malach in the Undercity.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.WOW_ZONE_Undercity, x = 67, y = 38, title = "Brother Malach (Undercity)" } } } } },
            [6226] = { helpText = "Durkot Wolfbrother in Warsong Hold.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.WOTLK_ZONE_BoreanTundra, x = 42, y = 54, title = "Durkot Wolfbrother (Warsong Hold)" } } } } },
            [6662] = { helpText = "Brother Keltan in Icecrown.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.WOTLK_ZONE_Icecrown, x = 54, y = 71, title = "Brother Keltan (Icecrown)" } } } } },
        },
    },
    [1686] = {
        helpText = "Holiday Bromance (Alliance): Use Mistletoe on 8 brothers: Brother Nimetz (Stranglethorn Vale), Brother Karman (Theramore, Dustwallow Marsh), Brother Wilhelm (Goldshire), and Brothers Joshua, Cassius, Kristoff, Crowley, Benjamin (Stormwind). Get Mistletoe by /kiss on Winter Revelers under mistletoe.",
        criteria = {
            [6227] = { helpText = "Brother Nimetz in Stranglethorn Vale.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.WOW_ZONE_NorthernStranglethorn, x = 38, y = 50, title = "Brother Nimetz (Northern Stranglethorn)" } } } } },
            [6228] = { helpText = "Brother Kristoff in Stormwind.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.WOW_ZONE_StormwindCity, x = 49, y = 39, title = "Brothers in Stormwind (Cathedral Square)" } } } } },
            [6229] = { helpText = "Brother Crowley in Stormwind.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.WOW_ZONE_StormwindCity, x = 49, y = 39, title = "Brothers in Stormwind (Cathedral Square)" } } } } },
            [6230] = { helpText = "Brother Benjamin in Stormwind.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.WOW_ZONE_StormwindCity, x = 49, y = 39, title = "Brothers in Stormwind (Cathedral Square)" } } } } },
            [6231] = { helpText = "Brother Wilhelm in Goldshire.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.WOW_ZONE_ElwynnForest, x = 43.5, y = 65.8, title = "Brother Wilhelm (Goldshire)" } } } } },
            [6232] = { helpText = "Brother Karman in Theramore.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.WOW_ZONE_DustwallowMarsh, x = 66.4, y = 45.2, title = "Brother Karman (Theramore)" } } } } },
            [6233] = { helpText = "Brother Joshua in Stormwind.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.WOW_ZONE_StormwindCity, x = 49, y = 39, title = "Brothers in Stormwind (Cathedral Square)" } } } } },
            [6234] = { helpText = "Brother Cassius in Stormwind.", waypoints = { { kind = "point", coordinates = { { mapId = MapZones.WOW_ZONE_StormwindCity, x = 49, y = 39, title = "Brothers in Stormwind (Cathedral Square)" } } } } },
        },
    },
}
