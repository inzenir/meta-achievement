--[[
    Retail (10.0+) Options panel for Game Menu -> Options -> AddOns.
    Uses Settings.RegisterAddOnSetting to read/write directly to MetaAchievementConfigurationDB.
    SetValueChangedCallback triggers our listeners (EmitChange). When Defaults is clicked from
    our category, we show our own simple dialog instead of Blizzard's.
]]

local ourCategoryID = nil
local WAYPOINT_NO_INTEGRATIONS = "_no_integrations_"

--- Called when a setting value changes in the Blizzard UI. Sync invalid sentinel and notify listeners.
local function OnSettingChanged(setting, variableKey)
    if not MetaAchievementConfigurationDB or not variableKey then return end
    local value = (setting and setting.GetValue and setting:GetValue()) or MetaAchievementConfigurationDB[variableKey]
    if variableKey == "waypointIntegration" and value == WAYPOINT_NO_INTEGRATIONS then
        MetaAchievementConfigurationDB[variableKey] = MetaAchievementConfigurationDB[variableKey] or "native"
        value = MetaAchievementConfigurationDB[variableKey]
    end
    if MetaAchievementSettings and MetaAchievementSettings.EmitChange then
        MetaAchievementSettings:EmitChange(variableKey, value, nil)
    end
end

--- Fallback: proxy getter/setter when RegisterAddOnSetting or direct table binding isn't available.
local function makeGetter(key)
    return function()
        if key == "waypointIntegration" and MapIntegrationBase and MapIntegrationBase.GetInstance then
            local mi = MapIntegrationBase.GetInstance()
            if mi then
                local list = mi:GetIntegrationList()
                if not list or #list == 0 then
                    return WAYPOINT_NO_INTEGRATIONS
                end
            end
        end
        return MetaAchievementSettings and MetaAchievementSettings:Get(key) or (DefaultSettings and DefaultSettings()[key])
    end
end

local function makeSetter(key)
    return function(value)
        if key == "waypointIntegration" and value == WAYPOINT_NO_INTEGRATIONS then
            return
        end
        if MetaAchievementSettings then
            MetaAchievementSettings:Set(key, value)
        end
    end
end

--- Proxy path: when Blizzard UI reports a value change, sync to our DB.
local function setValueChangedCallback(setting, variable)
    if not setting or type(setting.SetValueChangedCallback) ~= "function" then return end
    setting:SetValueChangedCallback(function()
        if not MetaAchievementSettings then return end
        local value = setting.GetValue and setting:GetValue()
        if value == nil then return end
        if variable == "waypointIntegration" and value == WAYPOINT_NO_INTEGRATIONS then return end
        MetaAchievementSettings:Set(variable, value)
    end)
end

local function isOurCategoryCurrent()
    if not ourCategoryID or not SettingsPanel or not SettingsPanel.GetCurrentCategory then
        return false
    end
    local current = SettingsPanel:GetCurrentCategory()
    return current and current.GetID and current:GetID() == ourCategoryID
end

