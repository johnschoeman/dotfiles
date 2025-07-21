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

  imports = [
    /home/john/dotfiles/nixos/home/alacritty.nix
    /home/john/dotfiles/nixos/home/bash.nix
    /home/john/dotfiles/nixos/home/neovim.nix
    /home/john/dotfiles/nixos/home/nh.nix
    /home/john/dotfiles/nixos/home/yazi.nix
  ];

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

  home.packages = with pkgs; [
    # fonts
    pkgs.nerd-fonts.jetbrains-mono

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
