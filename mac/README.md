# macOS Setup

Bootstrap a fresh Mac with the same dev environment as the NixOS machine: Fish + Helix + Alacritty + Zellij + Catppuccin Frappe.

## Quick Start

```bash
git clone <repo> ~/dotfiles
~/dotfiles/mac/setup_mac.sh
```

The script is idempotent — safe to re-run.

## What Gets Installed

**CLI tools:** fish, helix, zellij, bat, fzf, fd, ripgrep, eza, zoxide, gitui, dust, dua-cli, fastfetch, starship, btop, htop, atuin, xh, direnv, pandoc, timer

**Dev tools:** node, pnpm, python@3, rustup

**Fonts:** JetBrains Mono Nerd Font

**GUI apps:** Alacritty, Obsidian, Chrome, Rectangle

## Config Symlinks

| Config | Links to |
|--------|----------|
| `~/.config/fish/config.fish` | `mac/fish/config.fish` |
| `~/.config/helix/config.toml` | `helix/config.toml` |
| `~/.config/helix/languages.toml` | `helix/languages.toml` |
| `~/.config/zellij/config.kdl` | `zellij/config.kdl` |
| `~/.config/alacritty/alacritty.toml` | `mac/alacritty.toml` |
| `~/.gitconfig` | `gitconfig` |
| `~/.gitmessage` | `gitmessage` |
| `~/.claude/settings.json` | `claude/settings.json` |
| `~/.claude/skills` | `claude/skills` |

Helix, Zellij, Git, and Claude configs are shared with NixOS. Fish and Alacritty have macOS-specific versions in `mac/`.

## Updating Packages

```bash
brew bundle --file=~/dotfiles/mac/Brewfile # alias: brewbundle
```

Add new packages to `mac/Brewfile`, then re-run.
