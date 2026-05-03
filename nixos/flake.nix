{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    claude-code = {
      url = "github:sadjow/claude-code-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    claude-desktop.url = "github:k3d3/claude-desktop-linux-flake";
  };

  outputs =
    {
      nixpkgs,
      hyprland,
      home-manager,
      claude-code,
      claude-desktop,
      ...
    }:
    {
      nixosConfigurations.framework = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = {
              claude-code-pkg = claude-code.packages.x86_64-linux.claude-code;
              claude-desktop-pkg = claude-desktop.packages.x86_64-linux.claude-desktop-with-fhs;
            };
            home-manager.users.john = {
              imports = [
                /home/john/dotfiles/nixos/home/home.nix
              ];
            };
          }
          hyprland.nixosModules.default
          {
            programs.hyprland.enable = true;
            programs.hyprland.withUWSM = true;
            programs.uwsm.enable = true;
          }
        ];
      };
    };
}
