---
name: task-plan
description: Break down a project description into individual tasks. Use when the user wants to plan tasks from a description, break down work, or says "plan tasks". Pass a description as an argument.
argument-hint: [description or brief]
---

# Plan Tasks

Break down a description into individual, actionable tasks.

## Process

### 1. Load Config

Read `.claude/docs/tasks.md` from the current repo root. If missing, bail with setup guidance.

### 2. Get Planning Input

Accept input from the user's argument:

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
- **Priority** — high, medium, or low based on dependencies and impact

Present as a table:

```
| # | Title | Priority | Notes |
|---|-------|----------|-------|
| 1 | Do the thing | High | Blocking other work |
| 2 | Another thing | Medium | |
```

**Sizing:** If a work item would take >1 day, consider splitting it. If <15 minutes, consider combining with related items. Each task should have a clear "done" state.

Aim for 3-8 tasks per planning session.

### 5. Review with User

Use `AskUserQuestion` with `multiSelect: true` to let the user:
- Approve tasks to create
- Remove tasks they don't want
- Note: they can request edits to specific tasks before confirming

### 6. Batch Create

For each approved task:
- Generate filename: `NN-slug-from-title.md` (next available number)
- Create file with `## Priority: <value>` heading and `# Title` heading
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
- Flag potential duplicates with existing tasks rather than silently skipping
<!-- catalog: task-plan v1 -->
