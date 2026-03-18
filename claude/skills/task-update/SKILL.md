---
name: task-update
description: Update a task's status or fields — complete, promote, or edit. Use when the user wants to complete a task, change its status, update task fields, or says "task done". Pass a task name or search term as an argument.
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

Match the user's argument against the JSON results using the [search strategy](REFERENCE.md#search-strategy).

- **One match** → use it
- **Multiple matches** → present options via `AskUserQuestion`
- **No match** → tell the user and list open tasks

If no argument provided, list all non-done tasks and ask which to update.

### 3. Show Current State

Read the matched file and display:
- Title (from H1 heading)
- Current field values
- File path

### 4. Ask What to Change

Use `AskUserQuestion` with actions based on current state:

- **Complete it** — set status to done, add completed date
- **Promote status** — move to the next status level (e.g., later → next → now)
- **Start working** — set status to active/now
- **Edit other fields** — then ask which field and new value

### 5. Apply the Update

Use the `Edit` tool to modify the file in place.

**Completing a task:**
- Update status field to done/completed
- Set completed date to today (YYYY-MM-DD)
- Move file from tasks path to done path using `mv`

**Changing status:**
- Update the status field line

**Editing fields:**
- Update the specific field, validating against allowed values from config

### 6. Confirm

Display: what changed (old → new values), updated field summary.

## Notes

- Always read the file before editing to get exact text for the Edit tool
- Preserve all other fields unchanged
- When completing: update fields first, then move the file
- Check done directory too if no match in active tasks (user may want to reopen)
