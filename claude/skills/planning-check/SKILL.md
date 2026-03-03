---
name: planning-check
description: Review the current state of planning — active work, queued items, priorities, and alignment. Use when the user wants a status check, asks "how am I doing", or wants to review priorities. Reads repo-specific planning context from .claude/docs/planning.md.
---

# Planning Status Check

Review the current state of planning by reading the repo's planning context and following its references.

## Process

### 1. Load Planning Context

Read `.claude/docs/planning.md` in the current repository.

**If the file is missing**, tell the user:

> No planning context found. To use `/planning-check`, create `.claude/docs/planning.md` describing your planning setup — focus areas, where active/queued items live, and where recent activity is tracked.

Then stop.

### 2. Read Focus / Priorities

From the planning doc's **Focus** section, read the referenced priority and goal documents. Summarize:
- What are the current high-level priorities?
- What should be getting the most attention right now?

### 3. Active Items → Next Actions

From the planning doc's **Active items** section, find items matching the "active" criteria described there.

For each active item:
- Show its name and any relevant metadata (category, tier, area, etc.)
- **Extract Next Actions** — incomplete tasks (`- [ ]`) from each item
- Flag items with **no Next Actions** defined (needs planning attention)
- Flag items that appear **stalled** (no recent updates, empty task lists)

This surfaces actual work to be done, not just item names.

### 4. Queued Items

From the planning doc's **Queued items** section, list items matching the "queued/next" criteria. These are ready when capacity opens.

### 5. Recent Activity

From the planning doc's **Recent activity** section, read the referenced temporal notes (daily, weekly, monthly, session logs — whatever the repo uses).

Assess:
- What's been getting attention lately?
- Any areas being neglected?
- Any recurring themes or concerns?

### 6. Repo-Specific Review Steps

If the planning doc includes additional review steps (capacity checks, artifact tracking, domain balance, etc.), perform those as described.

### 7. Alignment Check

Compare active work against priorities:
- Are active items aligned with stated focus?
- Is anything important being neglected?
- Is lower-priority work crowding out higher-priority work?
- Any drift from priorities?

### 8. Output Summary

Provide a structured summary. Adapt section names to match the repo's terminology:

```
## Planning Status Check

### Focus
- [High-level priorities summary]
- [Current period focus]

### Active Items
**[Item Name]** - [relevant metadata]
- [ ] [Next action 1]
- [ ] [Next action 2]

**[Item Name]** - [relevant metadata]
- [ ] [Next action 1]

### Queued
- [Item list]

### Recent Activity
- [What's getting attention]
- [Patterns observed]

### [Repo-Specific Sections]
- [As defined in planning.md]

### Observations
- [Alignment concerns or drift]
- [Stalled or under-planned items]
- [Things going well]

### Recommended Focus
1. [Highest priority action]
2. [Second priority]
3. [If time remains]
```

## When to Use

- Weekly planning or check-in
- When feeling scattered or wanting to refocus
- When unsure what to work on next
- After completing a major milestone
- Before status updates or 1:1s
