# Add Nix garbage collection and boot entry limit

## Priority: High

## Why

Without `nix.gc` settings, old generations accumulate and `/boot` fills up over time. Every rebuild adds a boot entry forever.

## What

- Add `nix.gc` to `nixos/configuration.nix`:
  ```nix
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  ```
- Add `boot.loader.systemd-boot.configurationLimit = 15;` to limit boot entries

## Files

- `nixos/configuration.nix`
