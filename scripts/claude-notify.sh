#!/usr/bin/env bash
export PATH="/etc/profiles/per-user/john/bin:$PATH"

INPUT=$(cat)
TYPE=$(echo "$INPUT" | jq -r '.type // "unknown"')
PROJECT=$(echo "$INPUT" | jq -r '.cwd // "unknown"' | xargs basename)

if [ "$TYPE" = "permission_prompt" ]; then
    notify-send -t 30000 -u critical -a 'Claude Code' "Claude [$PROJECT] -  Needs permission"
else
    notify-send -t 15000 -a 'Claude Code' "Claude [$PROJECT] - Task complete"
fi
