#!/usr/bin/env bash
# Claude Code notification hook
# https://docs.anthropic.com/en/docs/claude-code/hooks
#
# JSON fields available:
#   session_id        - current session identifier
#   transcript_path   - path to conversation transcript
#   cwd               - current working directory
#   permission_mode   - default, plan, acceptEdits, dontAsk, bypassPermissions
#   hook_event_name   - always "Notification" for this hook
#   message           - notification text content
#   title             - notification title (optional)
#   notification_type - permission_prompt, idle_prompt, auth_success, elicitation_dialog

export PATH="/etc/profiles/per-user/john/bin:$PATH"

ATTENTION_FILE="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/claude-waybar-attention"

INPUT=$(cat)
TYPE=$(echo "$INPUT" | jq -r '.notification_type // "unknown"')
MESSAGE=$(echo "$INPUT" | jq -r '.message // ""')
PROJECT=$(echo "$INPUT" | jq -r '.cwd // "unknown"' | xargs basename)

# Find the parent claude process by walking up the PPID chain
find_claude_pid() {
    local pid=$$
    while [[ "$pid" -gt 1 ]]; do
        local name
        name=$(ps -p "$pid" -o comm= 2>/dev/null) || break
        if [[ "$name" == "claude" ]]; then
            echo "$pid"
            return
        fi
        pid=$(ps -p "$pid" -o ppid= 2>/dev/null | tr -d ' ') || break
    done
}

add_attention() {
    local claude_pid
    claude_pid=$(find_claude_pid)
    if [[ -n "$claude_pid" ]]; then
        # Append PID if not already present
        if ! grep -qx "$claude_pid" "$ATTENTION_FILE" 2>/dev/null; then
            echo "$claude_pid" >> "$ATTENTION_FILE"
        fi
    fi
}

remove_attention() {
    local claude_pid
    claude_pid=$(find_claude_pid)
    if [[ -n "$claude_pid" && -f "$ATTENTION_FILE" ]]; then
        grep -vx "$claude_pid" "$ATTENTION_FILE" > "${ATTENTION_FILE}.tmp" 2>/dev/null
        mv "${ATTENTION_FILE}.tmp" "$ATTENTION_FILE" 2>/dev/null
        # Clean up empty file
        [[ ! -s "$ATTENTION_FILE" ]] && rm -f "$ATTENTION_FILE"
    fi
}

case "$TYPE" in
    permission_prompt)
        add_attention
        notify-send -t 30000 -u critical -a "Claude Code" "Claude Code" "[$PROJECT] - Needs permission"
        ;;
    *)
        remove_attention
        notify-send -t 15000 -a "Claude Code" "Claude Code" "[$PROJECT] - $MESSAGE"
        ;;
esac
