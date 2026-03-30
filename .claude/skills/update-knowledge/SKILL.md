---
name: update-knowledge
description: Review and update .claude/KNOWLEDGE.md with stable knowledge from the session — decisions, learnings, operational context. Run when you've learned something worth persisting.
---

# Update Knowledge

Review the session for stable knowledge worth persisting and update `.claude/KNOWLEDGE.md`.

## Process

### 1. Read Existing Knowledge

Read `.claude/KNOWLEDGE.md`. If the file doesn't exist, create it with:

```markdown
# Knowledge

Stable knowledge for this repository. Read at session start. Organized by topic, not chronologically.

---

## Decisions

[Choices and reasoning — why X not Y. Things that shouldn't be re-litigated.]

## Learnings

[Discovered facts, gotchas, technical notes. Things figured out through experience.]
```

### 2. Review the Session

Look through the conversation for knowledge that should persist:

**Decisions** — choices with reasoning. Prescriptive — guides future behavior.
- "We use X because Y"
- "A not B, because..."
- NixOS configuration choices, tool preferences, workflow decisions

**Learnings** — discovered facts. Descriptive — saves rediscovery.
- Nix/NixOS gotchas and workarounds
- How home-manager modules actually behave
- Hyprland/Waybar configuration quirks
- Operational values (paths, commands) needed repeatedly

### 3. Check for Stale Entries

Review existing entries against what you now know. Flag anything outdated or contradicted by the session's work.

### 4. Update the File

- Add new entries under the appropriate section (Decisions or Learnings)
- Use topic subheadings within each section to organize by area
- Revise entries that are now outdated
- Remove entries that are no longer true

### 5. Show the User What Changed

Summarize what was added, revised, or removed so they can review.

## Guidelines

- Organize by topic, not chronologically
- Keep entries concise — facts and decisions, not narratives
- Remove entries that become outdated
- Only add knowledge that's stable and confirmed — not speculative
- This is distinct from the session log: knowledge = stable facts and decisions, session log = what happened when
<!-- catalog: update-knowledge v1 -->
