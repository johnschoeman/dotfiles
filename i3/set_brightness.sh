#!/bin/bash

# set_brightness.sh
#
# Set the screen brightness

# Ensure an argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <brightness>"
    echo "Brightness should be a value between 0.1 and 1.0."
    exit 1
fi

# Validate the brightness value
if (( $(echo "$1 < 0.1" | bc -l) )) || (( $(echo "$1 > 1.0" | bc -l) )); then
    echo "Brightness should be a value between 0.1 and 1.0."
    exit 1
fi

# Get the output name (usually something like 'eDP-1' or 'HDMI-1')
OUTPUT=$(xrandr | grep " connected" | awk '{ print $1 }')

# Get the current gamma value
CURRENT_GAMMA=$(xrandr --verbose | grep -m 1 -i gamma | awk '{ print $2 }')

# Extract individual gamma values and invert them
IFS=':' read -r R_GAMMA G_GAMMA B_GAMMA <<< "$CURRENT_GAMMA"
INVERTED_R_GAMMA=$(echo "1/$R_GAMMA" | bc -l)
INVERTED_G_GAMMA=$(echo "1/$G_GAMMA" | bc -l)
INVERTED_B_GAMMA=$(echo "1/$B_GAMMA" | bc -l)

# Set the brightness while keeping the inverted gamma values
xrandr --output $OUTPUT --gamma $INVERTED_R_GAMMA:$INVERTED_G_GAMMA:$INVERTED_B_GAMMA --brightness $1

echo "Brightness set to $1."
