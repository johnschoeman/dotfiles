# Nix OS notes

hostname = nixos

# Nix Shell

```
nix-shell -p cowsay lolcat

$> cowsay "hello world" | lolcat

exit
```

# TODO

- [x] check out zaneyos (not going to use directly, just as a reference)
- [x] use nh cli helper
- [x] gnome -> hyprland
- [x] move home.nix to ~/dotfiles/nixos
- [x] map capslock to ctrl (gnome)
- [x] map capslock to ctrl (hyprland)
- [x] Fix font
- [x] use git to track nix os config
- [ ] script to commit dotfiles and then build nix and rollback commit if build fails and re-source terminal shell
- [x] automatically start zellij when opening terminal

## Setup

- [ ] move git config to nix so we don't have to do the symlinking step

## Window Manager - Hyprland

- [ ] ? move hyprland.conf to nix (or use a symlink?)
- [x] replicate omarchy bindings
- [x] setup waybar
- [ ] rofi configuration
- [ ] checkout hyprpaper and other related packages
- [ ] use more neutral cursor

## Theme

- [x] select theme (catppuccine frappe)
  - [ ] helix
  - [ ] nvim
  - [x] waybar
  - [x] zellij
  - [ ] alacritty / kitty
  - [ ] firefox / chrome / brave
- [ ] toggle from light to dark

## Git

- [x] g function
- [x] vim as commit editor
- [x] helix as commit editor
- [ ] try using gitui

## neovim

- [ ] use lazy vim?
- [ ] global find and replace
- [ ] fix configuration usage (moved neovim to user config)
- [ ] lazy.nvim plugins
  - [ ] tree-sitter
  - [ ] telescope
- [ ] same config for sudo and login shell
- [ ] navigate pane shortcuts (https://github.com/hiasr/vim-zellij-navigator?tab=readme-ov-file)
- [x] setup spellchecker (z=)

## Helix

- [x] install helix
- [x] configure helix
- [x] learn helix
- [x] set helix as default editor

- #### Rust IDE

- [ ] rust-analyize
- [ ] rust lsp
- [ ] cargo fmt on save

## Aliases

- [ ] move dot file aliases over
- [x] cat -> bat
- [x] eza -> ls -l
- [x] cd -> z (zoxide)

## Web Browser

- [ ] omarchy shortcuts
  - new tab
  - rotate tabs
  - close tab

## Yazi

- [x] vim as default editor
- [x] helix as default editor
- [ ] move yazi.toml to home manager (currently in .config/yazi/yazi.toml and not version controled)
- [ ] setup y shell function
