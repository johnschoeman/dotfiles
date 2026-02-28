{ config, pkgs, ...}:
{
  home.username = "john";
  home.homeDirectory = "/home/john";
  home.stateVersion = "25.05";

  imports = [
    /home/john/dotfiles/nixos/home/alacritty.nix
    /home/john/dotfiles/nixos/home/atuin.nix
    /home/john/dotfiles/nixos/home/bash.nix
    /home/john/dotfiles/nixos/home/ccboard.nix
    /home/john/dotfiles/nixos/home/claude.nix
    /home/john/dotfiles/nixos/home/fish.nix
    /home/john/dotfiles/nixos/home/helix.nix
    /home/john/dotfiles/nixos/home/hyprland.nix
    /home/john/dotfiles/nixos/home/nh.nix
    /home/john/dotfiles/nixos/home/waybar.nix
    # /home/john/dotfiles/nixos/home/yazi.nix
    /home/john/dotfiles/nixos/home/zellij.nix
  ];

  home.sessionVariables = {
    EDITOR = "hx";
  };

  home.packages = with pkgs; [
    # nix
    nixfmt-rfc-style
    nil
    nixd
    direnv

    # fonts
    pkgs.nerd-fonts.jetbrains-mono

    # programs
    devenv
    git
    spotify

    # applications
    obsidian
    discord
    zoom-us
    anki
    google-chrome
    claude-code

    # python
    python315

    # web dev tools
    nodejs_24
    pnpm
    typescript-language-server
    vscode-langservers-extracted
    superhtml
    tailwindcss_4
    zola

    # rust dev tools
    rustup
    cargo-watch
    cargo-generate
    cargo-shuttle
    trunk
    leptosfmt
    lldb

    # language servers / editor tools
    fish-lsp

    # utilities
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
    htop
    yazi
  ];
}
