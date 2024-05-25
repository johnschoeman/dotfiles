Ubuntu Setup
---

# Get dotfiles from github

install 1Password via .deb

install gh cli and auth ssh
add git config --global user.email user.name
git clone dotfiles

# Run dotfiles linking script

```
./setup_shell.sh
```

installs and changes shell to zsh

log out and back in to set login shell to zsh


# Run dev tools install script

```
./setup_linux.sh
```

Installs kitty, tmux, i3, asdf, screencapture, xclip, lua, jf, python, c, etc,

# Install latest neovim

download from github releases
tar xzvf nvim-linux64.tar.gz

```
mkdir ~/.config/nvim
ln -sf ~/dotfiles/vim/vim.lua ~/.config/nvim/init.lua
```


# Setup ssh keys for bitbucket

https://support.atlassian.com/bitbucket-cloud/docs/set-up-personal-ssh-keys-on-linux/

# Install Communication Tools

Zoom
Slack
Loom
Tuple

