---
name: setup-repo
description: Set up or audit Claude Code infrastructure for a project. Creates CLAUDE.md, .claude/ directory. Use when initializing a new project, saying "setup repo", or reviewing a project's Claude config.
model: sonnet
effort: medium
---

Set up Claude Code infrastructure from scratch, or audit an existing setup and suggest improvements.

## Quick Start

Run `/setup-repo` from any project. The skill will:

1. Scan for existing Claude infrastructure (CLAUDE.md, .claude/ directory)
2. If missing: generate it from codebase analysis
3. If present: audit it against the standard layout

## Quality Standards

**Sizing target:** CLAUDE.md should be under 200 lines (~1,500 tokens). Treat every line like ad space — if removing it wouldn't cause Claude to make mistakes, cut it.

**80/20 rule:** 80% work description (audience, constraints, standards), 20% behavioral guidance. If your CLAUDE.md is mostly personality rules, rebalance.

**What belongs in CLAUDE.md:**

| Include | Put elsewhere |
|---------|---------------|
| Build/test/lint commands | Exhaustive API references (`.claude/references/`) |
| Constraints ("use Zustand, not Redux") | Standard conventions Claude already knows |
| Key architecture decisions | Verbose explanations (link to README) |
| Non-obvious gotchas with "why" | Session-specific state |
| Routing table (task → directory) | Content duplicated from README.md |

**Enforcement hierarchy:** Linters > hooks > CLAUDE.md. Only put rules in CLAUDE.md that require LLM judgment. If a linter or hook can enforce it, don't spend context tokens on it.

**Conciseness principles:**

- Skip what Claude already knows (standard language features, common framework patterns)
- Be specific, not generic — "use `pytest -x --tb=short`" beats "run tests"
- Use directive language — MUST, NEVER, ALWAYS outperform soft suggestions. Compare: "It's generally better to use server components" vs "ALWAYS use server components unless the component needs useState or event handlers"
- Include "why" for non-obvious decisions — "Zustand not Redux (bundle size)" saves re-litigation
- The template is a ceiling, not a floor — delete sections that don't apply
- Link, don't inline — for deeper context, use "Read `docs/api-patterns.md` when adding a new endpoint" so context loads only when relevant
- Start minimal, grow organically — begin with Key Commands + a few hard rules, then add rules only when Claude makes a specific mistake. Upfront planning produces bloated files; real usage produces precise rules

## Workflow

### Scan

**1. Scan existing infrastructure**

Check which of these exist and read their contents:
- `CLAUDE.md`
- `.claude/settings.json`
- `.claude/rules/`
- `.claude/references/`
- `.claude/skills/`
- `.claude/agents/`
- `.claude/hooks/`

Also check the user's global Claude settings:
- `~/.claude/CLAUDE.md` — check for voice/behavior rules
- `~/.claude/settings.json` — check for global hooks or permissions

If no project infrastructure exists → run the **Fresh Setup** phase.
If any exists → run the **Audit** phase.

### Fresh Setup

**2a. Fresh Setup** (when no Claude infrastructure exists)

**Analyze the codebase:**
- Language, frameworks, libraries
- Build / test / lint commands (package.json, Makefile, Cargo.toml, etc.)
- Directory structure and key subdirectories
- Architecture — major components, entry points
- Git history — `git log --oneline -20`

**Select a template:**

| Template | Use when |
|----------|----------|
| [Simple](CLAUDE-TEMPLATE-SIMPLE.md) | Single language, straightforward build, few conventions |
| [Full](CLAUDE-TEMPLATE-FULL.md) | Complex architecture, multiple services, team onboarding needs |

Either way, delete sections that don't apply — the template is a ceiling, not a floor.

**Ask the user for coding guidelines:**
Ask if there are specific rules for how Claude should write code in this project — patterns to follow, patterns to avoid, preferred libraries, error handling style, etc. Capture these as directive statements in the Conventions section. Use command language: "Always use X", "Never do Y", "Prefer X over Y". Vague preferences are less useful than direct instructions.

**Add behavioral rules** that shape how Claude approaches work. High-impact defaults:

- **Think before coding** — state assumptions explicitly, surface confusion instead of guessing
- **Simplicity first** — implement only requested features, avoid abstractions for single-use code
- **Surgical changes** — touch only what's needed, match existing style, don't improve adjacent code unprompted
- **Goal-driven execution** — frame requests as success criteria: "Add validation" → "Write tests for invalid inputs, then make them pass"

Frame rules as goals, not steps — Claude loops well against success criteria. Include only the behavioral rules relevant to the project; these are defaults to suggest, not mandatory.

**Generate CLAUDE.md** at project root using the selected template. Standard sections:

