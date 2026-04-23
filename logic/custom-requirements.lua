--[[
  Registry for optional map-detail requirements *body* overrides.
  Authoring: optional `requirementsBodyOverrideElement` on flat waypoint entries in achi-list *.waypoints.lua.
  UI modules register via RegisterBodyElement(name, api). Map-detail swaps the ScrollBox body for the custom frame.
]]

MetaAchievementCustomRequirements = MetaAchievementCustomRequirements or {}

local registry = {}
local warnedUnknown = {}

function MetaAchievementCustomRequirements.RegisterBodyElement(name, api)
    if type(name) ~= "string" or name == "" or type(api) ~= "table" or type(api.Create) ~= "function" then
        return false
    end
    registry[name] = api
    return true
end

function MetaAchievementCustomRequirements.GetBodyElement(name)
    if type(name) ~= "string" or name == "" then
        return nil
    end
    return registry[name]
end

--- @return string|nil
function MetaAchievementCustomRequirements.GetBodyOverrideElementName(topAchievementId, achievementId)
    if not AchievementData or type(AchievementData.GetInformation) ~= "function" then
        return nil
    end
    if type(topAchievementId) ~= "number" or type(achievementId) ~= "number" then
        return nil
    end
    local info = AchievementData:GetInformation(topAchievementId, achievementId)
    if not info or type(info.requirementsBodyOverrideElement) ~= "string" or info.requirementsBodyOverrideElement == "" then
        return nil
    end
    return info.requirementsBodyOverrideElement
end

function MetaAchievementCustomRequirements.WarnUnknownBodyElementOnce(name)
    if warnedUnknown[name] then
        return
    end
    warnedUnknown[name] = true
    local prefix = MetaAchievementTitle or "Meta Achievement Tracker"
    print("|cffff9900" .. prefix .. ": Unknown requirements body override \"" .. tostring(name) .. "\".|r")
end

function MetaAchievementCustomRequirements.ReleaseDetailBody(detail)
    if not detail then
        return
    end
    local frame = detail._customRequirementsBodyFrame
    local mountedName = detail._customRequirementsBodyName
    if mountedName and frame then
        local api = registry[mountedName]
        if api and type(api.Release) == "function" then
            api.Release(frame)
        end
    end
    if frame then
        frame:SetParent(nil)
        frame:Hide()
    end
    detail._customRequirementsBodyFrame = nil
    detail._customRequirementsBodyName = nil
end
