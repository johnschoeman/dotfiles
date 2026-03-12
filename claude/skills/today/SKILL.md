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

From the planning doc's **Focus** section, read the referenced plan and goals documents (e.g., `_2026-plan.md`, `_goals.md`).

Extract:
- North Star (primary yearly focus)
- Foundations (supporting priorities)
- Current quarter focus if available

### 3. Find Today's Daily Note

Calculate today's date. Look for `_daily/dn_YYYY-MM-DD.md`.

**If it exists:** Read it. Note any items already filled in:
- "Who do I want to be today?" intention
- Habit checklist items (the `- [ ]` items before the first `---` separator after the intention)
- Minimum section items
- Killing It section items

**If it doesn't exist:** Note this — will prompt the user in the output.

### 4. Find Yesterday's Daily Note

Find the most recent `_daily/dn_*.md` before today (not in `_archive/`). Read it.

Extract:
- Completed items (`- [x]`)
- Uncompleted items (`- [ ]`) that may need to carry forward
- Notes section content
- Intention if filled in

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
- Read the file
- Extract project name (from H1 heading)
- Extract incomplete Next Actions (`- [ ]` items from the `## Next Actions` section)
- Note the project's domains

Skip the template file (`_project_template.md`).

**Task files:** Read all files in `tasks/` with frontmatter `status: this-week` or `status: in-progress`. These are the active task items to include in today's plan alongside project next actions. Note each task's domain and priority for ranking.

### 7. Rank and Output

Produce the daily briefing. Rank project actions by alignment with current weekly intentions and North Star priorities.

## Output Format

Print to conversation (never write to files):

```
## Today — [Day of Week], [Month Day, Year]

### Intention
[If today's note has "Who do I want to be today?" filled in, reflect it back]
[If blank or no daily note: "Your intention is blank — take a moment to fill in 'Who do I want to be today?' in your daily note."]

### Today's Plan

**Habits**
- [ ] [habit items from daily note template — track weight, water, meds, etc.]

**Must-dos** (from daily note Minimum section + weekly action items due)
- [ ] [items from Minimum section]
- [ ] [relevant weekly action items]

**Project work** (ranked by priority alignment)
- **[Project Name]**: [specific next action from project file]
- **[Project Name]**: [specific next action]
[Include 2-4 most aligned project actions, not exhaustive list]

**Stretch** (from Killing It section + lower-priority items)
- [ ] [items from Killing It if any]

### Yesterday
[What got done (completed items), what didn't (uncompleted items worth noting), any reflections from notes]
[Flag items that should carry forward to today]

### This Week
[From weekly note — current intentions/priorities, relevant incomplete action items]
[Note any red flags flagged in the weekly review]
```

## Tone

- Brief and actionable — this is a morning kickstart, not a report
- Present tense, forward-looking
- Flag carryover items from yesterday without judgment
- If daily note is missing, say so simply and suggest creating one
- Don't repeat the full project descriptions — just names and next actions
- If a section has no content (e.g., no Killing It items), omit it rather than showing empty sections
