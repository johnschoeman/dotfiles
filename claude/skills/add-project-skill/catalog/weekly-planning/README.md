# weekly-planning

Project-specific weekly planning session — review priorities, active work, and set focus for the week.

## Recommends when

Project has planning context (`.claude/docs/planning.md`) or periodic planning cadence. Useful when the global `/planning` skill needs project-specific focus areas, priority frameworks, or review steps.

## Detection hints

- `.claude/docs/planning.md` exists
- `tasks/` directory exists
- Weekly notes or planning artifacts exist in the repo

## Questions

1. **planning_context_path** — Where does this project's planning context live?
   - `.claude/docs/planning.md` — Standard location (default)
   - `custom` — Ask user for path

2. **focus_source** — Where are priorities/goals defined?
   - `planning-doc` — Inline in the planning context doc (default)
   - `tasks` — Derive from task board priority fields
   - `external` — Reference an external doc or system (ask for path/URL)
   - `custom` — Ask user to describe

3. **review_cadence** — What does a planning cycle look like?
   - `weekly` — Review and set focus each week (default)
   - `sprint` — 2-week sprint cycles
   - `monthly` — Monthly planning with weekly check-ins
   - `custom` — Ask user to describe

4. **extra_review_steps** — Any project-specific review steps?
   - `none` — Just priorities, active items, and alignment check (default)
   - `capacity` — Include capacity/workload assessment
   - `dependencies` — Check cross-project or external dependencies
   - `custom` — Ask user to describe

## Generated files

- `SKILL.md` — from `SKILL.md.template`
- `REFERENCE.md` — from `REFERENCE.md.template`
