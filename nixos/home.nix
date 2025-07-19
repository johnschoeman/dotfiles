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
      hello = "echo 'hello from home.nix 5'";
      nrsetc = "sudo nixos-rebuild switch --impure --flake /etc/nixos#nixos";
      nrs = "sudo nixos-rebuild switch --impure --flake /home/john/dotfiles/nixos#nixos";
      nixclean = "sudo nix-collect-garbage --delete-older-than 15d";
      ls = "eza -la";
      cat = "bat";
      cd = "z";
    };
    initExtra = ''
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
  ];
}
