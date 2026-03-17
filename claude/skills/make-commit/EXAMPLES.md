# Make Commit — Examples

## Feature addition

**Git state shows:**
- Modified: `src/auth.ts`, `src/routes/login.ts`
- New file: `src/middleware/rate-limit.ts`

**Resulting commit:**

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

## Simple config change

**Git state shows:**
- Modified: `nixos/home/helix.nix`

**Resulting commit:**

```
Enable soft wrap in helix

Why:

Long lines in markdown and config files required horizontal
scrolling, making editing awkward.

This commit:

- Add soft-wrap.enable = true to helix editor config
```
