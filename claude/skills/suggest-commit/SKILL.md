---
name: suggest-commit
description: Review git status and create a suggested commit message following the repository conventions. Use when the user wants to commit, says "suggest commit", or asks for a commit message.
disable-model-invocation: true
---

# Suggest Commit Message

Review the current git state and create a commit message following repository conventions.

## Process

### 1. Gather Git State

Run these commands to understand what's being committed:

```bash
git status
```

```bash
git diff --staged
```

```bash
git diff
```

```bash
git log --oneline -5
```

### 2. Analyze Changes

- What files are modified, added, or deleted?
- What is the nature of the changes? (new feature, fix, refactor, docs, etc.)
- Why were these changes made? (infer from context)

### 3. Write Commit Message

Follow this format:

```
<title - imperative mood, max 50 chars>

Why:

<why paragraph - briefly explain the why, wrap at 72 chars>

This commit:

- <bullet points of actual changes>
- <only include uncommitted changes, not already-committed work>
```

**Title rules:**
- Imperative mood ("Add feature" not "Added feature")
- Max 50 characters
- No period at end
- Capitalize first letter

**Body rules:**
- Explain WHY the change was made, not just WHAT changed
- Wrap lines at 72 characters
- Use bullet points for multiple changes
- Reference related context if helpful

### 4. Write to File

Write the commit message to `commit-msg.txt` in the project root.

### 5. Display and Remind

Show the commit message and tell the user:

"Commit message written to `commit-msg.txt`. You can commit with:
```bash
git add -A && git commit -F commit-msg.txt
```"

## Notes

- Never run `git commit` directly - user manages commits
- If no changes are staged or modified, inform the user
- For trivial changes (typos, minor tweaks), keep the message simple
- Don't include file lists in commit messages unless they add clarity
