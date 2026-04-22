---
name: setup-repo
description: Set up or audit Claude Code infrastructure for a project. Creates CLAUDE.md, .claude/ directory. Use when initializing a new project, saying "setup repo", or reviewing a project's Claude config.
model: sonnet
effort: medium
---

Set up Claude Code infrastructure from scratch, or audit an existing setup and suggest improvements.

## Quick Start

Run `/setup-repo` from any project. The skill will:

1. Scan for existing Claude infrastructure (CLAUDE.md, .claude/ directory)
2. If missing: generate it from codebase analysis
3. If present: audit it against the standard layout

## Quality Standards

**Sizing target:** CLAUDE.md should be under 200 lines (~1,500 tokens). Treat every line like ad space — if removing it wouldn't cause Claude to make mistakes, cut it.

**What belongs in CLAUDE.md:**

| Include | Put elsewhere |
|---------|---------------|
| Build/test/lint commands | Exhaustive API references (`.claude/context/`) |
| Constraints ("use Zustand, not Redux") | Standard conventions Claude already knows |
| Key architecture decisions | Verbose explanations (link to README) |
| Non-obvious gotchas | Session-specific state (KNOWLEDGE.md) |
| File path conventions | Content duplicated from README.md |

**Enforcement hierarchy:** Linters > hooks > CLAUDE.md. Only put rules in CLAUDE.md that require LLM judgment.

**Conciseness principles:**

- Skip what Claude already knows (standard language features, common framework patterns)
- Be specific, not generic — "use `pytest -x --tb=short`" beats "run tests"
- Use directive language — MUST, NEVER, ALWAYS outperform soft suggestions
- Include "why" for non-obvious decisions — saves re-litigation
- The template is a ceiling, not a floor — delete sections that don't apply
- Link, don't inline — `Read docs/api-patterns.md when adding endpoints` loads context only when relevant
- Start minimal, grow organically — add rules only when Claude makes a specific mistake

## Workflow

### Scan

**1. Scan existing infrastructure**

Check which of these exist and read their contents:
- `CLAUDE.md`
- `.claude/KNOWLEDGE.md`
- `.claude/settings.json`
- `.claude/rules/`
- `.claude/context/`
- `.claude/skills/`
- `.claude/agents/`
- `.claude/hooks/`

Also check the user's global Claude settings:
- `~/.claude/CLAUDE.md` — check for voice/behavior rules
- `~/.claude/settings.json` — check for global hooks or permissions

If no project infrastructure exists → run the **Fresh Setup** phase.
If any exists → run the **Audit** phase.

### Fresh Setup

**2a. Fresh Setup** (when no Claude infrastructure exists)

**Analyze the codebase:**
- Language, frameworks, libraries
- Build / test / lint commands (package.json, Makefile, Cargo.toml, pyproject.toml, etc.)
- Directory structure and key subdirectories
- Architecture — major components, entry points
- Git history — `git log --oneline -20`

**Select a template:**

| Template | Use when |
|----------|----------|
| Simple | Single language, straightforward build, few conventions |
| Full | Complex architecture, multiple services, team onboarding needs |

Either way, delete sections that don't apply — the template is a ceiling, not a floor.

**Ask the user for coding guidelines:**
Ask if there are specific rules for how Claude should write code in this project — patterns to follow, patterns to avoid, preferred libraries, error handling style, etc. Capture these as directive statements in the Conventions section. Use command language: "Always use X", "Never do Y", "Prefer X over Y".

**Add behavioral rules** that shape how Claude approaches work. High-impact defaults:

- **Think before coding** — state assumptions explicitly, surface confusion instead of guessing
- **Simplicity first** — implement only requested features, avoid abstractions for single-use code
- **Surgical changes** — touch only what's needed, match existing style, don't improve adjacent code unprompted
- **Goal-driven execution** — frame requests as success criteria

**Generate CLAUDE.md** at project root. Standard sections:

- **Overview** — what the repo does
- **Key Commands** — build, test, lint, dev server
- **Verification** — commands Claude should run after code changes
- **Key Directories** — top-level layout with purpose
- **Architecture** — only if complexity warrants it
- **Voice** — terse response rules (include by default)
- **Conventions** — patterns, naming, file organization, coding guidelines
- **Common Tasks** — how to add a feature/endpoint/component (if repeatable pattern exists)
- **Gotchas** — non-obvious things that cause mistakes
- **Git Workflow** — use verbatim from `references/REFERENCE.md#git-workflow-verbatim`

