---
name: task-board
description: View open tasks grouped by status with a next-work suggestion. Use when the user wants to see their task board, check what's active, asks "what's open", or says "show tasks".
---

# Task Board

Read-only view of all tasks, grouped by status and sorted by priority.

## Process

### 1. Load Config

Read `.claude/docs/tasks.md` from the current repo root. If missing, tell the user:

> No task config found. Run `/setup-claude` and add a `tasks.md` context file, or create `.claude/docs/tasks.md` manually.

### 2. Run Task List Script

```bash
python3 ~/.claude/skills/task-scripts/task-list.py
```

This returns compact JSON with all tasks grouped by status, sorted by priority, with counts.

### 3. Format and Display

Render the JSON output as a board. Use `task_line` from config if set, otherwise default format:

```
## Task Board

### <Group Name> (N)
- **Task Title** — field1 · field2 (filename.md)

### <Next Group> (N)
...

### Done Recently (last N days)
- **Task Title** — completed YYYY-MM-DD

---
**Counts:** N group1 · N group2 · ... · N done recently (N total done)
```

**Adapt to the config:**
- Use `group_order` from config (or field values) for section ordering
- Use field names from config for the detail line
- If a group has >10 items, summarize by a secondary field (e.g., initiative counts) instead of listing all

### 4. Suggest Next Work

Consider:
1. Active/now tasks should be finished first
2. Then next-priority tasks by priority (high > medium > low)
3. Keep the suggestion to 1-2 sentences, actionable

## Notes

- This is read-only — do not modify any files
- Show the filename in parentheses for easy reference
- If the script errors, read task files directly as a fallback
