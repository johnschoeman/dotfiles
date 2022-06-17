#!/bin/bash

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
echo "---Install Programs (MacOS only)---" 
echo
echo "Programs: kitty, neovim, tmux, ack, vim-plug"
read -p "Okay to install programs using brew? (y/n) " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo
  echo "Installing programs..."
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
  brew install neovim
  brew install tmux
  brew install ack
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
  echo
  echo "Okay, some settings may not work."
fi
echo
echo "Done intalling programs"
echo

# Make symlinks for relevant files

links=(
  ~/.ackrc
  ~/.aliases
  ~/.bin
  ~/.config/kitty/kitty.conf
  ~/.config/nvim/init.vim
  ~/.config/nvim/coc-settings.json
  ~/.ctags
  ~/.gitconfig
  ~/.gitmessage
  ~/.psqlrc
  ~/.tmux.conf
  ~/.vimrc
  ~/.zsh
  ~/.zshenv
  ~/.zshrc
)

files=(
  ~/dotfiles/ackrc
  ~/dotfiles/aliases
  ~/dotfiles/bin
  ~/dotfiles/kitty.conf
  ~/dotfiles/vim/init.vim
  ~/dotfiles/vim/coc-settings.json
  ~/dotfiles/ctags
  ~/dotfiles/gitconfig
  ~/dotfiles/gitmessage
  ~/dotfiles/psqlrc
  ~/dotfiles/tmux.conf
  ~/dotfiles/vim/vimrc
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
    if [ -L "${links[$i]}" ]; then
      echo "overwriting ${links[$i]} to link to ${files[$i]}"
      rm "${links[$i]}"
      ln -s "${files[$i]}" "${links[$i]}"
    else
      echo "creating symbolic link from ${links[$i]} to ${files[$i]}"
      ln -s "${files[$i]}" "${links[$i]}"
    fi
  done
else
  echo "Not making symlinks, you may need to link the relevant files manually"
fi
echo

# Source config files
echo "---Sourcing Config Files---"
echo
config_files=(~/.aliases ~/.zshrc)

for file in "${config_files[@]}"
do
  echo "running source ${file}"
  source "${file}"
done

echo
echo "-----------------------------"
echo "---Dotfiles Setup Complete---"
echo "-----------------------------"
