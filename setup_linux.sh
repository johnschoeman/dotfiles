#!/bin/bash

# setup_linux_dependencies.sh
#
# Install dependencies for linux. Notes:
#
# Expected to have sourced .zshrc prior to running script
#
# Installed Dependencies
#
# i3, xclip, brightnessctl, maim, xdotool
# Installed Programs
#
# kitty, tmux, i3, neovim, asdf, lua


function log() {
  echo "[Setup Linux] $1"
}

# ---- i3

log "i3"
sudo apt install i3
sudo apt-get install xclip

# -- i3 screen brightness
sudo apt install brightnessctl

# -- i3 Screenshots
sudo apt install maim
sudo apt install xdotool


# ---- Base Dev Tools

log "tmux"
sudo apt install tmux

log "ripgrep"
sudo apt-get install ripgrep

log "kitty"
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

log "asdf"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0

log "lua"
asdf plugin add lua
asdf install lua latest
asdf global lua latest
# since we are using asdf for lua, we add a link for shebang lines
ln -s $(which lua) /bin/lua

log "nerd font"
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip \
&& cd ~/.local/share/fonts \
&& unzip JetBrainsMono.zip \
&& rm JetBrainsMono.zip \
&& fc-cache -fv

# ---- Programming Languages

log "python3"
sudo apt install libffi-dev libncurses5-dev zlib1g zlib1g-dev libssl-dev libreadline-dev libbz2-dev libsqlite3-dev
asdf plugin add python
asdf install python 3.10.14
asdf global python 3.10.14

log "c++"
# ansi c compiler and build tools
sudo apt-get install make
sudo apt-get install linux-headers-$(uname -r) build-essential
sudo apt install cmake

log "clangd"
sudo apt-get install clangd-12
sudo update-alternatives --install /usr/bin/clangd clangd /usr/clangd-12 100

# Developer Contributing Tools

log "JFrog"
wget -qO - https://releases.jfrog.io/artifactory/jfrog-gpg-public/jfrog_public_gpg.key | sudo apt-key add -
echo "deb https://releases.jfrog.io/artifactory/jfrog-debs xenial contrib" | sudo tee -a /etc/apt/sources.list
  && sudo apt update
  && sudo apt install -y jfrog-cli-v2-jf
  && jf intro

log "---- Making Symlinks"

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

mkdir -p ~/.config/nvim
mkdir -p ~/.config/i3

for ((i = 0; i < ${#files[@]}; i++))
do
  log "overwriting ${links[$i]} to link to ${files[$i]}"
  ln -sf "${files[$i]}" "${links[$i]}"
done


