# today

Project-specific morning daily briefing — gather context and produce a focused plan for the day.

## Recommends when

Project has daily/weekly notes, active projects, or planning docs. Useful when the global `/today` needs different context sources, note formats, or output sections per project.

## Detection hints

- `.claude/docs/planning.md` exists
- Daily notes directory exists (e.g., `_daily/`, `daily/`, or Obsidian vault path)
- Weekly notes exist (e.g., `_daily/wk_*.md`)
- `tasks/` directory with status-tracked tasks
- `.claude/session-history/` with recent entries

## Questions

1. **daily_note_path** — Where do daily notes live and what's the filename pattern?
   - `custom` — Ask user for path and pattern (e.g., `_daily/dn_YYYY-MM-DD.md`)
   - No default — this is always project-specific

2. **weekly_note_path** — Where do weekly notes live?
   - `same-as-daily` — Same directory as daily notes with `wk_` prefix (default)
   - `none` — No weekly notes in this project
   - `custom` — Ask user for path and pattern

3. **context_sources** — What should the briefing read? (multi-select)
   - `planning-doc` — `.claude/docs/planning.md` priorities and active projects
   - `daily-notes` — Yesterday's daily note for carryover
   - `session-log` — Recent session history for continuity
   - `git-log` — Recent commits for what shipped
   - `tasks` — Task board for active/in-progress items
   - Default: all of the above

4. **output_sections** — What sections should the briefing include?
   - `full` — Intention, habits, must-dos, project work, stretch, yesterday, this week (default)
   - `minimal` — Just must-dos and project work
   - `no-habits` — Everything except habits tracking
   - `custom` — Ask user to describe their ideal briefing format

5. **intention_prompt** — Does the daily note have a reflection/intention field?
   - `yes` — Reflect it back and prompt if blank (default)
   - `no` — Skip the intention section

## Generated files

- `SKILL.md` — from `SKILL.md.template`
- `REFERENCE.md` — from `REFERENCE.md.template`
