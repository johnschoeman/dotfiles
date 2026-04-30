---
name: project-index
description: Token-efficient codebase navigation map. Loads a short routing table, then reads only the relevant section file. Self-bootstraps on first run by scanning the project structure. Use when locating files, understanding feature boundaries, or deciding which area to look in.
adapt-hints: "top-level source directory (src/, app/, lib/), directories to exclude (build output, vendored deps, generated code), whether the project has distinct user-facing feature domains"
model: sonnet
effort: low
---

## Objective

Navigate the codebase without loading everything. Load this index first, then read only the section file relevant to your task.

## Project Structure

| Area | Location | Details |
|------|----------|---------|
| <!-- area name --> | `<!-- path/ -->` | [references/<!-- area -->.md](references/<!-- area -->.md) |

## Technical Areas

| Area | File | Load when |
|------|------|-----------|
| <!-- area --> | [references/<!-- area -->.md](references/<!-- area -->.md) | <!-- when to load --> |

## Feature Domains

| Feature | File | Load when |
|---------|------|-----------|
| <!-- feature --> | [references/features/<!-- feature -->.md](references/features/<!-- feature -->.md) | <!-- when to load --> |

## Bootstrap

**If any reference file linked above is missing or contains only placeholder content**, scan and populate it before answering the user's question.

Run in this order:

1. **Structural scan** — map the top two directory levels, classify technical areas
2. **Technical area scan** — for each area, catalog key files and their purposes in a File | Purpose table
3. **Feature domain scan** — for projects with user-facing features, map all related files per feature across every technical layer. Skip for pure libraries, CLIs, and infra repos.
4. **Write files** — write or overwrite each reference file using the format in [references/TEMPLATE.md](references/TEMPLATE.md)
5. **Update SKILL.md** — replace the placeholder rows in this file with the actual areas and paths you found

For scanning guidance, see the `generate-project-context` skill in the developer-ai-toolkit if available.

After bootstrapping, proceed normally as a routing table.

## Maintenance

This index is self-healing. If you follow a reference and find it wrong, outdated, or missing — **update the relevant file immediately** before continuing. Do not wait for the user to ask.

For larger structural changes (new feature domains, major reorganization), run `/refresh-project-context` instead.

## Success Criteria

After loading this index you can:

- Identify which area of the project to look in
- Load only the relevant section file for your task
- Find related files across all layers for a given feature
