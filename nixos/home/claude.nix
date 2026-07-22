{ config, lib, ... }:
{
  # Direct single-hop symlink; mkOutOfStoreSymlink's store-symlink hop breaks
  # Claude Code's own atomic writes to this file.
  home.activation.claudeSettingsSymlink = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ln -sf /home/john/dotfiles/claude/settings.json "$HOME/.claude/settings.json"
  '';

  home.file.".claude/skills".source =
    config.lib.file.mkOutOfStoreSymlink "/home/john/dotfiles/claude/skills";
  home.file.".claude/CLAUDE.md".source =
    config.lib.file.mkOutOfStoreSymlink "/home/john/dotfiles/claude/CLAUDE.md";
}
