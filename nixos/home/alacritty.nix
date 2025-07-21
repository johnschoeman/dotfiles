{ pkgs, ... }:
{
  home.packages = [
    pkgs.alacritty
  ];
  
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.9;
    };
  };
}
