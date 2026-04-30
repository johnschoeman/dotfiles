# CLAUDE.md Full Template

````markdown
# CLAUDE.md

## Overview

[What this repo does in 1-2 sentences.]

**Product:** [Express | eXpedite | Portal | Insights | Internal]
**Team:** [Team name]

## Key Commands

```bash
[install]     # Install dependencies
[dev]         # Run locally
[test]        # Run tests
[build]       # Build for production
[lint]        # Lint / format
```

## Verification

After code changes, run:

```bash
[test]        # Run tests
[lint]        # Lint / format
[build]       # Verify build passes
```

## Key Directories

| Path | Purpose |
|------|---------|
| `src/` | [Description] |
| `tests/` | [Description] |
| `config/` | [Description] |

## Architecture

[Brief description — what type of app/service, key technologies, how it fits into Evolv's system.]

<!-- For detailed architecture docs, link instead of inlining: -->
<!-- "Read `.claude/references/architecture.md` for component diagrams and data flow." -->

## Voice

Terse by default — saves tokens and keeps signal high.

1. **Ultra-short** — 1-4 words max per sentence. One-word answers preferred.
2. **No filler** — no preamble, no pleasantries, no narration, no "Me do X" announcements.
3. **Tools first** — run tools, show result, stop. Don't announce what you're about to do. If you must speak before a tool call, one word max (e.g., "Checking.").
4. **Drop pronouns and articles** — no "Me", "I", "the", "a", "an". Just the action or answer. Example: "Fixed." not "Me fix code."
5. **Answers are telegrams** — strip every word that doesn't add information. If the answer is a list, just list it. If yes/no, just say it.

User can say **"talk normal"** to switch to standard verbose responses. Say **"use terse voice"** to re-enable.

## Behavioral Rules

- **Think before coding** — state assumptions explicitly. If multiple approaches exist, present them — don't pick silently. If something is unclear, stop and ask.
- **Simplicity first** — NEVER add features beyond what was asked. No abstractions for single-use code. No speculative "flexibility." If you write 200 lines and it could be 50, rewrite it.
- **Surgical changes** — touch only what you must. Don't "improve" adjacent code, comments, or formatting. Match existing style. If your changes create unused imports/variables, remove those — but don't remove pre-existing dead code.
- **Goal-driven execution** — frame tasks as verifiable success criteria. "Add validation" → "Write tests for invalid inputs, then make them pass." Loop against criteria until verified.

## Conventions

<!-- Use directive language: MUST, NEVER, ALWAYS. Vague preferences are less useful than direct instructions. -->
<!-- Only add rules that require LLM judgment — if a linter or hook enforces it, don't repeat it here. -->
- [e.g., ALWAYS use server components unless the component needs useState or event handlers]
- [e.g., NEVER import from `src/legacy/` — use `src/core/` equivalents]
- [e.g., MUST include `why` in error messages — "Failed to parse config: missing 'port' key"]
- [Naming conventions]
- [File organization patterns]
- [Error handling approach]

<!-- Link, don't inline: for deeper context, use patterns like -->
<!-- "Read `docs/api-patterns.md` when adding a new endpoint" -->
<!-- "Read `.claude/references/stack.md` for library versions and constraints" -->

## Where to Look

<!-- Map task types to directories and reference docs so Claude navigates without guessing -->
- [e.g., API changes → `src/api/`, read `docs/api-patterns.md` for conventions]
- [e.g., Frontend → `src/components/`, follow patterns in `src/components/Button/`]
- [e.g., Tests → run `pnpm test`, co-locate with source files]

## Common Tasks

### Adding a new [endpoint/feature/component]

1. [Step 1]
2. [Step 2]
3. [Step 3]

## Gotchas

- [Non-obvious things that trip people up — include "why" for decisions that seem wrong]
- [Legacy decisions with reasons — e.g., "Zustand not Redux (bundle size)"]
- [Areas of technical debt to be aware of]

## Evolv Developer AI Toolkit

For Evolv-wide coding conventions, AI guidelines, and reusable skills, see the [developer-ai-toolkit](https://bitbucket.org/evolvmosaiq/developer-ai-toolkit) repo.

## Skill Auto-Routing

Load skills automatically — users shouldn't need to invoke them manually.

| Trigger | Skill |
|---------|-------|
| Locating files, navigating the codebase, understanding project structure | `project-index` |

<!-- Add more rows as the project grows — e.g., writing tests → `tdd`, reviewing changes → `code-review` -->

## Git Workflow

[Paste from REFERENCE.md verbatim]

<!-- Start minimal, grow organically. Add rules only when Claude makes a specific mistake. -->
<!-- Review quarterly — remove stale rules, offload detail to .claude/references/. -->
````
