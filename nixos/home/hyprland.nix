{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    waybar
    xdg-utils
    hyprcursor
    bibata-cursors

    # screenshot
    hyprshot
    grim
    slurp
    jq
    libnotify
  ];

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 12;
    gtk.enable = true;
    hyprcursor.enable = true;
  };

  # notification daemon (required for notify-send / Claude Code hooks)
  # colors managed by scripts/theme-select.sh
  services.mako.enable = true;

  xdg.configFile."mako/config".source =
    config.lib.file.mkOutOfStoreSymlink "/home/john/dotfiles/mako/config";

  wayland.windowManager.hyprland.enable = true;
  xdg.configFile."hypr/hyprland.conf".source =
    config.lib.file.mkOutOfStoreSymlink "/home/john/dotfiles/hypr/hyprland.conf";

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

  # lock screen colors managed by scripts/theme-select.sh
  programs.hyprlock.enable = true;

  xdg.configFile."hypr/hyprlock.conf".source =
    config.lib.file.mkOutOfStoreSymlink "/home/john/dotfiles/hyprlock/hyprlock.conf";

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };
      listener = [
        {
          timeout = 600;
          on-timeout = "hyprlock";
        }
        {
          timeout = 900;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

}
