# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles for NixOS (primary), with legacy support for Ubuntu and macOS.

## Quick Reference

**Rebuild NixOS after changes:**
```bash
nh os switch /home/john/dotfiles/nixos -- --impure
# or use the fish alias: nrs
```

**Never** run `nh os switch` or `nrs` directly. The user runs rebuilds in a separate terminal. When a rebuild is needed, prompt: "You may want to run `nrs` to apply these changes." Then wait for the user to report the outcome.

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

claude/                 # Claude Code global settings (symlinked to ~/.claude/)
scripts/               # Claude Code hooks & waybar integration
.claude/               # Session log, knowledge, settings

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

## Git Workflow

User manages all commits. You remind and suggest, never commit.

**After significant work:**
1. Run `/update-session-log` to capture session context
2. Run `git status` to see what's actually uncommitted
3. Write commit message to `commit-msg.txt`
4. Remind: "You may want to commit these changes"

**Commit message format:**
```
Concise summary (one line)

Why:

[Brief motivation - what problem this solves]

This commit:

- [Bullet points of actual changes]
- [Only include uncommitted changes, not already-committed work]
```

**Never:** Run git commands that modify history.

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
