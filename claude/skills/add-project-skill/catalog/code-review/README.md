# code-review

Project-specific code review checklist and standards.

## Recommends when

Any project with collaborative development or where Claude assists with reviewing changes. Useful when the project has specific security requirements, performance concerns, accessibility standards, or architectural patterns to enforce during review.

## Detection hints

- Git repo with multiple contributors or branches
- CLAUDE.md mentions review standards or conventions
- `.github/pull_request_template.md` exists
- CI/CD config exists (`.github/workflows/`, `Makefile`, etc.)

## Questions

1. **review_focus** — What areas need special attention during review?
   - `general` — Logic, readability, error handling (default)
   - `security-first` — Prioritize injection, auth, data exposure, OWASP top 10
   - `performance` — Prioritize allocations, N+1 queries, bundle size, caching
   - `custom` — Ask user to describe their focus areas

2. **checklist_items** — Any required review checklist items?
   - `standard` — Tests, error handling, naming, no dead code (default)
   - `with-docs` — Standard plus documentation and changelog updates
   - `with-migration` — Standard plus database migration safety checks
   - `custom` — Ask user to provide their checklist

3. **sensitive_paths** — Any files/patterns that always need careful review?
   - `none` — No special paths (default)
   - `auto` — Detect from project structure (auth/, config/, migrations/, etc.)
   - `custom` — Ask user to list sensitive paths or patterns

4. **review_style** — How should review feedback be delivered?
   - `inline` — Comment-style feedback on specific lines/sections (default)
   - `summary` — High-level summary with categorized findings
   - `pr-ready` — Formatted as a PR review comment (approve/request changes/comment)
   - `custom` — Ask user to describe

## Generated files

- `SKILL.md` — from `SKILL.md.template`
