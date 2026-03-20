-- Mount reward panel: shows mount name + 3D model when the empty-state panel is shown and top achievement has mountId.

function MetaAchievementMountRewardPanel_Update(mountPanel, mountId)
    if not mountPanel then
        return
    end
    if not mountId or type(C_MountJournal) ~= "table" or type(C_MountJournal.GetMountInfoByID) ~= "function" then
        mountPanel:Hide()
        return
    end
    local mOk, mName = pcall(C_MountJournal.GetMountInfoByID, mountId)
    if not mOk or not mName then
        mountPanel:Hide()
        return
    end
    local mountName = mountPanel.Name or _G[mountPanel:GetName() .. "Name"]
    if mountName and mountName.SetText then
        mountName:SetText(tostring(mName))
    end
    local mountModel = mountPanel.MountModel
    if not mountModel and CreateFrame then
        mountModel = CreateFrame("PlayerModel", mountPanel:GetName() .. "Model", mountPanel)
        mountModel:SetSize(440, 240)
        local nameFrame = _G[mountPanel:GetName() .. "Name"]
        mountModel:SetPoint("TOP", nameFrame or mountPanel, nameFrame and "BOTTOM" or "TOP", 0, nameFrame and -8 or -24)
        mountModel:SetPoint("LEFT", mountPanel, "LEFT", 0, 0)
        mountModel:SetPoint("RIGHT", mountPanel, "RIGHT", 0, 0)
        mountPanel.MountModel = mountModel
    end
    if mountModel then
        local w, h = mountPanel:GetWidth(), mountPanel:GetHeight()
        if w and w > 0 and h and h > 0 then
            local modelH = math.max(60, h - 24)
            mountModel:SetSize(w, modelH)
        else
            mountModel:SetSize(440, 240)
        end
    end
    if mountModel and type(mountModel.SetDisplayInfo) == "function" then
        local displayID
        if type(C_MountJournal.GetMountAllCreatureDisplayInfoByID) == "function" then
            local ok, infos = pcall(C_MountJournal.GetMountAllCreatureDisplayInfoByID, mountId)
            if ok and infos and infos[1] then
                local first = infos[1]
                displayID = type(first) == "number" and first or (first.creatureDisplayID or first.displayID)
            end
        end
        if displayID then
            mountModel:SetDisplayInfo(displayID)
            local pos = (type(MetaAchievementMountRewardPanel_GetPosition) == "function" and MetaAchievementMountRewardPanel_GetPosition(mountId)) or { x = -1, y = 0, z = -0.25, facingDegrees = 20 }
            if type(mountModel.SetPosition) == "function" then
                mountModel:SetPosition(pos.x, pos.y, pos.z)
            end
            if type(mountModel.SetFacing) == "function" then
                mountModel:SetFacing((pos.facingDegrees or 20) * math.pi / 180)
            end
            mountModel:Show()
        else
            mountModel:Hide()
        end
    end
    mountPanel:Show()
end
