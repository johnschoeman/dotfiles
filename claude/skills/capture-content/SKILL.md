---
name: capture-content
description: Generate structured notes from blog posts, PDFs, or transcripts. Use when consuming content for learning - pass a URL or paste content.
argument-hint: [url, path, or paste text]
---

# Capture Content

Extract and structure notes from content for later synthesis. Reads repo-specific configuration from `.claude/docs/content-capture.md`.

## Process

### 1. Load Context

Read `.claude/docs/content-capture.md` in the current repository.

**If the file is missing**, tell the user:

> No content capture context found. To use `/capture-content`, create `.claude/docs/content-capture.md` with these sections:
>
> - **Save path** — where to write captured notes
> - **Relevance targets** — checkbox template for the "Relevant To" section
> - **Active work** — where to check for active projects/initiatives
>
> Optional: **Scope** section to restrict what types of content to capture.

Then stop.

**Validate required sections** — if Save path, Relevance targets, or Active work sections are missing, tell the user which sections are needed and stop.

### 2. Check Scope

If the context file includes a **Scope** section, verify the content fits within it. If it doesn't, tell the user and stop.

### 3. Fetch/Read Content

The user provides one of:

- **URL** — use WebFetch to get content
- **PDF path** — use Read tool
- **Pasted text** — use as-is

For videos or audio, ask the user to paste a transcript or their manual notes.

### 4. Extract Notes

Create structured notes using the [template in REFERENCE.md](REFERENCE.md#note-template).

### 5. Fill Out Relevant To

Using the **Relevance targets** template from the context file:

- **Be selective** — only include targets that are clearly relevant
- **Remove irrelevant lines** — delete checkboxes that don't apply
- **Check active work** — read the location specified in the context file's **Active work** section
- Note author credibility if known

### 6. Save Notes

Save to the path from the context file's **Save path** section, using the [filename format in REFERENCE.md](REFERENCE.md#filename-format).

### 7. Report Back

Tell the user:
- Where the notes were saved
- Which targets seem relevant
- Suggest running `/synthesize-learning` when ready to process

## Tips

- Preserve statistics and data points — these are high value
- Keep the "Relevant To" section focused — 1-3 targets is typical
- Note author credibility context when it's useful
