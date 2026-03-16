# Move Rust project tools to devenv

## Priority: Medium

## Why

Since you're using devenv for project-specific toolchains, most Rust packages don't need to be globally installed. Keeps the base system lean.

## What

- Remove from `nixos/home/home.nix` (lines 63-69):
  - `cargo-watch`
  - `cargo-generate`
  - `cargo-shuttle`
  - `trunk`
  - `leptosfmt`
  - `lldb`
- Keep `rustup` globally if you want `rustc`/`cargo` available outside devenv shells, or remove it too if every Rust project uses devenv
- Verify your Rust devenv templates include these tools before removing

## Files

- `nixos/home/home.nix`
