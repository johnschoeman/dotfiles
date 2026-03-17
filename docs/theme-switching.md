# Theme Switching

Runtime theme switching across Alacritty, Zellij, Helix, and Waybar via a single script, bound to `Super+T`.

## Supported Themes

| Name | Notes |
|---|---|
| `catppuccin_frappe` | Default |
| `catppuccin_mocha` | |
| `gruvbox_dark` | |
| `nord` | |
| `rose_pine` | |
| `solarized_light` | Only light theme |
| `tokyo_night` | |

The canonical name format uses underscores (Alacritty convention). Other tools need different formats — the script handles translation.

## Architecture

```
Super+T → scripts/theme-select → rofi picker
                                      │
              ┌───────────┬───────────┼───────────┐
              ▼           ▼           ▼           ▼
          Alacritty    Zellij      Helix       Waybar
          (instant)   (new only)  (new only)  (instant)
```

### The NixOS Problem

NixOS generates config files into `/nix/store/` (read-only). Runtime theme switching requires mutable configs. The solution: `mkOutOfStoreSymlink` — home-manager creates a symlink from `~/.config/<app>/config` to a file in the dotfiles repo instead of the nix store. The script then modifies the repo file directly.

This pattern is used for Zellij (`zellij/config.kdl`) and Helix (`helix/config.toml`, `helix/languages.toml`). Alacritty uses a different approach — it imports a `current-theme.toml` file that gets overwritten.

For tools that use catppuccin/nix module integration (which generates theme config into the nix store), the module must be disabled: `catppuccin.helix.enable = false`.

### Per-Tool Mechanics

**Alacritty** — `alacritty.toml` imports `current-theme.toml` via `general.import`. The script copies the selected theme file over `current-theme.toml` and touches `alacritty.toml` to trigger inotify-based live reload. Theme files come from `pkgs.alacritty-theme`, symlinked to `~/.config/alacritty/themes/`. A home-manager activation script seeds the default on first run.

**Zellij** — `sed` replaces the `theme "..."` line in `config.kdl`. Uses hyphen-separated names (`catppuccin-frappe`). No live reload; applies to new sessions only.

**Helix** — `sed` replaces the `theme = "..."` line in `config.toml`. Uses Helix built-in theme names, which mostly match the canonical underscore format. Two exceptions need mapping: `gruvbox_dark` → `gruvbox`, `tokyo_night` → `tokyonight`. No automatic live reload, but `space t` (`:config-reload`) picks up changes in a running instance.

**Waybar** — `style.css` imports `colors.css` via `@import`. The script copies a theme-specific CSS file from `waybar/themes/` over `colors.css`, then sends `SIGUSR2` to Waybar for instant reload. Theme CSS files map each theme's palette onto Catppuccin semantic color names (`@define-color base`, `@define-color text`, etc.), so `style.css` uses one set of variable names regardless of theme.

## Name Translation

Each tool has its own naming convention. The script starts with the canonical underscore name and translates:

| Tool | Format | Example | How |
|---|---|---|---|
| Alacritty | `snake_case` | `catppuccin_frappe` | Canonical, no translation |
| Zellij | `kebab-case` | `catppuccin-frappe` | `${name//_/-}` |
| Helix | Varies | `tokyonight` | Associative array for exceptions, passthrough otherwise |
| Waybar | `kebab-case` | `catppuccin-frappe` | Reuses Zellij's translated name for file lookup |

## File Layout

```
scripts/theme-select              # Main script
helix/config.toml                 # Mutable helix config (mkOutOfStoreSymlink)
helix/languages.toml              # Mutable helix languages (mkOutOfStoreSymlink)
zellij/config.kdl                 # Mutable zellij config (mkOutOfStoreSymlink)
waybar/colors.css                 # Active color variables (overwritten by script)
waybar/themes/*.css               # Per-theme color definitions
waybar/style.css                  # Imports colors.css
nixos/home/alacritty.nix          # Alacritty config + activation script
nixos/home/helix.nix              # Helix config (catppuccin disabled, mkOutOfStoreSymlink)
nixos/home/zellij.nix             # Zellij config (mkOutOfStoreSymlink)
```

## Adding a New Theme

1. Verify the theme exists in `~/.config/alacritty/themes/` (from `pkgs.alacritty-theme`)
2. Create `waybar/themes/<kebab-name>.css` mapping the theme's palette to Catppuccin semantic color names
3. Verify the theme exists as a Zellij built-in and a Helix built-in
4. If the Helix built-in name differs from the underscore name, add an entry to `helix_map` in the script
5. Add the name to the `CURATED` array in `scripts/theme-select`
