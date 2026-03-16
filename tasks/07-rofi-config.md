# Configure rofi with Catppuccin theme

## Priority: Low

## Why

`SUPER+Space` already launches `rofi -show drun` but rofi has no configuration or theme. Adding a Catppuccin Frappe theme matches the rest of the system.

## What

- Add `programs.rofi` configuration via home-manager (new file `nixos/home/rofi.nix` or inline in `hyprland.nix`)
- Apply Catppuccin Frappe theme (community theme available)
- Remove `rofi` from the raw package list in `hyprland.nix` since `programs.rofi.enable` handles the package

## Files

- `nixos/home/hyprland.nix`
- `nixos/home/home.nix` (add import)
- New: `nixos/home/rofi.nix` (optional)