Skip sections that aren't meaningful for the repo.

**Scaffold .claude/ directory:**

| Component | Action |
|-----------|--------|
| `KNOWLEDGE.md` | Create with Decisions + Learnings sections |
| `settings.json` | Create with schema URL, permissions, git guardrails PreToolUse hook |
| `rules/conventions.md` | Create — ask user which apply |
| `rules/testing.md` | Create — ask user which apply |
| `rules/security.md` | Create — ask user which apply |
| `context/stack.md` | Create — fill in from codebase analysis |
| `context/architecture.md` | Create as template — too project-specific to auto-fill |
| `skills/commit/SKILL.md` | Create commit skill |
| `skills/review/SKILL.md` | Create review skill |
| `hooks/block-dangerous-git.sh` | Create and make executable |

For `context/stack.md`, fill in what you can from codebase analysis. Leave blank what you can't determine.

### Review & Maintain

**3. Remind the user to review and adapt**

After setup, tell the user:

> **Review the generated files** and adapt them to your project. These are starter templates — the real value comes from customizing them to your specific codebase.
>
> Treat your `.claude/` files like a test suite — living artifacts that need continuous maintenance. **Update at least monthly**, or whenever Claude makes a repeated mistake.

Specifically call out:
- `rules/conventions.md` — add project-specific patterns
- `rules/testing.md` — uncomment and fill in verification commands
- `rules/security.md` — add project-specific security requirements
- `context/architecture.md` — fill in when you have time
- `context/stack.md` — verify auto-filled content is accurate

### Audit

**2b. Audit** (when infrastructure already exists)

**Sizing check:**
- Count lines in CLAUDE.md. If over 200 lines, flag it and suggest pruning or offloading detail to `.claude/context/`.
- Check for content that duplicates README.md — suggest removing and linking instead.

**Compare each component against the standard:**

| Component | Standard |
|-----------|----------|
| `CLAUDE.md` | Sections: Overview, Key Commands, Verification, Key Directories, Architecture (if complex), Voice, Conventions, Common Tasks, Gotchas, Git Workflow |
| `.claude/KNOWLEDGE.md` | Decisions + Learnings sections |
| `.claude/settings.json` | Schema URL, permissions, PreToolUse hook for git guardrails |
| `.claude/rules/` | conventions.md, testing.md, security.md (at minimum) |
| `.claude/context/` | architecture.md, stack.md |
| `.claude/skills/` | commit/ and review/ (at minimum) |
| `.claude/hooks/` | block-dangerous-git.sh |

**Check CLAUDE.md for:**
- Missing sections vs standard template
- Stale content (repo structure vs reality, commands that may no longer work)
- Missing voice section (terse response rules)
- Missing git workflow section
- Generic content that Claude already knows (candidates for removal)
- Missing verification section
- Missing behavioral rules (think before coding, simplicity, surgical changes, goal-driven execution)

**Check .claude/ infrastructure for:**
- Missing or empty `rules/` directory
- Missing `context/` files — suggest adding architecture.md and stack.md
- Missing project-local skills — suggest adding commit/ and review/
- Missing git guardrails — check `settings.json` for PreToolUse hook and `hooks/` for block script

**Present findings:**

```
## Claude Setup Audit

**Line count:** [N lines — within/over target of 200]
**Present:** [what exists and looks good]
**Missing:** [what doesn't exist, with what it enables]
**Suggestions:** [specific improvements — prune, restructure, add sections]
```

Ask which changes to apply. Make changes only with user approval.

## Success Criteria

Setup is complete when:
- CLAUDE.md exists with relevant standard sections
- CLAUDE.md is under 200 lines (or user acknowledged and accepted the size)
- `.claude/` directory scaffolded: KNOWLEDGE.md, settings.json, rules/, context/, skills/, hooks/
- Git guardrails in place (settings.json + hook script)
- User reminded to review, adapt, and maintain .claude/ files continuously
- User has a clear summary of what was created/changed

<!-- sourced: developer-ai-toolkit/setup-repo -->
