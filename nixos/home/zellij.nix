{ pkgs, config, ... }:
{
  home.packages = [
    pkgs.zellij
  ];

  xdg.configFile."zellij/config.kdl" = {
    source = config.lib.file.mkOutOfStoreSymlink /home/john/dotfiles/zellij/config.kdl;
    force = true;
  };
}
