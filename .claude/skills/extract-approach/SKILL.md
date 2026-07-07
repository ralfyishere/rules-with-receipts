---
name: Extract Approach
description: After solving a non-trivial problem, capture the reusable approach as a short learning note in .claude/learnings/ before calling the work complete. Activate after: a hard bug is solved, a tricky architecture or strategy decision lands, a difficult prompt is fixed, a mistake occurs that must not repeat, an eval failure teaches something, or the same workflow shows up for the second time. Trigger signal: you're about to say "done" on something that took real effort and contains a pattern future sessions will need again. Not for trivial tasks.
---

# Extract Approach

## Purpose

Hard-won knowledge evaporates when the session ends. This skill converts a solved problem into a durable asset: a short note future sessions can read in 30 seconds and apply. It is the persistence half of learning — `self-improvement-loop` corrects course *within* a session; this skill writes the reusable residue *across* sessions.

## When to use this skill

After (not during) solving something non-trivial, when at least one of these is true:
- The solution created a **new pattern** worth reusing (an approach, a decision rule, a fixture design).
- The work exposed a **recurring failure mode** (yours, the model's, or the system's).
- The outcome **changes how future work should be done** (a tool quirk discovered, a wrong assumption corrected, a workflow that repeated for the second time).

## When NOT to use this skill

- Trivial or routine tasks — a note nobody will need is clutter, and clutter kills the index.
- Knowledge the repo already records (code comments, git history, existing docs, existing skills). Don't duplicate; link.
- Mid-task — finish and verify first. Notes about unverified solutions record guesses.

## Operating procedure

1. **Check the bar.** Does this meet one of the three criteria above? If not, stop — no note.
2. **Check for an existing note or skill** covering the same ground (`ls .claude/learnings/`, skim titles). If one exists, update it instead of creating a near-duplicate.
3. **Write the note** to `.claude/learnings/YYYY-MM-DD-short-title.md` (kebab-case title, today's date) using `_template.md`:

```markdown
# <Short title>
- **Problem:** what was broken/needed, one line.
- **Context:** where this applies (project, tool, situation), one line.
- **What worked:** the approach that solved it, 1-3 lines.
- **What failed / almost failed:** the dead ends or near-misses, 1-2 lines.
- **Decision rule:** "Next time X, do Y" — mechanical enough to follow cold.
- **Verification:** how to confirm the approach worked, one line.
- **Related skills:** [links to skills this touches]
- **Disposition:** learning-note | promote-to-skill | update-skill:<name> | update-snippet
```

4. **Set the disposition honestly.** Most notes stay notes. Mark `promote-to-skill` only when the pattern has now recurred and has a clear trigger; mark `update-skill` when an existing skill was wrong or incomplete (and say what to change); `update-snippet` is reserved for rules that must be always-on.
5. **Keep it under ~15 lines.** If it needs more, the reusable core hasn't been found yet — compress to the decision rule and verification step; details can point to the session/commit.

## Quality bar

- A cold reader can apply the decision rule without having lived this session.
- The "what failed" line names a specific dead end, not "initial approaches didn't work."
- No vague lessons: "be careful with X" fails the bar; "cast configparser values before arithmetic — they are always strings" passes.
- The note is findable: title says what it's about; date is real.

## Common failure modes

- **Journal creep:** narrating the session instead of extracting the rule. The note is the residue, not the story.
- **Fake profundity:** "always verify assumptions" — true, useless, already in the pack. If the pack already says it, don't re-note it.
- **Note inflation:** recording every task until the directory is noise and nothing gets read. The bar in step 1 is the feature.
- **Write-and-forget disposition:** everything marked `learning-note` forever; promotions never happen. The weekly review in `MAINTENANCE-CADENCE.md` exists to force the decision.
- **Skipping the duplicate check:** three notes about the same trap, each slightly different, none authoritative.

## Example

`.claude/learnings/2026-07-07-subagents-inherit-skill-snapshot.md`
```markdown
# Subagents can't test skill discovery
- **Problem:** Needed clean eval conditions; subagent "fresh" runs saw stale skill lists.
- **Context:** Claude Code — any eval or test of skill triggering.
- **What worked:** Fresh `claude -p` headless runs in isolated dirs outside the pack's tree.
- **What failed:** Agent-tool subagents — they inherit the parent session's skill snapshot.
- **Decision rule:** Next time behavior-under-skills must be tested, use `claude -p` in a temp dir, never a subagent.
- **Verification:** Ask the session to list its available skills; compare against the dir.
- **Related skills:** [delegation-discipline], [live-state-truth]
- **Disposition:** learning-note
```

## Works with sibling skills

- **`self-improvement-loop`** feeds this: its in-session AAR is often the draft of the note; this skill decides what survives the session.
- **`memory-hygiene`** governs the same persistence filter (durable? still true in 3 months?) — apply its cold-read test here.
- Promotions flow to new skills via the interview prompt (`WORKFLOW-SKILL-INTERVIEW-PROMPT.md`) and to always-on rules via `CLAUDE-MD-SNIPPET.md`.

## Provenance and maintenance

Added 2026-07 as the persistence layer of the pack: skills improve behavior in-session; this makes hard sessions leave assets behind. Re-verify via the weekly cadence (`.claude/MAINTENANCE-CADENCE.md`): if the learnings directory is empty after weeks of hard work, the trigger isn't firing; if it's bloated with trivia, the step-1 bar needs raising.
