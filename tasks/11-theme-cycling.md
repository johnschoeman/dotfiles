# Theme switching across tools

## Priority: Medium

## Status

- Alacritty: done (cp theme file, instant live reload)
- Zellij: done (sed config.kdl, new sessions only)
- Waybar: done (cp colors.css, SIGUSR2 instant reload)
- Helix: done (sed config.toml, new instances or space-t reload)
- Rofi: done (cp colors.rasi, next launch)
- Yazi: done (mutable theme.toml via mkOutOfStoreSymlink, instant)
- catppuccin/nix module: removed (theme-select is single source of truth)

- Mako: done (cat base.conf + theme colors > config, makoctl reload instant)
- Hyprlock: done (cp theme colors.conf, next lock)

## Documentation

Full system documented in `docs/theme-switching.md`.
