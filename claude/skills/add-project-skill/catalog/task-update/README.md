# task-update

Project-specific task update and completion workflow.

## Requires

- `.claude/docs/tasks.md` config (run `/setup-claude` first if missing)
- `task-list.py` script (ships with global skills at `~/.claude/skills/task-scripts/task-list.py`)

## Recommends when

Project needs custom completion workflows — e.g., tasks should be archived differently, additional fields should be set on completion, or status transitions follow specific rules.

## Detection hints

- `.claude/docs/tasks.md` exists
- `tasks/` directory exists with `.md` files

## Questions

1. **completion_workflow** — What happens when a task is completed?
   - `move` — Set status to done, add completed date, move to done directory (default)
   - `mark-only` — Set status to done, add completed date, keep in place
   - `archive` — Move to done directory and add a summary note
   - `custom` — Ask user to describe

2. **status_transitions** — Are there rules about how status can change?
   - `free` — Any status can change to any other status (default)
   - `linear` — Must follow the order defined in config (later → next → now → done)
   - `custom` — Ask user to describe their rules

3. **completion_fields** — Any additional fields to set when completing a task?
   - `none` — Just status and completed date (default)
   - `outcome` — Add an outcome/result field
   - `time-spent` — Add time tracking
   - `custom` — Ask user what fields to add

## Generated files

- `SKILL.md` — from `SKILL.md.template`
- `REFERENCE.md` — from `REFERENCE.md.template`
