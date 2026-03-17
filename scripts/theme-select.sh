#!/usr/bin/env bash
THEME_DIR="$HOME/dotfiles/alacritty/themes"
CURRENT="$HOME/.config/alacritty/current-theme.toml"
CURRENT_NAME="$HOME/.config/alacritty/current-theme-name"

CURATED=(
  catppuccin_frappe
  catppuccin_mocha
  gruvbox_dark
  nord
  rose_pine
  solarized_light
  tokyo_night
)

active=$(cat "$CURRENT_NAME" 2>/dev/null)

pick_theme() {
  list=""
  for t in "${CURATED[@]}"; do
    if [[ "$t" == "$active" ]]; then
      list+="* $t\n"
    else
      list+="  $t\n"
    fi
  done

  printf "%b" "$list" \
    | rofi -dmenu -i -p "Theme" -theme-str 'listview { lines: 7; }' \
    | sed 's/^[* ] //'
}

set_theme() {
  local name="$1"
  local file="$THEME_DIR/$name.toml"

  if [[ ! -f "$file" ]]; then
    notify-send -u critical -a "Theme" "Theme not found" "'$name' does not exist"
    exit 1
  fi

  cp "$file" "$CURRENT"
  echo "$name" > "$CURRENT_NAME"
  touch "$HOME/.config/alacritty/alacritty.toml"

  # Update Zellij config (new sessions only)
  zellij_name="${name//_/-}"
  zellij_config="$HOME/.config/zellij/config.kdl"
  if [[ -f "$zellij_config" ]]; then
    sed -i "s/^theme \".*\"/theme \"$zellij_name\"/" "$zellij_config"
  fi

  # Update Waybar colors (instant reload)
  waybar_theme="$HOME/dotfiles/waybar/themes/$zellij_name.css"
  waybar_colors="$HOME/dotfiles/waybar/colors.css"
  if [[ -f "$waybar_theme" ]]; then
    ln -sf "themes/$zellij_name.css" "$waybar_colors"
    pkill -SIGUSR2 waybar || true
  fi

  # Update Rofi colors (next launch)
  rofi_theme="$HOME/dotfiles/rofi/themes/$zellij_name.rasi"
  rofi_colors="$HOME/dotfiles/rofi/colors.rasi"
  if [[ -f "$rofi_theme" ]]; then
    ln -sf "themes/$zellij_name.rasi" "$rofi_colors"
  fi

  # Update Mako colors (instant reload)
  mako_theme="$HOME/dotfiles/mako/themes/$zellij_name.conf"
  mako_base="$HOME/dotfiles/mako/base.conf"
  mako_config="$HOME/dotfiles/mako/config"
  if [[ -f "$mako_theme" ]]; then
    cat "$mako_base" "$mako_theme" > "$mako_config"
    makoctl reload || true
  fi

  # Update Hyprlock colors (next lock)
  hyprlock_theme="$HOME/dotfiles/hyprlock/themes/$zellij_name.conf"
  hyprlock_colors="$HOME/dotfiles/hyprlock/colors.conf"
  if [[ -f "$hyprlock_theme" ]]; then
    ln -sf "themes/$zellij_name.conf" "$hyprlock_colors"
  fi

  # Update Helix theme (new instances only, can reload with space + T)
  declare -A helix_map=(
    [gruvbox_dark]=gruvbox
    [tokyo_night]=tokyonight
  )
  helix_name="${helix_map[$name]:-$name}"
  helix_config="$HOME/dotfiles/helix/config.toml"
  if [[ -f "$helix_config" ]]; then
    sed -i "s/^theme = .*/theme = \"$helix_name\"/" "$helix_config"
  fi

  notify-send -a "Theme" "Theme switched" "$name"
}

next_theme() {
  local idx=0
  for i in "${!CURATED[@]}"; do
    if [[ "${CURATED[$i]}" == "$active" ]]; then
      idx=$(( (i + 1) % ${#CURATED[@]} ))
      break
    fi
  done
  echo "${CURATED[$idx]}"
}

if [[ "$1" == "--next" ]]; then
  set_theme "$(next_theme)"
elif [[ -n "$1" ]]; then
  set_theme "$1"
else
  choice=$(pick_theme)
  [[ -z "$choice" ]] && exit 0
  set_theme "$choice"
fi
