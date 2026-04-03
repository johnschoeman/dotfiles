# Knowledge

Stable knowledge for this repository. Read at session start. Organized by topic, not chronologically.

---

## Decisions

**Directory convention**
`claude/` holds repo-managed global settings (symlinked to `~/.claude/`). `.claude/` holds project-level settings (session history, knowledge, local config).

**Session log format**
Daily files in `.claude/session-history/YYYY-MM-DD.md` instead of a single `SESSION_LOG.md`. Multiple entries per day are appended. Date is in the filename so entries use `## [title]` without date prefix. Old `SESSION_LOG.md` was deleted during documentation cleanup (2026-03-17); canonical history lives in `.claude/session-history/`.

**Scripts on PATH**
`~/dotfiles/scripts/` is on Fish PATH (via `fish_add_path` in `fish.nix`). Scripts there are available as bare commands — reference them by name in skills and docs, not by absolute path.

**Global skill pattern**
Global skills in `claude/skills/` define the process; repo-specific `.claude/docs/` files provide configuration. Skills validate their context file at startup and bail with guidance if missing or incomplete. Pattern used by: `planning` (reads `planning.md`), `content-capture` (reads `content-capture.md`), `content-synthesize` (reads `content-synthesis.md`), `wrap-day` (reads `close-day.md`). Variants: `git-analysis` uses a global script with CLI flags. `setup-claude` is standalone — creates CLAUDE.md + `.claude/` infrastructure, or audits existing setup. `commit` defaults to suggest-only, `--run` flag commits (checks CLAUDE.md for git rules first). `wrap-session` chains `/update-session-log` → `/update-knowledge` → `/commit`.

**Project-local skill overrides**
`.claude/skills/<name>/SKILL.md` in a project repo overrides the global skill of the same name. Used for project-specific commit conventions, task thresholds, session logging, etc. The `add-project-skill` catalog scaffolds these from templates.

**Skill catalog pattern (`add-project-skill`)**
`claude/skills/add-project-skill/catalog/` holds templates for scaffolding project-local skill overrides. Each catalog entry is a directory: `README.md` (description, detection hints, customization questions) + `.template` files (with `{{placeholder}}` markers). No registry — skill discovers templates by scanning `catalog/*/README.md`. Generated skills include `<!-- catalog: <name> v1 -->` for audit version tracking. `--audit` flag compares existing project skills against catalog.

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

**npm/JFrog auth approach**
`~/.npmrc` managed via `home.file` in `npm.nix`, not `programs.npm.settings` — scoped registry auth keys (`//host/path/:_authToken`) have slashes and colons that don't work as Nix attribute names, and `programs.npm.enable` would conflict with existing `nodejs_24` in home.packages. Auth token loaded at runtime via `${JFROG_NPM_TOKEN}` env var (npm interpolates env vars in `.npmrc`). Token sourced from 1Password CLI (`op read`) via `jfrog-login` fish function — no sops-nix needed since 1Password is already configured.

**Rust tooling strategy**
Only `rustup` is installed globally (for ad-hoc `rustc`/`cargo`). Project-specific tools (cargo-watch, cargo-generate, trunk, leptosfmt, etc.) belong in devenv templates, not `home.nix`.

**Theme approach**
`theme-select` is the single source of truth for runtime theming. Switches Alacritty, Zellij, Waybar, Helix, Rofi, Yazi, Mako, and Hyprlock at runtime — no rebuild needed. Catppuccin Frappe is the default. Super+T cycles themes, Super+Shift+T opens rofi picker. SDDM is themed separately (fixed Catppuccin Frappe via `catppuccin-sddm` nixpkg) since it runs before login. The `catppuccin/nix` module was removed — all theming is runtime via mutable dotfiles.

**macOS setup approach**
`mac/` uses an idempotent Homebrew + symlink setup script. `Brewfile` declares packages. Fish and Alacritty configs are macOS-adapted versions of the NixOS equivalents (pbcopy instead of wl-copy, `/opt/homebrew` paths). nix-darwin is a future exploration candidate for declarative macOS management.

**Dual-platform maintenance (NixOS + macOS)**
NixOS is the primary machine; macOS is actively used alongside it. Both platforms share the same tool stack (Fish, Alacritty, Zellij, Helix, Git) but configs diverge where platform differences require it (e.g., `option_as_alt` on macOS Alacritty, `pbcopy` vs `wl-copy` in Fish, `/opt/homebrew` paths). NixOS configs live in `nixos/` (declarative), macOS configs live in `mac/` (imperative Brew + symlinks). When changing shared tooling, consider whether both platforms need updating.

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
- Mutable symlinks: `config.lib.file.mkOutOfStoreSymlink` creates a direct symlink to a repo path — file stays mutable. Use for configs that apps write to (e.g., Claude Code `settings.json`) or configs you want to edit without rebuild (e.g., hyprland.conf). Regular `home.file.source` copies to the nix store (read-only). Requires `config` in the module's function args.
- clippy conflict: don't install standalone `clippy` alongside `rustup` — both provide `cargo-clippy`. Use `rustup component add clippy` instead.
- `rofi-wayland` has been merged into `rofi` in nixpkgs-unstable — just use `pkgs.rofi`
- catppuccin/nix was removed — all theming is now runtime via `theme-select` and mutable dotfiles

- Hyprlock reads config fresh on each launch — no reload mechanism needed, theme changes apply on next lock
- Mako doesn't support imports — uses concatenation (`cat base + theme > config`) instead of the symlink pattern used by waybar/rofi/hyprlock
- SDDM theming: `catppuccin-sddm` package with `.override { flavor; accent; font; }`, needs `qtsvg` in `extraPackages` and system-level font package (SDDM can't see home-manager fonts)
- `home.pointerCursor` sets `XCURSOR_SIZE` and `HYPRCURSOR_SIZE` env vars automatically — don't set them manually in hyprland.conf. Requires logout/login to take effect.
- home-manager backup collisions (e.g., `config.kdl.backup` already exists): add `force = true` to the `xdg.configFile` declaration to overwrite in place instead of backing up

**macOS / Homebrew**
- `brew bundle --file=Brewfile` is idempotent — safe to re-run, only installs missing items
- Root `gitconfig` in repo is the macOS git config (symlinked by setup script); NixOS uses declarative `git.nix` instead


**Alacritty**
- Live-reloads on config file change — no restart needed for theme/color updates
- home-manager `programs.alacritty.settings` maps directly to TOML; no built-in `theme` option
