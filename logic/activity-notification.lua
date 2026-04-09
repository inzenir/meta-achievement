--[[
  Chat notifications for world-quest and quest-line activity (DEV-020).
  Dedupe + per-key cooldown + global minimum interval between any two messages.
]]

MetaAchievementActivityNotify = MetaAchievementActivityNotify or {}

local function getAddonChatPrefix()
    local name = MetaAchievementTitle or "Meta Achievement Tracker"
    return "|cffb4b4ff" .. name .. ":|r "
end

--- Colored chat prefix for notifications; uses `MetaAchievementTitle` from bindings-localization.
function MetaAchievementActivityNotify.GetAddonChatPrefix()
    return getAddonChatPrefix()
end

-- Blizzard-style gold (`|cffffd200`) for meta achievement titles in chat.
function MetaAchievementActivityNotify.WrapMetaAchievementName(name)
    local s = (type(name) == "string" and name ~= "") and name or "?"
    return "|cffffd200" .. s .. "|r"
end

--- Standard line: "<addon name>: <meta achievement name>: <child achievement> - <comment>"
--- Addon segment is tinted blue; meta segment is gold; child + comment are plain. If `topAchievementId` is nil, resolves via `AchievementData:FindTopAchievementIdForChild`.
--- Remove WoW color / texture link markup for plain FontString display (card toasts).
function MetaAchievementActivityNotify.StripMarkupForPlainText(s)
    if type(s) ~= "string" then
        return ""
    end
    local out = s
    out = out:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
    out = out:gsub("|T.-|t", "")
    return out
end

--- Plain-text lines for card UI: meta title, child achievement title, description (no color codes).
function MetaAchievementActivityNotify.GetStandardMessageParts(topAchievementId, achievementId, comment)
    local metaName = "?"
    local topId = topAchievementId
    if type(topId) ~= "number" and AchievementData and type(AchievementData.FindTopAchievementIdForChild) == "function" then
        topId = AchievementData:FindTopAchievementIdForChild(achievementId)
    end
    if type(topId) == "number" and type(GetAchievementInfo) == "function" then
        local _, n = GetAchievementInfo(topId)
        if type(n) == "string" and n ~= "" then
            metaName = n
        end
    end
    local achName = "#" .. tostring(achievementId)
    if type(GetAchievementInfo) == "function" then
        local _, n = GetAchievementInfo(achievementId)
        if type(n) == "string" and n ~= "" then
            achName = n
        end
    end
    local c = comment
    if type(c) ~= "string" or c == "" then
        c = "?"
    end
    return metaName, achName, c
end

function MetaAchievementActivityNotify.FormatStandardMessage(topAchievementId, achievementId, comment)
    local prefix = getAddonChatPrefix()
    local metaName, achName, c = MetaAchievementActivityNotify.GetStandardMessageParts(topAchievementId, achievementId, comment)
    return prefix
        .. MetaAchievementActivityNotify.WrapMetaAchievementName(metaName)
        .. ": "
        .. achName
        .. " - "
        .. c
end

-- Minimum seconds between any two activity notifications (flood cap; spike ~60–120s).
-- Skipped while notificationBurstDepth > 0 so one scanner pass can emit multiple distinct
-- matches (e.g. several active delve stories) without silencing the rest in the same frame.
local GLOBAL_MIN_INTERVAL_SEC = 90

local lastByKey = {}
local lastGlobal = 0
local notificationBurstDepth = 0

--- Call around a full scan loop that may invoke TryNotify several times with different dedupeKeys.
--- Per-key cooldown still applies; only the global minimum interval is suppressed.
function MetaAchievementActivityNotify.BeginNotificationBurst()
    notificationBurstDepth = notificationBurstDepth + 1
end

function MetaAchievementActivityNotify.EndNotificationBurst()
    if notificationBurstDepth > 0 then
        notificationBurstDepth = notificationBurstDepth - 1
    end
end

local function defaultCooldownSec()
    local s = MetaAchievementSettings and MetaAchievementSettings:Get("activityNotifyCooldownSec")
    if type(s) == "number" and s > 0 then
        return s
    end
    return 21600
