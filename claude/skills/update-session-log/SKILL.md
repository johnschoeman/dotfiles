---
name: update-session-log
description: Capture session context for cross-session continuity. Run after significant work to record goals, tradeoffs, open threads, and surprises.
---

# Update Session Log

Write a structured entry in `.claude/SESSION_LOG.md` capturing context that helps future sessions pick up where this one left off.

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

### 3. Read Existing Log

Read `.claude/SESSION_LOG.md` to match the existing format and avoid duplicating recent entries.

If the file doesn't exist, create it with:

```markdown
# Session Log

Most recent first.

---
```

### 4. Write Entry

Add a new entry at the top (after the header). Use this format:

```markdown
## YYYY-MM-DD - [descriptive thread title]

**Thread:** [what we were trying to accomplish]

[Narrative of what happened — approach taken, tradeoffs, key findings]

**Open:** [incomplete threads, what to pick up next]
```

Adapt the format to match the repo's existing entries if they use a different structure.

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
