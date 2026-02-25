{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rofi
    waybar
    xdg-utils
    hyprcursor

    # screenshot
    hyprshot
    grim
    slurp
    jq
    libnotify
  ];

  # notification daemon (required for notify-send / Claude Code hooks)
  # Catppuccin Frappe colors
  services.mako = {
    enable = true;
    settings = {
      background-color = "#303446";
      text-color = "#c6d0f5";
      border-color = "#8caaee";
      width = 400;
      border-radius = 8;
      border-size = 2;
      default-timeout = 5000;

      "urgency=critical" = {
        border-color = "#e78284";
        default-timeout = 10000;
      };
    };
  };

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

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 300;
        hide_cursor = true;
        no_fade_in = false;
      };
      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];
      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(202, 211, 245)";
          inner_color = "rgb(91, 96, 120)";
          outer_color = "rgb(24, 25, 38)";
          outline_thickness = 5;
          placeholder_text = "password...";
          shadow_passes = 2;
        }
      ];
    };
  };

  # services.hypridle = {
  #   enable = true;
  #   settings = {
  #     general = {
  #       after_sleep_cmd = "hyprctl dispatch dpms on";
  #       ignore_dbus_inhibit = false;
  #       lock_cmd = "hyprlock";
  #     };
  #     listener = [
  #       {
  #         timeout = 900;
  #         on-timeout = "hyprlock";
  #       }
  #       {
  #         timeout = 1200;
  #         on-timeout = "hyprctl dispatch dpms off";
  #         on-resume = "hyprctl dispatch dpms on";
  #       }
  #     ];
  #   };
  # };

}
