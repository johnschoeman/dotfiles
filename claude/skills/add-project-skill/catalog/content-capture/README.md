# content-capture

Project-specific content capture — extract structured notes from blog posts, PDFs, transcripts, or other sources.

## Recommends when

Project consumes external content (research, articles, reports) and needs structured notes. Especially useful when the project has specific relevance targets, a defined save location, or a scope filter for what content to capture.

## Detection hints

- `.claude/docs/content-capture.md` exists
- A notes or content directory exists (e.g., `notes/`, `content/`, `_inbox/`)
- Project has active initiatives that benefit from external research

## Questions

1. **save_path** — Where should captured notes be saved?
   - `custom` — Ask user for path (e.g., `notes/_inbox/`, `content/raw/`)
   - No default — this is always project-specific

2. **relevance_targets** — What should captured content be tagged as relevant to?
   - `from-planning` — Derive from active projects/initiatives in planning docs
   - `custom-list` — Ask user to provide a checkbox list of targets
   - `none` — Skip relevance tagging

3. **note_template** — What sections should captured notes have?
   - `full` — Summary, key takeaways, relevant to, quotes, questions, raw notes (default)
   - `minimal` — Summary and key takeaways only
   - `research` — Full template plus methodology notes and data quality assessment
   - `custom` — Ask user to describe their template

4. **scope** — Any restrictions on what content to capture?
   - `any` — Capture anything the user provides (default)
   - `domain-restricted` — Only capture content relevant to the project's domain (ask for domain description)
   - `custom` — Ask user to describe scope rules

5. **follow_up** — What to suggest after capturing?
   - `synthesize` — Suggest running `/content-synthesize` (default)
   - `nothing` — Just show where the notes were saved
   - `custom` — Ask user what to suggest

## Generated files

- `SKILL.md` — from `SKILL.md.template`
- `REFERENCE.md` — from `REFERENCE.md.template`
