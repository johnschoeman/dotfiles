---
name: git-analysis
description: Analyze git commit history to reveal patterns in how files are modified together. Use when reviewing organization, considering restructuring, or wanting to understand which files are conceptually linked.
argument-hint: [months]
---

# Git History Analysis

Analyze git commit history to reveal patterns in how files are modified together. This data-driven approach can suggest better organizational groupings based on actual usage patterns.

## Process

### 1. Run the Analysis

Use `~/dotfiles/scripts/analyze_colocations.sh` with the user-provided timeframe (default: 6 months).

```bash
~/dotfiles/scripts/analyze_colocations.sh [OPTIONS] [MONTHS]
```

**Options:**
- `--strip-prefix PREFIX` — Remove a path prefix from files (use when the repo has a subfolder root, e.g., `notes-vault/`)
- `--exclude PATTERN` — Exclude files matching a pattern (repeatable)

Before running, check the repo structure. If files are nested under a single subfolder that acts as the real root (visible from `git log --oneline --name-only -5`), pass `--strip-prefix` to normalize paths.

### 2. Interpret Results

**Files frequently modified together:**
- File pairs appearing in the same commits multiple times reveal hidden relationships
- Cross-folder pairs suggest work that spans current structure boundaries

**Hot spots:**
- Files that change frequently are central to current work
- Files that never change may be stale or archive candidates

**Cross-folder patterns:**
- Commits touching multiple folders show which areas are worked on together
- Can suggest when folder boundaries don't match actual work patterns

### 3. Report

Summarize findings with:
- Top file co-modification pairs and what they suggest
- Cross-folder patterns worth noting
- Surprises — unexpected relationships
- Suggestions — restructuring ideas, if any patterns are strong

## Tips

- Run periodically (every 2-3 months) to see how patterns evolve
- Try different timeframes to distinguish recent vs long-term patterns
- Look for surprises — expected pairs confirm structure, unexpected pairs reveal insights
