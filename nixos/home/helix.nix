{ pkgs, config, ... }:
{
  home.packages = [
    pkgs.helix
  ];

  programs.helix = {
    enable = true;
    defaultEditor = true;
  };

  xdg.configFile."helix/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink /home/john/dotfiles/helix/config.toml;
  xdg.configFile."helix/languages.toml".source =
    config.lib.file.mkOutOfStoreSymlink /home/john/dotfiles/helix/languages.toml;
}
