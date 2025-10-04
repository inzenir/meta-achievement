MainFrame = {}
MainFrame.__index = MainFrame

local LDB = LibStub:GetLibrary("LibDataBroker-1.1")
local DBIcon = LibStub("LibDBIcon-1.0")

local function refrestAchievementsLists()
    for _, achilist in pairs(MetaAchievementDB.achievementLists) do
        achilist.data:rescanData()
        achilist.treeView:draw()
    end
end

function MainFrame:new()
    local obj = setmetatable({}, MainFrame)

    obj.mainFrame = {}
    obj.resizeButton = {}
    obj.settingsButton = {}
    obj.scrollBar = {}
    obj.scrollBarChildren = {}
    obj.drawnScrollElement = nil
    
    obj.previousDrawnElement = nil

    obj:createMainFrame()
    obj:createMinimapButton()
    obj:createResizeButton()
    obj:createSettingsButton()
    obj:registerEvents()
    obj:createScrollBar()

    return obj
end

function MainFrame:createMainFrame()
    self.mainFrame = CreateFrame("Frame", "MetaAchievementsTracker", UIParent, "BasicFrameTemplateWithInset")
    self.mainFrame:SetSize(300, 200)
    self.mainFrame:SetResizeBounds(300, 200)
    self.mainFrame:SetPoint("CENTER", 0, 0)
    self.mainFrame:SetMovable(true)
    self.mainFrame:SetResizable(true)
    self.mainFrame:EnableMouse(true)
    self.mainFrame:EnableMouseWheel(true)
    self.mainFrame:RegisterForDrag("LeftButton")
    self.mainFrame:SetScript("OnDragStart", self.mainFrame.StartMoving)
    self.mainFrame:SetScript("OnDragStop", self.mainFrame.StopMovingOrSizing)
    self.mainFrame:SetFrameStrata("TOOLTIP")

    self.mainFrame.title = self.mainFrame:CreateFontString(nil, "OVERLAY")
    self.mainFrame.title:SetFontObject("GameFontHighlight")
    self.mainFrame.title:SetPoint("LEFT", self.mainFrame.TitleBg, "LEFT", 5, 0)
end

function MainFrame:ChangeTitle(name)
    name = name or ""
    self.mainFrame.title:SetText("Meta Achievements Tracker - " .. name)
end

function MainFrame:registerEvents()
    self.mainFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    self.mainFrame:RegisterEvent("ACHIEVEMENT_EARNED")
    self.mainFrame:RegisterEvent("ADDON_LOADED")

    self.mainFrame:SetScript("OnEvent", function(element, event, arg1)
        if event == "PLAYER_ENTERING_WORLD" or event == "ACHIEVEMENT_EARNED" then
            refrestAchievementsLists()
        end

        if arg1 == "Worldsoul_Searching" and event == "ADDON_LOADED" then
            UpdateSettings()
            EntryPoint()
        end
    end)
end

function MainFrame:createMinimapButton()
    local iconObject = LDB:NewDataObject("MetaAchievementsTracker", {
        type = "launcher",
        icon = "Interface\\Icons\\achievement_zone_isleofdorn",
        OnClick = function(element, button)
            if button == "LeftButton" then
                if self.mainFrame:IsShown() then
                    self.mainFrame:Hide()
                else
                    self.mainFrame:Show()
                end
            end
            if button == "RightButton" then
                refrestAchievementsLists()
            end
        end,
        OnTooltipShow = function(tooltip)
            tooltip:AddLine("Meta Achievements Tracker")
            tooltip:AddLine("Left-click to toggle visibility.")
            tooltip:AddLine("Right-click to manually refresh achievements.")
        end,
    })
    DBIcon:Register("MetaAchievementsTracker", iconObject, MetaAchievementDB.minimap)
end

function MainFrame:createSettingsButton()
    self.settingsButton = CreateFrame("Button", nil, self.mainFrame, "UIPanelButtonTemplate")
    self.settingsButton:SetSize(24, 24)
    self.settingsButton:SetPoint("TOPRIGHT", self.mainFrame, "TOPRIGHT", -24, 1)

    local icon = self.settingsButton:CreateTexture(nil, "ARTWORK")
    icon:SetPoint("CENTER", self.settingsButton, "CENTER")
    icon:SetTexture("Interface\\Buttons\\UI-OptionsButton")

    self.settingsButton:SetScript("OnClick", function()
        if self.drawnScrollElement == WindowTabs.settings then
            self:drawScrollContent(self.previousDrawnElement)
        else
            self.previousDrawnElement = self.drawnScrollElement
            self:drawScrollContent(WindowTabs.settings)
        end
    end)
end

function MainFrame:createResizeButton()
    self.resizeButton = CreateFrame("Button", nil, self.mainFrame)
    self.resizeButton:SetSize(16, 16)
    self.resizeButton:SetPoint("BOTTOMRIGHT", self.mainFrame, "BOTTOMRIGHT", -4, 4)
    self.resizeButton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
    self.resizeButton:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
    self.resizeButton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")

    self.resizeButton:SetScript("OnMouseDown", function(element, button)
        if button == "LeftButton" then
            self.mainFrame:StartSizing("BOTTOMRIGHT")
            self.mainFrame:SetUserPlaced(true)
        end
    end)

    self.resizeButton:SetScript("OnMouseUp", function(element, button)
        self.mainFrame:StopMovingOrSizing()
    end)
end

function MainFrame:createScrollBar()
    self.scrollBar = CreateFrame("ScrollFrame", nil, self.mainFrame, "UIPanelScrollFrameTemplate")
    self.scrollBar:SetPoint("TOPLEFT", self.mainFrame, "TOPLEFT", 10, -30)
    self.scrollBar:SetPoint("BOTTOMRIGHT", self.mainFrame, "BOTTOMRIGHT", -35, 20)
end

function MainFrame:getFrame()
    return self.mainFrame
end

function MainFrame:addScrollChild(name, scrollChild)
    self.scrollBarChildren[name] = scrollChild
    self.scrollBarChildren[name]:getFrame():Hide()
end

function MainFrame:drawScrollContent(name)
    if self.drawnScrollElement then
        self.scrollBarChildren[self.drawnScrollElement]:getFrame():Hide()
    end
    self.drawnScrollElement = name

    self.scrollBar:SetScrollChild(self.scrollBarChildren[name]:getFrame())
    self.scrollBarChildren[name]:draw()
    self.scrollBarChildren[name]:getFrame():Show()
    self:ChangeTitle(self.scrollBarChildren[name]:getName())
end