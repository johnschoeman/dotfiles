#!/bin/bash

# setup_linux_dependencies.sh
#
# Install dependencies for linux.
#
# Notes:
#
# Expected to have sourced .zshrc prior to running script

# Installed Programs
#
# kitty, tmux, i3, neovim, asdf, lua


# Environment setup tools

echo "Installing i3..."
sudo apt install i3

echo "Installing xclip..."
sudo apt-get install xclip

# Base Dev Tools

echo "Installing tmux..."
sudo apt install tmux

echo "Installing ripgrep..."
sudo apt-get install ripgrep

echo "Installing kitty..."
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

echo "Install asdf..."
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0

echo "Install lua..."
asdf plugin add lua
asdf install lua latest
asdf global lua latest
# since we are using asdf for lua, we add a link for shebang lines
ln -s $(which lua) /bin/lua

# Programming Languages

echo "Install python3..."
sudo apt install libffi-dev libncurses5-dev zlib1g zlib1g-dev libssl-dev libreadline-dev libbz2-dev libsqlite3-dev
asdf plugin add python
asdf install python 3.10.14
asdf global python 3.10.14

echo "Install c dependencies"
# ansi c compiler and build tools
sudo apt-get install make
sudo apt-get install linux-headers-$(uname -r) build-essential
sudo apt install cmake

# Developer Contributing Tools

echo "Install jf..."
wget -qO - https://releases.jfrog.io/artifactory/jfrog-gpg-public/jfrog_public_gpg.key | sudo apt-key add -
echo "deb https://releases.jfrog.io/artifactory/jfrog-debs xenial contrib" | sudo tee -a /etc/apt/sources.list
  && sudo apt update
  && sudo apt install -y jfrog-cli-v2-jf
  && jf intro


# Make symlinks for relevant files

links=(
  ~/.config/kitty/kitty.conf
  ~/.tmux.conf
  ~/.config/i3/config
)

files=(
  ~/dotfiles/kitty.conf
  ~/dotfiles/tmux.conf
  ~/dotfiles/i3/config
)

# Get okay to overwrite files from user
echo "---Make Symlinks---"
echo
echo "WARNING: this will overwrite the following files if they exist:"
echo
printf '%s\n' "${links[@]}"
echo
read -p "Do you want to proceed? (y/n) " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "Making symlinks for relevant files"
  echo

  mkdir ~/.config/nvim
  mkdir ~/.config/i3

  for ((i = 0; i < ${#files[@]}; i++))
  do
    echo "overwriting ${links[$i]} to link to ${files[$i]}"
    ln -sf "${files[$i]}" "${links[$i]}"
  done
else
  echo "Not making symlinks, you may need to link the relevant files manually"
fi
echo


