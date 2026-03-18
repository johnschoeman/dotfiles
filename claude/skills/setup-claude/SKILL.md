---
name: setup-claude
description: Set up or audit Claude Code infrastructure for a project. Creates CLAUDE.md, .claude/ directory, knowledge, and session history from scratch — or analyzes existing setup and suggests changes to align with the standard layout. Use when initializing a new project, saying "setup claude", or reviewing a project's Claude config.
---

# Setup Claude

Set up Claude Code infrastructure from scratch, or audit an existing setup and suggest improvements.

## Process

### 1. Scan Existing Infrastructure

Check which of these exist and read their contents:

- `CLAUDE.md`
- `.claude/KNOWLEDGE.md`
- `.claude/session-history/`
- `.claude/docs/planning.md`
- `.claude/docs/content-capture.md`
- `.claude/docs/content-synthesis.md`
- `.claude/docs/close-day.md`
- `.claude/docs/tasks.md`

**If none exist** → run [Fresh Setup](#fresh-setup)

**If any exist** → run [Audit](#audit)

---

## Fresh Setup

### Analyze the Codebase

- Language, frameworks, libraries
- Build / test / lint commands (package.json, Makefile, Cargo.toml, etc.)
- Directory structure and key subdirectories
- Architecture — major components, entry points
- Conventions — naming, formatting, patterns
- Git history — `git log --oneline -20`

### Generate CLAUDE.md

Write `CLAUDE.md` at project root. Sections: Overview, Development Commands, Repository Structure, Architecture, Key Configurations, Git Workflow, Conventions. Skip sections that aren't meaningful.

Use the Git Workflow section verbatim from [REFERENCE.md](REFERENCE.md#git-workflow-verbatim).

### Create .claude/ Infrastructure

- `.claude/session-history/` directory
- `.claude/KNOWLEDGE.md` from [template](REFERENCE.md#knowledgemd-template)

### Optional Context Files

Ask the user which they want. Create from [templates](REFERENCE.md#doc-templates):

- **planning.md** — enables `/planning`
- **content-capture.md** — enables `/content-capture`
- **content-synthesis.md** — enables `/content-synthesize`
- **close-day.md** — enables `/wrap-day`
- **tasks.md** — enables `/task-board`, `/task-create`, `/task-update`, `/task-groom`, `/task-plan`

Show summary using the [output format](REFERENCE.md#summary-output).

---

## Audit

### Compare to Standard

For each component, assess exists / missing / incomplete:

| Component | Standard |
|-----------|----------|
| `CLAUDE.md` | Sections: Overview, Dev Commands, Repo Structure, Architecture, Git Workflow, Conventions |
| `.claude/KNOWLEDGE.md` | Decisions + Learnings sections |
| `.claude/session-history/` | Directory for daily session logs |
| `.claude/docs/` | Optional context files for skills |

### Check CLAUDE.md Quality

If it exists, check for:

- **Missing sections** — compare against standard sections
- **Stale content** — does repo structure match reality? Are commands valid?
- **Git Workflow** — does it match the [standard](REFERENCE.md#git-workflow-verbatim)?
- **Missing commands** — scan for package.json, Makefile, etc. not reflected

### Present Findings

```
## Claude Setup Audit

**Present:** [what exists and looks good]
**Missing:** [what doesn't exist, with what it enables]
**Suggestions:** [specific improvements to existing files]
```

Ask which changes to apply. Make changes only with user approval — don't auto-fix.
