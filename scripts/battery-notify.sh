#!/usr/bin/env bash
THRESHOLD=10
MARKER="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/battery-low-notified"
BAT="/sys/class/power_supply/BAT1"

capacity=$(cat "$BAT/capacity" 2>/dev/null) || exit 0
status=$(cat "$BAT/status" 2>/dev/null) || exit 0

if [[ "$capacity" -le "$THRESHOLD" && "$status" == "Discharging" ]]; then
    if [[ ! -f "$MARKER" ]]; then
        notify-send -u critical -a "Battery" "Battery Critical" "Battery at ${capacity}% — plug in soon"
        touch "$MARKER"
    fi
else
    rm -f "$MARKER"
fi
