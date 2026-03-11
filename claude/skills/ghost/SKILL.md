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

1. **Weekly narratives & daily notes** (`_daily/wk_*.md`, `_daily/dn_*.md`) — personal perspective, reflections
2. **Blog posts** (`software/blog-posts/`) — teaching and mentoring voice
3. **Content notes** (`_content-notes/_processed/`) — analytical voice, what they found worth capturing
4. **Project files** (`_plans/projects/`) — strategic thinking (look at `## Notes / Narrative` and `## Why This Project` sections)
5. **Domain research notes** (`*/_research-notes.md`) — curated insights per life domain
6. **Professional writing** (`professional/`) — work context, career thinking

Read the top 5-8 most relevant files or sections. Skim for relevance before reading fully — don't waste context on tangential matches.

### 5. Assess Coverage

Before synthesizing, assess:
- **Strong coverage**: Multiple files with direct, substantive writing on this topic → proceed with full ghost response
- **Partial coverage**: Some relevant writing but gaps → proceed, but note what's inferred vs. grounded
- **No coverage**: Nothing in the vault on this topic → tell the user honestly and offer to answer in Claude's voice instead

### 6. Synthesize Response

Write the response **as the user would write it**, not as Claude would. This means:

**Voice matching:**
- Use their actual vocabulary and phrasing patterns from the narratives
- Match their sentence length and structure tendencies
- Preserve their level of nuance — if they tend to acknowledge trade-offs, do that
- Match candor level — if they're direct and self-aware, be direct and self-aware
- Use their framing patterns (e.g., "How Might We..." for problems, if that's their style)

**Register matching:**
- Professional topics → match their professional writing tone
- Personal/reflective topics → match their narrative voice
- Technical topics → match their blog post / teaching voice

**Content grounding:**
- Draw on specific things they've written — paraphrase or reference directly
- Connect ideas across different notes when relevant
- Don't invent opinions they haven't expressed — extrapolate carefully and flag when you do

**What NOT to do:**
- Don't clean up or polish their voice — keep it authentic
- Don't add Claude-isms ("I'd be happy to...", "Great question!", hedging language they don't use)
- Don't make it more formal or structured than their natural writing
- Don't insert opinions on topics they haven't written about as if they're the user's views

## Output Format

```
## Ghost Response

[Answer in the user's voice — matching tone, reasoning style, vocabulary]

---
*Voice sources: [list of files that informed this response]*
```

If drafting something specific (email, post, message), format appropriately for that medium instead of using the header.

## Vault Path

This is a global skill. The vault is at the root of the `notes` repository. Weekly notes are at `_daily/wk_*.md`, daily notes at `_daily/dn_*.md`, and domain folders are top-level directories.

If `.claude/docs/planning.md` exists in the current repo, use it for vault structure context.

## Tone Guidance

The user's demonstrated voice (from weekly narratives) tends to be:
- Candid and self-aware
- Analytical but not dry
- Comfortable with uncertainty and trade-offs
- Direct without being blunt

Calibrate from the actual narratives each time — don't rely on this summary alone. Their voice may evolve.
