#!/usr/bin/bash

# set_vol.sh
#
# Set the current volume level

# Ensure an argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <volume>"
    echo "Volume should be a value between 0% and 100% or a increment between -10% and +10%"
    exit 1
fi

SINK=$(pactl list short sinks | grep RUNNING | awk '{print $2}')

# Check if we got a default sink
if [ -z "$SINK" ]; then
    echo "No active sink found."
    exit 1
fi

pactl set-sink-volume $SINK $1

VOLUME=$(pactl list sinks | grep -A 15 "$DEFAULT_SINK" | grep 'Volume:' | head -n 1 | awk '{print $5}')

echo "Volume set to $VOLUME"
