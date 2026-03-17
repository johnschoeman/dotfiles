{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = "/home/john/dotfiles/rofi/theme.rasi";

    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
      drun-display-format = "{icon} {name}";
      disable-history = false;
      hide-scrollbar = true;
      display-drun = " Apps";
      display-run = " Run";
      display-window = " Windows";
    };
  };
}
