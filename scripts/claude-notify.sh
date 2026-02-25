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

INPUT=$(cat)
TYPE=$(echo "$INPUT" | jq -r '.notification_type // "unknown"')
MESSAGE=$(echo "$INPUT" | jq -r '.message // ""')
CWD=$(echo "$INPUT" | jq -r '.cwd // "unknown"')
PROJECT=$(basename "$CWD")

# Encode path for attention marker: /home/john/dotfiles -> -home-john-dotfiles
ATTENTION_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/claude-attention"

case "$TYPE" in
    permission_prompt)
        mkdir -p "$ATTENTION_DIR"
        echo "$CWD" | tr '/' '-' | xargs -I{} touch "$ATTENTION_DIR/{}"
        notify-send -t 15000 -a "Claude Code" "Claude [$PROJECT]" "Needs Input"
        ;;
    *)
        notify-send -t 15000 -a "Claude Code" "Claude [$PROJECT]" "Task Complete"
        ;;
esac
