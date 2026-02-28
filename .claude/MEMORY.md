# Memory

## Waybar Claude Code Monitor

- **State detection**: JSONL transcripts in `~/.claude/projects/<encoded-path>/` contain `assistant` and `user` events with timestamps
- **Path encoding**: Claude encodes project paths by replacing `/` with `-` (e.g., `/home/john/dotfiles` -> `-home-john-dotfiles`)
- **Attention detection**: hybrid approach — notification hook touches a marker file instantly, waybar script validates against JSONL and cleans up
- **No PID -> session ID mapping**: checked `/proc/<pid>/fd`, cmdline, and environ — Claude opens JSONL transiently (no persistent fd), no session ID in args or env. Multiple sessions in same project share one JSONL lookup.
- **JSONL event types**: `assistant`, `user`, `progress`, `system`, `file-history-snapshot`. Each has a `timestamp` field.
- **Pango markup**: waybar CSS can't style individual characters within a module — use inline `<span color="...">` in the text output. Requires `format = "{}";` in module config.
- **Catppuccin Frappe colors for Pango**: blue=#8caaee, peach=#ef9f76, green=#a6d189

## Waybar General

- GTK CSS (waybar) doesn't support `@keyframes` — no pulse animations
- Custom module with `return-type = "json"` outputs `{"text", "tooltip", "class"}`
- `class: "empty"` with zero padding/margin hides the module

## Zellij

- Zellij intercepts keybindings before they reach terminal apps — remap conflicts on Zellij side, not the app side
- Mode switches remapped from Ctrl to Alt to avoid conflicts with Claude Code keybindings

## NixOS / Nix

- Custom Rust packages: use `rustPlatform.buildRustPackage` + `fetchFromGitHub`
- When upstream has no `Cargo.lock`: store one locally, use `cargoLock.lockFile`
- Scope builds to specific crate with `cargoBuildFlags = ["-p" "crate-name"]`
- **Mutable symlinks**: `config.lib.file.mkOutOfStoreSymlink` creates a direct symlink to a repo path — file stays mutable. Use for configs that apps write to (e.g., Claude Code `settings.json`). Regular `home.file.source` copies to the nix store (read-only).
- **Directory convention**: `claude/` holds repo-managed global settings (symlinked to `~/.claude/`). `.claude/` holds project-level settings (session log, memory, local config).
- **Package split**: `configuration.nix` = system-level (C toolchain, desktop env, system utils). `home.nix` = user-level (dev tools, LSPs, apps, languages).
- **clippy conflict**: don't install standalone `clippy` alongside `rustup` — both provide `cargo-clippy`. Use `rustup component add clippy` instead.
