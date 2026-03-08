--[[
    Three-part button helper: build left (start), center, right (end) textures
    from a single texture file (e.g. 128RedButton-style strip or UI-Panel-Button-Up).

    Texture is assumed to be a horizontal strip: [ left cap | middle | right cap ].
    Coordinates are normalized 0-1; capWidth and textureWidth are used to compute them.

    Usage:
        local left, center, right = MetaAchievement_SetupThreePartButton(frame, "Interface\\Buttons\\UI-Panel-Button-Up", 32, 128)
    Then anchor frame's children or size the frame; the textures are parented to frame at BACKGROUND.
]]

function MetaAchievement_SetupThreePartButton(frame, texturePath, capWidthPx, textureWidthPx)
    if not frame or not texturePath or not frame.CreateTexture then return end
    capWidthPx = capWidthPx or 32
    textureWidthPx = textureWidthPx or 128
    local capL = capWidthPx / textureWidthPx
    local capR = 1 - capL

    local left = frame:CreateTexture(nil, "BACKGROUND")
    left:SetTexture(texturePath)
    left:SetTexCoord(0, capL, 0, 1)
    left:SetPoint("TOPLEFT", frame, "TOPLEFT")
    left:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT")
    left:SetWidth(capWidthPx)

    local right = frame:CreateTexture(nil, "BACKGROUND")
    right:SetTexture(texturePath)
    right:SetTexCoord(capR, 1, 0, 1)
    right:SetPoint("TOPRIGHT", frame, "TOPRIGHT")
    right:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")
    right:SetWidth(capWidthPx)

    local center = frame:CreateTexture(nil, "BACKGROUND")
    center:SetTexture(texturePath)
    center:SetTexCoord(capL, capR, 0, 1)
    center:SetPoint("TOPLEFT", left, "TOPRIGHT")
    center:SetPoint("BOTTOMLEFT", left, "BOTTOMRIGHT")
    center:SetPoint("TOPRIGHT", right, "TOPLEFT")
    center:SetPoint("BOTTOMRIGHT", right, "BOTTOMLEFT")

    return left, center, right
end

--[[
    Silver button using Blizzard's panel button texture (variable width).
    frame: Button or Frame. heightPx: height in pixels (e.g. 22).
    Width is left to the frame/XML (Button has no SetMinimumWidth).
]]
function MetaAchievement_SetupSilverThreePartButton(frame, heightPx)
    heightPx = heightPx or 22
    frame:SetHeight(heightPx)
    -- Blizzard's panel button is a strip; use typical cap ~32px, texture width 128
    return MetaAchievement_SetupThreePartButton(frame, "Interface\\Buttons\\UI-Panel-Button-Up", 32, 128)
end
