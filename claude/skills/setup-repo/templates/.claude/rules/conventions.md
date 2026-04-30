# Coding Conventions

Design conventions that require judgment — things linters can't enforce.

## Universal

- ALWAYS prefer simplicity — implement only what's requested, no speculative features
- ALWAYS match existing patterns in the codebase before inventing new ones
- Use early returns to reduce nesting
- Small functions (<40 lines) and small files (<500 lines)
- Name things for the domain, not the implementation
- Prefer composition over inheritance
- One concept per file — if a file does two unrelated things, split it

## Project-Specific

<!-- Add conventions specific to this project below. Examples: -->
<!-- - ALWAYS use server components unless the component needs useState or event handlers -->
<!-- - NEVER use default exports — use named exports for better refactoring -->
<!-- - Prefer X library over Y for [reason] -->
