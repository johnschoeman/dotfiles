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

# Set NIX_PATH

nixos by default loads config from `/etc/nixos/configuration.nix`

```
export NIX_PATH="nixos-config=~/dotfiles/nixos/configuration.nix"
nixos-rebuild switch
```
