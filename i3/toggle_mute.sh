#!/usr/bin/bash

# toggle_mute.sh
#
# Toggle the audio mute.
#
# Usage:
#
# toggle_mute.sh

SINK=$(pactl list short sinks | grep RUNNING | awk '{print $2}')

# Check if we got a default sink
if [ -z "$SINK" ]; then
    echo "No active sink found."
    exit 1
fi

pactl set-sink-mute $SINK toggle

IS_MUTE=$(pactl get-sink-mute $SINK)

echo $IS_MUTE
