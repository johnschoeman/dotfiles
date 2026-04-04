---
name: session-wrap
description: End-of-session wrap-up — update session log, persist key decisions to knowledge, and suggest a commit. Use when finishing a work session, saying "wrap up", or ready to commit and close out.
---

# Session Wrap

Run three end-of-session steps in sequence: capture session context, persist stable knowledge, and suggest a commit.

## Process

### Step 1: Update Session Log

Follow the full `/session-update` process:

1. Review the conversation for goals, approach, tradeoffs, and open threads
2. Run `git diff --stat` and `git log --oneline -3` for grounding
3. Read today's `.claude/session-history/YYYY-MM-DD.md` (append if exists)
4. Read the 2-3 most recent session history files for continuity
5. Write the entry and show it to the user

### Step 2: Update Knowledge (conditional)

Review the session for stable knowledge — skip this step if there's nothing new.

**Add knowledge when the session produced:**
- Decisions with reasoning ("X not Y because...")
- NixOS/Nix gotchas or workarounds discovered
- Operational facts needed repeatedly

**Skip when:**
- Session was routine config editing with no new insights
- All learnings are session-specific, not reusable

If updating, follow the `/knowledge-update` process: read `.claude/KNOWLEDGE.md`, add/revise entries, remove stale ones, and show what changed.

### Step 3: Suggest a Commit

Follow the `/commit` process (always suggest mode — never run `git commit`):

1. Run `git status`, `git diff`, `git diff --staged`, `git log --oneline -5`
2. Analyze changes — identify what's part of the session's work vs unrelated
3. Write commit message to `commit-msg.txt`
4. List which files to stage (call out any files to exclude, including `commit-msg.txt`)
5. Remind: "You may want to commit these changes"

## Notes

- Each step builds on context from the previous — run sequentially, not in parallel
- If there are no uncommitted changes, skip step 3 and note it
- The session log captures narrative; knowledge captures stable facts — don't duplicate between them
- Never run `git commit`, `git add`, or any git write commands directly
<!-- catalog: session-wrap v1 -->