end

--- opts.feature: "worldQuest" | "questLine"
--- opts.achievementId: number (required)
--- opts.dedupeKey: string (required for stable cooldown)
--- opts.questId / opts.questLineId: optional (for default message)
--- opts.topAchievementId: optional; overrides meta segment in default message (else resolved from registry)
--- opts.message: optional full override (skips FormatStandardMessage)
--- opts.cardDescription: optional plain description line for cards when `message` is a custom override (e.g. delve story text)
function MetaAchievementActivityNotify.TryNotify(opts)
    if type(opts) ~= "table" then
        return
    end
    local feature = opts.feature
    if feature == "worldQuest" then
        if not MetaAchievementSettings or not MetaAchievementSettings:Get("enableWorldQuestNotifications") then
            return
        end
    elseif feature == "questLine" then
        if not MetaAchievementSettings or not MetaAchievementSettings:Get("enableDelveStoryNotifications") then
            return
        end
    else
        return
    end

    local achievementId = opts.achievementId
    if type(achievementId) ~= "number" then
        return
    end
    if MetaAchievementQuestRegistry and type(MetaAchievementQuestRegistry.IsAchievementIncompleteForPlayer) == "function" then
        if not MetaAchievementQuestRegistry.IsAchievementIncompleteForPlayer(achievementId) then
            return
        end
    end

    local dedupeKey = opts.dedupeKey
    if type(dedupeKey) ~= "string" or dedupeKey == "" then
        return
    end

    local now = GetTime and GetTime() or 0
    local cool = defaultCooldownSec()
    local prev = lastByKey[dedupeKey]
    if prev and (now - prev) < cool then
        return
    end
    if notificationBurstDepth == 0 and (now - lastGlobal) < GLOBAL_MIN_INTERVAL_SEC then
        return
    end

    local topId = opts.topAchievementId
    if type(topId) ~= "number" and AchievementData and type(AchievementData.FindTopAchievementIdForChild) == "function" then
        topId = AchievementData:FindTopAchievementIdForChild(achievementId)
    end

    local commentLine
    if type(opts.cardDescription) == "string" and opts.cardDescription ~= "" then
        commentLine = opts.cardDescription
    elseif feature == "worldQuest" then
        commentLine = string.format("related world quest may be active (quest %s)", tostring(opts.questId or "?"))
    else
        commentLine = string.format("related quest line may be available (line %s)", tostring(opts.questLineId or "?"))
    end

    local msg = opts.message
    if type(msg) ~= "string" or msg == "" then
        msg = MetaAchievementActivityNotify.FormatStandardMessage(topId, achievementId, commentLine)
    end

    local metaTitle, achievementTitle, descriptionText = MetaAchievementActivityNotify.GetStandardMessageParts(topId, achievementId, commentLine)

    local deliveryMode = "both"
    if MetaAchievementSettings and type(MetaAchievementSettings.Get) == "function" then
        local dm = MetaAchievementSettings:Get("activityNotifyDeliveryMode")
        if dm == "cards" or dm == "both" or dm == "chat" then
            deliveryMode = dm
        end
    end

    if deliveryMode == "chat" or deliveryMode == "both" then
        if DEFAULT_CHAT_FRAME and DEFAULT_CHAT_FRAME.AddMessage then
            DEFAULT_CHAT_FRAME:AddMessage(msg, 1, 1, 1)
        else
            print(msg)
        end
    end

    if deliveryMode == "cards" or deliveryMode == "both" then
        if MetaAchievementActivityCardNotify and type(MetaAchievementActivityCardNotify.TryShow) == "function" then
            MetaAchievementActivityCardNotify.TryShow({
                feature = feature,
                achievementId = achievementId,
                dedupeKey = dedupeKey,
                message = msg,
                metaTitle = metaTitle,
                achievementTitle = achievementTitle,
                description = descriptionText,
            })
        end
    end

    lastByKey[dedupeKey] = now
    lastGlobal = now
end
