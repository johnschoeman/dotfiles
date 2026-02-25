{ pkgs, ... }:

let
  ccboard = pkgs.callPackage /home/john/dotfiles/nixos/pkgs/ccboard.nix { };
in
{
  home.packages = [
    ccboard
  ];
}
