# fish.nix

{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      ## Setup

      function fish_greeting; end
      set EDITOR helix
      starship init fish | source
      zoxide init fish | source
      atuin init fish | source
      direnv hook fish | source

      ## Aliases

      #### NixOS

      alias ninfo "nh os info"
      alias nrs "nh os switch /home/john/dotfiles/nixos -- --impure"
      alias nclean "nh clean all --keep-since 14d"
      alias drun "rofi -show drun"
      alias neofetch "fastfetch"

      #### Vim

      alias v "nvim"
      alias vim "nvim"

      #### Helix

      alias h "hx"

      #### Utilities
      alias ls "eza -la"
      alias cat "bat"
      alias cd "z"
      alias find "fd"

      ## Functions

      # g
      #
      # No arguments: `git status`
      # With arguments: acts like `git`

      function g
          if test (count $argv) -eq 0
              git status
          else
              git $argv
          end
      end
    '';
  };
}
