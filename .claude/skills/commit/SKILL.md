---
name: commit
description: Review git state and create a commit message following repository conventions. Always suggest-only — writes to commit-msg.txt, never commits directly. Use when the user wants to commit, says "commit", or asks for a commit message.
argument-hint: [--run]
---

# Commit

Review git state and write a commit message to `commit-msg.txt`. This repo's policy is **user-managed commits** — this skill always operates in suggest mode, even with `--run`.

## Process

### 1. Gather Git State

Run in parallel:

```bash
git status
git diff --staged
git diff
git log --oneline -5
```

If no changes are staged or modified, inform the user and stop.

### 2. Analyze Changes

- What files are modified, added, or deleted?
- What is the nature of the changes? (new feature, fix, refactor, docs, etc.)
- Why were these changes made? (infer from context)
- Are there files to exclude? (runtime theme changes, `commit-msg.txt`, unrelated edits)

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

**Title:** imperative mood, max 50 chars, no period, capitalize first letter. No prefix — just a clear summary.

**Body:** explain WHY not just WHAT, wrap at 72 chars, bullet points for multiple changes.

### 4. Write to File

Write the commit message to `commit-msg.txt` in the project root.

### 5. Deliver

Show the commit message, list files to stage, and remind:

> Commit message written to `commit-msg.txt`. You can commit with:
> ```bash
> git add <files> && git commit -F commit-msg.txt
> ```

Call out any files that should be excluded from the commit.

## Notes

- Never run `git commit`, `git add`, or any git write commands directly
- For trivial changes (typos, one-line fixes), a title-only message is fine
- Always exclude `commit-msg.txt` from the staged files list
- Don't include file lists in commit messages unless they add clarity
<!-- catalog: commit v1 -->
