# Suggest Commit — Examples

## Bug fix

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
> git add -A && git commit -F commit-msg.txt
> ```
