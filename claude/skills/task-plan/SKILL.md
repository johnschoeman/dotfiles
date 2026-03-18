---
name: task-plan
description: Break down a project description or PRD into individual tasks. Use when the user wants to plan tasks from a document, break down a project, or says "plan tasks". Pass a file path, URL, or description as an argument.
argument-hint: [file path, URL, or brief description]
---

# Plan Tasks

Break down a project description into individual, actionable tasks.

## Process

### 1. Load Config

Read `.claude/docs/tasks.md` from the current repo root. If missing, bail with setup guidance.

### 2. Get Planning Input

Accept input from the user's argument:

- **File path** — read the file (markdown, text, etc.)
- **URL** — fetch and extract content using `WebFetch`
- **Pasted text** — use directly from the conversation
- **Brief description** — use as-is, ask clarifying questions if too vague

If no argument, ask the user what they want to plan.

### 3. Check Existing Tasks

Run the task list script to see what already exists:

```bash
python3 ~/.claude/skills/task-scripts/task-list.py
```

This prevents creating duplicates of existing work.

### 4. Analyze and Propose

Extract concrete deliverables and work items from the input. For each, determine:
- **Title** — clear, actionable (imperative mood)
- **Priority** — based on dependencies and impact
- **Status** — default from config (usually the lowest active status)
- **Category/field values** — infer from config fields

Present as a table using config field names. See [REFERENCE.md](REFERENCE.md#proposal-format) for format details.

### 5. Review with User

Use `AskUserQuestion` with `multiSelect: true` to let the user:
- Approve tasks to create
- Remove tasks they don't want
- Note: they can request edits to specific tasks before confirming

If the user wants changes, adjust and re-present.

### 6. Batch Create

For each approved task:
- Generate filename per config pattern
- Create file using config template/format
- Use `Write` tool for each file

### 7. Summarize

```
## Tasks Created

Created N tasks:
- N high priority, N medium, N low
- Files: list of created filenames

Run `/task-board` to see the updated board.
```

## Notes

- Keep tasks atomic — one clear deliverable per task
- Prefer 3-8 tasks per planning session (not too granular, not too broad)
- Flag potential duplicates with existing tasks rather than silently skipping
- Use config defaults for fields not inferable from the input
