{ pkgs, ... }:
{
  programs.bash = {
    enable = true;
    shellAliases = {
      # NixOS
      wtf = "echo 'wtf'";
      ninfo = "nh os info";
      nrs = "nh os switch /home/john/dotfiles/nixos -- --impure";
      nclean = "nh clean all --keep-since 14d";
      # Utilities
      ls = "eza -la";
      cat = "bat";
      cd = "z";
    };
    initExtra = ''
      EDITOR=nvim
      eval "$(starship init bash)"
      eval "$(zoxide init bash)"
    '';
  };
}
