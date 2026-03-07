# How Blizzard Creates a "Reset Chat Position"-Style Setting Row

Summary of the official Blizzard UI (from `Blizzard_SettingControls.lua` in wow-ui-source).

## 1. Control type: **Settings button** (label + action button)

- **Mixin:** `SettingsButtonControlMixin` (inherits `SettingsListElementMixin`, `SettingsNewTagMixin`).
- **Frame template:** `"SettingButtonControlTemplate"` (note: "Setting" singular in the template name).
- **Initializer factory:** `CreateSettingsButtonInitializer(name, buttonText, buttonClick, tooltip, addSearchTags, newTagID, gameDataFunc)`.

## 2. Creating the initializer

```lua
-- From Blizzard_SettingControls.lua (simplified)
function CreateSettingsButtonInitializer(name, buttonText, buttonClick, tooltip, addSearchTags, newTagID, gameDataFunc)
    local data = {
        name = name,
        buttonText = buttonText,
        buttonClick = buttonClick,
        tooltip = tooltip,
        newTagID = newTagID,
        gameDataFunc = gameDataFunc,
    }
    local initializer = Settings.CreateElementInitializer("SettingButtonControlTemplate", data)
    if addSearchTags then
        initializer:AddSearchTags(name)
        initializer:AddSearchTags(buttonText)
    end
    return initializer
end
```

So the “Reset Chat Position” row is created by registering an initializer built with this helper (or equivalent), and the template is **SettingButtonControlTemplate**.

## 3. Row layout (from `SettingsListElementMixin:Init`)

- **Label (left):**
  - `self.Text:SetPoint("LEFT", (self:GetIndent() + 37), 0)`  → label starts at **indent + 37** from the left.
  - `self.Text:SetPoint("RIGHT", self, "CENTER", -85, 0)`    → label ends at **center - 85** (leaves room for the control).
- **Button (right):**
  - If `name ~= ""`: `self.Button:SetPoint("LEFT", self, "CENTER", -40, 0)` (button in the right half).
  - If `name == ""`: `self.Button:SetPoint("LEFT", self.Text, "LEFT", 0, 0)` (button only, no label).
- **Indent:** `indentSize = 15`; optional extra indent via `initializer:Indent()` (adds 15px).

So alignment with other rows comes from the shared **37** left offset and the **CENTER - 85** for the label, with the button in the right half.

## 4. Button creation (from `SettingsButtonControlMixin:OnLoad`)

- `self.Button = CreateFrame("Button", nil, self, "UIPanelButtonTemplate")`
- `self.Button:SetWidth(200, 26)` (Blizzard uses 200 width in their example).
- Button gets `DefaultTooltipMixin` and a “New” tag frame.

So the actual control is a **UIPanelButtonTemplate** button, 200 wide, positioned as above.

## 5. Hover highlight (from `DefaultTooltipMixin`)

- In **OnEnter:**  
  `if self.HoverBackground then self.HoverBackground:Show() end`
- In **OnLeave:**  
  `if self.HoverBackground then self.HoverBackground:Hide() end`

So the “white but transparent” row highlight is a texture named **HoverBackground** on the list element frame; the template (e.g. in `Blizzard_SettingControls.xml`) defines this texture and the mixin shows/hides it on enter/leave.

## 6. Using Blizzard’s template from an addon

- Blizzard does **not** expose a public `Settings.CreateListButton()` (or similar); they use **CreateSettingsButtonInitializer** and **SettingButtonControlTemplate** internally.
- Addons can:
  - Use **CreateElementInitializer("SettingButtonControlTemplate", data)** with the same **data** shape (name, buttonText, buttonClick, tooltip, etc.) and **RegisterInitializer(category, initializer)** so the row is created like “Reset Chat Position”, **or**
  - Keep using a custom template (e.g. `MetaAchievementSettingsButtonTemplate`) and match Blizzard’s layout numbers (label left **37**, label right **CENTER - 85**, button in right half, **HoverBackground** texture) so it looks and behaves the same.

## 7. Alignment takeaway

To align a custom “label + button” row with Blizzard’s rows:

- Use **label left = 37** (or **indent + 37** if you support indent).
- Use **label right = frame center - 85** (or equivalent so the button sits in the right half).
- Use a **HoverBackground** texture and show/hide it in OnEnter/OnLeave for the same hover effect.
