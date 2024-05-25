#!/bin/bash

# setup_shell.sh
#
# Set shell to zsh and simlink env files

echo "----------------------------"
echo "---Running Dotfiles Setup---"
echo "----------------------------"
echo

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

echo "---Sourcing Config Files---"
echo
config_files=(~/.zshrc, ~/.aliases)

for file in "${config_files[@]}"
do
  echo "running source ${file}"
  source "${file}"
done

echo
echo "-----------------------------"
echo "---Dotfiles Setup Complete---"
echo "-----------------------------"

