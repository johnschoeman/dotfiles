# Commit — Examples

## Suggest mode (default)

**Git state shows:**
- Modified: `lib/parser.ts`

**Resulting commit message written to `commit-msg.txt`:**

```
Fix off-by-one error in CSV parser

Why:

CSV files with trailing newlines produced an empty final row,
causing downstream validation failures.

This commit:

- Trim trailing whitespace before splitting rows
- Skip empty rows during parsing
```

**Output to user:**

> Commit message written to `commit-msg.txt`. You can commit with:
> ```bash
> git add lib/parser.ts && git commit -F commit-msg.txt
> ```

## Run mode (`/commit --run`)

**Git state shows:**
- Modified: `src/auth.ts`, `src/routes/login.ts`
- New file: `src/middleware/rate-limit.ts`

**CLAUDE.md has no git restrictions, so commit proceeds:**

```
Add rate limiting to login endpoint

Why:

Login endpoint was vulnerable to brute-force attempts. Adding
per-IP rate limiting protects user accounts without impacting
normal usage.

This commit:

- Add rate-limit middleware with configurable window and max attempts
- Apply rate limiting to POST /login route
- Add rate limit headers to login responses
```

**Output:** `a1b2c3d Add rate limiting to login endpoint`

## Run mode blocked by CLAUDE.md

**CLAUDE.md contains:** "User manages all commits. You remind and suggest, never commit."

**Output:**

> This repo's CLAUDE.md says the user manages commits — falling back to suggest mode.
>
> Commit message written to `commit-msg.txt`. You can commit with:
> ```bash
> git add -A && git commit -F commit-msg.txt
> ```
