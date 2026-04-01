{ config, pkgs, ... }:
{
  home.username = "john";
  home.homeDirectory = "/home/john";
  home.stateVersion = "25.05";

  home.activation.themeDefaults =
    config.lib.dag.entryAfter [ "linkGeneration" ] ''
      dotfiles="/home/john/dotfiles"
      name=$(cat "$HOME/.config/alacritty/current-theme-name" 2>/dev/null || echo "catppuccin_frappe")
      kebab="''${name//_/-}"

      [ ! -e "$dotfiles/waybar/colors.css" ] && \
        ln -sf "themes/$kebab.css" "$dotfiles/waybar/colors.css"
      [ ! -e "$dotfiles/rofi/colors.rasi" ] && \
        ln -sf "themes/$kebab.rasi" "$dotfiles/rofi/colors.rasi"
      [ ! -e "$dotfiles/hyprlock/colors.conf" ] && \
        ln -sf "themes/$kebab.conf" "$dotfiles/hyprlock/colors.conf"
      [ ! -e "$dotfiles/mako/config" ] && \
        cat "$dotfiles/mako/base.conf" "$dotfiles/mako/themes/$kebab.conf" > "$dotfiles/mako/config"
    '';

  imports = [
    /home/john/dotfiles/nixos/home/alacritty.nix
    /home/john/dotfiles/nixos/home/atuin.nix
    /home/john/dotfiles/nixos/home/bash.nix
    /home/john/dotfiles/nixos/home/battery-notify.nix
    /home/john/dotfiles/nixos/home/ccboard.nix
    /home/john/dotfiles/nixos/home/claude.nix
    /home/john/dotfiles/nixos/home/fish.nix
    /home/john/dotfiles/nixos/home/git.nix
    /home/john/dotfiles/nixos/home/helix.nix
    /home/john/dotfiles/nixos/home/hyprland.nix
    /home/john/dotfiles/nixos/home/nh.nix
    /home/john/dotfiles/nixos/home/rofi.nix
    /home/john/dotfiles/nixos/home/waybar.nix
    /home/john/dotfiles/nixos/home/yazi.nix
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
    marp-cli           # slide decks

    # applications
    spotify            # music streaming
    obsidian           # note-taking
    discord            # chat app
    zoom-us            # video calls
    teams-for-linux    # Microsoft Teams
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

    # rust
    rustup             # Rust toolchain

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
    poppler-utils      # pdf reading
    pandoc             # doc reading
  ];
}
