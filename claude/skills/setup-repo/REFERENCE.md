# Setup Claude — Reference

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

## Advanced Patterns

### Monorepo Support

Claude loads `CLAUDE.md` from all parent directories. For monorepos, use nested `CLAUDE.md` files so backend devs don't scroll past React guidelines:

```
monorepo/
├── CLAUDE.md              # Shared conventions
├── apps/
│   ├── web/CLAUDE.md      # React-specific rules
│   └── api/CLAUDE.md      # Backend-specific rules
```

### Recommended Hooks

Beyond the git guardrails hook, add these as the project needs them:

| Hook | What It Does | When to Add |
|------|-------------|-------------|
| **Auto-format** (PostToolUse) | Runs prettier/black/gofmt after file edits | Day 1 if team uses formatters |
| **Type-check** (PostToolUse) | `tsc --noEmit` after edits | TypeScript repos |

**Performance budget:** Synchronous hooks should complete in under 5 seconds.

### CI Environment

Disable auto-memory in CI and non-developer environments:

```bash
export CLAUDE_CODE_DISABLE_AUTO_MEMORY=1
```

### Layered Config

Combine project-level `.claude/` (committed to git) with personal `~/.claude/` (local preferences). Personal prefs like voice/tone live globally; project rules stay in the repo.

### Mistake-to-Rule Practice

After every correction: *"Update CLAUDE.md so you don't make that mistake again."* This organic growth produces better CLAUDE.md files than upfront planning — real mistakes produce precise rules. One team tracked: corrections dropped from every 3-4 interactions to every 8-10 after two days of this practice.

## Summary Output

Show the user what was created:

```
## Project Init Complete

**Created:**
- CLAUDE.md — [created / skipped / regenerated] ([N] lines)
- .claude/settings.json — permissions + git guardrails hook
- .claude/rules/ — conventions.md, testing.md, security.md
- .claude/references/ — architecture.md, stack.md
- .claude/skills/ — commit/, review/
- .claude/hooks/ — block-dangerous-git.sh

**Evolv context:** [references developer-ai-toolkit / not an Evolv repo]

**Next steps:**
- Review all generated files and adapt to your project
- Fill in references/architecture.md and verify references/stack.md
- Add project-specific rules to the marked sections in rules/*.md
- Treat .claude/ like a test suite — update at least monthly
```
