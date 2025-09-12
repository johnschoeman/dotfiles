{ pkgs, ... }:
{
  programs.bash = {
    enable = true;
    shellAliases = {
      # NixOS
      ninfo = "nh os info";
      nrs = "nh os switch /home/john/dotfiles/nixos -- --impure";
      nclean = "nh clean all --keep-since 14d";

      drun = "rofi -show drun";
      neofetch = "fastfetch";

      # Vim
      v = "nvim";
      vim = "nvim";

      # Utilities
      ls = "eza -la";
      cat = "bat";
      cd = "z";
      find = "fd";
    };
    initExtra = ''
      EDITOR=nvim
      eval "$(starship init bash)"
      eval "$(zoxide init bash)"

      # g
      #
      # No arguments: `git status`
      # With arguments: acts like `git`

      g() {
        if [[ $# -gt 0 ]]; then
          git "$@"
        else
          git status
        fi
      }
    '';
  };
}
