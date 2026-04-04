# Project Init — Reference

## Git Workflow (Verbatim)

Use this section exactly as-is in every generated CLAUDE.md:

````markdown
## Git Workflow

User manages all commits. You remind and suggest, never commit.

**After significant work:**
1. Run `/session-update` to capture session context
2. Run `git status` to see what's actually uncommitted
3. Write commit message to `commit-msg.txt`
4. Remind: "You may want to commit these changes"

**Commit message format:**
```
Concise summary (one line)

Why:

[Brief motivation - what problem this solves]

This commit:

- [Bullet points of actual changes]
- [Only include uncommitted changes, not already-committed work]
```

**Never:** Run git commands that modify history.
````

## KNOWLEDGE.md Template

```markdown
# Knowledge

Stable knowledge for this repository. Read at session start. Organized by topic, not chronologically.

---

## Decisions

[Choices and reasoning — why X not Y. Things that shouldn't be re-litigated.]

## Learnings

[Discovered facts, gotchas, technical notes. Things figured out through experience.]
```

## Doc Templates

### planning.md

```markdown
# Planning Context

## Focus

<!-- Where to read current priorities/goals. Point to a file, section, or describe them inline. -->
PATH_TO_PRIORITIES_OR_GOALS

## Active Items

<!-- How to find active work items. Could be a file path, a filter criteria, or inline list. -->
PATH_TO_ACTIVE_ITEMS

## Queued Items

<!-- Where to find queued/next items ready when capacity opens. -->
PATH_TO_QUEUED_ITEMS

## Recent Activity

<!-- Where temporal notes live — session logs, daily notes, changelogs. -->
.claude/session-history/

## Repo-Specific Review Steps

<!-- Any additional review steps specific to this project. Delete this section if none. -->
```

### content-capture.md

```markdown
# Content Capture Context

## Save path

<!-- Directory where captured notes are saved. -->
PATH_TO_NOTES_DIRECTORY

## Relevance targets

<!-- Checkbox template for the "Relevant To" section. List topics/areas content might relate to. -->
- [ ] TARGET_1
- [ ] TARGET_2
- [ ] TARGET_3

## Active work

<!-- Where to check for active projects/initiatives when assessing relevance. -->
PATH_TO_ACTIVE_WORK

## Scope

<!-- Optional: restrict what types of content to capture. Delete if no restrictions. -->
```

### content-synthesis.md

```markdown
# Content Synthesis Context

## Input folder

<!-- Where unprocessed captured notes live (output of /content-capture). -->
PATH_TO_NOTES_DIRECTORY

## Target files

<!-- Table of synthesis destinations. Each row: target file, what goes there, any special guidance. -->
| Target | Content | Guidance |
|--------|---------|----------|
| PATH_TO_TARGET_1 | Description of what belongs here | Any special rules |

## Source reference format

<!-- How to cite sources in target docs. Example: "(Source: [title](url), YYYY-MM-DD)" -->

## Actionable items

<!-- How to handle action items found during synthesis. Options: write to a file, flag in output only, etc. -->

## Active work

<!-- Where to check for active projects when flagging relevance. -->
PATH_TO_ACTIVE_WORK
```

### tasks.md

```markdown
# Task Config

## Storage

- **type:** markdown-files
- **path:** tasks/
- **done_path:** tasks/_done/

## Format

<!-- Skills read task files in this directory to infer format.
     Add sections below to override defaults. -->

<!-- Optional sections — add as needed:

## Fields

### status
- **values:** now, next, later, done
- **default:** later

### priority
- **values:** high, medium, low
- **default:** medium

## Template

(paste your task file template here)

## Filename

- **pattern:** slug-from-title.md

## Board

- **group_by:** status
- **group_order:** now, next, later
- **sort_within:** priority
- **done_recent_days:** 7
-->
```

## Summary Output

Show the user what was created:

```
## Project Init Complete

**Created:**
- CLAUDE.md — [created / skipped / regenerated]
- .claude/session-history/ — [created / already existed]
- .claude/KNOWLEDGE.md — [created / already existed]
- .claude/docs/planning.md — [created / skipped / already existed]
- .claude/docs/content-capture.md — [created / skipped / already existed]
- .claude/docs/content-synthesis.md — [created / skipped / already existed]
- .claude/docs/tasks.md — [created / skipped / already existed]

**Next steps:**
- Review CLAUDE.md and adjust as needed
- [If any .claude/docs/ templates were created] Fill in PATH_TO_... placeholders in .claude/docs/ files
```
