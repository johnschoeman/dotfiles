## ========================================================================== --
## ==                             ZSH SETTINGS                             == --
## ========================================================================== --

# https://zsh.sourceforge.io/Doc/Release/Options.html

# cd options
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# glob options
setopt extendedglob

# expansion options
# allow [ or ] whereever you want
unsetopt nomatch

# editor
export VISUAL=nvim
export EDITOR="$VISUAL"

## ========================================================================== --
## ==                             KEY BINDINGS                             == --
## ========================================================================== --

# give us access to ^Q
stty -ixon

# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode

# handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey "^Q" push-line-or-edit
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"


case `uname` in
  Linux)
  # set caps a ctrl for i3 linux
  setxkbmap -option caps:ctrl_modifier
  ;;
  Darwin)
  ;;
esac

## ========================================================================== --
## ==                               COLORS                                 == --
## ========================================================================== --

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc. on FreeBSD-based systems
export CLICOLOR=1

## ========================================================================== --
## ==                               HISTORY                                == --
## ========================================================================== --

setopt hist_ignore_all_dups inc_append_history

HISTFILE=~/.zhistory
HISTFILESIZE=1000000000
HISTSIZE=1000000
SAVEHIST=1000000

export ERL_AFLAGS="-kernel shell_history enabled"

# back search
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "${terminfo[kcuu1]}" history-beginning-search-backward-end
bindkey "${terminfo[kcud1]}" history-beginning-search-forward-end

bindkey ' ' magic-space

## ========================================================================== --
## ==                               PROMPT                                 == --
## ========================================================================== --

# modify the prompt to contain git branch name if applicable
git_prompt_info() {
  current_branch=$(git current-branch 2> /dev/null)
  if [[ -n $current_branch ]]; then
    echo " %{$fg_bold[green]%}$current_branch%{$reset_color%}"
  fi
}

setopt promptsubst

# Allow exported PS1 variable to override default prompt.
if ! env | grep -q '^PS1='; then
  PS1='${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%c%{$reset_color%}$(git_prompt_info) %# '
fi

setopt prompt_subst

autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr 'M' 
zstyle ':vcs_info:*' unstagedstr 'M' 
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' actionformats '%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats \
  '%F{5}[%F{2}%b%F{5}] %F{2}%c%F{3}%u%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
zstyle ':vcs_info:*' enable git 
+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
  [[ $(git ls-files --other --directory --exclude-standard | sed q | wc -l | tr -d ' ') == 1 ]] ; then
  hook_com[unstaged]+='%F{1}??%f'
fi
}

precmd () { vcs_info }
# Full Prompt - [username] directory [git_info]
PROMPT='%F{5}[%F{2}%n%F{5}] %F{3}%3~ ${vcs_info_msg_0_} %f%# '

# Simple Prompt - directory [git_info]
# PROMPT='%F{5} %F{3}%2~ ${vcs_info_msg_0_} %f%# '

## ========================================================================== --
## ==                               COMPLETION                             == --
## ========================================================================== --

# load our own completion functions
fpath=(~/.zsh/completion /usr/local/share/zsh/site-functions $fpath)
autoload -U compinit
compinit

## ========================================================================== --
## ==                               BASE                                   == --
## ========================================================================== --

# Aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Fuctions
for function in ~/.zsh/functions/*; do
  source $function
done

## ========================================================================== --
## ==                               PATH                                   == --
## ========================================================================== --

# dotfiles
PATH="$HOME/.bin:/usr/local/sbin:$PATH"

# mkdir .git/safe in the root of repositories you trust
PATH=".git/safe/../../bin:$PATH"
export -U PATH

export PATH=$PATH:/usr/bin

export PATH=$HOME/.local/bin:$PATH

# Java

# Using homebrew for JDK
# when updating, need to set the JAVA_HOME to actual exe path.
#
# Find java exe path:
# java -XshowSettings:properties -version 2>&1 > /dev/null | grep 'java.home'

export JAVA_HOME=/usr/local/Cellar/openjdk@17/17.0.9/libexec/openjdk.jdk/Contents/Home
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH="/usr/local/opt/openjdk@17/bin:$PATH"

export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

export PATH=$PATH:$HOME/.reasonml
[ -f "/Users/johnschoeman/.ghcup/env" ] && source "/Users/johnschoeman/.ghcup/env" # ghcup-env

# elastic beanstalk cli
export PATH="/Users/johnschoeman/.ebcli-virtual-env/executables:$PATH"

. "$HOME/.asdf/asdf.sh"

# bun completions
[ -s "/Users/johnschoeman/.bun/_bun" ] && source "/Users/johnschoeman/.bun/_bun"
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# gh
export PATH=$PATH:$HOME/gh_2.49.2_linux_386/bin/

# neovim
export PATH=$PATH:$HOME/nvim-linux64/bin/
