---
name: Disclosure Is Not A Fix
description: Writing down a known defect does not resolve it. Activate when about to ship something with a "known limitation", "known issue", "caveat", "disclosed", "we're aware", "for now", "not yet handled", or "advisory" note; a TODO/FIXME left in shipped code; a review that found a defect you are documenting instead of fixing; or shipping with a noted-but-unfixed problem. Trigger signal: a well-written caveat is standing in for a mitigation. The honest bar - ship the cheapest mitigation, or record an explicit dated decision not to; disclosure is documentation, not resolution.
---

# Disclosure Is Not A Fix

## Purpose

Writing down a known defect does not resolve it. Disclosure is a documentation act: it manages the reader's expectations but leaves the defect fully present. The trap is that a well-written caveat *feels* like diligence and quietly substitutes for the fix. When you're about to ship something with a "known limitation" note, the honest bar is one of two things: ship the cheapest available mitigation, OR record an explicit, reasoned decision NOT to mitigate — why, and what would change it. The disclosure itself is neither. "We disclosed it" is not a disposition.

## When to use this skill

- The moment you reach for the words "known limitation", "known issue", "caveat", "we're aware", "for now", "not yet handled", or "advisory" in something you're about to ship.
- When a review, audit, or test surfaced a real defect and your instinct is to document it rather than fix it.
- When leaving a `TODO`/`FIXME` in code that is about to ship, or a "trap wanted"/"placeholder"/"not implemented" marker in a released artifact.
- Whenever an item is about to be closed on the strength of a note that describes the problem instead of resolving it.

## When NOT to use

- The defect is already mitigated or already carries a written, dated decision-not-to-fix — this skill's job is done; don't re-litigate.
- Genuinely adjacent problems you were not asked to touch — those are `scope-fence`'s flag list, not a defect *in the thing you are shipping*.
- Pure release notes / changelog entries that describe *resolved* behavior. Disclosure of a fixed thing is fine; this skill governs disclosure standing in for an *unfixed* thing.

## The procedure

1. **Name the defect and its real user-facing consequence** — the unsoftened version. Not "the parser has some edge cases" but "malformed input silently produces wrong totals the user will act on."
2. **Find the CHEAPEST mitigation.** It is often far cheaper than the defect's cost: reword an ungradeable criterion, add a guard, put a one-line warning at the point of danger, disable the broken path, remove the live rule. Cost the mitigation against the cost of the defect biting a real user.
3. **If mitigating now is viable, do it.** The cheap fix beats the elegant note.
4. **If not mitigating, write the explicit decision:** why deferring is acceptable, who it affects, and the concrete trigger that would force the fix — dated. A deferral with no recorded reason and no re-trigger is not a decision; it's an unfixed defect wearing a caveat.
5. **Put the disclosure where the defect BITES** — the entrypoint, command, screen, or Quick Start where the hazard fires — not only in a distant NOTES/known-issues section the user won't reach in time.
6. **Never let "we disclosed it" close the item.** The item closes on a mitigation or a recorded decision. Disclosure alone leaves it open.

## Quality bar

- No shipped known-defect without either a mitigation or a written, dated decision-not-to-fix.
- The warning sits where the hazard is triggered, not only in a file the endangered user never opens in time.
- The cheapest mitigation was actually considered and costed against the defect — not skipped on the way to writing the caveat.
- If deferred: the note names who it affects and the trigger that reopens it.

## Common failure modes

- **Disclosure-as-absolution:** a caveat in the README while the broken thing ships unchanged. The reader is warned; the defect is untouched.
- **Warning in the wrong place:** a root NOTES/known-issues entry while the dangerous Quick Start has no banner. The people who hit the hazard never saw the note.
- **"We found one instance":** documenting a single occurrence without sweeping the class — the same defect lives in the two rubrics/files you didn't check.
- **Silent deferral:** pushing the fix to "later" with no recorded reason and no re-trigger, so nothing ever reopens it.
- **Disclosed-but-live:** leaving a proven-ungradeable criterion or a broken rule active *because* it was disclosed — every user now reproduces the known noise you already knew about.

## Works with sibling skills

- **`scope-fence`** defers *adjacent* issues you were not asked to fix; this skill governs a defect *in the thing you ARE shipping* — mitigate-or-decide, don't just note.
- **`failure-mode-awareness`** identifies risks at design time; this skill governs the *disposition* of a known one at ship time.
- **`adversarial-verify`** surfaces the defect in finished work; this skill decides what shipping it honestly requires once it's surfaced.

## Provenance and maintenance

Added 2026-07-09 after an audit found three instances of disclosure substituting for a fix: a public eval tool shipping a grading criterion its own study had *proven* ungradeable — disclosed in the study doc, but the criterion still live in two rubrics, so every user reproduced the known noise; a taxonomy repo whose entries said "trap wanted" for traps a sibling repo had already published; and an abandoned bot whose dangerous Quick Start had no do-not-run banner despite a root verdict condemning it. Re-verify: on the next "known limitation" you write, check whether a cheaper mitigation existed and whether the item was closed on disclosure alone.
