# wrap-day

Project-specific end-of-day close-out — walk through daily note, complete habits/tasks, capture reflection, carry forward incomplete items.

## Recommends when

Project uses daily notes or has a daily cadence of tracked habits, tasks, or time entries. Especially useful when the project's daily note template or section types differ from the global default.

## Detection hints

- `.claude/docs/close-day.md` exists
- Daily notes directory exists (e.g., `daily/`, `journal/`, or an Obsidian vault path)
- Project has habits, checklists, or time-tracking sections in daily notes

## Questions

1. **daily_note_path** — Where do daily notes live?
   - `custom` — Ask user for path pattern (e.g., `~/vault/daily/YYYY-MM-DD.md`)
   - No default — this is always project-specific

2. **daily_note_template** — Path to the daily note template?
   - `custom` — Ask user for template path
   - No default — this is always project-specific

3. **sections** — What sections does the daily note have? (ask user to list them with types)
   - Types: `checklist`, `task-review`, `freeform`, `time-entry`, `timesheet`
   - Ask the user to describe their daily note sections and map each to a type

4. **carryover** — What happens to incomplete items?
   - `next-day` — Carry forward to tomorrow's daily note (default)
   - `task-board` — Move to the task board instead
   - `skip` — Don't carry forward, just flag them
   - `custom` — Ask user to describe

5. **follow_up** — What to prompt at the end?
   - `session-log` — Suggest running `/update-session-log` (default)
   - `commit` — Suggest running `/commit`
   - `none` — Just show the summary
   - `custom` — Ask user what to suggest

## Generated files

- `SKILL.md` — from `SKILL.md.template`
