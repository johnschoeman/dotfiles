#!/usr/bin/env bash
# Waybar custom module: Claude Code session monitor
# Outputs JSON: {"text", "tooltip", "class"} every 3s via waybar interval

ATTENTION_FILE="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/claude-waybar-attention"

# Find all claude processes
pids=$(pgrep -x claude 2>/dev/null)

if [[ -z "$pids" ]]; then
    echo '{"text": "", "tooltip": "", "class": "empty"}'
    exit 0
fi

# Read attention PIDs (if file exists)
declare -A attention_pids
if [[ -f "$ATTENTION_FILE" ]]; then
    while IFS= read -r pid; do
        [[ -n "$pid" ]] && attention_pids["$pid"]=1
    done < "$ATTENTION_FILE"
fi

count=0
tooltip_lines=()
has_processing=false
has_attention=false

while IFS= read -r pid; do
    # Get project name from cwd
    cwd=$(readlink "/proc/$pid/cwd" 2>/dev/null) || continue
    project=$(basename "$cwd")
    count=$((count + 1))

    # Determine status via CPU usage
    cpu=$(ps -p "$pid" -o %cpu= 2>/dev/null | tr -d ' ')
    cpu_int=${cpu%.*}

    if [[ -n "${attention_pids[$pid]}" ]]; then
        status="attention"
        has_attention=true
    elif [[ "$cpu_int" -ge 2 ]]; then
        status="processing"
        has_processing=true
    else
        status="idle"
    fi

    tooltip_lines+=("$project: $status")
done <<< "$pids"

if [[ $count -eq 0 ]]; then
    echo '{"text": "", "tooltip": "", "class": "empty"}'
    exit 0
fi

# Determine overall class
if $has_attention; then
    class="attention"
elif $has_processing; then
    class="processing"
else
    class="idle"
fi

# Build tooltip with jq for proper JSON escaping
tooltip=$(printf '%s\n' "${tooltip_lines[@]}")
jq -cn --arg text " $count" --arg tooltip "$tooltip" --arg class "$class" \
    '{text: $text, tooltip: $tooltip, class: $class}'
