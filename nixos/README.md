# NixOS

## Setup

0. Install fresh NixOS

1. Connect to Wifi

```
nmcli device wifi list
nmcli device wifi connect <SSID> password <password>
```

2. SSH for github

```
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

Add the SSH public key to your account on GitHub.

3. Clone dotfiles

```
nix-shell -p git
git clone git@github.com:johnschoeman/dotfiles.git
```

4. Build Initial NixOS

```
sudo nixos-rebuild switch --impure --flake /home/john/dotfiles/nixos#nixos
```

5. Add symlinks for non nix program configs

```
ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/gitmessage ~/.gitmessage
```

6. Restart System

7. Validate

```
ninfo
```

## Theme

[Catppuccine Frappe](https://catppuccin.com/palette/)

## Usage

rebuild-switch nixos

```
nrs
```

## Programs

### OS

- [x] nh         # nix cli

### Window Manager

- [x] hyprland   # tiling window manager
- [x] rofi       # application launcher
- [x] waybar     # window status bar
- [x] hwg-look   # GTK settings editor
- [x] hyprcursor # cursor for hyprland

### Shells

- [x] Bash       # login shell
- [x] Fish       # default interactive shell in zellij

### Terminal Tools

- [x] Zellij     # terminal multiplexer
- [x] Ripgrep    # (rg -h)
- [x] Fd         # find replacement
- [x] fzf        # fuzzy file finder
- [x] Bat        # cat with wings
- [x] Eza        # ls replacement
- [x] Zoxide     # cd replacement
- [x] Xh         # http requests
- [x] Gitui      # git tui
- [x] du-dust    # disk usage
- [x] dua        # disk usage also
- [x] yazi       # terminal file navigator
- [x] atuin      # shell history
- [x] starship   # terminal prompt
- [x] neofetch   # fetch system info
- [x] htop-vim   # system process tui

### Editors

- [x] neovim     # a modern text editor
- [x] helix      # a post-modern text editor (set as default)

### Applications

- [x] 1password
- [x] spotify

## To Review

- [ ] dash         # alternative to bash, for minimal posix compliant login shell

### Termnial Tools

- [ ] trash-cli    # rm replacement
- [ ] tree
- [ ] hyperfine
- [ ] bacon
- [ ] cargo-info
- [ ] fselect
- [ ] ncspot
- [ ] rusty-man
- [ ] delta
- [ ] ripgrep-all
- [ ] tokei
- [ ] wiki-tui
- [ ] just
- [ ] mask
- [ ] mprocs
- [ ] presenterm
- [ ] kondo
- [ ] bob-nvim
- [ ] rtx
- [ ] espanso
- [ ] jq         # A lightweight and flexible command-line JSON processor
- [ ] yq-go      # yaml processor https://github.com/mikefarah/yq

### archives

- [ ] zip
- [ ] xz
- [ ] unzip
- [ ] p7zip

### networking tools

- [ ] mtr        # A network diagnostic tool
- [ ] iperf3
- [ ] dnsutils   # `dig` + `nslookup`
- [ ] ldns       # replacement of `dig`, it provide the command `drill`
- [ ] aria2      # A lightweight multi-protocol & multi-source command-line download utility
- [ ] socat      # replacement of openbsd-netcat
- [ ] nmap       # A utility for network discovery and security auditing
- [ ] ipcalc     # it is a calculator for the IPv4/v6 addresses

### misc

- [ ] cowsay
- [ ] file
- [ ] which
- [ ] gnused
- [ ] gnutar
- [ ] gawk
- [ ] zstd
- [ ] gnupg
- [ ] btop       # replacement of htop/nmon
- [ ] iotop      # io monitoring
- [ ] iftop      # network monitoring

### system call monitoring

- [ ] strace     # system call monitoring
- [ ] ltrace     # library call monitoring
- [ ] lsof       # list open files

### system tools

- [ ] sysstat
- [ ] lm_sensors # for `sensors` command
- [ ] ethtool
- [ ] pciutils   # lspci
- [ ] usbutils   # lsusb
