# onboarding

Project-specific onboarding guide — help new contributors (or future-you) get up to speed quickly.

## Recommends when

Any project where context matters — code repos, knowledge bases, documentation projects. Especially useful when returning to a project after a break or onboarding someone else. The skill reads project structure and produces a guided tour.

## Detection hints

- `CLAUDE.md` exists (has project overview)
- `README.md` exists
- `.claude/KNOWLEDGE.md` exists (has accumulated decisions)
- `.claude/session-history/` has entries (has project narrative)
- `tasks/` directory exists (has active work)

## Questions

1. **audience** — Who is this onboarding for?
   - `self` — Future-you returning after a break (default)
   - `contributor` — A new contributor to the project
   - `reviewer` — Someone reviewing or auditing the project
   - `custom` — Ask user to describe

2. **depth** — How deep should the onboarding go?
   - `overview` — Project purpose, structure, key files, how to run (default)
   - `deep-dive` — Overview plus architecture, conventions, active work, recent decisions
   - `guided-tour` — Interactive walkthrough — read files together, ask questions
   - `custom` — Ask user to describe

3. **focus_areas** — What should the onboarding emphasize?
   - `auto` — Infer from project structure (default)
   - `code` — Architecture, patterns, how to build and test
   - `workflow` — How work gets done — tasks, commits, reviews, deploys
   - `custom` — Ask user to describe

4. **output** — How should the onboarding be delivered?
   - `conversation` — Walk through it interactively (default)
   - `document` — Write an ONBOARDING.md file
   - `checklist` — Generate a getting-started checklist

## Generated files

- `SKILL.md` — from `SKILL.md.template`
