---
name: wrap-day
description: Evening close-out — walk through today's daily note, complete habits/tasks, capture reflection, carry forward incomplete items. Use at end of day or when saying "wrap day".
---

# Wrap Day

Evening bookend to `/today`. Walks through the daily note interactively — complete habits, review tasks, capture reflection, carry forward incomplete items. Reads repo-specific configuration from `.claude/docs/close-day.md`.

## Process

### 1. Load Config

Read `.claude/docs/close-day.md` in the current repository.

**If the file is missing**, tell the user:

> No close-day config found. To use `/close-day`, create `.claude/docs/close-day.md` with these sections:
>
> - **Daily Note** — path pattern and template path
> - **Sections** — ordered list of sections to walk through, with prompts and types
> - **Carryover** — where incomplete items go
> - **Follow-up** — what to prompt at the end

Then stop.

### 2. Find Today's Daily Note

Calculate today's date. Look for the daily note at the path pattern from the config.

**If it exists:** Read it and proceed to step 3.

**If it doesn't exist:** Tell the user no daily note was found for today. Offer to create one from the template path in the config. If user declines, stop. If user accepts, create the note from template, then proceed.

### 3. Scan What's Already Filled In

Read the note and identify which sections (from the config's section list) already have content. "Content" means non-empty text beyond the section heading — checked items, written paragraphs, log entries, etc.

Track which sections are filled vs empty. This determines prompting behavior in step 4.

### 4. Walk Through Sections Interactively

For each section defined in the config (in order):

**If the section already has content:**
- Show the user what's there (brief summary, not full dump)
- Ask if they want to update or add anything
- If they say no, move on

**If the section is empty:**
- Use the section's **Prompt** from the config
- Use `AskUserQuestion` where the section type calls for choices (checklists, task reviews)
- Use `Edit` to write responses into the daily note

**Section types** (from config):
- **checklist** — present items as choices, check off selected ones
- **task-review** — show existing tasks, ask what got done, check off completed, optionally add new items
- **freeform** — ask the prompt, append the user's response to the section
- **time-entry** — gather activities and write formatted entries (check git commits if config says to)
- **timesheet** — invoke another skill (e.g., `/log-time`) if user wants

**Keep it low-friction** — 3-5 prompts total across all sections. Combine where natural. Don't over-ask.

### 5. Carryover Check

After walking through sections, collect incomplete items from the sources specified in the config's **Carryover** section.

If there are incomplete items:
1. Show them to the user
2. Ask which should carry forward to tomorrow (use `AskUserQuestion` with multiSelect)
3. If any carry forward:
   - Calculate tomorrow's date
   - Check if tomorrow's daily note exists
   - If not, create it from the template
   - Write carryover items to the target section specified in config

If there are no incomplete items, skip this step entirely.

### 6. Summary

Print a brief recap to the conversation:

```
## Day Closed

**Completed:** [count] items checked off
**Carried forward:** [count] items → tomorrow
**Sections updated:** [list]
```

Then check the config's **Follow-up** section. If one is configured, show the prompt (e.g., "Want to run `/update-session-log`?").

## Tone

- Conversational and low-key — this is end-of-day, not a status report
- Don't judge incomplete items — just ask what carries forward
- Keep prompts short — the user is tired
- If a section is already complete, acknowledge briefly and move on
- Treat the whole flow as 2-3 minutes max
