# commit

Project-specific commit message conventions and git workflow.

## Recommends when

Any git repository. Especially useful when the project has specific commit prefix requirements, a suggest-only git policy, or files that should always be excluded from commits.

## Detection hints

- Is this a git repo? (always true if you're here)
- Does CLAUDE.md mention git workflow, commit conventions, or "user manages commits"?
- Do recent `git log --oneline -10` entries use a prefix pattern? (conventional commits, ticket IDs)
- Are there files commonly excluded? (.env, generated files, lock files)

## Questions

1. **prefix_style** — Commit message prefix convention?
   - `none` — No prefix, just imperative title (default)
   - `conventional` — Conventional commits (`feat:`, `fix:`, `docs:`, etc.)
   - `ticket` — Ticket ID prefix (e.g., `JIRA-123: Add feature`)
   - `custom` — Ask user to describe their format

2. **run_mode** — Can Claude run `git commit` directly?
   - `suggest` — Always write to `commit-msg.txt`, never commit (default if CLAUDE.md mentions user-managed commits)
   - `ask` — Default to suggest, but support `--run` flag to commit directly
   - `auto` — Commit directly unless told otherwise

3. **exclude_patterns** — Files to always exclude from commits?
   - Examples: `commit-msg.txt`, `.env`, `*.generated.*`
   - Default: `commit-msg.txt`

4. **message_format** — Commit message body format?
   - `full` — Title + Why + This commit (default)
   - `title-only` — Just a title for trivial changes, full body for substantial changes
   - `custom` — Ask user to describe their format

## Generated files

- `SKILL.md` — from `SKILL.md.template`
- `TEMPLATE.md` — from `TEMPLATE.md.template`
