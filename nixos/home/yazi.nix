{ pkgs, config, ... }:
{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y";
  };

  xdg.configFile."yazi/theme.toml".source =
    config.lib.file.mkOutOfStoreSymlink /home/john/dotfiles/yazi/theme.toml;
}
