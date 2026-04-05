# fish.nix

{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      ## Setup

      function fish_greeting; end
      fish_add_path ~/dotfiles/scripts
      set EDITOR hx
      starship init fish | source
      zoxide init fish | source
      atuin init fish | source
      direnv hook fish | source

      ## Aliases

      #### NixOS

      alias ninfo "nh os info"
      alias nrs "nh os switch /home/john/dotfiles/nixos -- --impure"
      alias nclean "nh clean all --keep-since 14d"
      alias nhsearch "nh search"
      alias nupdate "nix flake update --flake ~/dotfiles/nixos"
      alias nupdated "stat -c '%y' ~/dotfiles/nixos/flake.lock"
      alias drun "rofi -show drun"
      alias neofetch "fastfetch"

      #### Helix

      alias v "hx"
      alias h "hx"

      #### Utilities
      alias ls "eza -la"
      alias cat "bat"
      alias cd "z"
      alias find "fd"
      alias bell "aplay ~/dotfiles/media/bell.wav"
      alias copy "wl-copy"
      alias paste "wl-paste"
      alias ccm "bat commit-msg.txt | wl-copy"
      alias rec "gif-record.sh"

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

      # jfrog-login
      #
      # Load JFrog npm auth token from 1Password.
      # Run once per session before using npm/pnpm with Artifactory.

      function jfrog-login --description "Load JFrog npm token from 1Password"
          set -gx JFROG_NPM_TOKEN (op read "op://Personal/JFrog Artifactory Token/token" 2>/dev/null)
          if test $status -eq 0
              echo "JFrog npm token loaded."
          else
              echo "Failed to load JFrog token. Is 1Password unlocked?" >&2
          end
      end

      # pom
      #
      # No arguments: `timer 25m && bell`
      # With arguments: `timer $argv && bell`

      function pom
          if test (count $argv) -eq 0
              timer 25m && bell
          else
              timer $argv && bell
          end
      end
    '';
  };
}
