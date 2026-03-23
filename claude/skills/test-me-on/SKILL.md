---
name: test-me-on
description: Interactive quiz on training modules. Reads module content, asks scenario-based questions, assesses answers against module practices. Use when user invokes /test-me-on.
---

# Test Me On

Interactive quiz skill for training modules.

## Argument Format

- `/test-me-on claude-code` — random module from the claude-code subject
- `/test-me-on claude-code#session-discipline` — specific module
- `/test-me-on claude-code#all` — full quiz across all modules

## Process

1. **Parse the argument.** Extract subject and optional module name.
   - If no module specified, pick one at random from the subject's README.md module list.
   - If `#all`, quiz across all modules (1 question per module).

2. **Read the module.** Load `training/<subject>/<module>.md`.

3. **Ask questions.** Use the "Test Yourself" section first — these are pre-written scenario-based questions. For variety or `#all` mode, generate additional questions from module content.

4. **One question at a time.** Present a scenario, wait for the user's response.

5. **Assess.** Compare the answer against the module's key practices, checklists, and common mistakes. Be specific — quote the relevant practice. Don't accept vague answers.

6. **After 3-5 questions:** Summarize what they nailed and what to revisit. Link to the module for review.

## Assessment Guidelines

See [REFERENCE.md](REFERENCE.md) for the assessment rubric and scoring approach.

## Rules

- **Scenario-based only.** No trivia ("what does /effort do?"). Every question should be "you're in this situation, what do you do?"
- **Accept valid alternatives.** If the user's answer achieves the same outcome through a different valid approach, credit it.
- **Be direct.** Don't soften feedback. "That misses the key point" is fine.
- **Connect to Evolv.** Where possible, frame scenarios using Evolv products (Express, Portal, eXpedite, Insights).
