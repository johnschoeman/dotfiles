---
name: today
description: Morning daily briefing — reads active projects, yesterday's context, today's daily note, and weekly priorities to produce a focused, prioritized plan for the day. Use when starting the day, saying "today", or wanting a morning plan.
---

# Today — Daily Briefing

Read-only morning command. Gathers context from planning docs, daily/weekly notes, and active projects, then outputs a concise daily plan. Does not modify any files.

## Process

### 1. Load Planning Context

Read `.claude/docs/planning.md` in the current repository.

**If missing**, tell the user:

> No planning context found. `/today` needs `.claude/docs/planning.md` to know where your planning files live.

Then stop.

### 2. Read Focus & Priorities

From the planning doc's **Focus** section, read the referenced plan and goals documents.

Extract:
- North Star (primary yearly focus)
- Foundations (supporting priorities)
- Current quarter focus if available

### 3. Find Today's Daily Note

Calculate today's date. Look for `_daily/dn_YYYY-MM-DD.md`.

**If it exists:** Read it. Note any items already filled in (intention, habits, minimum, killing it).

**If it doesn't exist:** Note this — will prompt the user in the output.

### 4. Find Yesterday's Daily Note

Find the most recent `_daily/dn_*.md` before today (not in `_archive/`). Read it.

Extract:
- Completed items (`- [x]`)
- Uncompleted items (`- [ ]`) that may need to carry forward
- Notes section content

### 4a. Read Previous Day's Session Log

Find the most recent `.claude/session-history/*.md` file before today. Read it.

Extract:
- Session summaries (H2 headings = what was worked on)
- Open threads / items left incomplete (look for **Open:** sections)
- Key decisions, artifacts created, or tasks created

If no session log exists, skip.

### 4b. Read Recent Git History

Run `git log --since="yesterday" --oneline` to get recent commits. Summarize briefly. If none, skip.

### 5. Find Latest Weekly Note

Find the most recent `_daily/wk_*.md`. Read it.

Extract:
- Next Week Intentions (or current week intentions)
- Action Items (incomplete ones)
- Red Flags
- Priority ratings (brief summary)

### 6. Read Active Projects and Task Files

**Projects:** From the planning doc's **Active items** section, find projects matching the active criteria (typically `status: now` in frontmatter).

For each active project:
- Extract project name (from H1 heading)
- Extract incomplete Next Actions (`- [ ]` from `## Next Actions`)
- Note the project's domains

Skip `_project_template.md`.

**Task files:** Read all files in `tasks/` with frontmatter `status: this-week` or `status: in-progress`. Note each task's domain and priority for ranking.

### 7. Rank and Output

Produce the daily briefing. Rank project actions by alignment with current weekly intentions and North Star priorities.

Use the [output format](REFERENCE.md#output-format) and [tone guidance](REFERENCE.md#tone) from REFERENCE.md.
