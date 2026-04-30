---
name: commit
description: Review git state and create a commit message. Writes to commit-msg.txt — never commits directly.
---

# Commit

Review git state and write a commit message to `commit-msg.txt`.

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

- What areas changed? (features, tests, config, docs, infrastructure)
- Why were these changes made? (infer from conversation context)
- Are there files to exclude? (drafts, `commit-msg.txt`, unrelated edits)

### 3. Write Commit Message

Fill in `TEMPLATE.md` from this skill directory.

**Formatting rules:**

- Title line: max **50 characters** (imperative mood, no period)
- Body text: wrap at **72 characters**

### 4. Write to File

Write the commit message to `commit-msg.txt` in the project root.

### 5. Deliver

Show the commit message, list files to stage, and remind:

> Commit message written to `commit-msg.txt`. You can commit with:
>
> ```bash
> git add <files> && git commit -F commit-msg.txt
> ```

## Notes

- Never run `git commit`, `git add`, or any git write commands directly
- For trivial changes (typos, one-line fixes), a title-only message is fine
- Always exclude `commit-msg.txt` from the staged files list
