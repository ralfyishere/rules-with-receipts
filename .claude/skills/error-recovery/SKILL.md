---
name: Error Recovery
description: Recover cleanly when work goes sideways mid-task - failed fixes, broken state, cascading patches, a working tree worse than where you started. Activate when a second consecutive attempt at the same problem fails, when tests that were green are now red after your changes, when you notice patch-on-patch layering, or when you can no longer say precisely what state the work is in. Trigger phrases (from you or the user): "still failing", "now something else broke", "let me try one more thing", "this is getting messy".
---

# Error Recovery

## Purpose

The most expensive failures aren't the first error — they're the recovery attempts that compound it: patches stacked on unverified patches, experiments left half-applied, a working state destroyed by attempts to improve it. This skill is the circuit breaker: recognize the spiral early, stabilize to a known state, and choose *revert* or *fix forward* deliberately instead of by momentum. It governs your own work going wrong mid-task — `debugging-playbook` diagnoses defects in the artifact; this skill manages *you* when the fixing itself is failing.

## When to use this skill

- **The two-strike rule fires:** two consecutive attempts at the same problem have failed. Stop; do not try "one more thing."
- Your changes broke something that was working (newly red tests, new errors elsewhere).
- You can't state precisely what's currently applied: experiments, debug prints, half-reverted edits are mixed together.
- Any moment where the honest status is "worse than when I started."

## When NOT to use this skill

- First failure of a first attempt — that's normal iteration; go to `debugging-playbook`.
- Expected failures during exploratory work you've isolated (a scratch branch, a sandbox). Spirals only count in state that matters.

## Operating procedure

**1 — Stop.** The urge to immediately try the next patch is the spiral's engine. No edits for the duration of steps 2–4.

**2 — Establish where you are.** Diff the current state against the last known-good state (`git diff`/`git status`, document version history, the original file). List: what changed, what's broken now that wasn't, which changes were deliberate vs. debris (debug prints, commented-out blocks, abandoned experiments).

**3 — Preserve the evidence.** Before any revert, save what the failed attempts taught: the diff of each attempt, the exact errors, what you predicted vs. what happened — to a scratch file or note. Reverting without capturing this deletes the learning along with the mess.

**4 — Choose: revert or fix forward.** This is a decision, not a default:

| Choose **revert to known-good** when... | Choose **fix forward** when... |
|---|---|
| You can't fully explain the current breakage | You can name the *exact* remaining defect and why the fix addresses it |
| Changes are entangled debris (patches on patches) | The state is clean: one understood change with one understood problem |
| Known-good is cheap to reach (version control, saved copy) | Reverting would destroy substantial verified progress |
| **Default here when unsure** — a clean start with lessons beats a mystery state | |

**5 — Re-enter with smaller steps.** Whatever failed at the previous step size, retry at half: one change → verify → next (`live-state-truth` after *every* increment now, not at the end). The spiral began because verification lagged changes; invert that.

**6 — Reassess the approach, not just the attempt.** Two failed attempts are data about the plan: is the diagnosis wrong (back to `debugging-playbook` step 3 with the new evidence)? Is the approach wrong (back to `plan-gate` — revise visibly)? Is there missing knowledge (a cheap unknown that's now expensive — go resolve it)? Same-plan-try-again is only justified if steps 2–3 revealed a specific execution error.

**7 — Report honestly.** If state was broken and recovered, say so: what broke, what was reverted, what was learned, current verified status. "Some turbulence, now green, here's the diff that's actually applied" builds trust; discovered debris destroys it.

## Quality bar

- No third consecutive unverified patch — the two-strike rule actually stops the hands.
- After recovery, the current state is *fully accounted for*: every diff line is deliberate and explained.
- Known-good was never more than one deliberate decision away (version control checkpoint, saved copy) — if it was, that's the first lesson for the AAR.
- Failed attempts left evidence, not just absence.

## Common failure modes

- **Patch-on-patch spiral:** each fix targets the symptom of the previous fix. Detectable by narration: "now it's failing differently."
- **Sunk-cost continuation:** "I've spent an hour on this approach, one more tweak" — the hour is spent either way; the tweak is a bet against evidence.
- **Mystery-state shipping:** declaring success while debug prints, commented code, or half an experiment are still applied. Step 2's deliberate-vs-debris list exists for this.
- **Rage revert:** dumping everything including the parts that worked and were verified, then re-losing an hour re-deriving them. Preserve evidence first, revert second.
- **Environment blaming:** "the tooling must be broken" before diffing your own changes. Occasionally true; check yourself first — you changed more recently than the environment did.
- **Silent recovery:** cleaning up the mess and reporting only the final success, hiding that the deliverable took three destroyed states to reach. The user needs calibrated trust in the process, not a highlight reel.

## Example

Fixing a failing date parser: attempt 1 (timezone offset) — still fails. Attempt 2 (locale format) — original test passes, **two other tests now fail**. Two-strike rule fires. *Stop.* Diff shows both patches still applied plus a stray debug print. Evidence saved: both diffs + the observation that attempt 2 fixed the target case but broke ISO inputs — meaning the parser has *two* input formats and the diagnosis ("one wrong format string") was wrong. Decision: revert to known-good (entangled patches, cheap revert). Re-entry: back to `debugging-playbook` with the better hypothesis — dual-format inputs need format detection, not a different format string. One small change + verify: all tests green. Report includes the wrong turn and the two-format finding.

## Works with sibling skills

- **`debugging-playbook`** diagnoses the artifact; this skill fires when the *fixing process itself* is failing, and usually routes back into it with better evidence.
- **`self-improvement-loop`** consumes step 3's preserved evidence — recovery is where its best lessons come from.
- **`change-control`** prevents most spirals upstream (small isolated changes, checkpoints); this skill is the downstream net when they happen anyway.
- **`live-state-truth`** at every re-entry increment; **`memory-hygiene`** for the stale beliefs that often caused the spiral.

## Provenance and maintenance

Added 2026-07 in the expansion pass: the core pack covered diagnosing defects and learning lessons afterward, but not the in-the-moment discipline of a failing recovery — the patch-on-patch spiral is among the most damaging observed agent behaviors and had no owner. The two-strike threshold is a judgment default, not a measured constant — tune it to your risk tolerance. Re-verify by scanning painful sessions for third-consecutive-unverified-patch moments; each one is this skill failing to fire.
