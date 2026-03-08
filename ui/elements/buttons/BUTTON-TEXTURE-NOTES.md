# Button from start/end (and middle) textures

## 128RedButton.PNG (Gethe/wow-ui-textures)

- **What it is:** A single PNG in `Buttons/128RedButton.PNG` (~360KB). The "128" usually means design width in pixels. Such assets are typically laid out as a **horizontal strip**: left cap (start) | repeatable/stretchable middle | right cap (end).
- **In WoW:** The game does not use this path by default; addons reference it only if they ship or reference the file. Blizzard’s own panel buttons use `Interface\Buttons\UI-Panel-Button-Up` (and Down/Highlight) as a single texture, often with `SetTexCoord` to show a portion.

## Creating a button from “start and end” (and middle)

Two approaches:

### 1. One texture with left / center / right regions

Use **one** texture file that contains start, middle, and end in a single strip. Create **three** Texture objects, all using the same file, and use `SetTexCoord(left, right, top, bottom)` so that:

- **Start (left):** fixed-width cap on the left (e.g. first 25% or first 32 px of a 128 px-wide texture).
- **Middle:** stretchable center (e.g. 25%–75% of texture); this texture is anchored between the two caps and stretches.
- **End (right):** fixed-width cap on the right (e.g. last 25% or last 32 px).

Normalized coords (0–1): if the strip is 128 px wide and each cap is 32 px, then:

- Left:  `SetTexCoord(0, 32/128, 0, 1)` → `(0, 0.25, 0, 1)`
- Center: `SetTexCoord(32/128, 96/128, 0, 1)` → `(0.25, 0.75, 0, 1)`
- Right:  `SetTexCoord(96/128, 1, 0, 1)` → `(0.75, 1, 0, 1)`

Anchor the three textures: left at frame LEFT; center from end of left to start of right; right at frame RIGHT. Set left and right to a fixed pixel width; let the center fill the rest.

### 2. Separate “start” and “end” silver textures

If you have **two** files (e.g. `SilverButton-Left.PNG` and `SilverButton-Right.PNG`):

- **Left texture:** `SetTexture(pathToStart)`, anchor to frame’s LEFT, fixed width.
- **Right texture:** `SetTexture(pathToEnd)`, anchor to frame’s RIGHT, fixed width.
- **Middle:** Either a third texture (e.g. a stretchable silver center from another file) or a solid color texture (`SetColorTexture(r,g,b,a)`) so the gap between the two caps is filled.

No `SetTexCoord` needed for the caps if each file is already just the cap art.

## Silver look with Blizzard assets

If you don’t have custom silver PNGs:

- Use **UI-Panel-Button-Up** (and Down/Highlight for states) as the texture path. That is the standard silver/gold panel button; use the 3-part approach above with the same path for left/center/right if you want a stretchable silver bar with caps.
- For a **small fixed-size button** (e.g. cog), a single texture or backdrop (as in the settings cog) is enough; the 3-part approach is for **variable-width** buttons.

## Helper

See `ui/elements/buttons/three-part-button-helper.lua` for a function that builds the left/center/right textures from one texture path and optional cap width (pixels) and total texture width (for coord math).
