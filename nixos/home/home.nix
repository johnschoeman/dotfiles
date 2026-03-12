{ config, pkgs, ... }:
{
  home.username = "john";
  home.homeDirectory = "/home/john";
  home.stateVersion = "25.05";

  imports = [
    /home/john/dotfiles/nixos/home/alacritty.nix
    /home/john/dotfiles/nixos/home/atuin.nix
    /home/john/dotfiles/nixos/home/bash.nix
    /home/john/dotfiles/nixos/home/battery-notify.nix
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
    nixfmt-rfc-style   # nix formatter
    nil                # nix LSP
    nixd               # nix LSP (advanced)
    direnv             # auto env loading

    # fonts
    pkgs.nerd-fonts.jetbrains-mono # monospace font

    # programs
    devenv             # dev environments
    git                # version control

    # applications
    spotify            # music streaming
    obsidian           # note-taking
    discord            # chat app
    zoom-us            # video calls
    google-chrome      # web browser
    claude-code        # AI coding CLI

    # python
    python315          # Python runtime

    # web dev tools
    nodejs_24          # JS runtime
    pnpm               # package manager
    typescript-language-server # TS LSP
    vscode-langservers-extracted # HTML/CSS/JSON LSPs
    superhtml          # HTML LSP
    tailwindcss_4      # CSS framework
    zola               # static site generator

    # rust dev tools
    rustup             # Rust toolchain
    cargo-watch        # auto-rebuild
    cargo-generate     # project templates
    cargo-shuttle      # cloud deploy
    trunk              # WASM bundler
    leptosfmt          # Leptos formatter
    lldb               # debugger

    # language servers / editor tools
    fish-lsp           # Fish LSP

    # utilities
    bat                # syntax-highlighted cat
    fzf                # fuzzy finder
    fd                 # file finder
    ripgrep            # fast grep
    eza                # modern ls
    xh                 # HTTP client
    zoxide             # smart cd
    gitui              # git TUI
    dust               # disk usage tree
    dua                # disk usage interactive
    fastfetch          # system info
    starship           # shell prompt
    btop               # system monitor
    htop               # process viewer
    yazi               # file manager
    poppler-utils      # pdf reading
  ];
}
