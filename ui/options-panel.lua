--[[
    Retail (10.0+) Options panel for Game Menu -> Options -> AddOns.
    Uses Settings.RegisterVerticalLayoutCategory and RegisterProxySetting.
    When Defaults is clicked from our category, we show our own simple dialog
    instead of Blizzard's (no "All Settings" option, just Cancel and Reset these settings).
]]

local ourCategoryID = nil

local function getDefault(key)
    if MetaAchievementConfigurationDB and MetaAchievementConfigurationDB[key] ~= nil then
        return MetaAchievementConfigurationDB[key]
    end
    local defaults = DefaultSettings()
    return defaults and defaults[key]
end

local function makeGetter(key)
    return function()
        return getDefault(key)
    end
end

local function makeSetter(key)
    return function(value)
        if MetaAchievementConfigurationDB then
            MetaAchievementConfigurationDB[key] = value
        end
    end
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
    if not MetaAchievementConfigurationDB or not DefaultSettings then
        return
    end
    local definitions = MetaAchievementOptionsDefinitions or {}
    local defaults = DefaultSettings()
    for _, def in ipairs(definitions) do
        local key = def.variable
        if key and defaults[key] ~= nil then
            MetaAchievementConfigurationDB[key] = defaults[key]
        end
    end
    if Settings and Settings.NotifyUpdate then
        for _, def in ipairs(definitions) do
            if def.variable then
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

function RegisterMetaAchievementOptionsPanel()
    if not Settings or not Settings.RegisterVerticalLayoutCategory or not Settings.RegisterAddOnCategory then
        return
    end
    if not Settings.RegisterProxySetting or not Settings.VarType or not Settings.VarType.Boolean then
        return
    end

    local category = Settings.RegisterVerticalLayoutCategory(MetaAchievementTitle)
    ourCategoryID = category:GetID()

    local VarType = Settings.VarType
    local noDefaultButton = Settings.CannotDefault
    local definitions = MetaAchievementOptionsDefinitions or {}

    for _, def in ipairs(definitions) do
        local variable = def.variable
        local name = def.name or variable
        local tooltip = def.tooltip or name
        local varTypeKey = (def.varType or "boolean"):lower()
        if not variable then
            break
        end
        if varTypeKey == "boolean" and VarType.Boolean then
            local setting = Settings.RegisterProxySetting(category, variable, VarType.Boolean, name, noDefaultButton, makeGetter(variable), makeSetter(variable))
            Settings.CreateCheckbox(category, setting, tooltip)
        end
        -- Future: elseif varTypeKey == "enum" and def.options then ... Settings.CreateDropdown(...)
    end

    Settings.RegisterAddOnCategory(category)
    hookDefaultsButton()
end
