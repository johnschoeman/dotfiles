# update-knowledge

Project-specific knowledge capture — what to persist, how to organize, and what categories matter.

## Recommends when

Any project with a `.claude/KNOWLEDGE.md` or where the default knowledge categories (Decisions, Learnings) don't fit. Useful when the project has domain-specific knowledge areas, stricter criteria for what's worth persisting, or a different file structure.

## Detection hints

- `.claude/KNOWLEDGE.md` exists
- `.claude/` directory exists
- Project has domain-specific terminology or conventions

## Questions

1. **categories** — What knowledge categories does this project use?
   - `default` — Decisions and Learnings (default)
   - `with-conventions` — Decisions, Learnings, and Conventions
   - `with-ops` — Decisions, Learnings, and Operational (IDs, URLs, config values)
   - `custom` — Ask user to list their categories

2. **capture_criteria** — What qualifies as knowledge worth persisting?
   - `standard` — Decisions with reasoning, discovered gotchas, repeated operational values (default)
   - `strict` — Only decisions and hard-won gotchas — skip anything derivable from code
   - `broad` — Include conventions, patterns, and team preferences
   - `custom` — Ask user to describe

3. **staleness_check** — Should the skill check for stale entries?
   - `yes` — Review existing entries and flag outdated ones (default)
   - `skip` — Just add new entries, don't review existing
   - `aggressive` — Actively prune entries that can be derived from current code

4. **after_update** — What to prompt after updating knowledge?
   - `nothing` — Just show what changed (default)
   - `commit` — Suggest committing the knowledge update
   - `session-log` — Suggest updating the session log too

## Generated files

- `SKILL.md` — from `SKILL.md.template`
