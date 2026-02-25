# Session Log

## 2026-02-25 (3)

**Goal:** Deconflict Zellij and Claude Code keybindings

**What happened:**
- Remapped all 9 Zellij mode-switching keybindings from `Ctrl` to `Alt` in `zellij/config.kdl`
- Three modes needed different letters because their `Alt+<same letter>` was already taken: resize (`Alt+r`), session (`Alt+a`), move (`Alt+m`)
- 16 total edits: toggle-off bindings inside each mode, activator bindings in `shared_except` blocks, and quit/locked in the shared block

**Decisions:**
- Fix applied on Zellij side since it intercepts keys before they reach terminal apps — remapping Claude Code wouldn't help
- Preserved all non-mode-switch `Ctrl` bindings: `Ctrl+b/f` (vim page scroll), `Ctrl+c` (cancel), `Ctrl+b` in tmux (raw byte)
- Letter choices for conflicts: `n→r` (resize), `o→a` (session/about), `h→m` (move) — mnemonics match the mode name

## 2026-02-25 (2)

**Goal:** Add waybar Claude Code session monitor

**What happened:**
- Created `scripts/claude-waybar.sh` — polling script that detects sessions via `pgrep`, determines idle/processing via CPU usage, reads attention state from marker file
- Extended `scripts/claude-notify.sh` to write/clear PID-based attention markers in `$XDG_RUNTIME_DIR/claude-waybar-attention` alongside existing notifications
- Added `custom/claude` module to `nixos/home/waybar.nix` (3s interval, JSON return type)
- Added Catppuccin Frappe-themed CSS to `waybar/style.css`: idle (overlay1), processing (lavender), attention (peach)
- Symlinked script to `~/.local/bin/claude-waybar.sh`

**Decisions:**
- Session detection via `pgrep -x claude` + `/proc/<pid>/cwd` for project names
- CPU threshold >= 2% for "processing" vs "idle" distinction
- Attention state tracked via hook writing PIDs to a runtime file; cleared on any non-permission notification
- GTK CSS (waybar) doesn't support `@keyframes` — dropped pulse animation, using static color for attention state
- Module hides itself (empty class, zero padding/margin) when no sessions are active

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
