---
name: project-init
description: Initialize a project for Claude Code — analyze codebase, generate CLAUDE.md, create .claude/ infrastructure, and optionally set up planning/content capture context files.
---

# Project Init

Set up a project for Claude Code with a CLAUDE.md, .claude/ infrastructure, and optional context files for planning and content capture skills.

## Process

### 1. Pre-flight Check

Check which of these already exist:
- `CLAUDE.md`
- `.claude/KNOWLEDGE.md`
- `.claude/session-history/`
- `.claude/docs/planning.md`
- `.claude/docs/content-capture.md`
- `.claude/docs/content-synthesis.md`

**If `CLAUDE.md` exists**, ask the user whether to regenerate it or skip. For all other files, skip silently if they already exist.

### 2. Analyze the Codebase

Examine the project thoroughly:

- **Language & framework** — primary language, frameworks, libraries
- **Build / test / lint commands** — look at package.json, Makefile, Cargo.toml, pyproject.toml, flake.nix, etc.
- **Directory structure** — top-level layout and key subdirectories
- **Architecture** — major components, how they connect, entry points
- **Conventions** — naming, formatting, patterns visible in the code
- **Git history** — run `git log --oneline -20` for recent context on what the project does and how it evolves

Be thorough here — this analysis feeds directly into CLAUDE.md quality.

### 3. Generate CLAUDE.md

Write a unified `CLAUDE.md` at the project root. Include these sections (skip any that aren't meaningful for the project):

#### Overview

1-3 sentences on what the project is and does.

#### Development Commands

Build, test, lint, run — whatever applies. Use code blocks. Include single-test and single-file-lint commands if available.

#### Repository Structure

```
directory/tree format showing key directories and files with comments
```

#### Architecture

Major components, data flow, key abstractions. Only include if the project has meaningful architecture worth documenting.

#### Key Configurations

Table or list of important config files and what they control. Only include if useful.

#### Git Workflow

**This section is verbatim — use exactly this text in every project:**

`````markdown
## Git Workflow

User manages all commits. You remind and suggest, never commit.

**After significant work:**
1. Run `/update-session-log` to capture session context
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
`````

#### Conventions

Formatting, naming, patterns, tooling preferences discovered during analysis.

### 4. Create .claude/ Infrastructure

Create these if they don't already exist:

**`.claude/session-history/` directory** — for session log entries.

**`.claude/KNOWLEDGE.md`** — with this template:

```markdown
# Knowledge

Stable knowledge for this repository. Read at session start. Organized by topic, not chronologically.

---

## Decisions

[Choices and reasoning — why X not Y. Things that shouldn't be re-litigated.]

## Learnings

[Discovered facts, gotchas, technical notes. Things figured out through experience.]
```

### 5. Optional .claude/docs/ Templates

Ask the user which of these context files they want (if any). Explain briefly what each enables:

- **planning.md** — enables `/planning-check` for status reviews and priority tracking
- **content-capture.md** — enables `/capture-content` for structured note-taking from articles/videos
- **content-synthesis.md** — enables `/synthesize-learning` for processing captured notes into target docs

For each one the user wants, create `.claude/docs/<file>` with the template below. Skip any that already exist.

#### planning.md template

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

#### content-capture.md template

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

#### content-synthesis.md template

```markdown
# Content Synthesis Context

## Input folder

<!-- Where unprocessed captured notes live (output of /capture-content). -->
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

### 6. Summary

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

**Next steps:**
- Review CLAUDE.md and adjust as needed
- [If any .claude/docs/ templates were created] Fill in PATH_TO_... placeholders in .claude/docs/ files
```
