# Remove --impure flag from NixOS builds

## Priority: Low

## Why

The `--impure` flag is required because absolute paths like `/home/john/dotfiles/...` are used throughout the config for imports, `builtins.readFile`, `pkgs.callPackage`, and file sources. Removing these would make builds pure and more portable.

## What

Convert all impure absolute path references to relative or flake-based alternatives:

- **home.nix imports** (~15 files) — use relative paths from flake root
- **flake.nix** — `home.nix` import uses absolute path
- **waybar.nix** — `builtins.readFile /home/john/dotfiles/waybar/style.css`
- **zellij.nix** — `.source = /home/john/dotfiles/zellij/config.kdl`
- **ccboard.nix** — `pkgs.callPackage /home/john/dotfiles/nixos/pkgs/ccboard.nix`
- **git.nix** — `home.file.".gitmessage".source = /home/john/dotfiles/gitmessage`
- **battery-notify.nix** — absolute path to script in ExecStart

Keep `mkOutOfStoreSymlink` paths as-is (they need absolute strings by design).

After migration, update the `nrs` alias in fish.nix and bash.nix to drop `-- --impure`.

## Files

- `nixos/flake.nix`
- `nixos/home/home.nix`
- `nixos/home/waybar.nix`
- `nixos/home/zellij.nix`
- `nixos/home/ccboard.nix`
- `nixos/home/git.nix`
- `nixos/home/battery-notify.nix`
- `nixos/home/fish.nix`
- `nixos/home/bash.nix`
