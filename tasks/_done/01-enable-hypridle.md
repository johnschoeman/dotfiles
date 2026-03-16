# Enable hypridle

## Priority: High

## Why

No idle management means the laptop drains battery whenever you walk away. The config is already written and commented out in `hyprland.nix`.

## What

- Uncomment the `services.hypridle` block in `nixos/home/hyprland.nix:91-111`
- Remove `swayidle` from `nixos/configuration.nix:146` (redundant — hypridle integrates better with Hyprland)
- Delete the fully-commented-out `hypr/suspend.sh` (superseded by hypridle)
- Tune timeouts to preference (currently: lock at 15min, dpms off at 20min)

## Files

- `nixos/home/hyprland.nix`
- `nixos/configuration.nix`
- `hypr/suspend.sh`
