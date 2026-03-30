# task-board

Project-specific task board display and next-work suggestions.

## Requires

- `.claude/docs/tasks.md` config (run `/setup-claude` first if missing)
- `task-list.py` script (ships with global skills at `~/.claude/skills/task-scripts/task-list.py`)

## Recommends when

Project has a `tasks/` directory or `.claude/docs/tasks.md` config. Useful when the default board display needs project-specific tweaks — custom grouping, different summary thresholds, or domain-specific next-work logic.

## Detection hints

- `.claude/docs/tasks.md` exists
- `tasks/` directory exists with `.md` files

## Questions

1. **display_style** — How should the board be displayed?
   - `default` — Group by status, show priority and key fields (default)
   - `compact` — One-line per task, minimal fields
   - `detailed` — Include notes/description snippets

2. **next_work_logic** — How should next-work suggestions be prioritized?
   - `priority-first` — Highest priority in active status (default)
   - `deadline-first` — Closest deadline, then priority
   - `blocked-aware` — Skip blocked tasks, suggest unblocked work
   - `custom` — Ask user to describe their logic

3. **large_group_threshold** — When to summarize instead of listing all tasks in a group?
   - `10` — Default, summarize groups with >10 items
   - `5` — Summarize earlier for tighter boards
   - `never` — Always list all tasks

## Generated files

- `SKILL.md` — from `SKILL.md.template`