-- Our own reset-defaults dialog: fixed size, dim overlay, opaque, on top (like Blizzard's).
local RESET_DIALOG_NAME = "MetaAchievementResetDefaultsDialog"
local RESET_OVERLAY_NAME = "MetaAchievementResetDefaultsOverlay"
local DIALOG_TOP_OFFSET = 28
local DIALOG_WIDTH = 450
local DIALOG_HEIGHT = 110

local function resetOurOptionsToDefaults()
    if not DefaultSettings then
        return
    end
    local definitions = MetaAchievementOptionsDefinitions or {}
    local defaults = DefaultSettings()
    -- Write defaults into DB so RegisterAddOnSetting-bound controls have the new value.
    if MetaAchievementConfigurationDB then
        for _, def in ipairs(definitions) do
            local key = def.variable
            if key and defaults[key] ~= nil and type(defaults[key]) ~= "table" then
                MetaAchievementConfigurationDB[key] = defaults[key]
            end
        end
    end
    -- Notify our listeners (e.g. map integration).
    if MetaAchievementSettings and MetaAchievementSettings.EmitChange then
        for _, def in ipairs(definitions) do
            local key = def.variable
            if key and defaults[key] ~= nil then
                MetaAchievementSettings:EmitChange(key, defaults[key], nil)
            end
        end
    end
    -- Refresh Blizzard Settings controls. AddOn path uses "MetaAchievement_<key>"; proxy uses "<key>".
    if Settings and Settings.NotifyUpdate then
        for _, def in ipairs(definitions) do
            if def.variable then
                Settings.NotifyUpdate("MetaAchievement_" .. def.variable)
                Settings.NotifyUpdate(def.variable)
            end
        end
    end
end

local function createResetDefaultsOverlay()
    if _G[RESET_OVERLAY_NAME] then
        return _G[RESET_OVERLAY_NAME]
    end
    local overlay = CreateFrame("Frame", RESET_OVERLAY_NAME, UIParent)
    overlay:SetFrameStrata("FULLSCREEN_DIALOG")
    overlay:SetFrameLevel(1)
    overlay:SetAllPoints(UIParent)
    overlay:EnableMouse(true)
    local tex = overlay:CreateTexture(nil, "BACKGROUND")
    tex:SetAllPoints(overlay)
    tex:SetColorTexture(0, 0, 0, 0.5)
    overlay:Hide()
    return overlay
end

local function createResetDefaultsDialog()
    if _G[RESET_DIALOG_NAME] then
        return _G[RESET_DIALOG_NAME]
    end
    local overlay = createResetDefaultsOverlay()
    local dialog = CreateFrame("Frame", RESET_DIALOG_NAME, UIParent, "BackdropTemplate")
    dialog:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 },
    })
    dialog:SetBackdropColor(0.09, 0.09, 0.09, 1)
    -- Solid opaque fill so background is never transparent (backdrop texture can have alpha)
    local bg = dialog:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints(dialog)
    bg:SetColorTexture(0.09, 0.09, 0.09, 1)
    dialog:SetFrameStrata("FULLSCREEN_DIALOG")
    dialog:SetFrameLevel(2)
    dialog:SetScript("OnKeyDown", function(_, key)
        if key == "ESCAPE" then
            overlay:Hide()
            dialog:Hide()
        end
    end)
    dialog:SetScript("OnHide", function()
        overlay:Hide()
    end)
    table.insert(UISpecialFrames, RESET_DIALOG_NAME)

    local label = dialog:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("TOP", 0, -16)
    label:SetPoint("LEFT", 24, 0)
    label:SetPoint("RIGHT", -24, 0)
    label:SetWordWrap(true)
    label:SetJustifyH("CENTER")
    label:SetText("Do you want to reset these settings to their defaults?")

    local cancelBtn = CreateFrame("Button", nil, dialog, "UIPanelButtonTemplate")
    cancelBtn:SetSize(120, 22)
    cancelBtn:SetPoint("BOTTOM", 70, 16)
    cancelBtn:SetText(CANCEL or "Cancel")
    cancelBtn:SetScript("OnClick", function()
        overlay:Hide()
        dialog:Hide()
    end)

    local resetBtn = CreateFrame("Button", nil, dialog, "UIPanelButtonTemplate")
    resetBtn:SetSize(140, 22)
    resetBtn:SetPoint("BOTTOM", -70, 16)
    resetBtn:SetText("Reset Settings")
    resetBtn:SetScript("OnClick", function()
        resetOurOptionsToDefaults()
        overlay:Hide()
        dialog:Hide()
    end)

    dialog:Hide()
    return dialog
end

local function showOurResetDefaultsDialog()
    local overlay = createResetDefaultsOverlay()
    local dialog = createResetDefaultsDialog()
    dialog:SetSize(DIALOG_WIDTH, DIALOG_HEIGHT)
    dialog:SetParent(UIParent)
    dialog:ClearAllPoints()
    local panel = SettingsPanel
    if panel and panel.GetWidth and panel.GetTop then
        local pw = panel:GetWidth()
        local left, bottom, width, height = panel:GetRect()
        -- Position dialog over the Options panel (top-centered), using panel's screen rect
        dialog:SetPoint("TOP", panel, "TOP", 0, -DIALOG_TOP_OFFSET)
        dialog:SetPoint("LEFT", panel, "LEFT", (pw - DIALOG_WIDTH) / 2, 0)
    else
        dialog:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    end
    overlay:Show()
    dialog:Show()
    dialog:SetPropagateKeyboardInput(false)
end

-- When Defaults is clicked: if our category is active, show our dialog; otherwise Blizzard's.
local function hookDefaultsButton()
    if not ourCategoryID then
        return
    end
    C_Timer.After(1, function()
        local panel = SettingsPanel
        if not panel or not panel.GetSettingsList then
            return
        end
        local list = panel:GetSettingsList()
        local header = list and list.Header
        local defaultsBtn = header and header.DefaultsButton
        if not defaultsBtn then
            return
        end
        defaultsBtn:SetScript("OnClick", function()
            if isOurCategoryCurrent() then
                showOurResetDefaultsDialog()
            else
                StaticPopup_Show("GAME_SETTINGS_APPLY_DEFAULTS")
            end
        end)
    end)
