---
name: task-groom
description: Review tasks for staleness, overload, and missing fields. Use when the user wants to groom, triage, or clean up their task board, or says "groom tasks".
---

# Groom Tasks

Analyze the task board for hygiene issues and guide the user through fixes.

## Process

### 1. Load Config

Read `.claude/docs/tasks.md` from the current repo root. If missing, bail with setup guidance.

### 2. Gather Task Data

Run the task list script:

```bash
python3 ~/.claude/skills/task-scripts/task-list.py
```

### 3. Analyze for Issues

Check for these categories:

**Stale tasks** — tasks that haven't been modified in a long time:
- For each task, check last modification: `git log -1 --format=%ai -- <filepath>`
- Flag if last modified >60 days ago

**Overloaded** — too many high-priority tasks:
- Flag if >3 tasks are high priority

**Missing fields** — required fields from config that are empty:
- Check each task against configured fields (priority)
- Flag tasks with empty required fields

### 4. Present Findings

Group findings by category:

```
## Task Grooming

### Issues Found

**Stale (N):** Tasks not modified in >60 days
- task-name.md — last modified YYYY-MM-DD

**Overloaded:** N high-priority tasks (recommend ≤3)
- ...

**Missing Fields (N):**
- task-name.md — missing: priority

### No Issues
- [categories with no problems]
```

### 5. Ask What to Do

For each issue category with findings, use `AskUserQuestion`:

- **Stale tasks:** Archive (move to _done)? Keep? Remove?
- **Overloaded:** Downgrade some tasks? Which ones?
- **Missing fields:** Fill in now? Skip?

Process one category at a time. Apply changes with `Edit` tool and `mv` for completions.

### 6. Summarize

After all categories processed:
- Count of changes made
- Current board state (brief)

## Notes

- This is interactive — don't auto-fix anything without asking
- Process categories in order: stale → overloaded → missing fields
- If no issues found, say so and show a brief board summary
- Use `git log` sparingly — batch check modification dates
<!-- catalog: task-groom v1 -->
