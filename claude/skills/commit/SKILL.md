---
name: commit
description: Review git state and create a commit message following repository conventions. By default suggests only (writes commit-msg.txt). Pass --run to stage and commit. Use when the user wants to commit, says "commit", or asks for a commit message.
argument-hint: [--run]
---

# Commit

Review git state, create a commit message, and either suggest it or run the commit.

## Process

### 1. Gather Git State

Run in parallel:

```bash
git status
git diff --staged
git diff
git log --oneline -5
```

### 2. Analyze Changes

- What files are modified, added, or deleted?
- What is the nature of the changes? (new feature, fix, refactor, docs, etc.)
- Why were these changes made? (infer from context)
- Are there files to exclude? (runtime theme changes, secrets, unrelated edits)

If no changes are staged or modified, inform the user and stop.

### 3. Write Commit Message

Format:

```
<title - imperative mood, max 50 chars>

Why:

<brief motivation, wrap at 72 chars>

This commit:

- <bullet points of actual changes>
- <only uncommitted changes, not already-committed work>
```

**Title:** imperative mood, max 50 chars, no period, capitalize first letter.
**Body:** explain WHY not just WHAT, wrap at 72 chars, bullet points for multiple changes.

### 4. Write to File

Write the commit message to `commit-msg.txt` in the project root.

### 5. Deliver

**Default (no flag):** Show the commit message, list files to stage, and remind:

> Commit message written to `commit-msg.txt`. You can commit with:
> ```bash
> git add <files> && git commit -F commit-msg.txt
> ```

**With `--run` flag:** Check CLAUDE.md for git workflow instructions first. If it says the user manages commits (e.g., "never commit", "user manages all commits"), warn and fall back to suggest mode. Otherwise, run `git add -A && git commit -F commit-msg.txt`, then show `git log --oneline -1` to confirm.

## Notes

- For trivial changes (typos, minor tweaks), keep the message simple
- Don't include file lists in commit messages unless they add clarity
- Call out files that should be excluded from the commit (unrelated changes, secrets)
