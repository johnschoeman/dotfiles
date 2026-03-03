---
name: update-session-log
description: Capture session context for cross-session continuity. Run after significant work to record goals, tradeoffs, open threads, and surprises.
---

# Update Session Log

Write a structured entry in `.claude/session-history/YYYY-MM-DD.md` capturing context that helps future sessions pick up where this one left off.

## Process

### 1. Review the Session

Look back through the conversation to understand:
- What was the goal or thread?
- What happened — what approach was taken, what tradeoffs were made?
- What alternatives were considered and rejected?
- What's left incomplete or unresolved?
- Any surprises or learnings?

### 2. Check Git State

Run `git diff --stat` and `git log --oneline -3` to see what concrete changes were made. This grounds the entry in reality, but the entry itself should not be a change list.

### 3. Read Recent History

Create `.claude/session-history/` if it doesn't exist.

Read today's file at `.claude/session-history/YYYY-MM-DD.md` if it exists — you'll append to it (multiple sessions per day are normal).

Also read the most recent 2-3 files in `.claude/session-history/` for continuity context and to avoid duplicating recent entries.

### 4. Write Entry

Write to `.claude/session-history/YYYY-MM-DD.md`.

If creating a new file, start with a date header:

```markdown
# YYYY-MM-DD

```

Then append the entry (whether the file is new or existing):

```markdown
## [descriptive thread title]

**Thread:** [what we were trying to accomplish]

[Narrative of what happened — approach taken, tradeoffs, key findings]

**Open:** [incomplete threads, what to pick up next]
```

### 5. Show the User

Display the entry you wrote so they can review it.

## What to Capture

- Session goal / thread — what were we trying to accomplish?
- Tradeoffs and rejected alternatives — "we considered X but went with Y because..."
- Open threads — what's left incomplete, what to pick up next
- Surprises / learnings — things discovered during the session

## What NOT to Capture

- File-by-file change lists (git history covers this)
- Implementation details (code + commits cover this)
- Stable decisions or knowledge (belongs in KNOWLEDGE.md)
