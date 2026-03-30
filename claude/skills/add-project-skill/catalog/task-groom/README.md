# task-groom

Project-specific task grooming rules and thresholds.

## Requires

- `.claude/docs/tasks.md` config (run `/setup-claude` first if missing)
- `task-list.py` script (ships with global skills at `~/.claude/skills/task-scripts/task-list.py`)

## Recommends when

Project has tasks and the default grooming thresholds don't fit — e.g., long-running research tasks shouldn't be flagged as stale at 30 days, or the team's WIP limit differs from the default 3.

## Detection hints

- `.claude/docs/tasks.md` exists
- `tasks/` directory exists with `.md` files

## Questions

1. **stale_days** — How many days before a low-priority task is considered stale?
   - `30` — Default
   - `14` — Aggressive, for fast-moving projects
   - `60` — Relaxed, for projects with long-term backlog items
   - `custom` — Ask user for a number

2. **wip_limit** — Max tasks in active/now status before flagging overload?
   - `3` — Default
   - `5` — For projects with many parallel streams
   - `1` — Strict single-tasking
   - `custom` — Ask user for a number

3. **stalled_days** — How many days before an active task is flagged as stalled?
   - `7` — Default
   - `3` — Aggressive
   - `14` — Relaxed
   - `custom` — Ask user for a number

4. **extra_checks** — Any additional grooming checks for this project?
   - `none` — Just the defaults (default)
   - `missing-fields` — Flag tasks with empty required fields
   - `duplicates` — Check for duplicate/overlapping tasks
   - `custom` — Ask user to describe

## Generated files

- `SKILL.md` — from `SKILL.md.template`