end

--- True if we can use RegisterAddOnSetting. If the API signature differs (e.g. no variableTbl), registration may fail; we fall back to proxy per-setting.
local function useAddOnSetting()
    return Settings and Settings.RegisterAddOnSetting and MetaAchievementConfigurationDB and type(MetaAchievementConfigurationDB) == "table"
end

--- Try RegisterAddOnSetting with (category, variableId, variableKey, variableTbl, typeStr, name, defaultValue). Returns setting or nil on error.
local function tryRegisterAddOnSetting(category, variableId, variableKey, variableTbl, typeStr, name, defaultValue)
    local ok, setting = pcall(Settings.RegisterAddOnSetting, category, variableId, variableKey, variableTbl, typeStr, name, defaultValue)
    if ok and setting then
        return setting
    end
    return nil
end

function RegisterMetaAchievementOptionsPanel()
    if not Settings or not Settings.RegisterVerticalLayoutCategory or not Settings.RegisterAddOnCategory then
        return
    end
    -- Ensure DB has all default keys so RegisterAddOnSetting and Get() see valid values.
    if UpdateSettings then
        UpdateSettings()
    end
    local useAddOn = useAddOnSetting()
    if not useAddOn and (not Settings.RegisterProxySetting or not Settings.VarType or not Settings.VarType.Boolean) then
        return
    end
    local VarType = Settings.VarType
    local VarTypeString = Settings.VarType and Settings.VarType.String

    local category = Settings.RegisterVerticalLayoutCategory(MetaAchievementTitle)
    ourCategoryID = category:GetID()
    MetaAchievementSettingsCategoryID = ourCategoryID  -- for key binding: open game settings to this addon

    local definitions = MetaAchievementOptionsDefinitions or {}
    local defaultsTable = (DefaultSettings and DefaultSettings()) or {}
    local groups = MetaAchievementOptionsGroups or {}
    local groupOrder = MetaAchievementOptionsGroupOrder
    if not groupOrder or #groupOrder == 0 then
        -- Derive order from first occurrence in definitions
        groupOrder = {}
        local seen = {}
        for _, def in ipairs(definitions) do
            local g = def.group or "general"
            if not seen[g] then
                seen[g] = true
                groupOrder[#groupOrder + 1] = g
            end
        end
    end

    -- Add a category separator only when there is text (uses MetaAchievementSettingsSeparator_<groupKey>). No text = separator not drawn.
    local function addSeparator(groupKey)
        if not groupKey or not (Settings.RegisterInitializer and Settings.CreateElementInitializer) then return end
        local displayText = groups[groupKey] or groupKey
        if displayText == "" then return end
        local templateName = "MetaAchievementSettingsSeparator_" .. groupKey
        local ok, initializer = pcall(Settings.CreateElementInitializer, templateName, {})
        if ok and initializer then
            Settings.RegisterInitializer(category, initializer)
        end
    end

    -- Build panel by category: separator (only if group has text) then options.
    for _, groupKey in ipairs(groupOrder) do
        addSeparator(groupKey)
        for _, def in ipairs(definitions) do
            if (def.group or "general") ~= groupKey then
                -- skip
            elseif def.variable then
                -- Lazy options (e.g. waypointIntegration): need at least one option so dropdown is created; getOptions() returns live list or "no integrations" when shown
                if def.optionsSource == "waypointIntegration" then
                    def.options = def.options or { { value = WAYPOINT_NO_INTEGRATIONS, label = "No map integrations available." } }
                end

                local variable = def.variable
                local name = def.name or variable
                local tooltip = def.tooltip or name
                local varTypeKey = (def.varType or "boolean"):lower()

                -- BUTTON (label + action button via Blizzard's CreateSettingsButtonInitializer; action dispatched by def.action)
                if varTypeKey == "button" and CreateSettingsButtonInitializer and Settings.RegisterInitializer then
                    local actionName = def.action or def.variable
                    local buttonActions = {
                        clearAllWaypoints = function()
                            if MapIntegrationBase and MapIntegrationBase.RemoveAllWaypoints then
                                MapIntegrationBase.RemoveAllWaypoints()
                            end
                        end,
                    }
                    local buttonClick = (actionName and buttonActions[actionName]) or function() end
                    local buttonText = def.buttonText or "Clear"
                    local initializer = CreateSettingsButtonInitializer(
                        name,
                        buttonText,
                        buttonClick,
                        tooltip,
                        true,
                        nil,
                        nil
                    )
                    if initializer then
                        Settings.RegisterInitializer(category, initializer)
                    end
                -- BOOLEAN TYPES
                elseif varTypeKey == "boolean" and VarType and VarType.Boolean then
                    local defaultValue = (defaultsTable[variable] ~= nil) and defaultsTable[variable] or false
                    local setting
                    if useAddOn then
                        local variableId = "MetaAchievement_" .. variable
                        setting = tryRegisterAddOnSetting(category, variableId, variable, MetaAchievementConfigurationDB, type(defaultValue), name, defaultValue)
                        if setting and type(setting.SetValueChangedCallback) == "function" then
                            setting:SetValueChangedCallback(function() OnSettingChanged(setting, variable) end)
                        end
                    end
                    if not setting then
                        setting = Settings.RegisterProxySetting(category, variable, VarType.Boolean, name, defaultValue, makeGetter(variable), makeSetter(variable))
                        setValueChangedCallback(setting, variable)
                    end
                    if setting then
                        Settings.CreateCheckbox(category, setting, tooltip)
                    end
                -- SELECT TYPES
                elseif varTypeKey == "select" and def.options and #(def.options or {}) > 0 and VarTypeString and Settings.CreateDropdown and Settings.CreateControlTextContainer then
                    local defaultValue = (defaultsTable[variable] ~= nil) and defaultsTable[variable] or (def.options[1] and def.options[1].value)
                    local setting
                    if useAddOn then
                        local variableId = "MetaAchievement_" .. variable
                        setting = tryRegisterAddOnSetting(category, variableId, variable, MetaAchievementConfigurationDB, type(defaultValue), name, defaultValue)
                        if setting and type(setting.SetValueChangedCallback) == "function" then
                            setting:SetValueChangedCallback(function() OnSettingChanged(setting, variable) end)
                        end
                    end
                    if not setting then
                        setting = Settings.RegisterProxySetting(category, variable, VarTypeString, name, defaultValue, makeGetter(variable), makeSetter(variable))
                        setValueChangedCallback(setting, variable)
                    end
                    if setting then
                        local function getOptions()
                            local optionsToUse = def.options
                            if def.optionsSource == "waypointIntegration" and MapIntegrationBase and MapIntegrationBase.GetInstance then
                                local mi = MapIntegrationBase.GetInstance()
                                if mi then
                                    -- Only run registration callbacks when list is empty (e.g. options opened before PLAYER_ENTERING_WORLD). Otherwise we'd re-run Native/TomTom on every dropdown refresh and cause constant re-registration.
                                    local list = mi:GetIntegrationList()
                                    if not list or #list == 0 then
                                        if MapIntegrationBase.RunRegistrationCallbacks then
                                            MapIntegrationBase.RunRegistrationCallbacks(mi)
                                        end
                                        list = mi:GetIntegrationList()
                                    end
                                    optionsToUse = {}
                                    for _, item in ipairs(list or {}) do
                                        optionsToUse[#optionsToUse + 1] = { value = item.name, label = item.label }
                                    end
                                end
                                if not optionsToUse or #optionsToUse == 0 then
                                    optionsToUse = { { value = WAYPOINT_NO_INTEGRATIONS, label = "No map integrations available." } }
                                end
                            end
                            local container = Settings.CreateControlTextContainer()
                            if not container then return {} end
                            for _, opt in ipairs(optionsToUse or {}) do
                                if opt.value ~= nil and opt.label then
                                    container:Add(opt.value, opt.label)
                                end
                            end
                            return container.GetData and container:GetData() or {}
                        end
                        Settings.CreateDropdown(category, setting, getOptions, tooltip)
                    end
                end
            end
        end
    end
    
    Settings.RegisterAddOnCategory(category)
    hookDefaultsButton()

    -- Refresh waypoint integration dropdown when Settings panel is shown (defer to avoid re-entering layout and C stack overflow).
    if SettingsPanel and SettingsPanel.SetScript and Settings.NotifyUpdate then
        local origOnShow = SettingsPanel:GetScript("OnShow")
        SettingsPanel:SetScript("OnShow", function(...)
            if origOnShow then origOnShow(...) end
            C_Timer.After(0, function()
                if Settings and Settings.NotifyUpdate then
                    Settings.NotifyUpdate("waypointIntegration")
                    Settings.NotifyUpdate("MetaAchievement_waypointIntegration")
                end
            end)
        end)
    end
end
