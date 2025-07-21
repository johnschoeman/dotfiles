{ pkgs, ... }:
{
  home.packages = [
    pkgs.nh
  ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/john/dotfiles/nixos"; # sets NH_OS_FLAKE
  };
}
