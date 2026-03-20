-- Mini frame: same size as main window's main scroll frame (journal list ScrollBox: 312x523).

-- Dimensions matching journal list ScrollBox (see journal-list.xml: 340 - 6 - 22 width, frame height 535 - 12).
local MINI_FRAME_WIDTH = 312
local MINI_FRAME_HEIGHT = 523

-- Same as main frame: set the ButtonFrameTemplate portrait to the given texture.
local function setFramePortrait(frame, texturePath)
    if not frame or not texturePath then
        return
    end
    if type(ButtonFrameTemplate_SetPortraitToTexture) == "function" then
        ButtonFrameTemplate_SetPortraitToTexture(frame, texturePath)
        return
    end
    local portrait =
        frame.Portrait
        or frame.portrait
        or _G[frame:GetName() .. "Portrait"]
        or (frame.PortraitContainer and (frame.PortraitContainer.portrait or frame.PortraitContainer.Portrait))
    if portrait and portrait.SetTexture then
        portrait:SetTexture(texturePath)
    end
end

-- Get sorted data sources for the dropdown (same as main frame breadcrumbs).
local function getMiniFrameDataSources()
    if MetaAchievementMainFrameMgr and type(MetaAchievementMainFrameMgr.GetDataSourcesSorted) == "function" then
        return MetaAchievementMainFrameMgr:GetDataSourcesSorted()
    end
    if ActiveAchievementState and type(ActiveAchievementState.GetInstance) == "function" then
        local state = ActiveAchievementState:GetInstance()
        if type(state.GetRegisteredSources) == "function" then
            return state:GetRegisteredSources()
        end
    end
    return {}
end

function MetaAchievementMiniFrameDropdown_OnLoad(self)
    local frame = self:GetParent()
    if not frame then
        return
    end
    local hasMenuUtil = type(MenuUtil) == "table" and type(MenuUtil.CreateContextMenu) == "function"
    if not hasMenuUtil then
        self:Hide()
        local arrow = self.Arrow or _G[self:GetName() .. "Arrow"]
        if arrow then arrow:Hide() end
        return
    end
    self:Show()
    local arrow = self.Arrow or _G[self:GetName() .. "Arrow"]
    if arrow then arrow:Show() end
    if type(MetaAchievementDropdownArrowButton_OnLoad) == "function" then
        MetaAchievementDropdownArrowButton_OnLoad(self)
    end
    local dropdownMenu = nil
    local function openDropdown()
        if dropdownMenu then
            dropdownMenu:Close()
            dropdownMenu = nil
        end
        dropdownMenu = MenuUtil.CreateContextMenu(self, function(owner, rootDescription)
            local sources = getMiniFrameDataSources()
            if type(sources) ~= "table" then
                sources = {}
            end
            if #sources == 0 then
                rootDescription:CreateTitle("No achievement lists registered")
                return
            end
            rootDescription:CreateTitle("Achievement lists")
            local state = ActiveAchievementState and ActiveAchievementState:GetInstance()
            local currentKey = (MetaAchievementSettings and MetaAchievementSettings:Get("selectedSourceKey")) or (state and type(state.GetActiveSourceKey) == "function" and state:GetActiveSourceKey())
            local function isSelected(key)
                return currentKey == key
            end
            local function setSelected(key)
                if state and type(state.SetActiveSource) == "function" then
                    state:SetActiveSource(key)
                elseif MetaAchievementSettings and type(MetaAchievementSettings.Set) == "function" then
                    MetaAchievementSettings:Set("selectedSourceKey", key)
                end
                if type(MetaAchievementMiniFrame_RefreshContent) == "function" then
                    MetaAchievementMiniFrame_RefreshContent()
                end
                if dropdownMenu then
                    dropdownMenu:Close()
                    dropdownMenu = nil
                end
            end
            for _, src in ipairs(sources) do
                local key = (src and src.key) or ""
                local label = (src and (src.name or src.key)) or ""
                rootDescription:CreateRadio(label, isSelected, setSelected, key)
            end
        end)
    end
    self:SetScript("OnClick", function(btn, mouseButton)
        if mouseButton == "LeftButton" then
            openDropdown()
        end
    end)
end

