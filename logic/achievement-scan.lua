function achiInfo(achievementId, depth)
    depth = depth or 0
    local o = string.rep(" ", depth * 2)
    print(o .. "#" .. achievementId)

    local returnData = {
        id = achievementId
    }
    local tmpChildren = {}
    local tmpCriteria = {}

    local achiCriteriaNumber = GetAchievementNumCriteria(achievementId)

    for i = 1, achiCriteriaNumber do
        local criteriaString, criteriaType, _, _, _, _, _, assetID, _, criteriaID, _, _, _ = GetAchievementCriteriaInfo(achievementId, i)

        print(o .. " >" .. i .. " - " .. criteriaType)

        if criteriaType == 8 then -- another achievement
            print(o .. ".")
            tmpChildren[#tmpChildren+1] = achiInfo(assetID)
        else
            tmpCriteria[#tmpCriteria+1] = { id = criteriaID, name = criteriaString }
        end
    end

    if #tmpChildren > 0 then
        print(o .. "##")
        returnData["children"] = tmpChildren
    end

    if #tmpCriteria > 0 then
        print(o .. ">>")
        returnData["criteria"] = tmpCriteria
    end

    return returnData
end
