# wrap-session

Project-specific end-of-session wrap-up — capture session context, persist knowledge, and suggest a commit.

## Recommends when

Any project with active development. Useful when the project has specific git policies (suggest-only vs auto-commit), different knowledge update criteria, or should skip certain wrap-up steps.

## Detection hints

- Git repo with recent commits
- `.claude/session-history/` directory exists
- `.claude/KNOWLEDGE.md` exists

## Questions

1. **session_log** — Should the wrap-up capture a session log?
   - `yes` — Write to `.claude/session-history/YYYY-MM-DD.md` (default)
   - `skip` — Skip session logging for this project
   - `custom` — Ask user for path or format

2. **knowledge_update** — Should the wrap-up update project knowledge?
   - `conditional` — Only when the session produced new stable knowledge (default)
   - `always` — Always prompt for knowledge update
   - `skip` — Never update knowledge during wrap-up

3. **commit_mode** — How should the commit step work?
   - `suggest` — Write to `commit-msg.txt`, never commit directly (default)
   - `ask` — Ask user whether to commit directly or just suggest
   - `skip` — Skip the commit step entirely

4. **git_policy** — Any project-specific git restrictions?
   - `user-managed` — Never run git write commands (default if CLAUDE.md mentions this)
   - `standard` — Follow global commit skill behavior
   - `custom` — Ask user to describe

5. **extra_steps** — Any additional wrap-up steps for this project?
   - `none` — Just session log, knowledge, and commit (default)
   - `tests` — Run tests before suggesting a commit
   - `lint` — Run linter before suggesting a commit
   - `custom` — Ask user to describe

## Generated files

- `SKILL.md` — from `SKILL.md.template`
