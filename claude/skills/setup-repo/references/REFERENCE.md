# Setup Repo — Reference

## Git Workflow (Verbatim)

Use this section exactly as-is in every generated CLAUDE.md:

````markdown
## Git Workflow

User manages all commits. You remind and suggest, never commit.

**After significant work:**
1. Run `git status` to see what's actually uncommitted
2. Write commit message to `commit-msg.txt`
3. Remind: "You may want to commit these changes"

**Commit message format:**
```
Concise summary (one line)

Why:

[Brief motivation - what problem this solves]

This commit:

- [Bullet points of actual changes]
- [Only include uncommitted changes, not already-committed work]
```

**Never:** Run git commands that modify history.
````

## KNOWLEDGE.md Template

```markdown
# Knowledge

Stable knowledge for this repository. Read at session start. Organized by topic, not chronologically.

---

## Decisions

[Choices and reasoning — why X not Y. Things that shouldn't be re-litigated.]

## Learnings

[Discovered facts, gotchas, technical notes. Things figured out through experience.]
```

## Summary Output

Show the user what was created:

```
## Project Init Complete

**Created:**
- CLAUDE.md — [created / skipped / regenerated] ([N] lines)
- .claude/KNOWLEDGE.md — [created / already existed]
- .claude/settings.json — permissions + git guardrails hook
- .claude/rules/ — conventions.md, testing.md, security.md
- .claude/context/ — architecture.md, stack.md
- .claude/skills/ — commit/, review/
- .claude/hooks/ — block-dangerous-git.sh

**Next steps:**
- Review all generated files and adapt to your project
- Fill in context/architecture.md and verify context/stack.md
- Add project-specific rules to the marked sections in rules/*.md
- Treat .claude/ like a test suite — update at least monthly
```
