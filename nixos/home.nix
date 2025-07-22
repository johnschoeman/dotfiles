{ config, pkgs, ...}:
{
  home.username = "john";
  home.homeDirectory = "/home/john";
  home.stateVersion = "25.05";

  # # gnome settings
  # dconf.settings = {
  #   "org/gnome/desktop/input-sources" = {
  #     xkb-options = [ "ctrl:nocaps" ];
  #   };
  # };

  imports = [
    /home/john/dotfiles/nixos/home/alacritty.nix
    /home/john/dotfiles/nixos/home/bash.nix
    # /home/john/dotfiles/nixos/home/hyprland.nix
    /home/john/dotfiles/nixos/home/neovim.nix
    /home/john/dotfiles/nixos/home/nh.nix
    /home/john/dotfiles/nixos/home/yazi.nix
  ];


  home.packages = with pkgs; [
    # fonts
    pkgs.nerd-fonts.jetbrains-mono

    # window manager
    libinput     # inputs for hyprland
    libxkbcommon # keyboard descriptions, for wev
    wev          # wayland event viewer

    # programs
    git
    zellij

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
    neofetch
    starship
    htop-vim
  ];
}
