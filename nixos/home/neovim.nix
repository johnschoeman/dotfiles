{ pkgs, ... }:
{
  home.packages = [
    pkgs.neovim
  ];

  xdg.configFile.nvim.source = /home/john/dotfiles/vim;
}
