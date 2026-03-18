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

**Stale tasks** — tasks in the lowest status (e.g., "later") that haven't been modified recently:
- For each candidate, check last modification: `git log -1 --format=%ai -- <filepath>`
- Flag if last modified >30 days ago

**Overloaded** — too many tasks in active/now status:
- Flag if >3 tasks are in the highest active status

**Underloaded** — nothing prioritized:
- Flag if the active/now group is empty and there are tasks in next/queued

**Missing fields** — required fields from config that are empty:
- Check each task against configured fields
- Flag tasks with empty required fields

**Stalled** — tasks in "now" or active status but not recently modified:
- Flag if a now/active task hasn't been touched in >7 days

### 4. Present Findings

Group findings by category:

```
## Task Grooming

### Issues Found

**Stale (N):** Tasks sitting in <status> for a long time
- task-name.md — last modified YYYY-MM-DD
- ...

**Overloaded:** N tasks in <active status> (recommend ≤3)
- ...

**Missing Fields (N):**
- task-name.md — missing: field1, field2

### No Issues
- [categories with no problems]
```

### 5. Ask What to Do

For each issue category with findings, use `AskUserQuestion`:

- **Stale tasks:** Archive (move to done)? Promote? Leave as-is?
- **Overloaded:** Demote some tasks? Which ones?
- **Missing fields:** Fill in now? Skip?

Process one category at a time. Apply changes with `Edit` tool and `mv` for completions.

### 6. Summarize

After all categories processed:
- Count of changes made
- Current board state (brief)

## Notes

- This is interactive — don't auto-fix anything without asking
- Process categories in order: stale → overloaded → underloaded → missing fields → stalled
- If no issues found, say so and show a brief board summary
- Use `git log` sparingly — batch check modification dates
