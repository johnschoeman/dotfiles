# Nix OS notes

hostname = nixos

# Nix Shell

```
nix-shell -p cowsay lolcat

$> cowsay "hello world" | lolcat

exit
```

NixOS Setup
---

# Wifi

nmcli device wifi list

nmcli device wifi connect <SSID> password <password>

# SSH for github

```
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

Add the SSH public key to your account on GitHub .


# TODO

[x] check out zaneyos (not going to use directly, just as a reference)
[x] use nh cli helper
[x] gnome -> hyprland
[x] move home.nix to ~/dotfiles/nixos
[x] map capslock to ctrl (gnome)
[x] map capslock to ctrl (hyprland)
[x] Fix font
[x] use git to track nix os config
[ ] script to commit dotfiles and then build nix and rollback commit if build fails and re-source terminal shell
[x] automatically start zellij when opening terminal

## Window Manager - Hyprland

[ ] move hyprland.conf to nix (or use a symlink?)
[x] replicate omarchy bindings
[x] setup waybar
[ ] rofi configuration
[ ] checkout hyprpaper and other related packages
[ ] use more neutral cursor

## Theme

[x] select theme (catppuccine)
    [ ] nvim
    [x] waybar
    [x] zellij
    [ ] alacritty / kitty
    [ ] firefox / chrome / brave
[ ] toggle from light to dark

## Git

[x] g function
[ ] vim as commit editor
[ ] try using gitui

## neovim

[ ] fix configuration usage (moved neovim to user config)
  [ ] lazy.nvim plugins
    [ ] tree-sitter
    [ ] telescope
  [ ] same config for sudo and login shell
[ ] navigate pane shortcuts (https://github.com/hiasr/vim-zellij-navigator?tab=readme-ov-file)
[x] setup spellchecker (z=)
[ ] global find and replace
[ ] use lazy vim?

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

## Yazi

[x] vim as default editor
[ ] setup y shell function

## Programs

[ ] Fish
[ ] Nushell

[x] nh         # nix cli

[x] hyprland   # tiling window manager
[x] rofi       # application launcher
[x] waybar     # window status bar
[x] hwg-look   # GTK settings editor
[x] hyprcursor # cursor for hyprland

[x] Ripgrep    # (rg -h)
[x] Fd         # find replacement
[x] fzf        # fuzzy file finder
[x] Bat        # cat with wings
[x] Eza        # ls replacement
[x] Zoxide     # cd replacement
[x] Xh         # http requests
[x] Zellij     # terminal multiplexer
[x] Gitui      # git tui
[x] du-dust    # disk usage
[x] dua        # disk usage also
[x] yazi       # terminal file navigator

[ ] tree
[x] neofetch
[x] htop-vim

[ ] xremap     # maybe not: depends on if need more remaps than caps -> ctrl

[x] starship   # terminal prompt
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


[x] 1password
[x] spotify


# archives
[ ] zip
[ ] xz
[ ] unzip
[ ] p7zip

# utils
[ ] jq         # A lightweight and flexible command-line JSON processor
[ ] yq-go      # yaml processor https://github.com/mikefarah/yq

# networking tools
[ ] mtr        # A network diagnostic tool
[ ] iperf3
[ ] dnsutils   # `dig` + `nslookup`
[ ] ldns       # replacement of `dig`, it provide the command `drill`
[ ] aria2      # A lightweight multi-protocol & multi-source command-line download utility
[ ] socat      # replacement of openbsd-netcat
[ ] nmap       # A utility for network discovery and security auditing
[ ] ipcalc     # it is a calculator for the IPv4/v6 addresses

# misc
[ ] cowsay
[ ] file
[ ] which
[ ] gnused
[ ] gnutar
[ ] gawk
[ ] zstd
[ ] gnupg

[ ] btop       # replacement of htop/nmon
[ ] iotop      # io monitoring
[ ] iftop      # network monitoring

# system call monitoring
[ ] strace     # system call monitoring
[ ] ltrace     # library call monitoring
[ ] lsof       # list open files

# system tools
[ ] sysstat
[ ] lm_sensors # for `sensors` command
[ ] ethtool
[ ] pciutils   # lspci
[ ] usbutils   # lsusb

