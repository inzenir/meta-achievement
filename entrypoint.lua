MetaAchievementDB = {
    achievementLists = {
        worldSoulSearching = {
            data = DataList:new(WorldSoulSearchingAchievements),
            treeView = {}
        }
    }
}

local mainFrame = CreateFrame("Frame", "MetaAchievementsTracker", UIParent, "BasicFrameTemplateWithInset")
local LDB = LibStub:GetLibrary("LibDataBroker-1.1")
local DBIcon = LibStub("LibDBIcon-1.0")

local function refrestAchievementsLists()
    for _, achilist in pairs(MetaAchievementDB.achievementLists) do
        achilist.data:rescanData()
        achilist.treeView:drawTreeList()
    end
end

local iconObject = LDB:NewDataObject("MetaAchievementsTracker", {
    type = "launcher",
    icon = "Interface\\Icons\\achievement_zone_isleofdorn",
    OnClick = function(self, button)
        if button == "LeftButton" then
            if mainFrame:IsShown() then
                mainFrame:Hide()
            else
                mainFrame:Show()
            end
        end
        if button == "RightButton" then
            refrestAchievementsLists()
        end
    end,
    OnTooltipShow = function(tooltip)
        tooltip:AddLine("Meta Achievements Tracker")
        tooltip:AddLine("Left-click to toggle visibility.")
        tooltip:AddLine("Right-click to manually refresh addons.")
    end,
})
DBIcon:Register("MetaAchievementsTracker", iconObject, MetaAchievementDB.minimap)

mainFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
mainFrame:RegisterEvent("ACHIEVEMENT_EARNED")

mainFrame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_ENTERING_WORLD" or event == "ACHIEVEMENT_EARNED" then
        refrestAchievementsLists()
    end
end)


-- Main frame
mainFrame:SetSize(300, 200)
mainFrame:SetResizeBounds(300, 200)
mainFrame:SetPoint("CENTER", 0, 0)
mainFrame:SetMovable(true)
mainFrame:SetResizable(true)
mainFrame:EnableMouse(true)
mainFrame:EnableMouseWheel(true)
mainFrame:RegisterForDrag("LeftButton")
mainFrame:SetScript("OnDragStart", mainFrame.StartMoving)
mainFrame:SetScript("OnDragStop", mainFrame.StopMovingOrSizing)
mainFrame:SetFrameStrata("TOOLTIP")

mainFrame.title = mainFrame:CreateFontString(nil, "OVERLAY")
mainFrame.title:SetFontObject("GameFontHighlight")
mainFrame.title:SetPoint("LEFT", mainFrame.TitleBg, "LEFT", 5, 0)
mainFrame.title:SetText("Worldsoul Searching")

-- Add a resize button (bottom-right corner)
local resizeButton = CreateFrame("Button", nil, mainFrame)
resizeButton:SetSize(16, 16)
resizeButton:SetPoint("BOTTOMRIGHT", mainFrame, "BOTTOMRIGHT", -4, 4)
resizeButton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
resizeButton:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
resizeButton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")

resizeButton:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" then
        mainFrame:StartSizing("BOTTOMRIGHT")
        mainFrame:SetUserPlaced(true)
    end
end)

resizeButton:SetScript("OnMouseUp", function(self, button)
    mainFrame:StopMovingOrSizing()
end)

-- Scroll frame

local scrollFrame = CreateFrame("ScrollFrame", nil, mainFrame, "UIPanelScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 10, -30)
scrollFrame:SetPoint("BOTTOMRIGHT", mainFrame, "BOTTOMRIGHT", -35, 20)


MetaAchievementDB.achievementLists.worldSoulSearching.treeView = TreeView:new(mainFrame, MetaAchievementDB.achievementLists.worldSoulSearching.data)
scrollFrame:SetScrollChild(MetaAchievementDB.achievementLists.worldSoulSearching.treeView:getFrame())
MetaAchievementDB.achievementLists.worldSoulSearching.treeView:drawTreeList()
