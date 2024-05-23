#!/bin/bash

# Ubuntu Setup

# install zsh
# chsh -s $(which zsh)
# log out and back in

# install 1Password via .deb
# install gh cli and auth ssh
# add git config --global user.email user.name
# git clone dotfiles

# run dotfiles linking script

# run install programs script

# kitty, tmux, i3, neovim,

# install i3

# Install neovim, make sure it's above v5.0

# grep tool, used for neovim telescope, and cli
# install ripgrep 
# sudo apt-get install ripgrep

# screenshot capture dependencies:
# install maim xclip xdotool
# sudo apt install main xclip xdotool

# Set caps to control on ubuntu
# setxkbmap -option caps:ctrl_modifier
# (added to zshrc)

# install kitty

# install asdf

# install lua via asdf
# since we are using asdf for lua, we should add a link for shebang lines
# ln -s $(which lua) /bin/lua


echo "----------------------------"
echo "---Running Dotfiles Setup---"
echo "----------------------------"
echo

# Set zsh as login shell
echo "---Set zsh as login shell---"
echo
read -p "Okay to set zsh to login shell? (y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo
  echo "setting zsh to login shell"
  chsh -s $(which zsh)
else
  echo
  echo "Okay, things may not work, proceed at your own risk"
fi
echo
echo "Done setting shell"
echo

# Install Programs
echo "---Install Programs---" 
echo
echo "Programs: ripgrep"

if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo
  echo "Installing programs..."
#  sudo apt-get install ripgrep
else
  echo
  echo "Okay, some settings may not work."
fi
echo
echo "Done intalling programs"
echo

# Make symlinks for relevant files

links=(
  ~/.aliases
  ~/.bin
  ~/.ctags
  ~/.gitconfig
  ~/.gitmessage
  ~/.zsh
  ~/.zshenv
  ~/.zshrc
)

files=(
  ~/dotfiles/aliases
  ~/dotfiles/bin
  ~/dotfiles/ctags
  ~/dotfiles/gitconfig
  ~/dotfiles/gitmessage
  ~/dotfiles/zsh
  ~/dotfiles/zshenv
  ~/dotfiles/zshrc
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

  for ((i = 0; i < ${#files[@]}; i++))
  do
    echo "overwriting ${links[$i]} to link to ${files[$i]}"
    ln -sf "${files[$i]}" "${links[$i]}"
  done
else
  echo "Not making symlinks, you may need to link the relevant files manually"
fi
echo

# Source config files
echo "---Sourcing Config Files---"
echo
config_files=(~/.zshrc)

for file in "${config_files[@]}"
do
  echo "running source ${file}"
  source "${file}"
done

echo
echo "-----------------------------"
echo "---Dotfiles Setup Complete---"
echo "-----------------------------"

