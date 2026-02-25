{ config, ... }:
{
  home.file.".claude/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "/home/john/dotfiles/claude/settings.json";
}
