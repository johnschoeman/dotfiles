{ config, pkgs, ...}:
{
  home.username = "john";
  home.homeDirectory = "/home/john";
  home.stateVersion = "25.05";

  imports = [
    /home/john/dotfiles/nixos/home/alacritty.nix
    /home/john/dotfiles/nixos/home/atuin.nix
    /home/john/dotfiles/nixos/home/bash.nix
    /home/john/dotfiles/nixos/home/fish.nix
    /home/john/dotfiles/nixos/home/hyprland.nix
    /home/john/dotfiles/nixos/home/neovim.nix
    /home/john/dotfiles/nixos/home/nh.nix
    /home/john/dotfiles/nixos/home/waybar.nix
    /home/john/dotfiles/nixos/home/yazi.nix
    /home/john/dotfiles/nixos/home/zellij.nix
  ];


  home.packages = with pkgs; [
    # nix
    nixfmt-rfc-style

    # fonts
    pkgs.nerd-fonts.jetbrains-mono

    # programs
    git
    spotify

    # utilities
    libgccjit
    bat
    fzf
    fd
    ripgrep
    eza
    xh
    zoxide
    gitui
    dust
    dua
    fastfetch
    starship
    btop
    htop-vim
  ];
}
