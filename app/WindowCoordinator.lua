--[[
  Single place for main vs mini window visibility rules: keybind, minimap, slash,
  bus handlers (controller), and minimize button. Behavior matches prior entrypoint
  and MetaAchievementMainFrameMgr paths; lastOpenWindow is set only where it was before
  (ShowPanel, MetaAchievementMiniFrame_Show, etc.).
]]

MetaAchievementWindowCoordinator = MetaAchievementWindowCoordinator or {}

--- SetPropagateKeyboardInput is protected during combat and during UIPanel Hide/CloseAllWindows.
--- Only call from user keyboard handlers or OnShow — never from OnHide / ReleaseKeyboardCapture.
function MetaAchievementWindowCoordinator.CanSetPropagateKeyboardInput()
    return type(InCombatLockdown) ~= "function" or not InCombatLockdown()
end

function MetaAchievementWindowCoordinator.SafeSetPropagateKeyboardInput(frame, enabled)
    if not frame or type(frame.SetPropagateKeyboardInput) ~= "function" then
        return
    end
    if not MetaAchievementWindowCoordinator.CanSetPropagateKeyboardInput() then
        return
    end
    frame:SetPropagateKeyboardInput(enabled)
end

local function clearFrameKeyboardCapture(f)
    if not f or (f.IsShown and f:IsShown()) then
        return
    end
    if f.EnableKeyboard then
        pcall(function()
            f:EnableKeyboard(false)
        end)
    end
    if f.SetScript then
        f:SetScript("OnKeyDown", nil)
    end
end

--- After **any** close (X button, ESC, HidePanel, coordinator): force both journal frames to drop
--- keyboard hooks. Hidden frames must not keep `EnableKeyboard` or `OnKeyDown` — that steals ESC from
--- the game menu on the next keypress (especially when closing mini with X only).
function MetaAchievementWindowCoordinator.ReleaseKeyboardCapture()
    local main = MetaAchievementMainFrameMgr and MetaAchievementMainFrameMgr.frame
    local mini = _G.MetaAchievementMiniFrame
    clearFrameKeyboardCapture(main)
    clearFrameKeyboardCapture(mini)
    C_Timer.After(0, function()
        clearFrameKeyboardCapture(main)
        clearFrameKeyboardCapture(mini)
    end)
    if MetaAchievementUIBus and type(MetaAchievementUIBus.Emit) == "function" then
        MetaAchievementUIBus:Emit("MA_JOURNAL_KEYBOARD_RELEASED")
    end
end

--- Primary toggle: follows SavedVariables lastOpenWindow ("mini" → mini toggle, else main Toggle).
function MetaAchievementWindowCoordinator.TogglePrimaryWindow()
    if MetaAchievementSettings and MetaAchievementSettings:Get("lastOpenWindow") == "mini" then
        if type(MetaAchievementMiniFrame_ToggleVisibility) == "function" then
            MetaAchievementMiniFrame_ToggleVisibility()
        end
    else
        if MetaAchievementMainFrameMgr and type(MetaAchievementMainFrameMgr.Toggle) == "function" then
            MetaAchievementMainFrameMgr:Toggle()
        end
    end
end

--- Show main journal, hide mini, set lastOpenWindow to main (delegates to ShowPanel).
function MetaAchievementWindowCoordinator.ShowMainHideMini()
    if MetaAchievementMainFrameMgr and type(MetaAchievementMainFrameMgr.ShowPanel) == "function" then
        MetaAchievementMainFrameMgr:ShowPanel()
    end
end

--- Hide main journal and show mini (minimize / smaller button).
--- Main is opened via ShowUIPanel (ShowPanel); hiding with raw frame:Hide() leaves the UIPanel manager out of sync
--- and ESC / special-frame handling breaks after returning to the mini. Always use HidePanel → HideUIPanel.
--- Defer showing the mini to the next frame (same pattern as RestoreStartupWindowFromSettings) so main OnHide finishes.
function MetaAchievementWindowCoordinator.HideMainShowMini()
    if MetaAchievementMainFrameMgr and type(MetaAchievementMainFrameMgr.HidePanel) == "function" then
        MetaAchievementMainFrameMgr:HidePanel()
    else
        local main = MetaAchievementMainFrameMgr and MetaAchievementMainFrameMgr.frame
        if main and main.Hide then
            main:Hide()
        end
    end
    C_Timer.After(0, function()
        if type(MetaAchievementMiniFrame_Show) == "function" then
            MetaAchievementMiniFrame_Show()
        end
    end)
end

--- Hide main panel only (slash hide, etc.).
function MetaAchievementWindowCoordinator.HideMainPanel()
    if MetaAchievementMainFrameMgr and type(MetaAchievementMainFrameMgr.HidePanel) == "function" then
        MetaAchievementMainFrameMgr:HidePanel()
    end
end

--- After journal data sources and ActiveAchievementState are ready: open mini or main per lastOpenWindow.
function MetaAchievementWindowCoordinator.RestoreStartupWindowFromSettings()
    local lastOpen = MetaAchievementSettings and MetaAchievementSettings:Get("lastOpenWindow") or "main"
    if lastOpen == "mini" and type(MetaAchievementMiniFrame_Show) == "function" then
        local state = ActiveAchievementState and ActiveAchievementState:GetInstance()
        if state and type(state.GetActiveSourceKey) == "function" and not state:GetActiveSourceKey() then
            local sources = state:GetRegisteredSources()
            if type(sources) == "table" and sources[1] and sources[1].key then
                state:SetActiveSource(sources[1].key)
            end
        end
        if state and type(state.InvalidateList) == "function" then
            state:InvalidateList()
        end
        if MetaAchievementMainFrameMgr and type(MetaAchievementMainFrameMgr.HidePanel) == "function" then
            MetaAchievementMainFrameMgr:HidePanel()
        end
        C_Timer.After(0, function()
            if type(MetaAchievementMiniFrame_Show) == "function" then
                MetaAchievementMiniFrame_Show()
            end
        end)
    else
        if MetaAchievementMainFrameMgr and type(MetaAchievementMainFrameMgr.ShowPanel) == "function" then
            MetaAchievementMainFrameMgr:ShowPanel()
        end
    end
end
