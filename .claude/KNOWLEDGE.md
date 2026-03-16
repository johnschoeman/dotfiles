# Knowledge

Stable knowledge for this repository. Read at session start. Organized by topic, not chronologically.

---

## Decisions

**Directory convention**
`claude/` holds repo-managed global settings (symlinked to `~/.claude/`). `.claude/` holds project-level settings (session history, knowledge, local config).

**Session log format**
Daily files in `.claude/session-history/YYYY-MM-DD.md` instead of a single `SESSION_LOG.md`. Multiple entries per day are appended. Date is in the filename so entries use `## [title]` without date prefix. Old `SESSION_LOG.md` files left in place as history.

**Scripts on PATH**
`~/dotfiles/scripts/` is on Fish PATH (via `fish_add_path` in `fish.nix`). Scripts there are available as bare commands — reference them by name in skills and docs, not by absolute path.

**Global skill pattern**
Global skills in `claude/skills/` define the process; repo-specific `.claude/docs/` files provide configuration. Skills validate their context file at startup and bail with guidance if missing or incomplete. Pattern used by: `planning-check` (reads `planning.md`), `capture-content` (reads `content-capture.md`), `synthesize-learning` (reads `content-synthesis.md`). Variants: `git-analysis` uses a global script with CLI flags for repo-specific customization instead of a context file. `project-init` is standalone (no context file) — one-time setup that creates CLAUDE.md, `.claude/` infrastructure, and optional `.claude/docs/` templates.

**Git Workflow section is verbatim**
The Git Workflow section in CLAUDE.md is identical across every project — user manages commits, `/update-session-log` + `git status` + `commit-msg.txt` + remind pattern, standard commit format (imperative title, "Why:" paragraph, "This commit:" bullets), never modify history. Enforced by `/project-init` which inserts it as a fixed block.

**Content note format**
YAML frontmatter (`source`, `type`, `date-captured`, `author`) for machine-readable metadata. `synthesize-learning` adds `date-processed` when done. Filename: `YYYY-MM-DD-[slug].md`. Processed notes move to `_processed/` subfolder within the content notes directory.

**Package split**
`configuration.nix` = system-level (C toolchain, desktop env, system utils). `home.nix` = user-level (dev tools, LSPs, apps, languages).

**Git config**
Managed declaratively via `programs.git` in `nixos/home/git.nix`. Commit template (`gitmessage`) delivered via `home.file`. Machine-specific overrides via `include.path = ~/.gitconfig.local`. No manual symlinks needed.

**Zellij mode switches**
Remapped from Ctrl to Alt to avoid conflicts with Claude Code keybindings.

**Idle management**
hypridle via home-manager `services.hypridle` in `hyprland.nix`. Lock at 600s, dpms off at 900s, no suspend. Replaces swayidle + `hypr/suspend.sh`. Starts as a systemd user service — no `exec-once` needed.

**Rust tooling strategy**
Only `rustup` is installed globally (for ad-hoc `rustc`/`cargo`). Project-specific tools (cargo-watch, cargo-generate, trunk, leptosfmt, etc.) belong in devenv templates, not `home.nix`.

**Theme approach**
Catppuccin Frappe is the base/default theme. `catppuccin/nix` flake is a flake input with global `catppuccin.enable = true` + `catppuccin.flavor = "frappe"` in home.nix. Per-app theming is automatic for supported programs. Theme cycling across multiple palettes is planned (task 11).

---

## Learnings

**Waybar Claude Code Monitor**
- State detection: JSONL transcripts in `~/.claude/projects/<encoded-path>/` contain `assistant` and `user` events with timestamps
- Path encoding: Claude encodes project paths by replacing `/` with `-` (e.g., `/home/john/dotfiles` -> `-home-john-dotfiles`)
- Attention detection: hybrid approach — notification hook touches a marker file instantly, waybar script validates against JSONL and cleans up
- No PID -> session ID mapping: checked `/proc/<pid>/fd`, cmdline, and environ — Claude opens JSONL transiently (no persistent fd), no session ID in args or env. Multiple sessions in same project share one JSONL lookup.
- JSONL event types: `assistant`, `user`, `progress`, `system`, `file-history-snapshot`. Each has a `timestamp` field.
- Pango markup: waybar CSS can't style individual characters within a module — use inline `<span color="...">` in the text output. Requires `format = "{}";` in module config.
- Catppuccin Frappe colors for Pango: blue=#8caaee, peach=#ef9f76, green=#a6d189

**Waybar General**
- GTK CSS (waybar) doesn't support `@keyframes` — no pulse animations
- Custom module with `return-type = "json"` outputs `{"text", "tooltip", "class"}`
- `class: "empty"` with zero padding/margin hides the module

**Zellij**
- Zellij intercepts keybindings before they reach terminal apps — remap conflicts on Zellij side, not the app side

**NixOS / Nix**
- `services.xserver.enable = true` is needed even on Wayland — XWayland depends on it for X11 apps (Discord, Chrome, Spotify)
- Custom Rust packages: use `rustPlatform.buildRustPackage` + `fetchFromGitHub`
- When upstream has no `Cargo.lock`: store one locally, use `cargoLock.lockFile`
- Scope builds to specific crate with `cargoBuildFlags = ["-p" "crate-name"]`
- Mutable symlinks: `config.lib.file.mkOutOfStoreSymlink` creates a direct symlink to a repo path — file stays mutable. Use for configs that apps write to (e.g., Claude Code `settings.json`). Regular `home.file.source` copies to the nix store (read-only).
- clippy conflict: don't install standalone `clippy` alongside `rustup` — both provide `cargo-clippy`. Use `rustup component add clippy` instead.
- `rofi-wayland` has been merged into `rofi` in nixpkgs-unstable — just use `pkgs.rofi`
- catppuccin/nix `catppuccin.enable = true` auto-sets theme options on supported programs (helix, rofi, etc.) — don't also set theme manually or you get conflicts

**Alacritty**
- Live-reloads on config file change — no restart needed for theme/color updates
- home-manager `programs.alacritty.settings` maps directly to TOML; no built-in `theme` option
