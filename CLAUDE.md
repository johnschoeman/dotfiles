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

## Memory

`.claude/MEMORY.md` stores durable knowledge: architectural decisions, gotchas, discovered limitations, and conventions. Read it at the start of a session. Update it when you discover something that would be useful across sessions.

- Organize by topic, not chronologically
- Keep entries concise — facts and decisions, not narratives
- Remove entries that become outdated
- This is distinct from the session log: memory = stable knowledge, session log = what happened when

## Session Log

Update `.claude/SESSION_LOG.md` after significant work:
- Add new entry at the top (most recent first)
- Include: date, goal, key decisions, and outcomes
- Focus on decisions and context that would help future sessions
- Keep entries concise but informative

## Git Workflow

User manages all commits. You remind and suggest, never commit.

**After significant work:**
1. Update `.claude/SESSION_LOG.md` with session summary
2. Run `git status` to see what's actually uncommitted
3. Write commit message to `temp_commit_message.txt`
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

**Session log:** `.claude/SESSION_LOG.md`
