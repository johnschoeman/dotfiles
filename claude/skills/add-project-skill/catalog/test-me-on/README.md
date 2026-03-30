# test-me-on

Project-specific interactive quiz on training modules or documentation.

## Recommends when

Project has a `training/` directory with learning modules, onboarding docs, or structured knowledge that people should be tested on. Also useful for repos with runbooks, process docs, or compliance materials.

## Detection hints

- `training/` directory exists with markdown modules
- `docs/` or `runbooks/` directory with structured content
- Onboarding or process documentation in the repo

## Questions

1. **training_path** — Where do training modules live?
   - `training/` — Standard location (default)
   - `docs/` — In the docs directory
   - `custom` — Ask user for path

2. **subject_structure** — How are modules organized?
   - `subject/module` — Grouped by subject, each module is a file (default: `training/<subject>/<module>.md`)
   - `flat` — All modules in one directory
   - `custom` — Ask user to describe

3. **question_style** — What kind of questions should be asked?
   - `scenario` — "You're in this situation, what do you do?" (default)
   - `conceptual` — "Explain why X works this way"
   - `practical` — "Walk through the steps to accomplish X"
   - `mixed` — Blend of all styles

4. **domain_context** — Any domain-specific context for framing scenarios?
   - `auto` — Infer from CLAUDE.md and repo content (default)
   - `custom` — Ask user to describe their product/domain for realistic scenarios

5. **scoring** — How strict should assessment be?
   - `standard` — Two-dimension rubric: practice alignment + practical judgment (default)
   - `lenient` — Accept any valid approach, focus on understanding
   - `strict` — Require specific terminology and exact practices
   - `custom` — Ask user to describe

## Generated files

- `SKILL.md` — from `SKILL.md.template`
- `REFERENCE.md` — from `REFERENCE.md.template`
