# Task Update — Reference

## Search Strategy

Match the user's argument against task filenames and titles. Priority order:

1. **Exact filename** — argument matches filename minus `.md` extension
2. **Filename contains all words** — all search words appear in the filename
3. **Title contains all words** — all search words appear in the H1 title
4. **Any word match** — filename or title contains any search word

When multiple matches exist at the same priority level, present all as options via `AskUserQuestion`.

### Examples

| Argument | Matches |
|----------|---------|
| `remove-impure-flag` | Exact: `12-remove-impure-flag.md` |
| `impure flag` | All words in filename: `12-remove-impure-flag.md` |
| `safety governance` | All words in title: file with H1 "Draft Safety Governance Charter" |
| `packages` | Any word: `14-packages-to-review.md` |

### Searching the JSON Output

The task-list.py output groups tasks by status. To search:
1. Iterate all groups (now, next, later, etc.)
2. Check each task's `file` and `title` fields
3. Also check `done_recent` for recently completed tasks
