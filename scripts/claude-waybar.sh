#!/usr/bin/env bash
# Waybar custom module: Claude Code session monitor
# Outputs JSON: {"text", "tooltip", "class"} every 3s via waybar interval

ATTENTION_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/claude-attention"

get_session_status() {
    local cwd="$1"
    # Encode path: /home/john/dotfiles -> -home-john-dotfiles
    local encoded
    encoded=$(echo "$cwd" | tr '/' '-')
    local project_dir="$HOME/.claude/projects/${encoded}"
    local marker="$ATTENTION_DIR/$encoded"

    [[ ! -d "$project_dir" ]] && echo "idle" && return

    # Find most recent .jsonl file
    local jsonl
    jsonl=$(ls -t "$project_dir"/*.jsonl 2>/dev/null | head -1)
    [[ -z "$jsonl" ]] && echo "idle" && return

    # Read last 20 lines, find last assistant or user event
    local last_type last_has_tool_use
    eval "$(tail -20 "$jsonl" | while IFS= read -r line; do echo "$line" | jq -r '
        select(.type == "assistant" or .type == "user") |
        "last_type=\(.type) last_has_tool_use=\(
            if .type == "assistant" then
                ([.message.content[]? | select(.type == "tool_use")] | length > 0)
            else false end
        )"' 2>/dev/null; done | tail -1)"

    if [[ "$last_type" == "assistant" && "$last_has_tool_use" == "true" ]]; then
        # Pending tool_use — check for attention marker from hook
        if [[ -f "$marker" ]]; then
            echo "attention"
        else
            echo "processing"
        fi
    elif [[ "$last_type" == "assistant" && "$last_has_tool_use" == "false" ]]; then
        # Session moved past tool_use — clean up stale marker
        rm -f "$marker"
        echo "idle"
    else
        # User event (tool_result or new message) — clean up stale marker
        rm -f "$marker"
        echo "processing"
    fi
}

# Find all claude processes
pids=$(pgrep -x claude 2>/dev/null)

if [[ -z "$pids" ]]; then
    echo '{"text": "", "tooltip": "", "class": "empty"}'
    exit 0
fi

idle_count=0
attention_count=0
processing_count=0
tooltip_lines=()

while IFS= read -r pid; do
    # Get project name from cwd
    cwd=$(readlink "/proc/$pid/cwd" 2>/dev/null) || continue
    project=$(basename "$cwd")

    status=$(get_session_status "$cwd")
    case "$status" in
        idle)       idle_count=$((idle_count + 1)) ;;
        attention)  attention_count=$((attention_count + 1)) ;;
        processing) processing_count=$((processing_count + 1)) ;;
    esac

    tooltip_lines+=("$project: $status")
done <<< "$pids"

total=$((idle_count + attention_count + processing_count))

if [[ $total -eq 0 ]]; then
    echo '{"text": "", "tooltip": "", "class": "empty"}'
    exit 0
fi

# Build text: idle processing attention counts
# Colored via Pango markup: idle=blue, attention=peach (only when > 0)
idle_text="<span color=\"#8caaee\">${idle_count}</span>"
if [[ $attention_count -gt 0 ]]; then
    attention_text="<span color=\"#ef9f76\">${attention_count}</span>"
else
    attention_text="0"
fi
text=" ${idle_text} ${processing_count} ${attention_text}"

# Build tooltip with jq for proper JSON escaping
tooltip=$(printf '%s\n' "${tooltip_lines[@]}")
jq -cn --arg text "$text" --arg tooltip "$tooltip" \
    '{text: $text, tooltip: $tooltip}'
