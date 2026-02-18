# Session Log

## 2026-02-18

**Goal:** Set up Claude Code guidance and configure ollama

**What happened:**
- Added standard Claude Code header to CLAUDE.md
- Added Git Workflow section (user manages commits, Claude reminds/suggests)
- Added Session Log instructions and created this file
- Created .claude/settings.local.json with git permissions (read-only allowed, writes denied)
- Enabled ollama service in configuration.nix (replaces package-only approach)

**Decisions:**
- Following same patterns as evolv-notes for git workflow and session logging
- Commit messages written to `temp_commit_message.txt` for user to review
- Git permissions enforced via settings.local.json, not just documentation
- Use `services.ollama.enable` instead of just the package for auto-start
