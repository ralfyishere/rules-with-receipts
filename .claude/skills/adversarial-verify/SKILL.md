---
name: Adversarial Verify
description: Actively try to disprove or break your own answer before presenting it. Activate before finalizing any High or Critical-effort deliverable — code changes, bug diagnoses, analyses, recommendations, math, migrations, strategy memos — and whenever you notice high confidence with low verification. Trigger signals: you're about to say "this should work", "the issue is X", or present a conclusion the user will act on. Not for trivial answers or rough drafts explicitly requested as rough.
---

# Adversarial Verify

## Purpose

Switch from author to attacker before the user does. Work that survives a genuine attempt to break it is worth presenting; work that hasn't been attacked is a hypothesis wearing a conclusion's clothes. This is a short, targeted pass — minutes, not a second project.

## When to use this skill

- Before presenting any High/Critical-tier deliverable (per `effort-calibration`).
- After "finishing" a fix, when the pull toward declaring victory is strongest and scrutiny is weakest.
- When your confidence is high but your verification count is low — that mismatch is the trigger.
- Before recommending a decision the user will act on (architecture, purchase, strategy).

## When NOT to use this skill

- Low-tier tasks and simple factual answers — one sanity check suffices.
- Explicitly rough drafts and brainstorms, where the user asked for volume or speed.
- As a substitute for `live-state-truth`: attacking a claim in your head is weaker than running it. If a check is executable, execute it.

## Operating procedure

**Step 1 — Finish the draft first.** Attacking while authoring produces neither good work nor good attacks.

**Step 2 — Switch roles.** You are now a skeptical senior reviewer whose job is to find the flaw. Assume there is one.

**Step 3 — Run the attack list** (pick the 3+ most relevant; don't run all mechanically):

| Attack | Question |
|---|---|
| Hidden assumption | What am I treating as true that I never checked? |
| Edge cases | Empty input, zero, negative, huge, duplicate, concurrent, unicode, missing file, expired auth? |
| Counterexample | Can I construct one input/scenario where this answer is wrong? |
| Wrongness probe | "What would have to be true for this to be wrong?" — then check whether it's true |
| Expert objection | What's the strongest objection a domain expert would raise? |
| Alternative explanation | (For diagnoses) What *else* produces these exact symptoms? |
| Success criteria audit | Does this actually satisfy the plan's success criteria, or something adjacent? |

**Step 4 — Test the attacks for real.** For each credible attack, prefer execution over reasoning: run the edge-case input, re-run the test suite, recompute the number a different way, reread the source paragraph. Reasoning-only rebuttals are the weakest form of defense.

**Step 5 — Resolve.** For each attack: **fixed** (change the work), **defended** (evidence that it holds — cite it), or **disclosed** (real limitation, stated to the user). Silence is not an option for a credible attack.

**Step 6 — Stop.** One pass, timeboxed. If the pass found major flaws, fix and run *one* more pass. Don't spiral into infinite review.

## Quality bar

- At least 3 distinct attacks were attempted on important work, and at least one was tested by execution/observation, not just thought.
- The attacks were genuine — aimed at the weakest point, not the most defensible one.
- Anything that survived only "it seems fine" is disclosed as unverified, not presented as solid.

## Common failure modes

- **Strawman review:** attacking trivial points (naming, formatting) while the load-bearing logic goes unexamined.
- **Author's immunity:** running the checklist but unconsciously steering every attack toward "actually it's fine." If all attacks failed instantly, suspect the attacker.
- **Verification by re-assertion:** "I checked and it's correct" with no artifact. A defense cites evidence: a command output, a test result, a quoted source.
- **Skipping the strongest attack** because it's expensive to test. That's the one that matters — run it or disclose it.
- **Infinite loop:** review passes forever, deliverable never ships. One pass, fix, one confirm pass, done.

## Example

Draft conclusion: "The memory leak is in the image cache; fix: clear it on navigation."

Attack run: *Alternative explanation* — do event listeners also accumulate? (Checked heap snapshot: yes, listener count grows too → conclusion incomplete, **fixed**.) *Counterexample* — does memory grow even with image cache disabled? (Ran it: grows slower but still grows → confirms second cause, **fixed**.) *Success criteria audit* — original symptom was OOM after ~2h; does the fix hold in a 2h soak? (Too slow to run now → **disclosed**: "verified over 15 min; 2-hour soak still recommended.")

## Works with sibling skills

- Consumes the success criteria from **`plan-gate`** — that's the contract to audit against.
- **`live-state-truth`** supplies the execution muscle for step 4; **`verification-discipline`** labels whatever survives as fact vs. inference.
- In **`debugging-playbook`**, this runs at the root-cause step: attack the diagnosis before writing the fix.
- **`ruthless-editor`** is the prose analog; run this on substance first, that on wording after.

## Provenance and maintenance

Written 2026-07 as part of a portable, project-agnostic quality pack. No repo-specific claims. Re-verify by auditing recent misses: when the user found a flaw you didn't, check which attack in the table would have caught it — if none, add a new attack row; if one existed but wasn't run, the failure is in step 3 discipline, not the list.
