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

# Install nvim
echo "---Installing nvim---"
brew install neovim
echo "Done installing nvim"

# Make symlinks for relevant files

links=(
  ~/.aginore
  ~/.aliases
  ~/.bin
  ~/.config/kitty/kitty.conf
  ~/.config/nvim/init.vim
  ~/.config/nvim/coc-settings.json
  ~/.ctags
  ~/.gemrc
  ~/.gitconfig
  ~/.gitmessage
  ~/.hushlogin
  ~/.psqlrc
  ~/.rcrc
  ~/.rspec
  ~/.tmux.conf
  ~/.vim/rcfiles/general
  ~/.vim/rcfiles/search-and-replace
  ~/.vimrc
  ~/.zsh
  ~/.zshenv
  ~/.zshrc
  ~/.config/nvim/init.vim
)

files=(
  ~/dotfiles/agignore
  ~/dotfiles/aliases
  ~/dotfiles/bin
  ~/dotfiles/kitty.conf
  ~/dotfiles/vim/init.vim
  ~/dotfiles/vim/coc-settings.json
  ~/dotfiles/ctags
  ~/dotfiles/gemrc
  ~/dotfiles/gitconfig
  ~/dotfiles/gitmessage
  ~/dotfiles/hushlogin
  ~/dotfiles/psqlrc
  ~/dotfiles/rcrc
  ~/dotfiles/rspec
  ~/dotfiles/tmux.conf
  ~/dotfiles/vim/rcfiles/general
  ~/dotfiles/vim/rcfiles/search-and-replace
  ~/dotfiles/vim/vimrc
  ~/dotfiles/zsh
  ~/dotfiles/zshenv
  ~/dotfiles/zshrc
  ~/dotfiles/init.vim
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
config_files=(~/.aliases ~/.rcrc)

for file in "${config_files[@]}"
do
  echo "running source ${file}"
  source "${file}"
done

echo

# Install Plug for neovim
echo "---Installing Plug for neovim---"
echo
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo


# Source zsh files
# source ~/.zshrc
# Create .config folder and add symlink between config/nvim/init.vim and dotfiles/initi.vim
# run PlugInstall from neovim
# add gruvbox colors


echo "-------------------------"
echo "Done with dotfiles setup!"
