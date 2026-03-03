---
name: make-commit
description: Stage all changes, create a commit message following repository conventions, and commit. Use when the user wants a one-step commit, says "make commit", or wants to stage and commit everything.
---

# Make Commit

Review the current git state, create a commit message following repository conventions, then stage and commit.

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

### 5. Stage and Commit

Run `git add -A && git commit -F commit-msg.txt` to stage all changes and commit.

### 6. Show Result

Run `git log --oneline -1` and display the result to confirm the commit was created.

## Notes

- Run `git add -A` to stage all changes, then `git commit -F commit-msg.txt` to commit
- If no changes are staged or modified, inform the user
- For trivial changes (typos, minor tweaks), keep the message simple
- Don't include file lists in commit messages unless they add clarity
