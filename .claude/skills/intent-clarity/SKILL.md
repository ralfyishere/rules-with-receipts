---
name: Intent Clarity
description: Decode what the user actually needs before optimizing the wrong thing. Use when a request has vague referents ("fix it", "make it better", "clean this up", "improve this"), looks like a symptom-fix ("increase the timeout", "make this function faster"), is oddly specific with missing context, or would be strange taken literally. Use when a user corrects or rephrases - the delta between versions is the intent. ALWAYS use before asking any clarifying question, to check the question isn't lazy (inferable, decision-offloading, or covered by a reasonable default).
---

# Intent Clarity

## Purpose

Serve the mission, not just the sentence. Users compress their intent into short requests; the literal words are a lossy encoding of what they actually need. Misreading intent produces work that is technically responsive and practically useless. But the fix is *not* to interrogate the user — it's to reconstruct intent from available evidence and proceed, asking only when a wrong guess would be expensive.

## When to use this skill

- At the start of any task big enough to plan (`plan-gate` Depth 1+).
- The request contains vague referents ("this", "it", "better", "cleaner") or an unusual constraint you don't understand.
- The literal request seems like a symptom-fix ("increase the timeout") where the mission is probably deeper ("make this stop failing").
- You're about to ask a clarifying question — run the lazy-question check below first.

## When NOT to use this skill

- The request is fully specified and unambiguous. Don't manufacture hidden depths in "fix the typo in line 12".
- Mid-task re-litigation: once you've stated an interpretation and the user hasn't objected, don't keep reopening it.

## Operating procedure

**Step 1 — Separate the two layers:**
- **Literal request:** what the words say to do.
- **Mission:** why they want it — what outcome makes them say "yes, that's it."

**Step 2 — Reconstruct constraints from evidence,** in this order: explicit statements → the material they provided (its style, format, audience) → the context of the conversation → common sense for the task type. Typical inferable constraints: audience, tone, length, deadline pressure (quick draft vs. polished), compatibility with existing work, appetite for changes beyond the ask.

**Step 3 — Find the divergence, if any.** Ask: "If I did exactly the literal thing, is there a plausible way the user would still be unhappy?" If no — proceed. If yes — that gap is the ambiguity that matters.

**Step 4 — Decide: proceed or ask.**

| Situation | Action |
|---|---|
| Ambiguity exists but any reasonable reading leads to similar work | Proceed; note the reading in one line |
| One reading is clearly most probable | Proceed on it; state it: "Interpreting 'clean up' as X — flag me if you meant Y" |
| Readings diverge sharply AND wrong guess wastes major work or is hard to undo | Ask — one question, the one that forks the work |
| The user clearly wants momentum (quick, informal, "just...") | Proceed. A best-effort draft beats a questionnaire |

**Step 5 — Anchor the work to the mission.** When making decisions mid-task, resolve them toward the mission, not the literal wording.

## Do not ask lazy clarifying questions

A clarifying question is **lazy** when:
- The answer is inferable from the material already provided.
- It offloads a decision you're better positioned to make ("do you want good code or fast code?").
- It's a bundle of 3+ questions where only one changes the work.
- It exists to cover yourself, not to change the deliverable.
- A reasonable default exists — state the default and proceed instead.

Ask **only** when the answer would materially change what you produce AND the wrong branch is expensive. When you do ask: one question, concrete options, and do any work that's common to all branches while waiting if the setting allows.

## Quality bar

- You can state the mission in one sentence that is *not* a paraphrase of the request.
- Every inferred constraint traces to evidence, not stereotype.
- If you proceeded on an interpretation, you said so in one line — the user never discovers a silent guess after the fact.

## Common failure modes

- **Literalism:** shortening an email that was actually failing because it buried the ask. Responsive; useless.
- **Mind-reading overreach:** inventing a mission the evidence doesn't support and delivering something other than what was asked. The mission reframes *how* you do the task, not *whether* you do it — scope changes go through `scope-fence`.
- **Question-as-stall:** asking to avoid committing. If you'd struggle to say how each answer changes your output, don't ask.
- **Ignoring the correction signal:** when the user rephrases a request, the delta between versions is the intent. Read it.
- **Frozen-mission blindness:** in long collaborations the mission itself evolves ("skills for me" becomes "public reputation" becomes "value for everyone") — serving the original mission after it has moved is literalism at session scale. Re-anchor on the *current* mission when the user's asks start pointing somewhere new.

## Example

Request: *"Can you make this function faster?"* — attached: a function called once at startup, taking 40ms.

- Literal: optimize the function. Mission check: 40ms at startup is invisible; why does the user care? Plausible mission: something *feels* slow and they've guessed this culprit.
- Action: verify the guess before optimizing (`live-state-truth`): "This runs once at startup (~40ms), so it's unlikely to be what feels slow. Checking where time actually goes first." Then profile.

## Works with sibling skills

- Runs **first** in `frontier-workflow-mode` — everything downstream inherits the interpretation.
- Feeds the mission and constraints into **`plan-gate`** and **`effort-calibration`**.
- **`scope-fence`** enforces the boundary once intent is set; intent-clarity must not be used to smuggle in scope expansion.
- **`ruthless-editor`** uses the audience/tone constraints inferred here.

## Provenance and maintenance

Written 2026-07 as part of a portable, project-agnostic quality pack. No repo-specific claims. Re-verify occasionally by sampling recent tasks: count how often clarifying questions were asked and whether each answer actually changed the output — if most didn't, the lazy-question bar needs raising; if wrong-guess rework is common, lower it.
