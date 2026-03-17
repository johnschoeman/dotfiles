---
name: ghost
description: Answer a question or draft text the way the user would, drawing on their vault writing for voice and perspective. Use when the user wants a response in their own voice, asks "what's my take on...", or wants to draft something that sounds like them.
argument-hint: [question or topic]
---

# Ghost — Write in the User's Voice

Read-only skill. Searches the vault for relevant writing, calibrates to the user's voice, and synthesizes a response as if they wrote it. Never modifies files.

## Process

### 1. Parse the Request

The user's `/ghost` argument (or conversation context) is the question or topic. Identify:
- **Intent**: Are they asking for their take on something, or drafting something (email, post, message)?
- **Register**: Professional, personal/reflective, technical/teaching? This guides which voice sources to prioritize.

### 2. Voice Calibration (Always Do This)

Read the 2-3 most recent weekly notes (`_daily/wk_*.md`, excluding `wk_template.md`). For each, extract the `# Narrative` section — this is the user's unfiltered voice.

These narratives establish baseline voice patterns: vocabulary, sentence structure, level of candor, how they frame problems, their reasoning style.

### 3. Extract Keywords

From the user's question/topic, extract 3-5 search keywords. Include synonyms and related terms. For example:
- "career decision" → career, job, role, professional, decision
- "work-life balance" → balance, burnout, energy, boundaries, work

### 4. Search for Topic-Relevant Content

Search the vault using grep with the extracted keywords. Search these locations in priority order:

1. **Weekly narratives & daily notes** (`_daily/wk_*.md`, `_daily/dn_*.md`) — personal perspective
2. **Blog posts** (`software/blog-posts/`) — teaching and mentoring voice
3. **Content notes** (`_content-notes/_processed/`) — analytical voice
4. **Project files** (`_plans/projects/`) — strategic thinking (`## Notes / Narrative` and `## Why This Project`)
5. **Domain research notes** (`*/_research-notes.md`) — curated insights
6. **Professional writing** (`professional/`) — work context

Read the top 5-8 most relevant files or sections.

### 5. Assess Coverage

Before synthesizing, assess:
- **Strong coverage**: Multiple files with direct writing on this topic → full ghost response
- **Partial coverage**: Some relevant writing but gaps → proceed, note what's inferred vs. grounded
- **No coverage**: Nothing in the vault → tell the user honestly and offer Claude's voice instead

### 6. Synthesize Response

Write the response **as the user would write it**:

- Use their actual vocabulary and phrasing patterns from the narratives
- Match their sentence length and structure tendencies
- Preserve their level of nuance and candor
- Match register to topic (professional/personal/technical)
- Draw on specific things they've written — paraphrase or reference directly
- Don't invent opinions they haven't expressed — flag when extrapolating

See [REFERENCE.md](REFERENCE.md) for voice anti-patterns, vault paths, and tone guidance.

## Output Format

```
## Ghost Response

[Answer in the user's voice — matching tone, reasoning style, vocabulary]

---
*Voice sources: [list of files that informed this response]*
```

If drafting something specific (email, post, message), format appropriately for that medium instead.
