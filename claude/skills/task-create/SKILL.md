---
name: task-create
description: Create a new task file with proper format. Use when the user wants to add a task, says "new task", "create task", or "task-create". Pass the task title as an argument.
argument-hint: [task title]
---

# Create Task

Create a new task file using the repo's configured format.

## Process

### 1. Load Config

Read `.claude/docs/tasks.md` from the current repo root. If missing, tell the user:

> No task config found. Run `/setup-claude` and add a `tasks.md` context file, or create `.claude/docs/tasks.md` manually.

Extract: fields (with values/defaults), template, filename pattern, storage paths.

### 2. Infer Format

If no `## Template` in config, read one existing task file from the tasks directory to use as a format reference.

### 3. Gather Information

If the user provided an argument (e.g., `/task-create fix the login bug`), use it as the starting title.

For each field in config:
- If the value is obvious from context, use it
- If the field has a default, use the default
- Only ask (via `AskUserQuestion`) for fields that can't be inferred and have no default

**Minimize prompting.** If the user gave enough context, don't ask redundant questions. Use defaults aggressively — the user can always update later with `/task-update`.

### 4. Generate Filename

Use the filename pattern from config:
- If pattern includes `NN-` prefix: find the highest-numbered file in the tasks directory and increment
- Otherwise: derive slug from title (lowercase, hyphens for spaces, strip special characters)
- Always end with `.md`

### 5. Create the File

Write to `<tasks_path>/<filename>` using:
- The template from config (with placeholders filled), or
- The format inferred from an existing file

Fill in:
- All field values (from user input or defaults)
- `created:` → today's date (YYYY-MM-DD)
- `completed:` → empty
- Title and description

### 6. Confirm

After creation, display:
- File path created
- Summary of field values
- Which board group it will appear under

## Notes

- Match exact field order from template or existing files
- Field values must match allowed values from config (if specified)
- Keep descriptions concise — task files are cards, not documents
- Use `Write` tool, not Bash, to create the file
