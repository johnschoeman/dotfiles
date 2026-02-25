# Session Log

## 2026-02-25

**Goal:** Package ccboard declaratively in NixOS

**What happened:**
- Created custom Rust derivation at `nixos/pkgs/ccboard.nix` using `rustPlatform.buildRustPackage` + `fetchFromGitHub`, pinned to v0.10.0
- Generated and stored `nixos/pkgs/ccboard-Cargo.lock` (upstream repo doesn't commit one)
- Created home-manager module at `nixos/home/ccboard.nix`
- Added import to `nixos/home/home.nix`
- Removed fish alias `ccboard "~/.cargo/bin/ccboard"` from `nixos/home/fish.nix` — binary is now on `$PATH` via Nix

**Decisions:**
- Repo is `FlorianBruniaux/ccboard` (not `DepthBeyond` as initially assumed)
- Used `cargoLock.lockFile` instead of `cargoHash` because upstream has no `Cargo.lock`; the lock file is stored locally alongside the derivation
- Build scoped to binary crate only via `cargoBuildFlags = ["-p" "ccboard"]` — avoids building WASM/web targets
- All 18 upstream tests pass during build

## 2026-02-18

**Goal:** Set up Claude Code guidance and configure ollama

**What happened:**
- Added standard Claude Code header to CLAUDE.md
- Added Git Workflow section (user manages commits, Claude reminds/suggests)
- Added Session Log instructions and created this file
- Created .claude/settings.local.json with git permissions (read-only allowed, writes denied)
- Enabled ollama service in configuration.nix (replaces package-only approach)

**Decisions:**
- Following same patterns as evolv-notes for git workflow and session logging
- Commit messages written to `temp_commit_message.txt` for user to review
- Git permissions enforced via settings.local.json, not just documentation
- Use `services.ollama.enable` instead of just the package for auto-start
