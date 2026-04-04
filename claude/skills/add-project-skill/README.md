# Skill Catalog

Templates for scaffolding project-local skills via `/add-project-skill`.

## Available Templates

| Template | Description | Per-project differences |
|----------|-------------|----------------------|
| **code-review** | Review code changes against project standards | Review focus (general/security/performance), required checklist items, sensitive paths, feedback style (inline/summary/PR-ready) |
| **commit** | Commit message conventions and git workflow | Prefix style (conventional, ticket ID, none), run mode (suggest-only vs auto), excluded files, message body format |
| **content-capture** | Extract structured notes from external content | Save path, relevance targets (from planning or custom list), note template (full/minimal/research), scope restrictions, follow-up prompt |
| **content-process** | Process raw notes into target docs | Input folder, target files and routing rules, source citation format, actionable item handling, processed note disposition (move/mark/delete) |
| **deploy** | Pre-deploy checks and deployment guidance | Deploy target and command, pre-deploy checks (tests/build/lint), rollback procedure, environments (single/staging-prod/multi) |
| **task-board** | Task display and next-work suggestions | Display style (compact vs detailed), next-work prioritization logic, large group summary threshold |
| **task-groom** | Task grooming rules and thresholds | Stale days (14/30/60), WIP limit, stalled threshold, extra checks (missing fields, duplicates) |
| **task-plan** | Task breakdown and planning conventions | Task sizing guidance, batch size per session, default status, input source format (PRDs, issues, freeform) |
| **task-update** | Task completion and status workflows | Completion action (move/mark/archive), status transition rules (free vs linear), extra completion fields (outcome, time) |
| **weekly-planning** | Forward-looking: set focus and priorities for the week | Focus source (planning doc, tasks, external), review cadence (weekly/sprint/monthly), extra review steps (capacity, dependencies) |
| **weekly-review** | Backward-looking: reflect on progress and capture learnings | Review sources (git, tasks, both), reflection depth (brief/structured/metrics), output location, knowledge capture policy |
| **onboarding** | Get up to speed on a project quickly | Audience (self/contributor/reviewer), depth (overview/deep-dive/guided-tour), focus areas (code/workflow/auto), output (conversation/document/checklist) |
| **test-me-on** | Interactive quiz on training modules or docs | Training path, module structure (subject/module vs flat), question style (scenario/conceptual/practical), domain context, scoring strictness |
| **today** | Morning daily briefing and plan | Daily/weekly note paths and patterns, context sources (planning doc, notes, session log, git, tasks), output sections (full/minimal/no-habits), intention prompt |
| **knowledge-update** | Persist stable decisions and learnings to KNOWLEDGE.md | Knowledge categories (decisions, learnings, conventions, ops), capture strictness, staleness checking, follow-up prompt |
| **session-update** | Capture session context for cross-session continuity | Log path, entry format (standard/minimal/detailed), git grounding on/off, follow-up prompt |
| **today-wrap** | End-of-day close-out with daily notes | Daily note path and template, section types (checklist, freeform, time-entry), carryover behavior, follow-up prompt |
| **session-wrap** | End-of-session wrap-up | Session log on/off, knowledge update policy, commit mode (suggest/ask/skip), git policy, extra steps (tests, lint) |

## Adding a New Template

Create a new folder under `catalog/` with:

```
catalog/<name>/
├── README.md              # Description, detection hints, customization questions
├── SKILL.md.template      # Template for the project's SKILL.md
├── REFERENCE.md.template  # (optional) Supporting reference doc
└── TEMPLATE.md.template   # (optional) Output format template
```

No registry to update — the skill discovers templates by scanning `catalog/*/README.md`.
