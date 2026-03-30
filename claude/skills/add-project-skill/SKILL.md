---
name: add-project-skill
description: Scaffold project-local skills from a catalog of templates, adapted to the current project's stack and conventions. Use when setting up a new project, wanting project-specific commit/test/review conventions, or saying "add project skill".
argument-hint: [skill-name | --audit]
---

# Add Project Skill

Copy a skill template from the catalog, customize it for this project, and write it to `.claude/skills/`.

## Process

### 1. Detect Project Context

Read (in parallel, skip any that don't exist):

- `CLAUDE.md` — project conventions, git workflow, tool preferences
- `.claude/KNOWLEDGE.md` — established decisions
- `.claude/skills/` — skills already present (avoid duplicates)
- Stack indicators: `package.json`, `tsconfig.json`, `Cargo.toml`, `go.mod`, `pyproject.toml`, `flake.nix`, `Makefile`, `Dockerfile`

### 2. Select Template

**If argument is a skill name** (e.g., `/add-project-skill commit`): jump to step 3.

**If `--audit`**: jump to the Audit flow below.

**Otherwise**: list the catalog by reading each `catalog/*/README.md` from this skill's directory. For each template show:

- Name and one-line description
- `[installed]` if `.claude/skills/<name>/` already exists in the project
- `[recommended]` if detection hints from README.md match the project

Ask the user which template(s) to scaffold.

### 3. Customize

For the selected template:

1. Read `catalog/<name>/README.md` for the list of questions
2. Pre-fill answers from step 1 detection where possible (e.g., if CLAUDE.md says "user manages all commits", default run_mode to suggest-only)
3. Ask all questions in a single turn using AskUserQuestion — don't ask one at a time

### 4. Scaffold

For each `.template` file in `catalog/<name>/`:

1. Read the template file
2. Replace `{{placeholders}}` based on user answers and detected context
3. Remove sections marked with conditional comments if they don't apply
4. Write to `.claude/skills/<name>/` — strip the `.template` suffix (e.g., `SKILL.md.template` → `SKILL.md`)

Add a version comment at the bottom of the generated SKILL.md:
```
<!-- catalog: <name> v1 -->
```

If `.claude/skills/<name>/` already exists, warn the user and ask before overwriting.

### 5. Summary

Show what was created and suggest testing:

```
Created .claude/skills/<name>/
  - SKILL.md
  - TEMPLATE.md (if applicable)

Test it: /<name>
```

---

## Audit Flow (`--audit`)

1. List `.claude/skills/*/` in the current project
2. For each that has a matching `catalog/*/` entry:
   - Compare structure (missing files? missing sections?)
   - Check catalog version comment against current catalog version
   - Note project customizations that would be preserved
3. For project skills with no catalog match: note as "fully custom"
4. Report findings and offer to update skills that are behind

---

## Notes

- Templates are starting points, not rigid forms — adapt freely based on project context
- The catalog lives at `add-project-skill/catalog/` in the global skills directory
- Adding a new catalog entry = creating a new folder with README.md + .template files
- Never overwrite existing project skills without asking
