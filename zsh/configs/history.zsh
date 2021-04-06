setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTFILESIZE=1000000000
HISTSIZE=1000000
SAVEHIST=1000000

export ERL_AFLAGS="-kernel shell_history enabled"
