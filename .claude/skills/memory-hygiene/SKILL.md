---
name: Memory Hygiene
description: Handle context carefully across long sessions - distinguish durable facts, temporary context, stale assumptions, and user preferences; re-verify before relying on old context. Activate in long or resumed sessions, after context compaction or summarization, when recalling something established "earlier" in the conversation, when the user contradicts what you remember, and before acting on any remembered detail that current evidence could check. Also governs what is worth persisting to memory files and what is not.
---

# Memory Hygiene

## Purpose

In a long session, your context is a mix of load-bearing facts, expired snapshots, superseded decisions, and things you inferred once and never checked. Treating that mix as uniformly true causes a distinctive class of error: acting confidently on information that *was* correct. The discipline: know which class each remembered item belongs to, and re-verify anything load-bearing that the world could have changed since you learned it.

## When to use this skill

- Long sessions, resumed sessions, and any session after context compaction/summarization — the summary preserved conclusions but dropped the evidence behind them.
- Before acting on something you recall from "earlier": a file's contents, a decision, a constraint, a number.
- When the user says something that contradicts your memory — the user is more current than your context.
- When deciding what to write to persistent memory files, and when reading memories back in a later session.

## When NOT to use this skill

- Short sessions where everything relevant is a few messages up and nothing has changed it.
- Don't ritualize: re-verifying a stable user preference every turn is friction, not hygiene. The test is *could it have changed, and is it load-bearing?*

## Operating procedure

**Step 1 — Classify before relying.** When reaching for a remembered item, tag it:

| Class | Examples | Reliability rule |
|---|---|---|
| **Durable fact** | The project is in Python; the user's role; decisions explicitly confirmed | Trust; re-verify only on contradiction |
| **User preference** | Tone, format, "always show diffs", risk appetite | Trust until contradicted; newest statement wins |
| **Snapshot** | File contents you read, test results, data values, what a doc said | **Expires the moment anything could have changed it** — incl. your own edits. Re-observe before load-bearing use (`live-state-truth`) |
| **Working assumption** | Things inferred to proceed, never confirmed | Still an assumption no matter how long ago you made it; label or verify |
| **Superseded** | Plans revised mid-session, requirements the user changed | Actively dangerous — the old version is still *in* your context, fluent and available. Latest statement wins |
| **Task-local detail** | Variable names from a finished task, one-off constraints | Let it go; do not generalize to new tasks |

**Step 2 — Apply the staleness triggers.** Re-verify a remembered item when: (a) it's load-bearing for the next action, AND (b) any of — you or anyone edited the thing since; significant session distance or a compaction sits between; it was a snapshot of something externally changeable; or it conflicts with anything current.

**Step 3 — On contradiction, current evidence wins — then reconcile.** Don't silently average your memory with the new information. Note the change ("earlier we said X; going with Y now") so superseded versions die visibly instead of resurfacing later.

**Step 4 — After compaction or resume, re-anchor before continuing.** Re-read the current state of whatever you're about to touch. Summaries carry *what was decided*, not *what is true now* — treat every summarized state claim as a snapshot needing refresh.

**Step 5 — Persist deliberately.** Worth writing to persistent memory: durable facts, stable preferences, corrections the user made about how you should work. Not worth persisting: snapshots (they expire), task-local details (they don't generalize), anything the code/files already record. Every persisted memory should be one that, read cold in three months, is still true or clearly dated.

## Quality bar

- No load-bearing action taken on an expired snapshot — every "the file says / the test passes / the doc states" claim traces to a *current* observation.
- Superseded decisions never resurface in outputs; when requirements changed, all downstream artifacts changed with them.
- Persistent memory contains only items that survive the cold-read-in-three-months test.

## Common failure modes

- **Snapshot decay:** editing a file based on your memory of reading it 50 tool-calls ago — five of your own edits in between. The most common serious failure this skill targets.
- **Zombie requirements:** the user changed direction at message 30; at message 80 the old requirement quietly reappears in your work because it's still sitting in context, fluently phrased.
- **Preference over-generalization:** "make this one terse" becomes "the user wants everything terse forever." Distinguish task-local instruction from standing preference; when unsure, it's task-local.
- **Summary as source:** citing a compaction summary's claim about the world as though it were the observation itself. The summary is secondhand; the file is firsthand.
- **Memory hoarding:** persisting session trivia until the memory index is noise. Curation is the hygiene; deletion is allowed and encouraged when memories go stale.
- **Averaging contradictions:** the user says the deadline moved; you produce a plan that half-uses both dates. Pick the current one, say you did.

## Example

Resumed session, task: "continue the refactor of `parser.py`."
Wrong: proceed from memory of the file's structure from yesterday's session.
Right: re-read `parser.py` *now* (someone — including yesterday's you — may have changed it), re-check the last plan against what's actually done, note "state check: steps 1–2 landed, step 3 half-applied — resuming from there," then continue.

## Works with sibling skills

- **`live-state-truth`** is the refresh mechanism — this skill decides *when* memory is suspect; that one goes and looks.
- **`verification-discipline`**: a stale snapshot presented as current fact is exactly the mislabeling that skill prohibits.
- **`self-improvement-loop`** writes its lessons through this skill's persistence filter (step 5).
- **`intent-clarity`** step-4 interpretations, once stated and unobjected, become durable facts for the session.

## Provenance and maintenance

Written 2026-07 as part of a portable, project-agnostic quality pack. No repo-specific claims. Re-verify after long-session incidents: when an error traces to remembered-but-changed state, identify which staleness trigger in step 2 should have fired. Periodically audit persistent memory files against the cold-read test and delete what fails it.
