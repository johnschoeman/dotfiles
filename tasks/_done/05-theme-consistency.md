# Unify theme to Catppuccin Frappe everywhere

## Priority: Medium

## Why

Everything uses Catppuccin Frappe except Helix (everforest_dark) and Alacritty (no theme). Unifying gives a cohesive look.

## What

- Switch Helix theme from `everforest_dark` to `catppuccin_frappe` in `nixos/home/helix.nix`
- Add Catppuccin Frappe color scheme to Alacritty config in `nixos/home/alacritty.nix`
- Both themes are built into their respective programs — no extra files needed

## Files

- `nixos/home/helix.nix`
- `nixos/home/alacritty.nix`
