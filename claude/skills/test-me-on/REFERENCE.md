# Test Me On — Assessment Rubric

## Scoring Approach

Each answer is assessed on two dimensions:

### 1. Core Practice Alignment

Does the answer reflect the module's key practices?

| Rating | Meaning |
|--------|---------|
| **Strong** | Cites or demonstrates the relevant practice, applies it correctly to the scenario |
| **Partial** | Right direction but misses a key element (e.g., says "start fresh" but doesn't mention why — context poisoning) |
| **Missed** | Doesn't address the core practice, or contradicts it |

### 2. Practical Judgment

Does the answer show understanding of *why*, not just *what*?

- **Strong:** Explains the tradeoff or consequence ("start fresh because corrections poison context, making each subsequent fix less likely to work")
- **Partial:** Correct action without reasoning ("just start a new session")
- **Missed:** Applies a rule rigidly without considering the scenario's specifics

## Summary Format

After 3-5 questions, provide:

```
## Results

**Nailed:**
- [Practice they demonstrated well] — [specific example from their answer]

**Revisit:**
- [Practice they missed or partially got] — [what the module says, with a brief explanation]
- See: [link to module section]
```

## Question Generation Guidelines

When generating questions beyond the pre-written "Test Yourself" section:

1. **Start from a scenario**, not a concept. Bad: "What is the 5-minute rule?" Good: "You've been working on a task for 8 minutes with no visible progress. What do you do?"
2. **Include realistic constraints.** "You're mid-sprint, the PR is due today, and Claude is struggling with the task."
3. **Use Evolv context.** Reference Express kiosk flows, Portal dashboard features, eXpedite notification systems, or Insights analytics pipelines.
4. **Test judgment, not recall.** The best questions have multiple defensible answers — you're assessing whether they reason about tradeoffs.
5. **One right answer isn't enough.** If a user gives a valid approach not in the module, credit it and note what the module additionally recommends.
