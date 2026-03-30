# content-synthesize

Project-specific content synthesis — process raw notes into target docs and flag relevant items for active work.

## Recommends when

Project has captured content notes (from `/content-capture` or manual notes) that need processing into target documents. Pairs with `content-capture` — capture creates raw notes, synthesize distributes insights.

## Detection hints

- `.claude/docs/content-synthesis.md` exists
- A notes input folder exists with `.md` files
- Target documents exist that receive synthesized insights

## Questions

1. **input_folder** — Where do unprocessed notes live?
   - `custom` — Ask user for path (e.g., `notes/_inbox/`, `content/raw/`)
   - No default — this is always project-specific

2. **target_files** — Where should insights be distributed?
   - `custom` — Ask user to describe target files and what goes where
   - This is always project-specific — each target file has its own rules

3. **source_reference_format** — How should sources be cited in target docs?
   - `inline` — `(Source: [title](path))` after the insight (default)
   - `footnote` — Numbered footnotes at section bottom
   - `none` — No source attribution
   - `custom` — Ask user for their format

4. **actionable_items** — How should action items from content be handled?
   - `flag` — Flag in synthesis report, don't create anything (default)
   - `tasks` — Create task files for actionable items
   - `checklist` — Add to a checklist in a specified file
   - `custom` — Ask user to describe

5. **processed_handling** — What happens to notes after processing?
   - `move` — Move to `_processed/` subfolder (default)
   - `mark` — Add `date-processed` to frontmatter, keep in place
   - `delete` — Remove after processing
   - `custom` — Ask user to describe

## Generated files

- `SKILL.md` — from `SKILL.md.template`
- `REFERENCE.md` — from `REFERENCE.md.template`
