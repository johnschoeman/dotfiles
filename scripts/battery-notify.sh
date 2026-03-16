#!/usr/bin/env bash
WARNING=20
CRITICAL=10
MARKER_WARN="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/battery-warn-notified"
MARKER_CRIT="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/battery-low-notified"
BAT="/sys/class/power_supply/BAT1"

capacity=$(cat "$BAT/capacity" 2>/dev/null) || exit 0
status=$(cat "$BAT/status" 2>/dev/null) || exit 0

if [[ "$status" != "Discharging" ]]; then
    rm -f "$MARKER_WARN" "$MARKER_CRIT"
    exit 0
fi

if [[ "$capacity" -le "$CRITICAL" ]]; then
    if [[ ! -f "$MARKER_CRIT" ]]; then
        notify-send -u critical -a "Battery" "Battery Critical" "Battery at ${capacity}% — plug in soon"
        touch "$MARKER_CRIT"
    fi
elif [[ "$capacity" -le "$WARNING" ]]; then
    if [[ ! -f "$MARKER_WARN" ]]; then
        notify-send -u normal -a "Battery" "Battery Low" "Battery at ${capacity}%"
        touch "$MARKER_WARN"
    fi
else
    rm -f "$MARKER_WARN" "$MARKER_CRIT"
fi
