---
name: add-skill
description: Scaffold a skill from the developer-ai-toolkit catalog, adapted to your conventions and stack. Installs to the project by default; use --global for personal cross-project use. Use when adding a skill, installing a catalog skill, or saying "add skill".
argument-hint: [skill-name | --list | --audit | --global | --project]
model: sonnet
effort: high
---

# Add Skill

Read a skill from the developer-ai-toolkit skill catalog, adapt it to your conventions and stack, and scaffold it into `.claude/skills/`. Uses Claude intelligence to adapt — not template substitution.

**Where skills are installed:**

- `--project` (default) — `.claude/skills/<name>/` in the current repo; commit to git so the team gets it
- `--global` — `~/.claude/skills/<name>/`; personal, works across all projects, not version-controlled

If you're unsure which to use, see the Best Practices section in the [skill-catalog README](../README.md).

## Quick Start

```
/add-skill                      # Browse catalog, install to project
/add-skill commit               # Install a specific skill to project
/add-skill commit --global      # Install a specific skill globally
/add-skill --list               # List catalog with [installed] markers
/add-skill --audit              # Review installed skills vs catalog
```

## Process

### 1. Resolve Catalog Path

Check in order — stop at the first that resolves:

1. `~/workspace/evolv/developer-ai-toolkit/skill-catalog/`
2. Walk up from `$CLAUDE_SKILL_DIR` looking for a `skill-catalog/` directory (works when skill lives in the toolkit itself)

If none resolve:

```
Catalog path not found. Set the environment variable:

  export DEVELOPER_AI_TOOLKIT=/path/to/developer-ai-toolkit

Then reload your shell and re-run the skill.
```

### 2. Determine Destination

- `--global` flag → destination is `~/.claude/skills/<name>/`
- `--project` flag or no flag → destination is `.claude/skills/<name>/`

### 3. Detect Context

Read in parallel — skip files that do not exist:

- `CLAUDE.md` — conventions, commit policy, tool preferences
- `.claude/KNOWLEDGE.md` — established decisions
- Both `.claude/skills/` and `~/.claude/skills/` — list installed skill names (for `[installed]` markers)
- Stack files: `package.json`, `go.mod`, `Cargo.toml`, `pyproject.toml`, `Makefile`, `Dockerfile`

Extract: language/stack, installed skill names, commit prefix conventions, test commands, any "user manages commits" or "never commit" policy.

### 4. Select Skill

**If argument is a skill name** (e.g., `/add-skill commit`) — jump to step 5.

**If `--list` or no argument** — read `<catalog-path>/README.md` and parse the skill tables. For each skill:

- Mark `[installed]` if it exists in either skills directory
- Mark `[recommended]` if the skill matches detected context (e.g., `commit` → any git repo; `tdd` → project has a test runner)

Display the list grouped by category and ask which skill to install.

### 5. Preview and Adapt

1. Read `<catalog-path>/<name>/SKILL.md` in full
2. If the skill has a `references/` subdirectory, list those filenames (do not read yet)
3. Show a one-paragraph summary of what the skill does and what will be customized

Ask adaptation questions in **one turn** using `AskUserQuestion`. Pre-fill answers from detected context wherever possible. Questions come from two sources:

**Universal (ask for all skills):**

- Any invocation preference? (rename the skill, different trigger words)
- Team conventions not in CLAUDE.md that this skill should enforce?

**Skill-specific questions** — check the selected skill's SKILL.md frontmatter for an `adapt-hints` field and use it to formulate targeted questions. If no `adapt-hints` field is present, skip skill-specific questions.

### 6. Scaffold

**SKILL.md:**

1. Adapt the catalog SKILL.md with Claude intelligence — rewrite sections to embed relevant conventions, commands, and constraints. Remove sections that do not apply.
2. Write to `<destination>/<name>/SKILL.md`
3. Append a version comment at the end: `<!-- sourced: developer-ai-toolkit/<name> -->`

**References:**

- If the source skill has a `references/` subdirectory, read each file
- Copy files containing conceptual knowledge (patterns, principles, domain docs) as-is
- Adapt files containing commands, paths, or generic examples
- Write to `<destination>/<name>/references/`

**Overwrite guard:** If `<destination>/<name>/` already exists, warn and ask before overwriting.

### 7. Summary

For project installs:

```
Created .claude/skills/<name>/
  - SKILL.md
  - references/<file>.md  (if any)

Test it: /<name>
Commit:  git add .claude/skills/<name>/
```

For global installs:

```
Created ~/.claude/skills/<name>/
  - SKILL.md
  - references/<file>.md  (if any)

Test it: /<name>  (available in all projects)
```

---

## Audit Flow

Run `/add-skill --audit` to review installed skills in both locations:

1. List `.claude/skills/*/` and `~/.claude/skills/*/`
2. For each directory:
   - If a matching skill exists in `<catalog-path>/`: check for version comment (`<!-- sourced: developer-ai-toolkit/<name> -->`), note any structural drift
   - If no catalog match: mark as "fully custom"
3. Report findings grouped by location (project / global)
4. Offer to refresh any that are behind the catalog

---

## Success Criteria

- `<destination>/<name>/SKILL.md` exists and contains adapted conventions
- Version comment present at the end of the file
- `references/` files copied and adapted if the source skill had them
- No overwrite of existing skills without user confirmation
