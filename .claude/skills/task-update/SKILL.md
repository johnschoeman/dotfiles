---
name: task-update
description: Update a task's priority or complete it. Use when the user wants to complete a task, change its priority, or says "task done". Pass a task name or search term as an argument.
argument-hint: [task name or search term]
---

# Update Task

Find a task by name and update its fields.

## Process

### 1. Load Config

Read `.claude/docs/tasks.md` from the current repo root. If missing, bail with setup guidance.

### 2. Find the Task

Run the task list script to get all tasks:

```bash
python3 ~/.claude/skills/task-scripts/task-list.py
```

Match the user's argument against task filenames and titles:

1. **Exact filename** — argument matches filename minus `.md` extension
2. **Filename contains all words** — all search words appear in the filename
3. **Title contains all words** — all search words appear in the H1 title
4. **Any word match** — filename or title contains any search word

- **One match** → use it
- **Multiple matches** → present options via `AskUserQuestion`
- **No match** → tell the user and list open tasks

If no argument provided, list all tasks and ask which to update.

### 3. Show Current State

Read the matched file and display:
- Title (from H1 heading)
- Current priority
- File path

### 4. Ask What to Change

Use `AskUserQuestion` with actions based on current state:

- **Complete it** — move to `tasks/_done/`
- **Change priority** — high, medium, or low
- **Edit other fields** — then ask which field and new value

### 5. Apply the Update

Use the `Edit` tool to modify the file in place.

**Completing a task:**
- Move file from `tasks/` to `tasks/_done/` using `mv`

**Changing priority:**
- Update the `## Priority:` line

### 6. Confirm

Display: what changed (old → new values).

## Notes

- Always read the file before editing to get exact text for the Edit tool
- Preserve all other content unchanged
- When completing: move the file after any field updates
- Check `tasks/_done/` too if no match in active tasks (user may want to reopen)
<!-- catalog: task-update v1 -->
