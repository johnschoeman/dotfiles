# NixOS Dotfiles

## NixOS Setup

0. Install fresh NixOS

1. Connect to Wifi

nmcli device wifi list

nmcli device wifi connect <SSID> password <password>

2. SSH for github

```
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

Add the SSH public key to your account on GitHub .

3. Clone dotfiles

```
nix-shell -p git
git clone git@github.com:johnschoeman/dotfiles.git
```

4. Build Initial NixOS

```
sudo nixos-rebuild swith --impure --flake /home/john/dotfiles/nixos#nixos
```

5. Validate

```
ninfo
```
