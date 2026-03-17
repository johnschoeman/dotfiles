# Style SDDM login screen

Style the SDDM display manager to visually match the hyprlock lock screen — large clock, date, clean input field, Catppuccin Frappe defaults.

## Context

- SDDM is configured in `nixos/configuration.nix` (KDE6 package, Wayland)
- Uses QML-based themes, separate from hyprlock's hyprlang config
- Currently using the default SDDM theme
- Should feel consistent with hyprlock: blurred/dimmed background, clock+date, minimal input field

## Considerations

- SDDM themes are QML — may need a custom theme or a community theme that's close enough to customize
- Ideally theme-aware, but SDDM runs before login so runtime theme switching is less critical
- NixOS has `sddm.theme` and `sddm.extraPackages` options for declarative theming
