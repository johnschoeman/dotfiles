#!/usr/bin/env bash
# PreToolUse hook: blocks dangerous git commands before execution.
# Installed by /setup-repo. Runs on every Bash tool call.

set -euo pipefail

COMMAND=$(echo "$TOOL_INPUT" | jq -r '.command // empty')
[ -z "$COMMAND" ] && exit 0

# Patterns that should never run without explicit user action
BLOCKED_PATTERNS=(
  'git push'
  'git reset --hard'
  'git clean -f'
  'git branch -D'
  'git branch --delete --force'
  'git checkout \.'
  'git restore \.'
  'git stash drop'
  'git stash clear'
  'git rebase --abort'
)

for pattern in "${BLOCKED_PATTERNS[@]}"; do
  if echo "$COMMAND" | grep -qE "$pattern"; then
    echo "BLOCKED: '$pattern' is not allowed. Run this command yourself if intended."
    exit 2
  fi
done

exit 0
