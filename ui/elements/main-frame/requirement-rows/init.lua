--[[
    Dispatches to the correct row type: description, regular, or progress.
    Add new row types here and in their own file under main-frame/requirement-rows/.
]]

RequirementRows = RequirementRows or {}

function RequirementRows.InitRow(frame, elementData, detail)
    local req = elementData and elementData.req
    local index = elementData and elementData.index or 0
    if not frame or not req then return end

    frame._owner = detail
    frame._index = index

    if RequirementRowsFrame and RequirementRowsFrame.EnsureRefs then
        RequirementRowsFrame.EnsureRefs(frame)
    end

    if req.isDescriptionRow and RequirementRowDescription and RequirementRowDescription.Apply then
        RequirementRowDescription.Apply(frame, req)
    elseif req.reqQuantity and req.reqQuantity > 1 and req.quantity ~= nil and RequirementRowProgress and RequirementRowProgress.Apply then
        RequirementRowProgress.Apply(frame, req)
    elseif RequirementRowRegular and RequirementRowRegular.Apply then
        RequirementRowRegular.Apply(frame, req)
    else
        if RequirementRowRegular and RequirementRowRegular.Apply then
            RequirementRowRegular.Apply(frame, req)
        end
    end

    frame:SetScript("OnClick", function(f, btn)
        if MetaAchievementMapRequirementRow_OnClick then
            MetaAchievementMapRequirementRow_OnClick(f, btn or "LeftButton")
        end
    end)
end
