-- Breadcrumbs element controller (Retail only).
-- Renders: Journal > Parent > Child > Selected
-- - Home button: fixed text "Journal", not clickable

local function ensureBus()
    MetaAchievementUIBus = MetaAchievementUIBus or {}
    if type(MetaAchievementUIBus.Emit) ~= "function" then
        function MetaAchievementUIBus:Emit(eventName, ...)
            local list = self._listeners and self._listeners[eventName]
            if not list then
                return
            end
            for _, handler in ipairs(list) do
                pcall(handler, ...)
            end
        end
    end
end

local function getNodeName(node)
    if not node then
        return ""
    end

    local name = (node.data and node.data.name) or node.name
    if name and name ~= "" then
        return name
    end

    if node.id and type(GetAchievementInfo) == "function" then
        local ok, _, apiName = pcall(GetAchievementInfo, node.id)
        if ok and apiName then
            return apiName
        end
    end

    return tostring(node.id or "")
end

local function findPath(node, targetId, outPath)
    if not node or not targetId then
        return false
    end

    outPath[#outPath + 1] = node
    if node.id == targetId then
        return true
    end

    for _, child in ipairs(node.children or {}) do
        if findPath(child, targetId, outPath) then
            return true
        end
    end

    outPath[#outPath] = nil
    return false
end

local function buildBreadcrumbPath(items, selectedNode)
    if type(items) ~= "table" or not selectedNode or not selectedNode.id then
        return {}
    end

    local roots = {}
    for _, node in ipairs(items) do
        if node and node.depth == 0 then
            roots[#roots + 1] = node
        end
    end
    if #roots == 0 and items[1] then
        roots = { items[1] }
    end

    local path = {}
    for _, root in ipairs(roots) do
        if findPath(root, selectedNode.id, path) then
            break
        end
        path = {}
    end

    if #path == 0 then
        path = { selectedNode }
    end

    return path
end

local function ensureNavBarInitialized(self)
    if self._navInit then
        return
    end

    local homeData = {
        name = "Journal",
        OnClick = function() end,
    }

    NavBar_Initialize(self, "NavButtonTemplate", homeData, self.home, self.overflow)
    self._navInit = true
end

local function render(self, items, selectedNode)
    if not self or type(NavBar_Initialize) ~= "function" or type(NavBar_AddButton) ~= "function" then
        return
    end

    ensureNavBarInitialized(self)
    if type(NavBar_Reset) == "function" then
        NavBar_Reset(self)
    end

    -- Home button: "Journal" (not clickable)
    if self.homeButton then
        self.homeButton:SetText("Journal")
        self.homeButton.listFunc = nil
        self.homeButton.myclick = nil
        self.homeButton:EnableMouse(false)
        self.homeButton:Show()
    end

    local path = buildBreadcrumbPath(items, selectedNode)
    if #path == 0 then
        return
    end

    local function emitClicked(node)
        ensureBus()
        if MetaAchievementUIBus and type(MetaAchievementUIBus.Emit) == "function" then
            MetaAchievementUIBus:Emit("MA_BREADCRUMB_CLICKED", self, node and node.id or nil, node, "LeftButton")
        end
    end

    -- Create listFunc for first button if dropdown functionality is available
    local firstButtonListFunc = nil
    if type(MetaAchievementBreadcrumbsDropdown_GetListFunc) == "function" then
        firstButtonListFunc = MetaAchievementBreadcrumbsDropdown_GetListFunc(self)
    end

    -- Breadcrumbs: render all nodes in path
    for i, node in ipairs(path) do
        local buttonData = {
            name = getNodeName(node),
            id = node and node.id or nil,
            node = node,
            OnClick = function(buttonSelf, mouseButton)
                emitClicked(buttonSelf and buttonSelf.data and buttonSelf.data.node or node)
            end,
        }

        -- Set listFunc on first button to show dropdown arrow
        if i == 1 and firstButtonListFunc then
            buttonData.listFunc = firstButtonListFunc
        end

        local beforeCount = self.navList and #self.navList or 0
        NavBar_AddButton(self, buttonData)

        -- Set up dropdown menu on the first breadcrumb button (ensure it's properly configured)
        if i == 1 and type(MetaAchievementBreadcrumbsDropdown_SetupButton) == "function" then
            if self.navList and #self.navList >= beforeCount + 1 then
                local firstButton = self.navList[beforeCount + 1]
                if firstButton then
                    MetaAchievementBreadcrumbsDropdown_SetupButton(self, firstButton)
                end
            end
        end
    end
end

function MetaAchievementBreadcrumbs_OnLoad(self)
    ensureBus()

    -- Initialize dropdown functionality if available
    if type(MetaAchievementBreadcrumbsDropdown_OnLoad) == "function" then
        MetaAchievementBreadcrumbsDropdown_OnLoad(self)
    end

    self:HookScript("OnSizeChanged", function()
        if self._items ~= nil then
            render(self, self._items, self._selectedNode)
        end
    end)
end

function MetaAchievementBreadcrumbs_SetSelection(self, items, selectedNode)
    if not self then
        return
    end
    
    -- Always store and render breadcrumbs when SetSelection is called
    self._items = items
    self._selectedNode = selectedNode
    render(self, items, selectedNode)
end
