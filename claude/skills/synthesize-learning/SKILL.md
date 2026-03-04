---
name: synthesize-learning
description: Process raw content notes into target docs and flag relevant items for active work. Use after capturing content with /capture-content.
---

# Synthesize Learning

Process raw content notes into target documents and flag items relevant to active work. Reads repo-specific configuration from `.claude/docs/content-synthesis.md`.

## Process

### 1. Load Context

Read `.claude/docs/content-synthesis.md` in the current repository.

**If the file is missing**, tell the user:

> No content synthesis context found. To use `/synthesize-learning`, create `.claude/docs/content-synthesis.md` with these sections:
>
> - **Input folder** — where unprocessed notes live
> - **Target files** — table of synthesis destinations with guidance
> - **Source reference format** — how to cite sources in target docs
> - **Actionable items** — how to handle action items
> - **Active work** — where to check for relevance flagging

Then stop.

**Validate required sections** — if any required section is missing, tell the user which sections are needed and stop.

### 2. Find Unprocessed Notes

List `.md` files in the **Input folder** from the context file (root level only, not `_processed/`).

If user specifies a file, process just that one. Otherwise, ask which to process or process all if few.

### 3. For Each Note

Read the note and its "Relevant To" section.

For each relevant target:

#### Update Target Docs

Read the target file and follow the guidance from the context file's **Target files** table:

1. Find the appropriate section for this insight (or create one if needed)
2. Add the new information, matching the doc's existing style
3. Add source reference using the format from the context file's **Source reference format** section
4. Follow any additional per-target rules from the context file

**Be selective:** Only add genuinely new or valuable insights. Don't duplicate existing content.

#### Handle Actionable Items

Follow the context file's **Actionable items** section — this varies by repo:
- Some repos want actions written to specific files
- Others want actions flagged in output only

#### Flag for Active Work

Check if insights are relevant to active items in the location specified by the context file's **Active work** section.

If relevant, note in output: "This may be relevant to [item]: [why]"

Don't automatically modify active work files unless the context file says otherwise — just flag for user awareness.

### 4. Mark Note as Processed

After processing:
1. Check the boxes in "Relevant To" for targets that were updated
2. Add `date-processed: YYYY-MM-DD` to the YAML frontmatter
3. Move the file to `_processed/` within the input folder

This keeps the input folder as a clean inbox.

### 5. Report Summary

Output a summary:

```
## Synthesis Complete

**Processed:** [filename]

**Updated:**
- [target file] - Added [what]

**Active work flags:**
- [item]: [insight] may be relevant because [reason]

**Actionable items:**
- [what was done per context file guidance]

**Skipped:**
- [target] - No new insights to add
```

## Tips

- Don't over-synthesize — not every note needs to update every target
- Preserve the original note — synthesis adds to target docs, doesn't replace notes
- Flag active work relevance liberally — better to flag too much than miss something
- Match the existing style of target files when adding content
