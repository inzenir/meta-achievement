--[[
  Delve story activity notifications: scan all AchievementData-registered waypoints for
  criteria rows that opt in (criteriaType 73), intersect with live POI/widget
  cache (MetaAchievementDelveStoryAvailability), and notify when incomplete + active.

  No hardcoded meta or single waypoints table — new lists only need RegisterDataSource + data.
]]

-- Retail 12.x: delve storyline rows; see Glory waypoints file comments.
local CRITERIA_TYPE_DELVE_STORYLINE = 73

local function isCriteriaIncompleteById(achievementId, criteriaId)
    if type(achievementId) ~= "number" or type(criteriaId) ~= "number" then
        return false
    end
    -- Prefer criteria id lookup (stable vs index order / API quirks).
    if type(GetAchievementCriteriaInfoByID) == "function" then
        local ok, _criteriaString, _criteriaType, completed = pcall(GetAchievementCriteriaInfoByID, achievementId, criteriaId)
        if ok and completed ~= nil then
            return completed ~= true
        end
    end
    if type(GetAchievementNumCriteria) ~= "function" or type(GetAchievementCriteriaInfo) ~= "function" then
        return false
    end
    local num = GetAchievementNumCriteria(achievementId) or 0
    for idx = 1, num do
        local _, _, completed, _, _, _, _, _, _, cid = GetAchievementCriteriaInfo(achievementId, idx)
        if cid == criteriaId then
            return completed ~= true
        end
    end
    return false
end

local function formatDelveStoryActiveMessage(topAchievementId, achievementId, storyLabel)
    local label = type(storyLabel) == "string" and storyLabel ~= "" and storyLabel or "story"
    local comment = string.format("%s story is active", label)
    if MetaAchievementActivityNotify and type(MetaAchievementActivityNotify.FormatStandardMessage) == "function" then
        return MetaAchievementActivityNotify.FormatStandardMessage(topAchievementId, achievementId, comment)
    end
    local prefix = "|cffb4b4ff" .. (MetaAchievementTitle or "Meta Achievement Tracker") .. ":|r "
    local metaWrapped = MetaAchievementActivityNotify and type(MetaAchievementActivityNotify.WrapMetaAchievementName) == "function"
        and MetaAchievementActivityNotify.WrapMetaAchievementName("?")
        or "|cffffd200?|r"
    return prefix .. metaWrapped .. ": #" .. tostring(achievementId) .. " - " .. comment
end

function MetaAchievementDelveStoryNotify_TryRefresh()
    if not AchievementData or type(AchievementData.ForEachRegisteredAchievementEntry) ~= "function" then
        return
    end
    if not MetaAchievementDelveStoryAvailability
        or type(MetaAchievementDelveStoryAvailability.IsDelveStoryCriteriaActive) ~= "function"
    then
        return
    end
    if not MetaAchievementActivityNotify or type(MetaAchievementActivityNotify.TryNotify) ~= "function" then
        return
    end

    if type(MetaAchievementActivityNotify.BeginNotificationBurst) == "function" then
        MetaAchievementActivityNotify.BeginNotificationBurst()
    end
    AchievementData:ForEachRegisteredAchievementEntry(function(topAchievementId, achievementId, flatEntry)
        local criteria = flatEntry and flatEntry.criteria
        if type(criteria) ~= "table" then
            return
        end
        for criteriaId, cinfo in pairs(criteria) do
            if type(criteriaId) == "number"
                and type(cinfo) == "table"
                and cinfo.criteriaType == CRITERIA_TYPE_DELVE_STORYLINE
            then
                if isCriteriaIncompleteById(achievementId, criteriaId)
                    and MetaAchievementDelveStoryAvailability.IsDelveStoryCriteriaActive(achievementId, criteriaId)
                then
                    local storyLabel = tostring(criteriaId)
                    if type(GetAchievementCriteriaInfoByID) == "function" then
                        local ok, s = pcall(GetAchievementCriteriaInfoByID, achievementId, criteriaId)
                        if ok and type(s) == "string" and s ~= "" then
                            storyLabel = s
                        end
                    end
                    if storyLabel == tostring(criteriaId) and type(cinfo.name) == "string" and cinfo.name ~= "" then
                        storyLabel = cinfo.name
                    end
                    local desc = string.format("%s story is active", type(storyLabel) == "string" and storyLabel ~= "" and storyLabel or "story")
                    MetaAchievementActivityNotify.TryNotify({
                        feature = "questLine",
                        achievementId = achievementId,
                        dedupeKey = "delve_story:"
                            .. tostring(topAchievementId)
                            .. ":"
                            .. tostring(achievementId)
                            .. ":"
                            .. tostring(criteriaId),
                        message = formatDelveStoryActiveMessage(
                            topAchievementId,
                            achievementId,
                            storyLabel
                        ),
                        cardDescription = desc,
                    })
                end
            end
        end
    end)
    if type(MetaAchievementActivityNotify.EndNotificationBurst) == "function" then
        MetaAchievementActivityNotify.EndNotificationBurst()
    end
end
