# task-plan

Project-specific task planning and breakdown conventions.

## Requires

- `.claude/docs/tasks.md` config (run `/setup-claude` first if missing)
- `task-list.py` script (ships with global skills at `~/.claude/skills/task-scripts/task-list.py`)

## Recommends when

Project needs customized task breakdown rules — different sizing guidance, domain-specific categories, or a particular planning input format (PRDs, GitHub issues, etc.).

## Detection hints

- `.claude/docs/tasks.md` exists
- `tasks/` directory exists

## Questions

1. **sizing** — How granular should tasks be?
   - `default` — 15 min to 1 day per task (default)
   - `fine` — Small tasks, each under a few hours
   - `coarse` — Larger chunks, multi-day tasks are OK
   - `custom` — Ask user to describe

2. **batch_size** — How many tasks per planning session?
   - `3-8` — Default range
   - `1-3` — Focused, minimal planning
   - `5-15` — Larger project breakdowns
   - `custom` — Ask user for range

3. **default_status** — What status should new tasks start at?
   - `auto` — Use the lowest non-done status from config (default)
   - `custom` — Ask user which status

4. **input_sources** — What formats does this project plan from?
   - `any` — Files, URLs, pasted text, descriptions (default)
   - `prd` — Primarily from PRD/spec documents
   - `issues` — Primarily from GitHub/Linear issues
   - `custom` — Ask user to describe

## Generated files

- `SKILL.md` — from `SKILL.md.template`
- `REFERENCE.md` — from `REFERENCE.md.template`
