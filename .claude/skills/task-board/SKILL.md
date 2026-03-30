---
name: task-board
description: View open tasks grouped by priority with a next-work suggestion. Use when the user wants to see their task board, check what's active, asks "what's open", or says "show tasks".
---

# Task Board

Read-only view of all tasks, grouped by priority and sorted.

## Process

### 1. Load Config

Read `.claude/docs/tasks.md` from the current repo root. If missing, tell the user:

> No task config found. Run `/setup-claude` and add a `tasks.md` context file, or create `.claude/docs/tasks.md` manually.

### 2. Run Task List Script

```bash
python3 ~/.claude/skills/task-scripts/task-list.py
```

This returns compact JSON with all tasks grouped by priority, with counts.

### 3. Format and Display

Render the JSON output as a board:

```
## Task Board

### High (N)
- **Task Title** (filename.md)

### Medium (N)
- **Task Title** (filename.md)

### Low (N)
- **Task Title** (filename.md)

### Done Recently (last 7 days)
- **Task Title** — completed YYYY-MM-DD

---
**Counts:** N high · N medium · N low · N done recently
```

- Use `group_order` from config for section ordering (high, medium, low)
- If a group has >10 items, summarize by count instead of listing all

### 4. Suggest Next Work

Pick the highest-priority task and suggest it:
1. High priority tasks first
2. Then medium
3. Keep the suggestion to 1-2 sentences, actionable

## Notes

- This is read-only — do not modify any files
- Show the filename in parentheses for easy reference
- If the script errors, read task files directly as a fallback
<!-- catalog: task-board v1 -->
