#!/usr/bin/env bash
# Starship-inspired statusLine for Claude Code

# Read JSON input from stdin
input=$(cat)

# Extract values
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
model=$(echo "$input" | jq -r '.model.display_name')
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')
output_style=$(echo "$input" | jq -r '.output_style.name // "default"')

# Get directory name
dir=$(basename "$cwd")

# Get git branch if in a git repo
git_info=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git -C "$cwd" branch --show-current 2>/dev/null || echo "detached")

    # Check for changes (staged, unstaged, or untracked)
    if [ -n "$(git -C "$cwd" status --porcelain 2>/dev/null)" ]; then
        modified="*"
    else
        modified=""
    fi

    if [ -n "$modified" ]; then
        git_info=" \033[2;35m$branch$modified\033[0m"
    else
        git_info=" \033[2;34m$branch\033[0m"
    fi
fi

# Context info (only show if available)
context_info=""
if [ -n "$remaining" ]; then
    # Color code based on remaining percentage
    if (( $(echo "$remaining < 20" | bc -l) )); then
        color="\033[2;31m"  # Red for low
    elif (( $(echo "$remaining < 50" | bc -l) )); then
        color="\033[2;33m"  # Yellow for medium
    else
        color="\033[2;32m"  # Green for plenty
    fi
    context_info=" ${color}ctx:${remaining}%"
fi

# Output style indicator (if not default)
style_info=""
if [ "$output_style" != "default" ]; then
    style_info=" \033[2;36m[$output_style]\033[0m"
fi

# Build and output the status line
printf "\033[2;34m%s/\033[0m%b \033[2;36m%s\033[0m%b%b" \
    "$dir" \
    "$git_info" \
    "$model" \
    "$context_info" \
    "$style_info"
