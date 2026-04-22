{ config, ... }:
{
  home.file.".claude/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "/home/john/dotfiles/claude/settings.json";
  home.file.".claude/skills".source =
    config.lib.file.mkOutOfStoreSymlink "/home/john/dotfiles/claude/skills";
  home.file.".claude/CLAUDE.md".source =
    config.lib.file.mkOutOfStoreSymlink "/home/john/dotfiles/claude/CLAUDE.md";
}
