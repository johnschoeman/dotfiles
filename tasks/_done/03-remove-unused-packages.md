# Remove unused and duplicate packages

## Priority: Medium

## Why

Reduces clutter and avoids confusion about what's actually in use.

## What

- Remove `programs.kitty.enable = true;` from `nixos/home/hyprland.nix:42` (you use Alacritty)
- Remove `wl-clipboard-rs` from `nixos/configuration.nix:165` (duplicate of `wl-clipboard` on line 144)
- Decide on yazi: either uncomment the module in `home.nix:19` and finish setup, or remove `yazi` from packages in `home.nix:89`

## Files

- `nixos/home/hyprland.nix`
- `nixos/configuration.nix`
- `nixos/home/home.nix`
