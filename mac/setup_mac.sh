#!/bin/bash
set -euo pipefail

# setup_mac.sh — Idempotent macOS dev environment setup
# Usage: ~/dotfiles/mac/setup_mac.sh

DOTFILES="$HOME/dotfiles"

echo "=== macOS Dotfiles Setup ==="
echo

# 1. Install Homebrew if missing
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "Homebrew already installed."
fi

# 2. Install packages from Brewfile
# Use ~/Applications for casks to avoid sudo requirement
echo "Installing packages from Brewfile..."
export HOMEBREW_CASK_OPTS="--appdir=$HOME/Applications"
brew bundle --file="$DOTFILES/mac/Brewfile"
echo

# 3. Create symlinks
echo "Creating symlinks..."

link() {
  local target="$1"
  local link_path="$2"
  mkdir -p "$(dirname "$link_path")"
  ln -sf "$target" "$link_path"
  echo "  $link_path -> $target"
}

link "$DOTFILES/mac/fish/config.fish"    "$HOME/.config/fish/config.fish"
link "$DOTFILES/helix/config.toml"       "$HOME/.config/helix/config.toml"
link "$DOTFILES/helix/languages.toml"    "$HOME/.config/helix/languages.toml"
link "$DOTFILES/zellij/config.kdl"       "$HOME/.config/zellij/config.kdl"
link "$DOTFILES/mac/alacritty.toml"      "$HOME/.config/alacritty/alacritty.toml"
link "$DOTFILES/gitconfig"               "$HOME/.gitconfig"
link "$DOTFILES/gitmessage"              "$HOME/.gitmessage"
link "$DOTFILES/claude/settings.json"    "$HOME/.claude/settings.json"
link "$DOTFILES/claude/skills"           "$HOME/.claude/skills"
link "$DOTFILES/claude/CLAUDE.md"        "$HOME/.claude/CLAUDE.md"
echo

# 4. Install Rust stable toolchain if not present
if ! rustup toolchain list 2>/dev/null | grep -q "stable"; then
  echo "Installing Rust stable toolchain..."
  rustup toolchain install stable
fi
# Ensure ~/.cargo/bin proxy shims exist
rustup set profile default
rustup update stable --no-self-update 2>/dev/null || true
echo

# 6. Copy default Alacritty theme if not present
THEME_DEST="$HOME/.config/alacritty/current-theme.toml"
if [ ! -f "$THEME_DEST" ]; then
  cp "$DOTFILES/alacritty/themes/catppuccin_frappe.toml" "$THEME_DEST"
  echo "Copied default Alacritty theme (Catppuccin Frappe)."
else
  echo "Alacritty theme already set, skipping."
fi
echo

# 7. Set Fish as default shell (requires sudo — skipped if unavailable)
FISH_PATH="/opt/homebrew/bin/fish"
if ! grep -qF "$FISH_PATH" /etc/shells; then
  if sudo -n true 2>/dev/null; then
    echo "Adding Fish to /etc/shells..."
    echo "$FISH_PATH" | sudo tee -a /etc/shells >/dev/null
  else
    echo "NOTE: Fish is not in /etc/shells. Run manually with admin access:"
    echo "  echo '$FISH_PATH' | sudo tee -a /etc/shells"
  fi
fi

if grep -qF "$FISH_PATH" /etc/shells && [ "$SHELL" != "$FISH_PATH" ]; then
  echo "Setting Fish as default shell..."
  chsh -s "$FISH_PATH"
elif [ "$SHELL" = "$FISH_PATH" ]; then
  echo "Fish is already the default shell."
fi
echo

# 8. Summary
echo "=== Setup Complete ==="
echo
echo "Installed: CLI tools, dev tools, fonts, GUI apps"
echo "Symlinked: fish, helix, zellij, alacritty, git, claude"
echo
echo "Next steps:"
echo "  1. Open Alacritty — should launch Fish with starship prompt"
echo "  2. Verify: hx --version, zellij --version, bat --version"
echo "  3. Verify: cargo --version"
