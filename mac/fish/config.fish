# config.fish — macOS Fish shell configuration

## Setup

function fish_greeting; end
fish_add_path /opt/homebrew/bin
fish_add_path ~/dotfiles/scripts
set -gx EDITOR hx
starship init fish | source
zoxide init fish | source
atuin init fish | source
direnv hook fish | source

## Aliases

#### Helix

alias v "hx"
alias h "hx"

#### Homebrew

alias brewfile "brew bundle --file=~/dotfiles/mac/Brewfile"

#### Utilities

alias ls "eza -la"
alias cat "bat"
alias cd "z"
alias find "fd"
alias bell "afplay ~/dotfiles/media/bell.wav"
alias copy "pbcopy"
alias paste "pbpaste"
alias ccm "bat commit-msg.txt | pbcopy"
alias neofetch "fastfetch"

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
