--[[
    LibDataBroker launcher + LibDBIcon minimap button (toggle journal UI).
    Registration runs from EntryPoint after SavedVariables and toggle helpers exist.
]]

local ADDON_NAME = "Worldsoul_Searching"
local ICON = "Interface\\AddOns\\Worldsoul_Searching\\images\\achievement_zone_isleofdorn"

function MetaAchievement_RegisterMinimapButton()
    local ldb = LibStub("LibDataBroker-1.1", true)
    local iconLib = LibStub("LibDBIcon-1.0", true)
    if not ldb or not iconLib or not MetaAchievementConfigurationDB then
        return
    end

    if UpdateSettings then
        UpdateSettings()
    end

    local db = MetaAchievementConfigurationDB.minimapIcon
    if not db then
        MetaAchievementConfigurationDB.minimapIcon = { hide = false }
        db = MetaAchievementConfigurationDB.minimapIcon
    end

    local dataObj = ldb:GetDataObjectByName(ADDON_NAME)
    if not dataObj then
        dataObj = ldb:NewDataObject(ADDON_NAME, {
            type = "launcher",
            icon = ICON,
            label = MetaAchievementTitle or ADDON_NAME,
            OnClick = function(_, btn)
                if btn == "RightButton" then
                    if Settings and type(Settings.OpenToCategory) == "function" and MetaAchievementSettingsCategoryID then
                        Settings.OpenToCategory(MetaAchievementSettingsCategoryID)
                    end
                else
                    MetaAchievement_ToggleWindowVisibility()
                end
            end,
            OnTooltipShow = function(tooltip)
                tooltip:SetText(MetaAchievementTitle or "Worldsoul Searching")
                tooltip:AddLine("Click to toggle the achievement journal.", 1, 1, 1, true)
                tooltip:AddLine("Right-click for addon options.", 0.8, 0.8, 0.8, true)
            end,
        })
    end

    if dataObj and not iconLib:GetMinimapButton(ADDON_NAME) then
        iconLib:Register(ADDON_NAME, dataObj, db)
    end
end
