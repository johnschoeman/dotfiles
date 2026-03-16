# Clean up configuration.nix boilerplate

## Priority: Low

## Why

NixOS installer artifacts add noise and make the file harder to scan. The comment question about xserver + Wayland should also be resolved.

## What

- Remove boilerplate comments (proxy config, SUID wrappers, firewall examples, "Did you read the comment?")
- Remove commented-out GNOME desktop lines
- Test whether `services.xserver.enable` can be set to `false` (SDDM on Wayland may not need it, but XWayland apps might)
- Set a real hostname (e.g., `"framework"` or similar) instead of `"nixos"`

## Files

- `nixos/configuration.nix`
