---
name: review
description: Review code changes against project conventions — quality, security, and patterns. Report-only — never applies fixes.
---

# Code Review

Review code changes against project conventions. Produces an actionable findings report without applying fixes.

## Usage

`/review` — review all recent changes
`/review src/api/` — review specific files or directories
`/review security` — security-focused review only

## Process

### 1. Determine Files

- If files specified, use those
- Otherwise, run `git diff --name-only HEAD` and `git diff --name-only --cached` to find recent changes
- If no changes found, inform the user and stop

### 2. Load Conventions

Read project rules from `.claude/rules/` and any convention files relevant to the files being reviewed.

### 3. Review

For each file, check against:

**General quality:**

- Does it follow project conventions?
- Are there naming issues, dead code, or unnecessary complexity?
- Does it handle errors appropriately?
- Are there missing tests?

**Security (always included):**

- Input validation at system boundaries
- SQL injection, XSS, or other injection risks
- Credential or PII exposure
- Authorization checks

**Duplicate code:**

Compare changed files against each other. If two or more files contain similar logic, flag it and recommend extracting a shared function. Suggest a name and location.

### 4. Report

Output findings grouped by severity:

```
## Code Review

**Files reviewed:** [count]

### Critical
[Issues that must be fixed before merging]

### Suggestions
[Improvements that would help but aren't blockers]

### Good
[Things done well — reinforce good patterns]
```

## Constraints

- NEVER apply fixes — report only
- NEVER modify files
- If no issues found, say so clearly
