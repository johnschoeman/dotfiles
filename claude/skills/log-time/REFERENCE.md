# Log Time — Reference

## Confirm and Append (Step 4)

After user confirms (or adjusts):

1. Read `~/workspace/evolv-notes/_daily/timesheet.md` to find the current month's table
2. Append the entry as a new row at the end of the current month's table (before the week totals section)
3. If the month section doesn't exist yet, create it with the table header:
   ```
   ### [Month Name]

   | Date       | Hours | Initiative | Category | Description                                     |
   | ---------- | ----- | ---------- | -------- | ----------------------------------------------- |
   | ...        | ...   | ...        | ...      | ...                                             |
   ```
4. Update the week totals if they exist — add hours to the current week's total, or create a new week entry

## Ask About Other Work (Step 5)

After appending the entry, ask:

> Any other work today not captured here? (meetings, learning, work in other repos, etc.)
> Say "done" to skip.

If the user describes additional work:
- Propose another entry following the same format
- Repeat until user says "done" or skips

## Summary (Step 6)

Show a brief summary:

```
Logged today:
- Xh: initiative (category) — description
- Yh: initiative (category) — description
Total: Zh

Week so far: [total]h / 20h target
```

## Table Format

The timesheet table uses this exact format:

```
| Date       | Hours | Initiative | Category | Description                                     |
| ---------- | ----- | ---------- | -------- | ----------------------------------------------- |
```

- Date: `YYYY-MM-DD`
- Hours: number (0.5 increments)
- Initiative: lowercase, hyphenated (match existing entries)
- Category: `roadmap` | `stakeholder` | `reactive` | `learning`
- Description: free text, concise

## Valid Values

**Initiatives** (from `~/workspace/evolv-notes/initiative-planning/initiatives/`):
- `claude-code-pilot`, `knowledge-hub`, `safety-governance`, `ai-agent-pilot`, `user-research`
- `learning` — personal projects, skill building
- `admin` — meetings, planning, overhead

**Categories** (from priority framework):
- `roadmap` — initiative delivery work
- `stakeholder` — meetings, 1:1s, admin
- `reactive` — ad-hoc requests, quick wins
- `learning` — skill building, exploration
