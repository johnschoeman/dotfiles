---
name: planning
description: Review the current state of planning — active work, queued items, priorities, and alignment. Use when the user wants a status check, says "planning", asks "how am I doing", or wants to review priorities. Reads repo-specific planning context from .claude/docs/planning.md.
---

# Planning

Review the current state of planning by reading the repo's planning context and following its references.

## Process

### 1. Load Planning Context

Read `.claude/docs/planning.md` in the current repository.

**If the file is missing**, tell the user:

> No planning context found. To use `/planning`, create `.claude/docs/planning.md` describing your planning setup — focus areas, where active/queued items live, and where recent activity is tracked.

Then stop.

### 2. Read Focus / Priorities

From the planning doc's **Focus** section, read the referenced priority and goal documents. Summarize:
- What are the current high-level priorities?
- What should be getting the most attention right now?

### 3. Active Items and Next Actions

From the planning doc's **Active items** section, find items matching the "active" criteria described there.

For each active item:
- Show its name and any relevant metadata (category, tier, area, etc.)
- **Extract Next Actions** — incomplete tasks (`- [ ]`) from each item
- Flag items with **no Next Actions** defined (needs planning attention)
- Flag items that appear **stalled** (no recent updates, empty task lists)

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

### 8. Output Summary

Provide a structured summary using the [output template in REFERENCE.md](REFERENCE.md#output-template).