function MetaAchievementMiniFrameDragRegion_OnLoad(self)
    local parent = self:GetParent()
    local function applyDragEnabled()
        local locked = MetaAchievementSettings and MetaAchievementSettings:Get("miniJournalLockPosition")
        if locked then
            self:RegisterForDrag()
        else
            self:RegisterForDrag("LeftButton")
        end
        if parent and parent.SetMovable then
            parent:SetMovable(not locked)
        end
    end
    applyDragEnabled()
    self._applyDragEnabled = applyDragEnabled
    self:SetScript("OnDragStart", function()
        if MetaAchievementSettings and MetaAchievementSettings:Get("miniJournalLockPosition") then
            return
        end
        local p = self:GetParent()
        if p then
            if p.SetMovable then p:SetMovable(true) end
            if p.StartMoving then p:StartMoving() end
        end
    end)
    self:SetScript("OnDragStop", function()
        local p = self:GetParent()
        if p and p.StopMovingOrSizing then
            p:StopMovingOrSizing()
        end
    end)
end

function MetaAchievementMiniFrame_OnLoad(self)
    self:SetSize(MINI_FRAME_WIDTH, MINI_FRAME_HEIGHT)
    self:SetFrameStrata("DIALOG")
    self:SetFrameLevel(100)
    if self.SetBackdrop then
        self:SetBackdrop({
            bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
            edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
            edgeSize = 16,
            insets = { left = 8, right = 8, top = 8, bottom = 0 },
        })
    end
    -- Window title: use our XML-positioned FontString (inside WindowTitleFrame) and hide the template title
    local titleFrame = self.WindowTitleFrame or _G[self:GetName() .. "WindowTitleFrame"]
    local windowTitle = titleFrame and (titleFrame.WindowTitle or _G[titleFrame:GetName() .. "WindowTitle"])
    if windowTitle and windowTitle.SetText then
        windowTitle:SetText("Meta Achievement Journal")
    end
    local templateTitle = self.TitleText or (self.TitleContainer and self.TitleContainer.TitleText) or _G[self:GetName() .. "TitleText"]
    if templateTitle and templateTitle.Hide then
        templateTitle:Hide()
    end
    local function applyLockPosition()
        local locked = MetaAchievementSettings and MetaAchievementSettings:Get("miniJournalLockPosition")
        self:SetMovable(not locked)
        if locked then
            self:RegisterForDrag()
        else
            self:RegisterForDrag("LeftButton")
        end
        local dragRegion = self.DragRegion or _G[self:GetName() .. "DragRegion"]
        if dragRegion and dragRegion._applyDragEnabled then
            dragRegion._applyDragEnabled()
        end
    end
    applyLockPosition()
    -- Only enable keyboard while visible. Enabling keyboard on a hidden frame can steal ESC globally
    -- (game menu won't open) — especially noticeable with "Escape does not close" + mini closed.
    self:EnableKeyboard(false)
    self:SetScript("OnShow", function(f)
        f:EnableKeyboard(true)
    end)
    self:SetScript("OnHide", function(f)
        f:EnableKeyboard(false)
    end)
    -- Escape closes this window (whichever addon window is open), unless "Escape does not close" is set.
    self:SetScript("OnKeyDown", function(_, key)
        if key == "ESCAPE" then
            local escapeDoesNotClose = MetaAchievementSettings and MetaAchievementSettings:Get("miniJournalEscapeDoesNotClose")
            if not escapeDoesNotClose then
                self:SetPropagateKeyboardInput(false)
                MetaAchievementMiniFrame_Hide()
            else
                self:SetPropagateKeyboardInput(true)
            end
        else
            self:SetPropagateKeyboardInput(true)
        end
    end)
    self:SetScript("OnDragStart", function()
        if not (MetaAchievementSettings and MetaAchievementSettings:Get("miniJournalLockPosition")) then
            self:SetMovable(true)
            self:StartMoving()
        end
    end)
    self:SetScript("OnDragStop", function()
        self:StopMovingOrSizing()
    end)
    self:SetUserPlaced(true)
    local largerBtn = _G[self:GetName() .. "LargerButton"]
    if largerBtn then
        largerBtn:SetFrameLevel(1000)
        largerBtn:SetScript("OnClick", function()
            MetaAchievementMiniFrame_Hide()
            if MetaAchievementMainFrameMgr and type(MetaAchievementMainFrameMgr.ShowPanel) == "function" then
                MetaAchievementMainFrameMgr:ShowPanel()
            end
        end)
        if type(MetaAchievement_CogButtonSetTooltip) == "function" then
            MetaAchievement_CogButtonSetTooltip(largerBtn, "Open full journal window")
        end
    end
    local settingsBtn = _G[self:GetName() .. "SettingsButton"]
    if settingsBtn then
        settingsBtn:SetFrameLevel(1000)
        settingsBtn:SetScript("OnClick", function()
            if Settings and type(Settings.OpenToCategory) == "function" and MetaAchievementSettingsCategoryID then
                Settings.OpenToCategory(MetaAchievementSettingsCategoryID)
            end
        end)
        if MetaAchievementSettingsCogButton_SetTooltip then
            MetaAchievementSettingsCogButton_SetTooltip(settingsBtn, "Addon settings")
        end
    end
    MetaAchievementMiniFrame_UpdateSettingsButtonVisibility()
    if MetaAchievementSettings and MetaAchievementSettings.RegisterListener then
        MetaAchievementSettings:RegisterListener("showSettingsButton", function()
            MetaAchievementMiniFrame_UpdateSettingsButtonVisibility()
        end)
        MetaAchievementSettings:RegisterListener("miniJournalLockPosition", function()
            applyLockPosition()
        end)
        MetaAchievementSettings:RegisterListener("selectedSourceKey", function()
            if self:IsShown() then MetaAchievementMiniFrame_RefreshContent() end
        end)
        MetaAchievementSettings:RegisterListener("selectedAchievementId", function()
            if self:IsShown() then MetaAchievementMiniFrame_UpdateSelectionOnly() end
        end)
        MetaAchievementSettings:RegisterListener("miniJournalHideCompletedCriteria", function()
            if self:IsShown() then MetaAchievementMiniFrame_RefreshContent() end
        end)
        -- Same settings that trigger main frame list refresh (hideCompleted, etc.)
        local keysToRefreshOn = { "hideCompleted", "showCompletedScreenWhenTopDone", "achievementLinkSource", "addWpsOnlyForUncompletedAchis" }
        for _, key in ipairs(keysToRefreshOn) do
            MetaAchievementSettings:RegisterListener(key, function()
                if self:IsShown() then
                    local state = ActiveAchievementState and ActiveAchievementState:GetInstance()
                    if state and type(state.InvalidateList) == "function" then
                        state:InvalidateList()
                    end
                    MetaAchievementMiniFrame_RefreshContent()
                end
            end)
        end
    end
    MetaAchievementMiniFrame_RefreshContent()
end

local MINI_MONTH_NAMES = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" }
local function miniFormatCompletionDate(month, day, year)
    if not month or not day or not year then return "" end
    local name = MINI_MONTH_NAMES[month] or tostring(month)
    return ("Completed on %s %d, %d"):format(name, day, 2000 + year)
end

local function updateMiniCompletedPanel(completedPanel, topAchievementId, mountId)
    if not completedPanel or not topAchievementId or type(GetAchievementInfo) ~= "function" then return end
    local ok, _, name, _, completed, month, day, year, _, _, icon = pcall(GetAchievementInfo, topAchievementId)
    if not ok then return end
    local msg = completedPanel.Message or _G[completedPanel:GetName() .. "Message"]
    if msg and msg.SetText then
        msg:SetText(completed and "All achievements in this list are completed." or "This awaits you when you complete this achievement.")
    end
    local dateStr = completed and miniFormatCompletionDate(month, day, year) or ""
    local dateFs = completedPanel.CompletedDate or _G[completedPanel:GetName() .. "CompletedDate"]
    if dateFs and dateFs.SetText then dateFs:SetText(dateStr) end
    local achiIcon = completedPanel.AchiIcon or _G[completedPanel:GetName() .. "AchiIcon"]
    if achiIcon then
        if icon and achiIcon.SetTexture then achiIcon:SetTexture(icon); achiIcon:Show() else achiIcon:Hide() end
    end
    if type(MetaAchievementMountRewardPanel_Update) == "function" then
        MetaAchievementMountRewardPanel_Update(completedPanel.MountPanel or _G[completedPanel:GetName() .. "MountPanel"], mountId)
    end
end

--- Update only the list selection from current settings (no full rebuild). Use when selectedAchievementId changes from a click.
function MetaAchievementMiniFrame_UpdateSelectionOnly()
    local frame = _G.MetaAchievementMiniFrame
    if not frame or not frame:IsShown() then return end
    local content = frame.Content or _G[frame:GetName() .. "Content"]
    local listFrame = content and (content.AchievementList or _G[content:GetName() .. "AchievementList"])
    if not listFrame or not listFrame._items or type(MetaAchievementMiniList_SetSelectedIndex) ~= "function" then return end
    local wantId = MetaAchievementSettings and MetaAchievementSettings:Get("selectedAchievementId")
    if not wantId then return end
    wantId = tonumber(wantId) or wantId
    for i, n in ipairs(listFrame._items) do
        if n and ((n.id == wantId) or (n.data and n.data.id == wantId)) then
            MetaAchievementMiniList_SetSelectedIndex(listFrame, i)
            return
        end
    end
end

--- Refresh mini frame content: title and header portrait only (no icon, description, or help text).
function MetaAchievementMiniFrame_RefreshContent()
    local frame = _G.MetaAchievementMiniFrame
    if not frame then return end
    local content = frame.Content or _G[frame:GetName() .. "Content"]
    if not content then return end
    local achievementTitleFs = frame.AchievementTitle or _G[frame:GetName() .. "AchievementTitle"]

    -- Selected top achievement/category from ActiveAchievementState (single source of truth).
    local state = ActiveAchievementState and ActiveAchievementState:GetInstance()
    local sourceKey = nil
    local src = nil
    if state and type(state.GetActiveSourceKey) == "function" and type(state.GetActiveSource) == "function" then
        sourceKey = state:GetActiveSourceKey()
        src = state:GetActiveSource()
    end
    if not src and state and type(state.GetSource) == "function" then
        sourceKey = MetaAchievementSettings and MetaAchievementSettings:Get("selectedSourceKey") or "worldSoulSearching"
        src = state:GetSource(sourceKey)
    end
    if (not src or not src.provider) and MetaAchievementMainFrameMgr and type(MetaAchievementMainFrameMgr.GetSelectedSource) == "function" then
        sourceKey = sourceKey or (MetaAchievementSettings and MetaAchievementSettings:Get("selectedSourceKey")) or "worldSoulSearching"
        src = MetaAchievementMainFrameMgr:GetSelectedSource({ _selectedSourceKey = sourceKey })
    end

    local list = {}
    local topAchievementId = nil
    if src and src.provider then
        topAchievementId = src.provider.topAchievementId
        if state and state:GetActiveSourceKey() == sourceKey and type(state.GetList) == "function" then
            list = state:GetList()
        else
            list = (type(src.provider.GetList) == "function" and src.provider:GetList()) or {}
        end
    end
    if type(list) ~= "table" then list = {} end

    local wantAchievementId = MetaAchievementSettings and MetaAchievementSettings:Get("selectedAchievementId")

    local wantId = wantAchievementId and (tonumber(wantAchievementId) or wantAchievementId)
    local node = nil
    if wantId then
        for _, n in ipairs(list) do
            if n and (n.id == wantId or (n.data and n.data.id == wantId)) then
                node = n
                break
            end
        end
    end
    if not node and list[1] then
        node = list[1]
    end

    if not src or not src.provider then
        if achievementTitleFs and achievementTitleFs.SetText then
            achievementTitleFs:SetText("No list selected")
        end
        setFramePortrait(frame, "Interface\\Icons\\INV_Misc_QuestionMark")
        local content = frame.Content or _G[frame:GetName() .. "Content"]
        local completedPanel = content and (content.CompletedPanel or _G[content:GetName() .. "CompletedPanel"])
        if completedPanel then completedPanel:Hide() end
        local listFrame = content and (content.AchievementList or _G[content:GetName() .. "AchievementList"])
        if listFrame then
            listFrame:Show()
            if type(MetaAchievementMiniList_SetItems) == "function" then
                MetaAchievementMiniList_SetItems(listFrame, {}, frame)
            end
        end
        return
    end

    -- Title = always the category (source) name. Icon = same logic as main frame (list[1] or GetAchievementInfo(topAchievementId) when list empty).
    local categoryName = (type(src.name) == "string" and src.name ~= "") and src.name or (src.key or "Achievement list")
    local topIcon = nil
    if list[1] then
        local top = list[1]
        topIcon = (top.data and top.data.icon) or top.icon
        if (not topIcon or topIcon == "") and top.id and type(GetAchievementInfo) == "function" then
            local ok, _, _, _, _, _, _, _, _, _, apiIcon = pcall(GetAchievementInfo, top.id)
            if ok and apiIcon then
                topIcon = apiIcon
            end
        end
    end
    if (not topIcon or topIcon == "") and topAchievementId and type(GetAchievementInfo) == "function" then
        local ok, _, _, _, _, _, _, _, _, _, apiIcon = pcall(GetAchievementInfo, topAchievementId)
        if ok and apiIcon then
            topIcon = apiIcon
        end
    end
    if achievementTitleFs and achievementTitleFs.SetText then
        achievementTitleFs:SetText(categoryName)
    end
    setFramePortrait(frame, (topIcon and topIcon ~= "") and topIcon or "Interface\\Icons\\INV_Misc_QuestionMark")

    local content = frame.Content or _G[frame:GetName() .. "Content"]
    local listFrame = content and (content.AchievementList or _G[content:GetName() .. "AchievementList"])
    local completedPanel = content and (content.CompletedPanel or _G[content:GetName() .. "CompletedPanel"])

    -- Show compact completed panel only when top achievement of category is completed (and setting allows).
    local topCompleted = false
    if topAchievementId and type(GetAchievementInfo) == "function" then
        local ok, _, _, _, completed = pcall(GetAchievementInfo, topAchievementId)
        topCompleted = ok and completed
    end
    local showCompletedScreen = (MetaAchievementSettings and MetaAchievementSettings:Get("showCompletedScreenWhenTopDone")) and topCompleted

    if showCompletedScreen and completedPanel then
        completedPanel:Show()
        if listFrame then listFrame:Hide() end
        local mountId = (src.provider and src.provider.topAchievementMountId) or nil
        updateMiniCompletedPanel(completedPanel, topAchievementId, mountId)
    else
        if completedPanel then completedPanel:Hide() end
        if listFrame then
            listFrame:Show()
            if type(MetaAchievementMiniList_SetItems) == "function" then
                MetaAchievementMiniList_SetItems(listFrame, list, frame)
                local selectedIndex = nil
                if node and list then
                    local wantId = (node.id) or (node.data and node.data.id)
                    for i, n in ipairs(list) do
                        if n and ((n.id == wantId) or (n.data and n.data.id == wantId)) then
                            selectedIndex = i
                            break
                        end
                    end
                end
                if selectedIndex and type(MetaAchievementMiniList_SetSelectedIndex) == "function" then
                    MetaAchievementMiniList_SetSelectedIndex(listFrame, selectedIndex)
                end
            end
        end
    end
end

function MetaAchievementMiniFrame_UpdateSettingsButtonVisibility()
    local frame = _G.MetaAchievementMiniFrame
    if not frame then return end
    local btn = _G[frame:GetName() .. "SettingsButton"]
    if not btn then return end
    local show = MetaAchievementSettings and MetaAchievementSettings:Get("showSettingsButton")
    if show then btn:Show() else btn:Hide() end
end

function MetaAchievementMiniFrame_Show()
    local frame = _G.MetaAchievementMiniFrame
    if not frame then
        return
    end
    -- Invalidate list so refresh uses current data (e.g. when opening by default at addon load).
    local state = ActiveAchievementState and ActiveAchievementState:GetInstance()
    if state and type(state.InvalidateList) == "function" then
        state:InvalidateList()
    end
    frame:SetParent(UIParent)
    if not frame:IsUserPlaced() then
        frame:ClearAllPoints()
        frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    end
    frame:SetFrameStrata("DIALOG")
    frame:SetFrameLevel(200)
    frame:Show()
    MetaAchievementMiniFrame_UpdateSettingsButtonVisibility()
    MetaAchievementMiniFrame_RefreshContent()
    if MetaAchievementSettings then
        MetaAchievementSettings:Set("lastOpenWindow", "mini")
    end
end

function MetaAchievementMiniFrame_Hide()
    local frame = _G.MetaAchievementMiniFrame
    if frame then
        frame:Hide()
    end
end

function MetaAchievementMiniFrame_ToggleVisibility()
    local frame = _G.MetaAchievementMiniFrame
    if not frame then
        return
    end
    if frame:IsShown() then
        MetaAchievementMiniFrame_Hide()
    else
        MetaAchievementMiniFrame_Show()
    end
end
