#!/usr/bin/bash

# set_color_temp.sh
#
# Set the the screen gamma to be either warm, cool or neutral

# Ensure an argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 {warm|cool|neutral}"
    exit 1
fi

# Get the output name (usually something like 'eDP-1' or 'HDMI-1')
OUTPUT=$(xrandr | grep " connected" | awk '{ print $1 }')

# Get the current brightness value
CURRENT_BRIGHTNESS=$(xrandr --verbose | grep -m 1 -i brightness | awk '{ print $2 }')

# Check the argument and set the gamma value accordingly
if [ "$1" == "warm" ]; then
    xrandr --output $OUTPUT --gamma 1.0:0.8:0.7 --brightness $CURRENT_BRIGHTNESS
    echo "Set to warm color temperature."
elif [ "$1" == "cool" ]; then
    xrandr --output $OUTPUT --gamma 0.7:0.8:1.0 --brightness $CURRENT_BRIGHTNESS
    echo "Set to cool color temperature."
elif [ "$1" == "neutral" ]; then
    xrandr --output $OUTPUT --gamma 1.0:1.0:1.0 --brightness $CURRENT_BRIGHTNESS
    echo "Set to neutral color temperature."
else
    echo "Invalid argument. Use 'warm', 'cool', or 'neutral'."
    exit 1
fi
