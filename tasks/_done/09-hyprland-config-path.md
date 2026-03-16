# Fix Hyprland config path to avoid impure reference

## Priority: Low

## Why

`hyprland.nix` uses `builtins.readFile /home/john/dotfiles/hypr/hyprland.conf` — an impure absolute path. This is why the build needs `--impure`. Using a symlink pattern (like Claude settings) or a relative path would be cleaner.

## What

- Option A: Use `config.lib.file.mkOutOfStoreSymlink` to symlink the config (consistent with the Claude settings pattern, allows live editing without rebuild)
- Option B: Use a relative path with `builtins.readFile` to at least remove the impurity
- Update CLAUDE.md if the `--impure` flag is no longer needed

## Files

- `nixos/home/hyprland.nix`
- `hypr/hyprland.conf`
