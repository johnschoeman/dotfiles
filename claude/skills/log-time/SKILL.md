---
name: log-time
description: Log time for the current session. Examines git commits, session context, and conversation to propose timesheet entries. Use at end of a work session.
---

# Log Time

End-of-session skill. Propose a timesheet entry based on evidence, get user confirmation, append to timesheet.

**This skill writes to the evolv-notes timesheet regardless of which repo you're in.** The timesheet is a single centralized file — all time is tracked by initiative/category, not by repo.

## Paths

- **Timesheet:** `~/workspace/evolv-notes/_daily/timesheet.md`
- **Initiatives:** `~/workspace/evolv-notes/initiative-planning/initiatives/`
- **Priority framework:** `~/workspace/evolv-notes/_plans/priority-framework.md`
- **Session history:** `.claude/session-history/` (in the current repo)

## Process

### 1. Gather Evidence

Collect activity signals from the current session:

**Git commits (primary signal) — current repo:**
```bash
git log --since="12 hours ago" --format="%ad | %s" --date=short
```

If no commits today, try the last 3 days:
```bash
git log --since="3 days ago" --format="%ad | %s" --date=short
```

**Session context:**
- Review the current conversation — what was the goal, what was accomplished?
- Check `.claude/session-history/` in the current repo for today's entries if they exist

**Other repos (if relevant):**
Check companion workspaces if mentioned in conversation:
```bash
git -C ~/workspace/evolv-notes log --since="12 hours ago" --format="%ad | %s" --date=short 2>/dev/null
git -C ~/workspace/notes log --since="12 hours ago" --format="%ad | %s" --date=short 2>/dev/null
```
Skip any repo that matches the current working directory (already checked above).

### 2. Read Current Timesheet

Read `~/workspace/evolv-notes/_daily/timesheet.md` to understand:
- Today's date and what's already logged
- The current month's table location (append target)
- Existing initiative and category values for consistency

### 3. Propose Entry

Present a proposed entry to the user:

```
Proposed timesheet entry:

| Date       | Hours | Initiative        | Category | Description                          |
| ---------- | ----- | ----------------- | -------- | ------------------------------------ |
| YYYY-MM-DD | X     | initiative-name   | category | Concise description of work done     |

Based on:
- [evidence summary — commits, conversation topics, etc.]

Does this look right? Adjust hours, initiative, category, or description?
```

**Field guidance:**
- **Date:** Today's date (YYYY-MM-DD)
- **Hours:** Estimate from session duration. Round to nearest 0.5h. If unclear, ask.
- **Initiative:** Match folder names in initiatives dir, or use `learning`/`admin`
- **Category:** `roadmap` | `stakeholder` | `reactive` | `learning`
- **Description:** Concise summary of key activities

### 4-6. Confirm, Follow-up, Summary

After user confirms, append to timesheet, ask about other work, then show summary. See [REFERENCE.md](REFERENCE.md) for detailed steps, table format, and valid values.
