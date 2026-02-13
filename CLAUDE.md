# Dotfiles Repository

Personal dotfiles for NixOS (primary), with legacy support for Ubuntu and macOS.

## Quick Reference

**Rebuild NixOS after changes:**
```bash
nh os switch /home/john/dotfiles/nixos -- --impure
# or use the fish alias: nrs
```

**Update flake dependencies:**
```bash
nix flake update
```

## Repository Structure

```
nixos/                  # NixOS configuration (primary)
├── flake.nix          # Flake inputs & outputs
├── configuration.nix  # System-level config
└── home/              # Home-manager modules per program

hypr/                  # Hyprland window manager
├── hyprland.conf      # Keybindings, window rules, settings

waybar/                # Status bar (Catppuccin Frappe theme)
zellij/                # Terminal multiplexer
vim/                   # Neovim config (init.lua)

ubuntu/                # Ubuntu setup scripts (legacy)
mac/                   # macOS setup scripts (legacy)

gitconfig              # Git config (symlinked to ~/.gitconfig)
gitmessage             # Commit message template
```

## Key Configurations

| Tool | Config Location | Notes |
|------|-----------------|-------|
| NixOS system | `nixos/configuration.nix` | Packages, services, hardware |
| User packages | `nixos/home/home.nix` | Home-manager entry point |
| Fish shell | `nixos/home/fish.nix` | Aliases, functions, integrations |
| Helix editor | `nixos/home/helix.nix` | Primary editor, LSP config |
| Hyprland | `hypr/hyprland.conf` | Window manager keybindings |
| Waybar | `waybar/style.css` | Status bar styling |
| Git | `gitconfig` | Aliases, user info |

## Conventions

**Commit messages:** Short imperative style (e.g., "Add soft wrap to helix config")

**Theme:** Catppuccin Frappe across Waybar, Hyprlock, Zellij

**Primary tools:**
- Editor: Helix (`hx`)
- Shell: Fish (interactive), Bash (login)
- Terminal: Alacritty + Zellij
- Window manager: Hyprland

## Common Tasks

**Add a new package:** Edit `nixos/home/home.nix` or `nixos/configuration.nix`, then rebuild

**Add a Hyprland keybinding:** Edit `hypr/hyprland.conf`, reload Hyprland

**Modify shell aliases:** Edit `nixos/home/fish.nix`, then rebuild
