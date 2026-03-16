# Move gitconfig into home-manager

## Priority: Low

## Why

Eliminates the manual symlink step. Git config expressed declaratively in Nix is more consistent with the rest of the setup. Already listed as a TODO in `nixos/notes.md`.

## What

- Create `nixos/home/git.nix` using `programs.git` home-manager module
- Migrate all settings from `gitconfig`: user, aliases, merge strategy, rebase, fetch, diff, colors
- Migrate commit template from `gitmessage`
- Preserve `include.path = ~/.gitconfig.local` for local overrides
- Add import to `home.nix`
- Keep old `gitconfig` and `gitmessage` until confirmed working, then remove

## Files

- New: `nixos/home/git.nix`
- `nixos/home/home.nix` (add import)
- `gitconfig` (remove after migration)
- `gitmessage` (remove after migration)
