{ host, config, pkgs, ... }:
# let
  # terminal = alacritty;
  # browser = firefox;
  # keyboardLayout = "us";
# in
{
  home.packages = with pkgs; [
    hyprland
    kitty
    waybar
    wofi
    xdg-utils
    networkmanagerapplet

    # swww   # wallpaper
    # grim   # screenshots
    # slurp  # screenshots
    # swappy # snapshot editing

    # ydotool        # command line editing
    # hyprpolkitagent
    # hyprland-qtutils # needed for banners and ANR messages
  ];


  wayland.windowManager.hyprland.enable = true; 

  programs.kitty.enable = true;
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM  = true;
  wayland.windowManager.hyprland.systemd.enable = false;

  wayland.windowManager.hyprland = {
    settings = {
      monitor = ",preferred,auto,1"; # auto-detect primary monitor
      exec-once = [ "waybar" "foot" ]; # auto-launch bar + terminal
      input = {
        kb_layout = "us";
      };
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        layout = "dwindle";
      };
      decoration = {
        rounding = 5;
      };
    };
  };

  programs.waybar.enable = true;
  programs.nm-applet.enable = true;

  # # Wayland session environment
  # home.sessionVariables = {
  #   XDG_SESSION_TYPE = "wayland";
  #   XDG_CURRENT_DESKTOP = "Hyprland";
  #   QT_QPA_PLATFORM = "wayland";
  #   SDL_VIDEODRIVER = "wayland";
  #   GDK_BACKEND = "wayland";
  # };

  wayland.windowManager.hyprland = {
    settings = {
      env = [
        "NIXOS_OZONE_WL, 1"
        "NIXPKGS_ALLOW_UNFREE, 1"
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"
        "GDK_BACKEND, wayland, x11"
        "CLUTTER_BACKEND, wayland"
        "QT_QPA_PLATFORM=wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
        "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
        "SDL_VIDEODRIVER, x11"
        "MOZ_ENABLE_WAYLAND, 1"
        # This is to make electron apps start in wayland
        "ELECTRON_OZONE_PLATFORM_HINT,wayland"
        # Disabling this by default as it can result in inop cfg
        # Added card2 in case this gets enabled. For better coverage
        # This is mostly needed by Hybrid laptops.
        # but if you have multiple discrete GPUs this will set order
        #"AQ_DRM_DEVICES,/dev/dri/card0:/dev/dri/card1:/dev/card2"
        "GDK_SCALE,1"
        "QT_SCALE_FACTOR,1"
        "EDITOR,nvim"
        # Set terminal and xdg_terminal_emulator to kitty
        # To provent yazi from starting xterm when run from rofi menu
        # You can set to your preferred terminal if you you like
        # ToDo: Pull default terminal from config
        "TERMINAL,kitty"
        "XDG_TERMINAL_EMULATOR,kitty"
      ];
    };
  };

  systemd.user.targets.hyprland-session.Unit.Wants = [
    "xdg-desktop-autostart.target"
  ];

  # # Place Files Inside Home Directory
  # home.file = {
  #   "Pictures/Wallpapers" = {
  #     source = ../../../wallpapers;
  #     recursive = true;
  #   };
  #   ".face.icon".source = ./face.jpg;
  #   ".config/face.jpg".source = ./face.jpg;
  # };

  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   package = pkgs.hyprland;
  #   systemd = {
  #     enable = true;
  #     enableXdgAutostart = true;
  #     variables = ["--all"];
  #   };
  #   xwayland = {
  #     enable = true;
  #   };
  #   settings = {
  #     exec-once = [
  #       "wl-paste --type text --watch cliphist store # Stores only text data"
  #       "wl-paste --type image --watch cliphist store # Stores only image data"
  #       "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
  #       "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
  #       "systemctl --user start hyprpolkitagent"
  #       # "killall -q swww;sleep .5 && swww init"
  #       # "killall -q waybar;sleep .5 && waybar"
  #       # "killall -q swaync;sleep .5 && swaync"
  #       # "nm-applet --indicator"
  #       # "pypr &"
  #       # "sleep 1.5 && swww img ${stylixImage}"
  #     ];
  #     input = {
  #       kb_layout = "${keyboardLayout}";
  #       kb_options = [
  #         "grp:alt_caps_toggle"
  #         "caps:super"
  #       ];
  #       numlock_by_default = true;
  #       repeat_delay = 300;
  #       follow_mouse = 1;
  #       float_switch_override_focus = 0;
  #       sensitivity = 0;
  #       touchpad = {
  #         natural_scroll = true;
  #         disable_while_typing = true;
  #         scroll_factor = 0.8;
  #       };
  #     };
  #     # gestures = {
  #     #   workspace_swipe = 1;
  #     #   workspace_swipe_fingers = 3;
  #     #   workspace_swipe_distance = 500;
  #     #   workspace_swipe_invert = 1;
  #     #   workspace_swipe_min_speed_to_force = 30;
  #     #   workspace_swipe_cancel_ratio = 0.5;
  #     #   workspace_swipe_create_new = 1;
  #     #   workspace_swipe_forever = 1;
  #     # };
  #     general = {
  #       "$modifier" = "SUPER";
  #       layout = "dwindle";
  #       gaps_in = 6;
  #       gaps_out = 8;
  #       border_size = 2;
  #       resize_on_border = true;
  #       # "col.active_border" = "rgb(${config.lib.stylix.colors.base08}) rgb(${config.lib.stylix.colors.base0C}) 45deg";
  #       # "col.inactive_border" = "rgb(${config.lib.stylix.colors.base01})";
  #     };
  #     misc = {
  #       layers_hog_keyboard_focus = true;
  #       initial_workspace_tracking = 0;
  #       mouse_move_enables_dpms = true;
  #       key_press_enables_dpms = false;
  #       disable_hyprland_logo = true;
  #       disable_splash_rendering = true;
  #       enable_swallow = false;
  #       vfr = true; # Variable Frame Rate
  #       vrr = 2; #Variable Refresh Rate  Might need to set to 0 for NVIDIA/AQ_DRM_DEVICES
  #       # Screen flashing to black momentarily or going black when app is fullscreen
  #       # Try setting vrr to 0

  #       #  Application not responding (ANR) settings
  #       enable_anr_dialog = true;
  #       anr_missed_pings = 20;
  #     };
  #     dwindle = {
  #       pseudotile = true;
  #       preserve_split = true;
  #       force_split = 2;
  #     };
  #     decoration = {
  #       rounding = 10;
  #       blur = {
  #         enabled = true;
  #         size = 5;
  #         passes = 3;
  #         ignore_opacity = false;
  #         new_optimizations = true;
  #       };
  #       shadow = {
  #         enabled = true;
  #         range = 4;
  #         render_power = 3;
  #         color = "rgba(1a1a1aee)";
  #       };
  #     };
  #     ecosystem = {
  #       no_donation_nag = true;
  #       no_update_news = true;
  #     };
  #     cursor = {
  #       sync_gsettings_theme = true;
  #       no_hardware_cursors = 2; # change to 1 if want to disable
  #       enable_hyprcursor = false;
  #       warp_on_change_workspace = 2;
  #       no_warps = true;
  #     };
  #     render = {
  #       explicit_sync = 1; # Change to 1 to disable
  #       explicit_sync_kms = 1;
  #       direct_scanout = 0;
  #     };
  #     master = {
  #       new_status = "master";
  #       new_on_top = 1;
  #       mfact = 0.5;
  #     };
  #   };
  #   extraConfig = "
  #     monitor=,preferred,auto,auto
  #     monitor=Virtual-1,1920x1080@60,auto,1
  #     # ${extraMonitorSettings}
  #     # To enable blur on waybar uncomment the line below
  #     # Thanks to SchotjeChrisman
  #     #layerrule = blur,waybar
  #   ";
  # };

 # wayland.windowManager.hyprland.settings = {
 #    bind = [
 #      "$modifier,Return,exec,uwsm app -- ${terminal}"
 #      "$modifier,K,exec,list-keybinds"
 #      # "$modifier SHIFT,Return,exec,rofi-launcher"
 #      # "$modifier SHIFT,W,exec,web-search"
 #      # "$modifier ALT,W,exec,wallsetter"
 #      # "$modifier SHIFT,N,exec,swaync-client -rs"
 #      # "$modifier,W,exec,uwsm app -- ${browser}"
 #      # "$modifier,Y,exec,uwsm app -- kitty -e yazi"
 #      # "$modifier,E,exec,emopicker9000"
 #      # "$modifier,S,exec,screenshootin"
 #      # "$modifier,D,exec,uwsm app -- discord"
 #      # "$modifier,O,exec,uwsm app -- obs"
 #      # "$modifier,C,exec,hyprpicker -a"
 #      # "$modifier,G,exec,uwsm app -- gimp"
 #      # "$modifier,T,exec,pypr toggle term"
 #      # "$modifier,M,exec,pavucontrol"
 #      # "$modifier,Q,killactive,"
 #      # "$modifier,P,pseudo,"
 #      # "$modifier,V,exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
 #      "$modifier SHIFT,I,togglesplit,"
 #      "$modifier,F,fullscreen,"
 #      "$modifier SHIFT,F,togglefloating,"
 #      "$modifier ALT,F,workspaceopt, allfloat"
 #      "$modifier SHIFT,C,exit,"
 #      "$modifier SHIFT,left,movewindow,l"
 #      "$modifier SHIFT,right,movewindow,r"
 #      "$modifier SHIFT,up,movewindow,u"
 #      "$modifier SHIFT,down,movewindow,d"
 #      "$modifier SHIFT,h,movewindow,l"
 #      "$modifier SHIFT,l,movewindow,r"
 #      "$modifier SHIFT,k,movewindow,u"
 #      "$modifier SHIFT,j,movewindow,d"
 #      "$modifier ALT, left, swapwindow,l"
 #      "$modifier ALT, right, swapwindow,r"
 #      "$modifier ALT, up, swapwindow,u"
 #      "$modifier ALT, down, swapwindow,d"
 #      "$modifier ALT, 43, swapwindow,l"
 #      "$modifier ALT, 46, swapwindow,r"
 #      "$modifier ALT, 45, swapwindow,u"
 #      "$modifier ALT, 44, swapwindow,d"
 #      "$modifier,left,movefocus,l"
 #      "$modifier,right,movefocus,r"
 #      "$modifier,up,movefocus,u"
 #      "$modifier,down,movefocus,d"
 #      "$modifier,h,movefocus,l"
 #      "$modifier,l,movefocus,r"
 #      "$modifier,k,movefocus,u"
 #      "$modifier,j,movefocus,d"
 #      "$modifier,1,workspace,1"
 #      "$modifier,2,workspace,2"
 #      "$modifier,3,workspace,3"
 #      "$modifier,4,workspace,4"
 #      "$modifier,5,workspace,5"
 #      "$modifier,6,workspace,6"
 #      "$modifier,7,workspace,7"
 #      "$modifier,8,workspace,8"
 #      "$modifier,9,workspace,9"
 #      "$modifier,0,workspace,10"
 #      "$modifier SHIFT,SPACE,movetoworkspace,special"
 #      "$modifier,SPACE,togglespecialworkspace"
 #      "$modifier SHIFT,1,movetoworkspace,1"
 #      "$modifier SHIFT,2,movetoworkspace,2"
 #      "$modifier SHIFT,3,movetoworkspace,3"
 #      "$modifier SHIFT,4,movetoworkspace,4"
 #      "$modifier SHIFT,5,movetoworkspace,5"
 #      "$modifier SHIFT,6,movetoworkspace,6"
 #      "$modifier SHIFT,7,movetoworkspace,7"
 #      "$modifier SHIFT,8,movetoworkspace,8"
 #      "$modifier SHIFT,9,movetoworkspace,9"
 #      "$modifier SHIFT,0,movetoworkspace,10"
 #      "$modifier CONTROL,right,workspace,e+1"
 #      "$modifier CONTROL,left,workspace,e-1"
 #      "$modifier,mouse_down,workspace, e+1"
 #      "$modifier,mouse_up,workspace, e-1"
 #      "ALT,Tab,cyclenext"
 #      "ALT,Tab,bringactivetotop"
 #      ",XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
 #      ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
 #      " ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
 #      ",XF86AudioPlay, exec, playerctl play-pause"
 #      ",XF86AudioPause, exec, playerctl play-pause"
 #      ",XF86AudioNext, exec, playerctl next"
 #      ",XF86AudioPrev, exec, playerctl previous"
 #      ",XF86MonBrightnessDown,exec,brightnessctl set 5%-"
 #      ",XF86MonBrightnessUp,exec,brightnessctl set +5%"
 #    ];

  #   bindm = [
  #     "$modifier, mouse:272, movewindow"
  #     "$modifier, mouse:273, resizewindow"
  #   ];
  # };

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

}
