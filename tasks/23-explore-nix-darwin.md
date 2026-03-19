# Task 23: Explore nix-darwin + home-manager

## Status: Future

Evaluate whether to migrate the Homebrew-based macOS setup to nix-darwin + home-manager.

## Questions to Answer

1. How much config from `nixos/home/` can be shared directly with a darwin flake?
2. What are the macOS-specific pain points with Nix (e.g., brew cask apps, system preferences)?
3. Is the added complexity worth it for a secondary machine?

## Pros

- Declarative, reproducible — same model as NixOS
- Single language (Nix) for both machines
- Home-manager modules (fish, helix, git, zellij) could be shared directly
- Rollback support

## Cons

- nix-darwin is less mature than NixOS — more rough edges
- GUI app management still needs Homebrew casks (nix-darwin delegates to `homebrew-bundle`)
- Nix store on macOS uses more disk and can conflict with system updates
- Slower iteration cycle vs. `brew install`
- Extra complexity for a machine that gets set up rarely

## Approach

1. Use the Homebrew setup for a while — identify actual pain points
2. If config drift between NixOS and macOS becomes a real problem, revisit
3. If exploring: start with a minimal `darwin-configuration.nix` that uses home-manager for shared modules (fish, helix, git, zellij) while keeping Homebrew for casks

## Decision

Deferred — use Homebrew setup first and evaluate after real-world use.
