#!/bin/bash

# Setup Linux Programs

# make
# sudo apt-get install make

# ansi c compiler and build tools
# sudo apt-get install linux-headers-$(uname -r) build-essential
# sudo apt install cmake

# kitty, tmux, i3, neovim,

# Install neovim, make sure it's above v5.0
# download from github releases
# tar xzvf nvim-linux64.tar.gz

# screenshot capture dependencies:
# install maim xclip xdotool
# sudo apt install main xclip xdotool

# install kitty

# install asdf

# install lua via asdf
# since we are using asdf for lua, we should add a link for shebang lines
# ln -s $(which lua) /bin/lua


# Install Programs
echo "---Install Programs---" 
echo

  echo
  echo "Installing programs..."

  echo "Installing tmux..."
  # sudo apt install tmux

  echo "Installing ripgrep..."
  # sudo apt-get install ripgrep

  echo "Installing kitty..."
  #curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

  echo "Install asdf..."
  #git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0

  echo "Install lua..."
  # asdf plugin add lua
  # asdf install lua latest

echo
echo "Done intalling programs"
echo

# Make symlinks for relevant files

links=(
  ~/.config/nvim/init.lua
  ~/.config/kitty/kitty.conf
  ~/.tmux.conf
  ~/.config/i3/config
)

files=(
  ~/dotfiles/vim/init.lua
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


