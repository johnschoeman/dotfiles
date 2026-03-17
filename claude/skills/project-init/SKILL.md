---
name: project-init
description: Initialize a project for Claude Code — analyze codebase, generate CLAUDE.md, create .claude/ infrastructure, and optionally set up planning/content capture context files.
---

# Project Init

Set up a project for Claude Code with a CLAUDE.md, .claude/ infrastructure, and optional context files.

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
- **Git history** — run `git log --oneline -20` for recent context

### 3. Generate CLAUDE.md

Write a unified `CLAUDE.md` at the project root. Include sections: Overview, Development Commands, Repository Structure, Architecture, Key Configurations, Git Workflow, Conventions. Skip sections that aren't meaningful.

Use the Git Workflow section verbatim from [REFERENCE.md](REFERENCE.md#git-workflow-verbatim).

### 4. Create .claude/ Infrastructure

Create `.claude/session-history/` directory and `.claude/KNOWLEDGE.md` using the [template in REFERENCE.md](REFERENCE.md#knowledgemd-template).

### 5. Optional .claude/docs/ Templates

Ask the user which context files they want:
- **planning.md** — enables `/planning-check`
- **content-capture.md** — enables `/capture-content`
- **content-synthesis.md** — enables `/synthesize-learning`

Create from [templates in REFERENCE.md](REFERENCE.md#doc-templates). Skip any that already exist.

### 6. Summary

Show what was created using the [output format in REFERENCE.md](REFERENCE.md#summary-output).
