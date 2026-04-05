--[[
  Application layer: registers MetaAchievementUIBus handlers that tie the main journal
  frame to MetaAchievementMainFrameMgr.

  Events owned by this controller:
  - MA_JOURNAL_LIST_ITEM_CLICKED — list row selection + provider OnItemSelected hooks; map-detail jumps to linked achievement use the same event
  - MA_BREADCRUMB_CLICKED — breadcrumb node → list index → SetSelectedIndex
  - MA_MAPDETAIL_REQUIREMENT_CLICKED — stub only; map-detail.lua performs click handling before Emit (see docs/EVENTS.md)
  - MA_SELECTION_CHANGED — emitted by MetaAchievementMainFrameMgr:SetSelectedIndex; no default handler
  - MA_MINI_SOURCE_CHANGED — mini dropdown: ActiveAchievementState / settings + mini refresh
  - MA_MINI_OPEN_FULL_JOURNAL — MetaAchievementWindowCoordinator.ShowMainHideMini (ShowPanel + lastOpenWindow)

  Scroll emits (scrollbar.lua) have no subscribers; scrolling uses frame scripts. Optional no-ops are left commented below.
]]

local function safeCall(fn, ...)
    if type(fn) == "function" then
        return fn(...)
    end
end

-- Future listeners only; scroll position is updated via ScrollFrame/scrollbar scripts.
-- MetaAchievementUIBus:Register("MA_SCROLLFRAME_VERTICAL_SCROLL", function() end)
-- MetaAchievementUIBus:Register("MA_SCROLLBAR_VALUE_CHANGED", function() end)

if MetaAchievementUIBus and type(MetaAchievementUIBus.Register) == "function" then
    MetaAchievementUIBus:Register("MA_MAPDETAIL_REQUIREMENT_CLICKED", function(owner, rowIndex, req, button)
        -- Intentionally empty: map-detail.lua already ran MetaAchievementMapDetail_OnRequirementClicked and waypoint toggles.
    end)

    MetaAchievementUIBus:Register("MA_MINI_SOURCE_CHANGED", function(key)
        local state = ActiveAchievementState and ActiveAchievementState.GetInstance and ActiveAchievementState:GetInstance()
        if state and type(state.SetActiveSource) == "function" then
            state:SetActiveSource(key)
        elseif MetaAchievementSettings and type(MetaAchievementSettings.Set) == "function" then
            MetaAchievementSettings:Set("selectedSourceKey", key)
        end
        if type(MetaAchievementMiniFrame_RefreshContent) == "function" then
            MetaAchievementMiniFrame_RefreshContent()
        end
    end)

    MetaAchievementUIBus:Register("MA_MINI_OPEN_FULL_JOURNAL", function()
        if MetaAchievementWindowCoordinator and type(MetaAchievementWindowCoordinator.ShowMainHideMini) == "function" then
            MetaAchievementWindowCoordinator.ShowMainHideMini()
        elseif MetaAchievementMainFrameMgr and type(MetaAchievementMainFrameMgr.ShowPanel) == "function" then
            MetaAchievementMainFrameMgr:ShowPanel()
        end
    end)
end

--- Wire bus events for the main Meta Achievement journal frame (call from OnLoad once `self` is ready).
function MetaAchievementController_RegisterMainFrame(frame)
    if not MetaAchievementUIBus or type(MetaAchievementUIBus.Register) ~= "function" then
        return
    end
    local frameRef = frame
    MetaAchievementUIBus:Register("MA_JOURNAL_LIST_ITEM_CLICKED", function(listFrame, index, item, button)
        if frameRef and listFrame == frameRef.JournalList then
            MetaAchievementMainFrameMgr:SetSelectedIndex(frameRef, index)

            local src = MetaAchievementMainFrameMgr:GetSelectedSource(frameRef)
            if src and src.provider and item then
                safeCall(src.provider.OnItemSelected, src.provider, item, button)
                safeCall(src.provider.onItemSelected, src.provider, item, button)
            end
        end
    end)

    MetaAchievementUIBus:Register("MA_BREADCRUMB_CLICKED", function(owner, nodeId, node, button)
        if not frameRef or owner ~= frameRef.Breadcrumbs then
            return
        end
        local idx = AchievementListUtils and AchievementListUtils.findIndexForAchievementId(frameRef._modelItems, nodeId)
        if idx then
            MetaAchievementMainFrameMgr:SetSelectedIndex(frameRef, idx)
        end
    end)
end
