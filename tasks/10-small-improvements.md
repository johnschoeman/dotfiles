# Small quality-of-life improvements

## Priority: Low

## Why

Minor tweaks that each improve daily usage slightly.

## What

- **Yazi `y` wrapper**: Add a Fish function that changes directory to wherever you navigated in yazi on exit (standard yazi shell integration)
- **Battery warning at 20%**: Add a warning notification in `scripts/battery-notify.sh` at 20% to match waybar's warning threshold (currently only alerts at < 10%)
- **Mako notification width**: Test whether Claude notifications get truncated at 200px width; increase if needed

## Files

- `nixos/home/fish.nix` (y function)
- `scripts/battery-notify.sh` (20% warning)
- `nixos/home/hyprland.nix` (mako width)
