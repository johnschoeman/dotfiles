#!/usr/bin/env bash
# Toggle GIF screen recording using wf-recorder + ffmpeg.
# First call: select region (or --fullscreen) and start recording.
# Second call: stop recording and convert to GIF.

PIDFILE="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/gif-record.pid"
OUTDIR="$HOME/Videos/recordings"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
MKVFILE="$OUTDIR/$TIMESTAMP.mkv"
GIFFILE="$OUTDIR/$TIMESTAMP.gif"

# Stop recording if already running
if [[ -f "$PIDFILE" ]]; then
    PID=$(cat "$PIDFILE")
    if kill -0 "$PID" 2>/dev/null; then
        kill -INT "$PID"
        wait "$PID" 2>/dev/null
    fi
    rm -f "$PIDFILE"

    # Read the mkv path stored alongside the PID
    MKVFILE=$(cat "${PIDFILE}.mkv")
    GIFFILE="${MKVFILE%.mkv}.gif"

    notify-send -a "Screen Record" "Converting to GIF..." "$MKVFILE"

    ffmpeg -y -i "$MKVFILE" \
        -vf "fps=15,scale=iw:-1:flags=lanczos,split[s0][s1];[s0]palettegen=max_colors=128[p];[s1][p]paletteuse=dither=bayer" \
        "$GIFFILE" 2>/dev/null

    rm -f "$MKVFILE" "${PIDFILE}.mkv"

    if [[ -f "$GIFFILE" ]]; then
        echo -n "$GIFFILE" | wl-copy
        notify-send -a "Screen Record" "GIF saved" "$GIFFILE (path copied)"
    else
        notify-send -u critical -a "Screen Record" "Conversion failed" "ffmpeg could not create GIF"
    fi
    exit 0
fi

# Start recording
mkdir -p "$OUTDIR"

if [[ "$1" == "--fullscreen" ]]; then
    MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
    GEOMETRY="--output=$MONITOR"
else
    REGION=$(slurp 2>/dev/null) || exit 0
    GEOMETRY="--geometry=$REGION"
fi

wf-recorder $GEOMETRY --file="$MKVFILE" &
RECPID=$!

echo "$RECPID" > "$PIDFILE"
echo "$MKVFILE" > "${PIDFILE}.mkv"

notify-send -a "Screen Record" "Recording started" "Press keybinding again to stop"
