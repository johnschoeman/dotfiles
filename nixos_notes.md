# Nix OS notes

hostname = nixos

# Nix Shell

```
nix-shell -p cowsay lolcat

$> cowsay "hello world" | lolcat

exit
```

# Nix Flake

```
nix flake init
```

## Deploy the flake

```
sudo nixos-rebuild switch
```

# TODO

[x] check out zaneyos (not going to use directly, just as a reference)
[ ] use nh cli helper
[ ] gnome -> hyprland
[ ] move home.nix to ~/dotfiles/nixos
[x] map capslock to ctrl (gnome)
[ ] map capslock to ctrl (hyprland)
[x] Fix font
[ ] use git to track nix os config

## Git

[ ] g alias
[ ] vim as commit editor
[ ] try using gitui

## neovim

[ ] fix configuration usage (moved neovim to user config)
  [ ] lazy.nvim plugins
    [ ] tree-sitter
    [ ] telescope
  [ ] same config for sudo and login shell
[ ] navigate pane shortcuts

## Aliases

[ ] move dot file aliases over
[x] cat -> bat
[x] eza -> ls -l
[x] cd -> z (zoxide)

## Web Browser

[ ] omarchy shortcuts
  - new tab
  - rotate tabs
  - close tab

## Programs

[ ] Fish
[ ] Nushell
[ ] nh
[x] Ripgrep (rg -h)
[x] Fd
[x] fzf
[x] Bat
[x] Eza
[x] Zoxide
[x] Xh
[x] Zellij
[x] Gitui
[x] du-dust
[x] dua

[ ] tree
[x] neofetch
[x] htop-vim

[ ] xremap # maybe not: depends on if need more remaps than caps -> ctrl

[x] starship
[ ] yazi
[ ] hyperfine
[ ] evil-helix
[ ] bacon
[ ] cargo-info
[ ] fselect
[ ] ncspot
[ ] rusty-man
[ ] delta
[ ] ripgrep-all
[ ] tokei
[ ] wiki-tui
[ ] just
[ ] mask
[ ] mprocs
[ ] presenterm
[ ] kondo
[ ] bob-nvim
[ ] rtx
[ ] espanso
