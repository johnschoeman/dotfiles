{ pkgs, ... }:
{
  home.packages = [
    pkgs.zellij
  ];

  xdg.configFile."zellij/config.kdl".source = /home/john/dotfiles/zellij/config.kdl;
}
