# Theme cycling for Alacritty

## Priority: Medium

## Why

Catppuccin Frappe doesn't suit all lighting environments. Need a quick way to switch between themes for different contexts — high contrast for bright rooms, warm tones for evening, cool tones for focus, low-light for dark rooms, etc.

## What

Build a theme cycling mechanism for Alacritty:

- Curate a small set of themes (4-6) covering different needs:
  - **Low light / dark**: Catppuccin Frappe (current default)
  - **High contrast**: e.g., Solarized Dark, Gruvbox Dark Hard
  - **Warm**: e.g., Gruvbox Dark, Tokyo Night
  - **Cool / focus**: e.g., Nord, Dracula
  - **Bright / daylight**: e.g., Solarized Light, Catppuccin Latte
- A keybinding or script to cycle through them (or pick from a list via rofi/wofi)
- Persist the current selection so new Alacritty windows use it

## Design considerations

- Alacritty supports `import` in its config and live-reloads on config change — could swap an imported theme file
- Could also extend to Helix / other tools for full environment theme switching
- Keep it simple initially — Alacritty first, expand later if useful

## Files

- `nixos/home/alacritty.nix` — theme import mechanism
- New: theme files or script for cycling
- Possibly `hypr/hyprland.conf` — keybinding to trigger
