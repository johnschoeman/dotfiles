# Git Analysis — Examples

## Notes repository

```bash
~/.claude/skills/git-analysis/scripts/analyze_colocations.sh \
  --strip-prefix notes-vault/ --exclude '_daily/dn_' 3
```

**Sample output:**

```
Analyzing Git History for File Colocation Patterns...
Looking back 3 months (since 2026-01-01)

Analyzing 142 commits

========================================================================
FILES FREQUENTLY MODIFIED TOGETHER (2+ times)
========================================================================

 12x _plans/projects/knowledge-hub.md
     -> professional/knowledge-management.md

  8x _plans/priority-framework.md
     -> _daily/wk_2026-03-10.md

  5x software/blog-posts/claude-code-tips.md
     -> professional/ai-tools.md

========================================================================
CROSS-DOMAIN PATTERNS (commits touching multiple domains)
========================================================================

 28x _plans <-> professional
 15x software <-> professional
  9x _plans <-> _daily
```

**What to look for:**
- The knowledge-hub project and knowledge-management doc always change together — tightly coupled
- Priority framework and weekly notes co-modify — weekly review updates priorities
- Cross-domain: _plans and professional is the strongest link — most planning is career-related