- **Overview** — what the repo does, product, team
- **Key Commands** — build, test, lint, dev server
- **Verification** — commands Claude should run after code changes (tests, lint, build). Output quality increases 2-3x when Claude can check its own work
- **Key Directories** — top-level layout with purpose
- **Architecture** — only if complexity warrants it (multiple services, non-obvious data flow)
- **Voice** — terse response rules (included in both templates by default)
- **Behavioral Rules** — think before coding, simplicity, surgical changes, goal-driven execution
- **Conventions** — patterns, naming, file organization, coding guidelines
- **Where to Look** — routing table mapping task types to directories and reference docs
- **Common Tasks** — how to add a feature/endpoint/component (if the codebase has a repeatable pattern)
- **Gotchas** — non-obvious things that cause mistakes
- **Git Workflow** — use verbatim from [REFERENCE.md](REFERENCE.md#git-workflow-verbatim)

Skip sections that aren't meaningful for the repo.

**For Evolv repos:** Include a line in the Overview or a standalone section:

```markdown
**Shared context:** For Evolv-wide conventions and reusable skills, see the [developer-ai-toolkit](https://bitbucket.org/evolvmosaiq/developer-ai-toolkit).
```

NEVER duplicate Evolv-wide content — reference it.

**Scaffold .claude/ directory** from [templates/](templates/.claude/):

| Component | Source | Action |
|-----------|--------|--------|
| `settings.json` | [template](templates/.claude/settings.json) | Copy — includes schema URL, permissions, git guardrails hook |
| `rules/` | [conventions](templates/.claude/rules/conventions.md), [testing](templates/.claude/rules/testing.md), [security](templates/.claude/rules/security.md) | Copy all three. Ask user which apply; remove irrelevant ones |
| `references/stack.md` | [template](templates/.claude/references/stack.md) | Fill in from codebase analysis (language, framework, libraries, commands) |
| `references/architecture.md` | [template](templates/.claude/references/architecture.md) | Copy as template — too project-specific to auto-fill |
| `skills/commit/` | [template](templates/.claude/skills/commit/) | Copy SKILL.md + TEMPLATE.md |
| `skills/review/` | [template](templates/.claude/skills/review/) | Copy SKILL.md |
| `skills/project-index/` | [template](templates/.claude/skills/project-index/) | Copy SKILL.md + references/TEMPLATE.md |
| `hooks/` | [template](templates/.claude/hooks/block-dangerous-git.sh) | Copy and make executable |

For `references/stack.md`, fill in what you can from the codebase analysis. Leave sections empty that you can't determine.

**Modular rules:** As the project grows, move rules into scoped files in `.claude/rules/` with path-based YAML frontmatter. Claude only loads rules relevant to the files it's working with — more effective than a long CLAUDE.md:

```markdown
# .claude/rules/api-standards.md
---
paths:
  - "src/api/**/*.ts"
---

- All endpoints MUST include Zod input validation
- Use AppError format for error responses
- Include OpenAPI JSDoc comments on every handler
```

Start with three rule files: `conventions.md`, `testing.md`, `security.md`. Add scoped rules as the codebase grows.

### Review & Maintain

**3. Remind the user to review and adapt**

After setup, tell the user:

> **Review the generated files** and adapt them to your project. These are starter templates — the real value comes from customizing them to your specific codebase.
>
> Treat your `.claude/` files like a test suite — they're living artifacts that need continuous maintenance. **Update them at least monthly**, or whenever Claude makes a repeated mistake. The "Mistake to Rule" practice is the best way to grow precise rules: every correction becomes a permanent improvement.

Specifically call out:
- `rules/conventions.md` — add project-specific patterns in the marked section
- `rules/testing.md` — uncomment and fill in verification commands
- `rules/security.md` — add project-specific security requirements
- `references/architecture.md` — fill in when you have time; high-value for cross-cutting work
- `references/stack.md` — verify auto-filled content is accurate

### Audit

**2b. Audit** (when infrastructure already exists)

**Sizing check:**
- Count lines in CLAUDE.md. If over 200 lines, flag it and suggest pruning or offloading detail to `.claude/references/`.
- Check for content that duplicates README.md — suggest removing and linking instead.
- Check the 80/20 balance — if mostly behavioral/personality rules, suggest adding more work description.

**Compare each component against the standard:**

| Component | Standard |
|-----------|----------|
| `CLAUDE.md` | Sections: Overview, Key Commands, Verification, Key Directories, Architecture (if complex), Voice, Behavioral Rules, Conventions, Where to Look, Common Tasks, Gotchas, Git Workflow |
| `.claude/settings.json` | Schema URL, permissions (deny/allow), PreToolUse hook for git guardrails |
| `.claude/rules/` | conventions.md, testing.md, security.md (at minimum) |
| `.claude/references/` | architecture.md, stack.md |
| `.claude/skills/` | commit/ and review/ (at minimum) |
| `.claude/hooks/` | block-dangerous-git.sh |

**Check CLAUDE.md for:**
- Missing sections vs standard template
- Stale content (repo structure vs reality, commands that may no longer work)
- Missing voice section (terse response rules)
- Missing git workflow section
- Missing developer-ai-toolkit reference (Evolv repos)
- Generic content that Claude already knows (candidates for removal)
- Missing verification section
- Missing behavioral rules (think before coding, simplicity, surgical changes, goal-driven execution)
- Missing routing table (Where to Look)
- Soft language ("consider using", "try to") instead of directives ("ALWAYS use", "NEVER do")
- Rules that a linter or hook could enforce instead

**Check .claude/ infrastructure for:**
- Missing or empty `rules/` directory — suggest adding from [templates](templates/.claude/rules/)
- Missing `references/` files — suggest adding architecture.md and stack.md
- Missing project-local skills — suggest adding commit/, review/, and project-index/
- Missing git guardrails — check `settings.json` for PreToolUse hook and `hooks/` for block script
- Missing deny/allow permissions in `settings.json`

**Present findings:**

```
## Claude Setup Audit

**Line count:** [N lines — within/over target of 200]
**Present:** [what exists and looks good]
**Missing:** [what doesn't exist, with what it enables]
**Suggestions:** [specific improvements — prune, restructure, add sections]
```

Ask which changes to apply. Make changes only with user approval.

## Success Criteria

Setup is complete when:
- CLAUDE.md exists with relevant standard sections
- CLAUDE.md is under 200 lines (or user acknowledged and accepted the size)
- CLAUDE.md follows 80/20 rule (mostly work description, not personality)
- Evolv repos reference the developer-ai-toolkit
- `.claude/` directory fully scaffolded: settings.json, rules/, references/, skills/ (commit/, review/, project-index/), hooks/
- Git guardrails in place (settings.json + hook script)
- User reminded to review, adapt, and maintain .claude/ files continuously
- User has a clear summary of what was created/changed
