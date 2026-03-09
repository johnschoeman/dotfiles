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

**Guidance for each field:**

- **Date:** Today's date (YYYY-MM-DD format)
- **Hours:** Estimate from session duration. Round to nearest 0.5h. If unclear, ask.
- **Initiative:** Match folder names in `~/workspace/evolv-notes/initiative-planning/initiatives/`, or use `learning` (personal projects, skill building) or `admin` (meetings, planning, misc overhead). Check existing timesheet entries for consistency.
- **Category:** One of `roadmap`, `stakeholder`, `reactive`, `learning` — matches capacity budget in priority framework
  - `roadmap` — Initiative work on the roadmap (claude-code-pilot, knowledge-hub, safety-governance, user-research)
  - `stakeholder` — Meetings, 1:1s, admin, planning
  - `reactive` — Quick wins, ad-hoc requests, office hours
  - `learning` — Personal skill building, tool exploration, training
- **Description:** Concise summary. Include key activities, not just initiative name.

### 4. Confirm and Append

After user confirms (or adjusts):

1. Read `~/workspace/evolv-notes/_daily/timesheet.md` to find the current month's table
2. Append the entry as a new row at the end of the current month's table (before the week totals section)
3. If the month section doesn't exist yet, create it with the table header:
   ```
   ### [Month Name]

   | Date       | Hours | Initiative | Category | Description                                     |
   | ---------- | ----- | ---------- | -------- | ----------------------------------------------- |
   | ...        | ...   | ...        | ...      | ...                                             |
   ```
4. Update the week totals if they exist — add hours to the current week's total, or create a new week entry

### 5. Ask About Other Work

After appending the entry, ask:

> Any other work today not captured here? (meetings, learning, work in other repos, etc.)
> Say "done" to skip.

If the user describes additional work:
- Propose another entry following the same format
- Repeat until user says "done" or skips

### 6. Summary

Show a brief summary:

```
Logged today:
- Xh: initiative (category) — description
- Yh: initiative (category) — description
Total: Zh

Week so far: [total]h / 20h target
```

## Table Format Reference

The timesheet table uses this exact format:

```
| Date       | Hours | Initiative | Category | Description                                     |
| ---------- | ----- | ---------- | -------- | ----------------------------------------------- |
```

- Date: `YYYY-MM-DD`
- Hours: number (0.5 increments)
- Initiative: lowercase, hyphenated (match existing entries)
- Category: `roadmap` | `stakeholder` | `reactive` | `learning`
- Description: free text, concise

## Valid Values

**Initiatives** (from `~/workspace/evolv-notes/initiative-planning/initiatives/`):
- `claude-code-pilot`, `knowledge-hub`, `safety-governance`, `ai-agent-pilot`, `user-research`
- `learning` — personal projects, skill building
- `admin` — meetings, planning, overhead

**Categories** (from priority framework):
- `roadmap` — initiative delivery work
- `stakeholder` — meetings, 1:1s, admin
- `reactive` — ad-hoc requests, quick wins
- `learning` — skill building, exploration
