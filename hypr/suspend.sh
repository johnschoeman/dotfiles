# 
# https://www.reddit.com/r/hyprland/comments/158jyiv/automatically_suspend_and_hibernate/

# swayidle -w \
# timeout 30 ' hyprlock ' \
# timeout 60 ' hyprctl dispatch dpms off' \
# timeout 90 'systemctl suspend' \
# resume ' hyprctl dispatch dpms on' \
# before-sleep 'hyprlock'
