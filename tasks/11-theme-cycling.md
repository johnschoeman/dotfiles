# Theme cycling across Alacritty, Zellij, and Waybar

## Priority: Medium

## Status

- Alacritty: done (rofi picker + live reload)
- Zellij: done (sed config, new sessions only)
- Waybar: next

## Waybar plan

### Context

`theme-select` currently switches themes for Alacritty and Zellij. Waybar uses a separate `frappe.css` color file imported via CSS `@import` in `style.css`. The `@import` is baked into the nix store at build time (`builtins.readFile`), but waybar resolves the import path **at runtime** — meaning the imported color file in the dotfiles repo is already mutable. No changes to `waybar.nix` needed.

Waybar reloads on `SIGUSR2` (default behavior), so theme changes are instant.

### Bug fix

`style.css:19` references `@subtext2` which doesn't exist in `frappe.css` (only `subtext0` and `subtext1`). Fix to `@subtext1`.

### Files to change

| File | Action |
|------|--------|
| `waybar/themes/*.css` | **Create** — color CSS files for each curated theme |
| `waybar/colors.css` | **Create** — active color file (defaults to catppuccin-frappe) |
| `waybar/style.css` | **Modify** — change `@import` from `frappe.css` to `colors.css` |
| `scripts/theme-select` | **Modify** — add waybar color swap + SIGUSR2 reload |

### Step 1: Create `waybar/themes/` color files

Create a CSS file for each of the 7 curated themes, each defining the same `@define-color` variables. Use hyphenated names matching the Zellij convention:

- `catppuccin-frappe.css` — exact copy of current `frappe.css`
- `catppuccin-mocha.css` — from catppuccin/waybar published palette
- `gruvbox-dark.css` — mapped from gruvbox palette
- `nord.css` — mapped from nord palette
- `rose-pine.css` — mapped from rose pine palette
- `solarized-light.css` — mapped from solarized palette
- `tokyo-night.css` — mapped from tokyo night palette

Each file defines all 26 variables (base, mantle, crust, text, subtext0/1, surface0/1/2, overlay0/1/2, and the 14 accent colors). For non-Catppuccin themes, accent colors are mapped semantically (e.g., nord aurora → rosewater/flamingo/mauve/etc.).

Variables actually used in style.css today: `mantle`, `base`, `text`, `subtext1`, `rosewater`, `flamingo`, `peach`, `red`. All 26 defined for forward-compatibility.

### Step 2: Create `waybar/colors.css`

Copy of `catppuccin-frappe.css` content. This is the "active" color file that `theme-select` overwrites at runtime. Tracked in git (like `zellij/config.kdl`).

### Step 3: Update `waybar/style.css`

Change `@import` from `frappe.css` to `colors.css`. Fix `@subtext2` → `@subtext1`.

### Step 4: Update `scripts/theme-select`

After the Zellij block, add waybar color swap + `pkill -SIGUSR2 waybar`. Reuses the `$zellij_name` variable (underscore→hyphen). If no matching waybar theme file exists, waybar keeps current colors.

Simplify notification to just `"$name"` (no longer Zellij-specific).

### Verification

1. Rebuild with `nrs` (one-time, to bake the new @import path)
2. `theme-select nord` → check `waybar/colors.css` has nord colors, waybar reloads instantly
3. `theme-select catppuccin_frappe` → reverts to frappe
4. Pick an uncurated theme → waybar stays on current colors, Alacritty changes
