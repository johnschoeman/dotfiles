# setup_dotfile_symlinks.sh
#
# Set simlinks for env files

echo "==== Setting Env Symlinks ======"
echo

links=(
  ~/.aliases
  ~/.bin
  ~/.ctags
  ~/.gitconfig
  ~/.gitmessage
  # TODO: setup switching on used shell for symlinks
  ~/.bashrc
  # ~/.zsh
  # ~/.zshenv
  # ~/.zshrc
)

files=(
  ~/dotfiles/aliases
  ~/dotfiles/bin
  ~/dotfiles/ctags
  ~/dotfiles/gitconfig
  ~/dotfiles/gitmessage
  ~/dotfiles/bashrc
  # ~/dotfiles/zsh
  # ~/dotfiles/zshenv
  # ~/dotfiles/zshrc
)

for ((i = 0; i < ${#files[@]}; i++))
do
  echo "setting ${links[$i]} to link to ${files[$i]}"
  ln -sf "${files[$i]}" "${links[$i]}"
done

echo
echo "==== Sourcing Config Files ====="
echo

config_files=(
  ~/.aliases
  # ~/.zshrc,
)

for file in "${config_files[@]}"
do
  echo "running source ${file}"
  source "${file}"
done

echo "==== Symlink Setup Complete ===="
echo
