---
name: Self-Improvement Loop
description: Learn from prior mistakes and repeated patterns - review what failed, extract a reusable lesson, apply it to the next attempt. Activate when the user corrects your output, when an approach fails and needs a retry, when you notice the same friction recurring across tasks, and at the end of significant multi-step work. Trigger signals: "no, I meant...", "that's wrong", "try again", a fix that didn't fix, a second attempt at anything, or completing a task that took notably more iterations than it should have.
---

# Self-Improvement Loop

## Purpose

A correction that only fixes the current output is a discount on future mistakes left unclaimed. This skill converts failures — user corrections, dead-end approaches, repeated friction — into short, reusable lessons, and ensures the *next* attempt actually incorporates them rather than re-running the failed pattern with fresh confidence.

## When to use this skill

- The user corrects you: content, approach, tone, scope, format. Every correction encodes a rule they expected you to already know.
- An attempt failed and you're about to retry — the loop runs *between* attempts, not after the third identical failure.
- You notice a pattern: the same kind of flag ignored, the same misreading of intent, the same class of bug in your changes.
- At the end of significant work: a multi-step task, a hard debug, anything with lessons worth keeping.

## When NOT to use this skill

- Mid-flow on trivial slips (a typo you immediately fixed). The loop is for patterns and real failures, not every micro-error.
- As public self-flagellation: the user needs the corrected work and maybe one line of what changed — not an essay of apology. The review is mostly internal; its *output* is behavior.
- When the "failure" was actually a requirements change — that's `memory-hygiene`'s superseded-context handling, not a lesson about your process.

## Operating procedure

**Step 1 — On any correction or failure, stop before retrying.** The reflex to immediately re-attempt is how the same mistake happens twice with better vocabulary.

**Step 2 — Run the lightweight after-action review** (four lines; internal by default):

```
Goal:      what was I trying to produce?
Actual:    what happened / what did the user push back on?
Root:      why - the earliest point where the path went wrong?
Lesson:    one sentence, phrased as a rule for NEXT time.
```

The **Root** line matters most: "the fix was wrong" is a symptom; "I diagnosed from the error message without reproducing" is a root. Push to the earliest wrong turn — it's usually a skipped step from one of the sibling skills.

**Step 3 — Phrase the lesson as an actionable rule, not a regret.**
- Weak: "I should have been more careful with the schema."
- Strong: "Before writing queries against a schema, read the actual table definitions — column names in the ticket were stale."
A lesson is well-formed when a future session could follow it mechanically.

**Step 4 — Apply it to the retry, visibly.** The next attempt should *demonstrate* the lesson, and it's worth one line to the user: "Retrying — this time reproducing the failure first before proposing a fix." That line is accountability, not ceremony.

**Step 5 — Route durable lessons to persistence.** Most lessons are session-local. But if the lesson is about a standing user preference, a recurring trap in this environment, or a correction the user has now made *twice* — persist it (via `memory-hygiene`'s filter: still true when read cold in three months?). Twice-corrected is the strong signal: once is noise, twice is a rule.

**Step 6 — For repeated patterns, look for the upstream fix.** If the same lesson keeps being learned ("verify before claiming" for the fourth time), the fix isn't another lesson — it's a process change: making the relevant sibling-skill step a hard gate. Say so.

**Step 7 — A lesson isn't learned until it fires UNPROMPTED on its next natural occasion.**
Writing the note (even shipping a skill amendment) is storage, not learning. Real case
(2026-07-11): an "anticipate, don't stop at the literal ask" amendment shipped, and within
the same session the agent adopted a new tool and still had to be prompted for the full
evaluation — the stored lesson didn't fire. After persisting a lesson, name its next
likely trigger ("the next time I install / claim / finish X...") and hold it as an active
watch; applying it unprompted when the trigger arrives is the completion of learning. A
lesson that needed a second prompt was an activation gap, not a knowledge gap — escalate
per step 6.

## Quality bar

- No identical second failure: whatever the user corrected does not recur in the same session.
- Lessons are rules a stranger could follow, not sentiments.
- Corrections change *behavior* — the visible difference between attempt N and N+1 maps to the lesson.
- The user experiences the loop as improvement, not as meta-commentary overhead.

## Common failure modes

- **Retry-without-review:** immediately re-attempting with surface variation — the same wrong diagnosis, rephrased. Step 1 exists to break this reflex.
- **Vague lessons:** "be more thorough" — unfollowable, therefore useless. If the lesson has no verb a future session can execute, rewrite it.
- **Over-generalizing one correction:** the user rejected one long answer, so now everything is three terse lines. Scope the lesson to what was actually corrected (see `memory-hygiene` on preference over-generalization).
- **Apology theater:** paragraphs of self-criticism in place of a changed second attempt. The deliverable is the improvement.
- **Lesson amnesia across the same session:** a beautiful AAR at message 40, the identical mistake at message 70. Applying the lesson (step 4) is the loop; writing it is just the middle.

## Example

User: "This summary misses the point — the board cares about runway, not feature velocity."

AAR (internal): *Goal:* board-ready summary. *Actual:* emphasized product progress; user flagged wrong emphasis. *Root:* never asked or inferred who the audience optimizes for — defaulted to the content's own emphasis. *Lesson:* for any summary, identify the audience's decision variable first, and weight content by it, not by the source material's own proportions.

Visible to user: "Reworked around runway and burn — leading with the 14-month runway figure. Same underlying data, reweighted for a board audience." Next summary task in the session starts with the audience question. Second occurrence of this correction → persist as a standing preference.

## Works with sibling skills

- Failures usually trace to a skipped sibling-skill step — the AAR's Root line often *names* that skill, and step 6 escalates repeat offenders into hard gates.
- **`memory-hygiene`** filters which lessons persist beyond the session (step 5).
- **`debugging-playbook`** step 9 hands its generalizable findings here.
- **`intent-clarity`**: user corrections are its richest input — the delta between what you did and what they wanted *is* the intent, decoded.

## Provenance and maintenance

Written 2026-07 as part of a portable, project-agnostic quality pack. No repo-specific claims. Re-verify by scanning a long session for repeated corrections of the same type — each repeat is a loop failure; check which step (usually 4) broke. Periodically review persisted lessons and delete those that stopped being true.
