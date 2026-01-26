-- Breadcrumbs dropdown menu controller (Retail only).
-- Handles the dropdown menu on the first breadcrumb button for data source selection.

local function createDropdownMenu(breadcrumbsFrame, button)
    if not breadcrumbsFrame or not button then
        return nil
    end
    
    -- Use MenuUtil.CreateContextMenu to create the dropdown menu
    if type(MenuUtil) == "table" and type(MenuUtil.CreateContextMenu) == "function" then
        return MenuUtil.CreateContextMenu(button, function(owner, rootDescription)
            local sources = breadcrumbsFrame._cachedDataSources
            if type(sources) ~= "table" then
                sources = {}
            end

            if #sources == 0 then
                rootDescription:CreateTitle("No achievement lists registered")
                return
            end

            rootDescription:CreateTitle("Achievement lists")

            local function isSelected(key)
                return breadcrumbsFrame._selectedSourceKey == key
            end

            local function setSelected(key)
                breadcrumbsFrame._selectedSourceKey = key
                
                -- Call selection callback - parent is responsible for updating breadcrumbs
                if breadcrumbsFrame._onSourceSelectedFunc and type(breadcrumbsFrame._onSourceSelectedFunc) == "function" then
                    breadcrumbsFrame._onSourceSelectedFunc(key)
                    breadcrumbsFrame._dropdownMenu:Close()
                    breadcrumbsFrame._dropdownMenu = nil
                end
            end

            for _, src in ipairs(sources) do
                local key = (src and src.key) or ""
                local label = (src and (src.name or src.key)) or ""
                rootDescription:CreateRadio(label, isSelected, setSelected, key)
            end
        end)
    end
    
    return nil
end

local function showDropdownMenu(breadcrumbsFrame, button)
    if not breadcrumbsFrame or not button then
        return
    end
    
    -- Don't show menu during initialization
    if breadcrumbsFrame._isInitializing then
        return
    end
    
    breadcrumbsFrame._dropdownMenu = createDropdownMenu(breadcrumbsFrame, button)
end

-- Get listFunc for NavBar button data (called before NavBar_AddButton)
function MetaAchievementBreadcrumbsDropdown_GetListFunc(breadcrumbsFrame)
    if not breadcrumbsFrame then
        return nil
    end
    
    -- Create listFunc for NavBar
    local function listFunc(button)
        -- Verify this is actually the first breadcrumb button
        if not button or not breadcrumbsFrame.navList or not breadcrumbsFrame.navList[1] then
            return {}
        end
        
        -- Only show dropdown if this is the first button in the navList
        local isFirstButton = (button == breadcrumbsFrame.navList[1])
        if not isFirstButton then
            -- Debug: log when listFunc is called on wrong button
            return {}
        end
        
        -- Don't show menu during initialization
        if breadcrumbsFrame._isInitializing then
            return {}
        end
        -- Show the dropdown menu
        showDropdownMenu(breadcrumbsFrame, button)
        -- Return empty table to satisfy NavBar's expectations
        return {}
    end
    
    return listFunc
end

-- Set up dropdown menu on the first breadcrumb button (called after NavBar_AddButton)
function MetaAchievementBreadcrumbsDropdown_SetupButton(breadcrumbsFrame, firstButton)
    if not breadcrumbsFrame or not firstButton then
        return
    end
    
    -- Get or create listFunc
    local listFunc = MetaAchievementBreadcrumbsDropdown_GetListFunc(breadcrumbsFrame)
    if not listFunc then
        return
    end
    
    -- Ensure listFunc is set on the button
    if firstButton then
        firstButton.listFunc = listFunc
        if firstButton.data then
            firstButton.data.listFunc = listFunc
        end
        
        -- Hook the dropdown arrow button click
        -- Wait a frame for the button to be fully created
        C_Timer.After(0, function()
            -- Look for dropdown arrow button in children
            for _, child in ipairs({firstButton:GetChildren()}) do
                local name = child:GetName() or ""
                if name:find("Dropdown") or (child:IsVisible() and child:GetWidth() and child:GetWidth() < 30) then
                    child:SetScript("OnClick", function(arrowButton, mouseButton)
                        if mouseButton == "LeftButton" then
                            showDropdownMenu(breadcrumbsFrame, firstButton)
                        end
                    end)
                end
            end
        end)
    end
end

-- Called by journal-map to set selection handler and selected key.
function MetaAchievementBreadcrumbsDropdown_SetDataSourceCallback(breadcrumbsFrame, _getDataSourcesFunc, onSourceSelectedFunc, selectedSourceKey)
    if not breadcrumbsFrame then
        return
    end
    breadcrumbsFrame._onSourceSelectedFunc = onSourceSelectedFunc
    breadcrumbsFrame._selectedSourceKey = selectedSourceKey
end

-- Called by journal-map to cache the registered achievement lists.
function MetaAchievementBreadcrumbsDropdown_SetDataSources(breadcrumbsFrame, sources)
    if not breadcrumbsFrame then
        return
    end
    breadcrumbsFrame._cachedDataSources = sources
end

-- Initialize dropdown functionality on breadcrumbs frame load
function MetaAchievementBreadcrumbsDropdown_OnLoad(breadcrumbsFrame)
    if not breadcrumbsFrame then
        return
    end
    
    -- Track initialization state to prevent menu from opening automatically
    breadcrumbsFrame._isInitializing = true
    
    -- Close any open menus on load
    C_Timer.After(0.1, function()
        if type(MenuUtil) == "table" and type(MenuUtil.CloseMenu) == "function" then
            MenuUtil.CloseMenu()
        end
        if type(CloseDropDownMenus) == "function" then
            CloseDropDownMenus()
        end
        if type(CloseMenus) == "function" then
            CloseMenus()
        end
        -- Mark initialization as complete after cleanup
        breadcrumbsFrame._isInitializing = false
    end)

    -- Seed cached data sources at load time (journal-map will keep it updated later).
    if MetaAchievementJournalMap and type(MetaAchievementJournalMap.GetDataSourcesSorted) == "function" then
        local ok, sources = pcall(function()
            return MetaAchievementJournalMap:GetDataSourcesSorted()
        end)
        if ok then
            breadcrumbsFrame._cachedDataSources = sources
        end
    end
end
