--[[
    Dispatches to the correct row type: description, regular, or progress.
    Add new row types here and in their own file under main-frame/requirement-rows/.
]]

RequirementRows = RequirementRows or {}

RequirementRows.REGULAR_HEIGHT = 20
RequirementRows.PROGRESS_HEIGHT = 41  -- text line + progress bar; must match progress-row.xml and ScrollBox extent

RequirementRows.TEMPLATE_DESCRIPTION = "MetaAchievementMapRequirementRowDescriptionTemplate"
RequirementRows.TEMPLATE_REGULAR = "MetaAchievementMapRequirementRowRegularTemplate"
RequirementRows.TEMPLATE_PROGRESS = "MetaAchievementMapRequirementRowProgressTemplate"

--- Progress bar rows only when the criterion tracks multi-step progress (e.g. 3/15).
--- Binary API criteria use reqQuantity 1 (0/1); those stay on the regular row template.
function RequirementRows.IsProgressRequirement(req)
    return type(req) == "table"
        and req.reqQuantity and req.reqQuantity > 1
        and req.quantity ~= nil
end

function RequirementRows.GetTemplateName(req)
    if type(req) ~= "table" then
        return RequirementRows.TEMPLATE_REGULAR
    end
    if req.isDescriptionRow then
        return RequirementRows.TEMPLATE_DESCRIPTION
    end
    if RequirementRows.IsProgressRequirement(req) then
        return RequirementRows.TEMPLATE_PROGRESS
    end
    return RequirementRows.TEMPLATE_REGULAR
end

function RequirementRows.GetRowHeightForTemplate(templateName)
    if templateName == RequirementRows.TEMPLATE_PROGRESS then
        return RequirementRows.PROGRESS_HEIGHT
    end
    return RequirementRows.REGULAR_HEIGHT
end

function RequirementRows.GetRowHeightForRequirement(req)
    return RequirementRows.GetRowHeightForTemplate(RequirementRows.GetTemplateName(req))
end

--- ScrollBoxList extent and frame height must match exactly or rows shift while scrolling.
function RequirementRows.ApplyRowFrameMetrics(frame, elementData)
    if not frame then
        return
    end
    local templateName = elementData and elementData.templateName
    local height = RequirementRows.GetRowHeightForTemplate(templateName)
    if frame.SetHeight then
        frame:SetHeight(height)
    end
    if frame.SetClipsChildren then
        frame:SetClipsChildren(templateName == RequirementRows.TEMPLATE_PROGRESS)
    end
end

function RequirementRows.InitRow(frame, elementData, detail)
    local req = elementData and elementData.req
    local index = elementData and elementData.index or 0
    if not frame or not req then return end

    RequirementRows.ApplyRowFrameMetrics(frame, elementData)

    frame._owner = detail
    frame._index = index

    if RequirementRowsFrame and RequirementRowsFrame.EnsureRefs then
        RequirementRowsFrame.EnsureRefs(frame)
    end

    if req.isDescriptionRow and RequirementRowDescription and RequirementRowDescription.Apply then
        RequirementRowDescription.Apply(frame, req)
    elseif RequirementRows.IsProgressRequirement(req) and RequirementRowProgress and RequirementRowProgress.Apply then
        RequirementRowProgress.Apply(frame, req)
    elseif RequirementRowRegular and RequirementRowRegular.Apply then
        RequirementRowRegular.Apply(frame, req)
    end

    frame:SetScript("OnClick", function(f, btn)
        if MetaAchievementMapRequirementRow_OnClick then
            MetaAchievementMapRequirementRow_OnClick(f, btn or "LeftButton")
        end
    end)
end
