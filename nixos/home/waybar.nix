{ pkgs, ... }:
{
  home.packages = with pkgs; [
    waybar
  ];

  # Docs: https://github.com/Alexays/Waybar
  programs.waybar = {
    enable = true;
    style = builtins.readFile /home/john/dotfiles/waybar/style.css;
    settings = [{
      layer = "top";
      position = "bottom";
      mod = "dock";
      exclusive = true;
      passtrough = false;
      gtk-layer-shell = true;
      height = 0;
      modules-left = [
        "custom/endleft"
        "clock"
        "custom/divider"
        "hyprland/workspaces"
        "custom/divider"
        "custom/claude"
      ];
      modules-center = [ "hyprland/window" ];
      modules-right = [
        "tray"
        "custom/divider"
        "network"
        "custom/divider"
        "memory"
        "custom/divider"
        "cpu"
        "custom/divider"
        "backlight"
        "custom/divider"
        "pulseaudio"
        "custom/divider"
        "battery"
        "custom/endright"
      ];
      "hyprland/window" = { format = "{}"; };
      "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          icon-size = 9;
          sort-by-number = true;
      };
      battery = { format = "󰁹 {}%"; };
      cpu = {
        interval = 10;
        format = "󰻠 {}%";
        max-length = 10;
        on-click = "";
      };
      memory = {
        interval = 30;
        format = " {}%";
        format-alt = " {used:0.1f}G";
        max-length = 10;
      };
      backlight = {
        format = "󰖨 {}";
        device = "acpi_video0";
      };
      tray = {
        icon-size = 13;
        tooltip = false;
        spacing = 10;
      };
      network = {
        format = "󰖩 ";
        format-disconnected = "󰖪 ";
        tooltip-format = "󰖩 {essid}";
      };
      clock = {
        format = "{:%a %d %H:%M} ";
        tooltip-format = ''
          <big>{:%Y %B}</big>
          <tt><small>{calendar}</small></tt>'';
      };
      pulseaudio = {
        format = "{icon} {volume}%";
        tooltip = false;
        format-muted = "";
        on-click = "pamixer -t";
        on-scroll-up = "pamixer -i 5";
        on-scroll-down = "pamixer -d 5";
        scroll-step = 5;
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [ "" "" " " ];
        };
      };
      "pulseaudio#microphone" = {
        format = "{format_source}";
        tooltip = false;
        format-source = " {volume}%";
        format-source-muted = " Muted";
        on-click = "pamixer --default-source -t";
        on-scroll-up = "pamixer --default-source -i 5";
        on-scroll-down = "pamixer --default-source -d 5";
        scroll-step = 5;
      };
      "custom/divider" = {
        format = " | ";
        interval = "once";
        tooltip = false;
      };
      "custom/endleft" = {
        format = " ";
        interval = "once";
        tooltip = false;
      };
      "custom/endright" = {
        format = " ";
        interval = "once";
        tooltip = false;
      };
      "custom/claude" = {
        exec = "~/.local/bin/claude-waybar.sh";
        return-type = "json";
        format = "{} ";
        interval = 3;
        tooltip = true;
      };
    }];
  };
}
