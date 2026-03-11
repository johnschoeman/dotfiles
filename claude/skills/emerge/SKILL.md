---
name: emerge
description: Scan recent internal writing for recurring themes coalescing into something bigger. Surfaces patterns ready to become formal projects. Use for periodic review, before planning sessions, or when asking "what keeps coming up?"
---

# Emerge — Surface Patterns from Internal Writing

Read-only skill. Scans recent weekly notes, daily notes, and domain files for recurring themes, cross-references against existing projects, and surfaces clusters ready to become formal projects. Never modifies files.

## Process

### 1. Gather Weekly Notes

Read all non-archived `_daily/wk_*.md` files (exclude `wk_template.md`). These are the primary source — typically 5-8 recent weeks.

From each weekly note, extract:
- **`# Narrative`** — richest source of recurring themes and what's on the user's mind
- **`# Reflections and Concerns`** — HMW questions that repeat across weeks = strong signal
- **`## Red Flags`** — persistent flags across weeks = unaddressed need
- **`# Notes`** — raw observations
- **`## Next Week Intentions`** — what keeps getting re-prioritized

### 2. Gather Supporting Sources

Skim these for additional signal (don't read exhaustively — look for themes that reinforce weekly patterns):

- **Unarchived daily notes** (`_daily/dn_*.md`) — `# Notes` sections for raw observations
- **Domain research notes** (`*/_research-notes.md`) — accumulated knowledge that might suggest action
- **Processed content notes** (`_content-notes/_processed/`) — external ideas that could spark internal projects

### 3. Extract and Cluster Themes

**Extract:** From each weekly note, list the distinct themes, concerns, and topics mentioned. Tag each with the week it appeared in.

**Cluster:** Group related observations across weeks. Look for:
- Same keywords or phrases appearing in multiple weeks
- Conceptual similarity (e.g., "therapy", "therapist", "self-reflection", "insecurities" cluster together)
- Same life domain getting repeated attention
- HMW questions that echo each other across weeks
- Red flags that persist without resolution

**Rank clusters by:**
1. **Recurrence** — how many weeks does this appear? (3+ = strong)
2. **Recency** — is it still showing up in the latest 1-2 weeks?
3. **Intensity** — how much was written about it? (full narrative paragraphs vs. brief mentions)

### 4. Cross-Reference Existing Projects

Read `_plans/projects/*.md` frontmatter (skip `_project_template.md`). For each file, extract the `status` field and project name (H1 heading).

For each theme cluster, check whether an existing project covers it:

- **Already tracked** — theme maps to a `now` or `next` project → note it, don't suggest a new one
- **Partially tracked** — project exists but is `later` status and theme keeps recurring → suggest promoting
- **Untracked** — no project covers this theme → candidate for a new project

### 5. Assess Readiness

Categorize each untracked or partially tracked cluster:

- **Ready to emerge**: 3+ weeks of mentions, clear actionable direction, no active project covering it
- **Emerging**: 2+ weeks, direction forming but not yet clear enough to act
- **Just surfacing**: 1-2 mentions, worth watching but too early to formalize

### 6. Output Report

## Output Format

```
## Emerge Report

### Ready to Become Projects
[Themes with strong recurrence, clear direction, and no existing project]

**[Theme Name]**
- Seen in: wk_XX, wk_XX, wk_XX (N weeks)
- Pattern: [what keeps coming up — summarize across weeks]
- Suggested scope: [what a project around this might look like]
- Related existing: [any tangential projects, or "none"]

### Emerging (Watch These)
[Themes building momentum but not yet actionable]

**[Theme Name]**
- Seen in: wk_XX, wk_XX
- Pattern: [what's showing up]
- What would make it ready: [what would clarify direction]

### Already Tracked
[Themes that map to existing projects — confirms coverage, flags drift]

**[Theme/Project Name]** (status: now/next/later)
- Still active in recent notes: yes/no
- Any new angle not captured in the project file?

---
*Scanned: [list of files read]*
*Window: wk_XX through wk_XX ([date range])*
```

## Guidelines

- **Be selective with "Ready"** — only promote themes that genuinely have enough signal. Two passing mentions is not a project. Look for themes the user keeps returning to with energy or concern.
- **Cluster generously** — "therapy", "therapist", "self-reflection", "attachment" are one cluster, not four. Name clusters by their actionable core, not by individual keywords.
- **Quote the user** — when describing patterns, reference specific phrases or observations from the notes. This grounds the analysis and helps the user recognize their own thinking.
- **Don't over-read** — if a topic appears once in a narrative but never again, it's not a pattern. The whole point is recurrence.
- **Skip trivial themes** — recurring mentions of routine activities (gym, work standup) aren't emergent themes unless there's a shift or concern attached.
- **Already Tracked is useful** — confirming that active projects match what's on the user's mind is valuable signal. Flag if a project seems dormant but the theme is active, or vice versa.
- **Suggest, don't prescribe** — "Suggested scope" should be a sentence or two sketching what a project *might* look like, not a full project spec. The user decides.

## Vault Path

This is a global skill. The vault is at the root of the `notes` repository. Weekly notes are at `_daily/wk_*.md`, daily notes at `_daily/dn_*.md`, projects at `_plans/projects/*.md`, and domain folders are top-level directories.

If `.claude/docs/planning.md` exists in the current repo, use it for additional vault structure context.
