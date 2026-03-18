# Task Plan — Reference

## Proposal Format

Present proposed tasks as a markdown table using the repo's configured fields. Adapt columns to match config.

### Example with minimal config (dotfiles-style)

```
| # | Title | Priority | Notes |
|---|-------|----------|-------|
| 1 | Set up hyprpaper wallpaper rotation | Medium | Needs hyprpaper package |
| 2 | Add screenshot keybinding | High | Depends on grimblast |
| 3 | Configure swayidle timeouts | Low | After hyprlock is stable |

Create all 3 tasks? (select which to create)
```

### Example with rich config (frontmatter-style)

```
| # | Title | Initiative | Priority | Status | Notes |
|---|-------|-----------|----------|--------|-------|
| 1 | Draft security review template | safety-governance | High | next | Blocking other reviews |
| 2 | Set up context library repo | context-library | Medium | later | |
| 3 | Schedule intro meetings | admin | High | now | Time-sensitive |

Create all 3 tasks? (select which to create)
```

## Extracting Work Items

When analyzing input, look for:

- **Explicit tasks/action items** — bullet points starting with verbs, checkbox lists
- **Deliverables** — named outputs, documents, features
- **Dependencies** — things that must happen before other things (these become high priority)
- **Milestones** — break these into constituent tasks

### Sizing guidance

- If a work item would take >1 day, consider splitting it
- If a work item is <15 minutes, consider combining with related items
- Each task should have a clear "done" state

## Deduplication

When checking against existing tasks:
- Match by title similarity (>70% word overlap)
- Match by topic (same subject area + similar scope)
- If a proposed task overlaps with an existing one, note it: "Similar to existing: filename.md"
- Let the user decide whether to skip, merge, or create anyway
