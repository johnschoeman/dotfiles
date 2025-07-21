{ config, pkgs, ...}:

{
  home.username = "john";
  home.homeDirectory = "/home/john";
  home.stateVersion = "25.05";

  # gnome settings
  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      xkb-options = [ "ctrl:nocaps" ];
    };
  };

  # imports = [
  #   ./bash.nix
  # ];

  # # hyprland
  # programs.kitty.enable = true;
  # wayland.windowManager.hyprland.enable = true; 

  # wayland.windowManager.hyprland.settings = {
  #   "$mod" = "SUPER";
  #   bind =
  #     [
  #       "$mod, F, exec, firefox"
  #       ", Print, exec, grimblast copy area"
  #     ]
  #     ++ (
  #       # workspaces
  #       # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
  #       builtins.concatLists (builtins.genList (i:
  #           let ws = i + 1;
  #           in [
  #             "$mod, code:1${toString i}, workspace, ${toString ws}"
  #             "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
  #           ]
  #         )
  #         9)
  #     );
  # };

  programs.bash = {
    enable = true;
    shellAliases = {
      # NixOS
      ninfo = "nh os info";
      nrs = "nh os switch /home/john/dotfiles/nixos -- --impure";
      nclean = "nh clean all --keep-since 14d";
      # Utilities
      ls = "eza -la";
      cat = "bat";
      cd = "z";
    };
    initExtra = ''
      EDITOR=nvim
      eval "$(starship init bash)"
      eval "$(zoxide init bash)"
    '';
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.9;
    };
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/john/dotfiles/nixos"; # sets NH_OS_FLAKE
  };

  programs.yazi = {
    enable = true;
  };

  # nvim config
  xdg.configFile.nvim.source = /home/john/dotfiles/vim;

  home.packages = with pkgs; [
    # fonts
    pkgs.nerd-fonts.jetbrains-mono

    # programs
    neovim
    alacritty
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
    yazi
  ];
}
