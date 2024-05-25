#!/bin/bash

# setup_mac.sh
#
# Install programs for mac

echo "----------------------------"
echo "---Running Dotfiles Setup---"
echo "----------------------------"
echo

echo "---Install Programs for MacOS ---" 
echo
echo "Programs: kitty, neovim, tmux, ack, asdf, vim-plug"
read -p "Okay to install programs using brew? (y/n) " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo
  echo "Installing programs..."
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
  brew install neovim
  brew install tmux
else
  echo
  echo "Okay, some settings may not work."
fi
echo
echo "Done intalling programs"
echo

links=(
  ~/.config/kitty/kitty.conf
  ~/.config/nvim/init.lua
)

files=(
  ~/dotfiles/kitty.conf
  ~/dotfiles/vim/init.lua
)

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
    ln -shf "${files[$i]}" "${links[$i]}"
  done
else
  echo "Not making symlinks, you may need to link the relevant files manually"
fi

echo
echo
echo "-----------------------------"
echo "---Dotfiles Setup Complete---"
echo "-----------------------------"
