{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rofi
    waybar
    xdg-utils
    hyprcursor
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile /home/john/dotfiles/hypr/hyprland.conf;
  };

  programs.kitty.enable = true;
  wayland.windowManager.hyprland.systemd.enable = false;

  # programs.waybar.enable = true;
  # programs.nm-applet.enable = true;

  # Wayland session environment
  home.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    GDK_BACKEND = "wayland";
  };
}
