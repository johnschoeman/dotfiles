# weekly-review

Project-specific weekly review — reflect on what happened, capture learnings, and close out the week.

## Recommends when

Project has active work tracked over time. Complements `weekly-planning` — planning looks forward, review looks back. Useful when the project needs structured reflection, progress tracking, or knowledge capture at a weekly cadence.

## Detection hints

- `.claude/docs/planning.md` exists
- `tasks/` directory with completed tasks in `_done/`
- Session logs or daily notes exist
- Git history shows regular activity

## Questions

1. **review_sources** — What should the review examine?
   - `git-and-tasks` — Git commits + task completions this week (default)
   - `git-only` — Just git history (for repos without task tracking)
   - `tasks-only` — Just task board changes
   - `custom` — Ask user what to review

2. **reflection_style** — How deep should the reflection be?
   - `brief` — What happened, what's next (default)
   - `structured` — What went well, what didn't, what to change
   - `metrics` — Include counts (commits, tasks completed, PRs merged)
   - `custom` — Ask user to describe

3. **output_location** — Where should the review be saved?
   - `stdout` — Display only, don't save (default)
   - `weekly-note` — Write to a weekly notes file (ask for path pattern)
   - `planning-doc` — Append to planning context doc
   - `custom` — Ask user where

4. **knowledge_capture** — Should the review update project knowledge?
   - `suggest` — Flag learnings and ask before saving (default)
   - `auto` — Automatically update `.claude/KNOWLEDGE.md`
   - `skip` — Don't touch knowledge files

## Generated files

- `SKILL.md` — from `SKILL.md.template`
