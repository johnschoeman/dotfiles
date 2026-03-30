# update-session-log

Project-specific session logging — capture context for cross-session continuity.

## Recommends when

Any project with active development. Useful when the project needs a different session log format, custom follow-up prompts, or specific sections to capture (e.g., time tracking, deployment notes).

## Detection hints

- `.claude/session-history/` directory exists
- Git repo with recent commits
- `.claude/` directory exists

## Questions

1. **log_path** — Where should session logs be stored?
   - `.claude/session-history/` — Standard location (default)
   - `custom` — Ask user for path

2. **entry_format** — What should each session entry capture?
   - `standard` — Thread, narrative, open items (default)
   - `minimal` — Just thread and open items, skip narrative
   - `detailed` — Include tradeoffs, rejected alternatives, surprises
   - `custom` — Ask user to describe their format

3. **follow_up** — What to prompt after writing the entry?
   - `log-time` — Suggest running `/log-time` (default)
   - `commit` — Suggest running `/commit`
   - `nothing` — Just show the entry
   - `custom` — Ask user what to suggest

4. **git_grounding** — Should the entry reference git state?
   - `yes` — Run `git diff --stat` and `git log --oneline -3` for grounding (default)
   - `skip` — Don't check git state (for non-code repos)

## Generated files

- `SKILL.md` — from `SKILL.md.template`
