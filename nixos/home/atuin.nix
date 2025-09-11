# Atuin
#
# enable sync:
#
# ```
# atuin register -u <USERNAME> -e <EMAIL>
# atuin import auto
# atuin sync
# ```

{ pkgs, ... }:
{
  home.packages = [
    pkgs.atuin
  ];

  programs.atuin = {
    enable = true;
    settings = {
      auto_sync = true;
      sync_frequency = "5m";
      sync_address = "https://api.atuin.sh";
    };
  };
}
