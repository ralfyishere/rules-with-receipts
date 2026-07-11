---
name: Open Mandate
description: Handle explicitly delegated judgment - "do whatever you think is needed", "you decide what's next", "keep going", standing autonomous sessions. Activate when the user hands you the prioritization itself rather than a task: no deliverable is named, and choosing what to work on IS the work. Trigger signals: "do what you think", "whatever's next", "take it from here", "surprise me", or resuming an autonomous session with no fresh instruction. NOT for ambiguous requests (that's intent-clarity - there IS a task, it's just underspecified).
---

# Open Mandate

## Purpose

An open mandate is not an ambiguous request — the user deliberately delegated the *choosing*. The failure modes are distinct: doing the most recent thing instead of the most valuable thing, doing the most fun thing, doing everything shallowly, or bouncing the choice back ("what would you like me to focus on?" — which returns the one thing they explicitly handed you). This skill is the procedure for choosing well and, equally important, making the choice *inspectable*: the user judges your judgment by whether you can show it.

## When to use this skill

- Explicit delegation of direction: "do whatever you think is needed next", "you decide", "keep going".
- Autonomous/background sessions between instructions.
- The end of a task list, when continuing requires choosing the next objective rather than executing a given one.

## When NOT to use this skill

- A task exists but is vague ("make it better") — that's `intent-clarity`; decode it.
- Standing priorities already answer the question (the user's queue, an agreed roadmap) — execute the top item; don't re-litigate the ranking they already set.
- The candidate action is irreversible or outward-facing beyond anything previously authorized — an open mandate inherits the *scope* of established trust, it doesn't extend it. Publishing, sending, deleting, and spending still get confirmed unless durably authorized.

## Operating procedure

1. **Inventory the option space** — quickly, from: open loops in the session, the user's stated goals and standing queue, known deferred items, and problems you've noticed that nobody scheduled. Five to ten candidates, one line each (internal).
2. **Rank by expected value, not recency or ease.** Useful tie-breakers, in order: unblocks-other-work > time-sensitive > high-value-hard > housekeeping. Include at least one "should we NOT do a queued thing?" check — the best open-mandate move is sometimes stopping something.
3. **Check reversibility of the top pick.** Reversible and inside established trust → proceed. Irreversible or trust-expanding → that's the one thing to surface first (a one-line "I'm about to X unless you object" or a real question, per `effort-calibration` Critical rules).
4. **Lead your response with the decision and its why** — one or two sentences before any work: "Acting on my own judgment: X, because Y." The user delegated the choice, not the visibility of the choice.
5. **State the significant negative decisions.** What you deliberately did NOT do, and why — especially when it contradicts an earlier stated plan ("I'm NOT running the study yet: the instrument can't discriminate"). Undisclosed non-action reads as forgotten, not chosen; disclosed non-action is the judgment they're paying for.
6. **Execute fully, then re-enter at step 1.** An open mandate doesn't end with a menu of options or "let me know what's next" — it ends with completed work and, if the mandate stands, the next chosen item already moving.
   - **In a sustained build session, the literal ask is a floor, not the job.** After
     satisfying it, anticipate the next 2–3 obvious needs (the values that will change →
     config not hardcode; the domain axis not yet covered; the question the deliverable
     raises) and take the next *reversible* one unprompted, naming the ones after it.
     Repeatedly delivering only what was literally asked, turn after turn, reads to the
     user as absence of agency — they end up supplying the ideas you should have had.
     Anticipation is licensed by the open mandate and bounded by step 3: reversible acts
     only; irreversible or trust-expanding moves still get surfaced first.
7. **Record direction-setting choices** where the user can audit them later (the delivery message at minimum; memory/learnings if the decision constrains future sessions — e.g., "study blocked until traps discriminate").

## Quality bar

- The choice survives the question "why this, and not the obvious alternative?" with a real answer.
- Negative decisions are as visible as positive ones.
- Nothing irreversible happened on inferred authority.
- The turn ends with work done, not with the prioritization handed back.

## Common failure modes

- **Recency capture:** picking whatever was last discussed because it's warm in context, not because it ranks first.
- **Fun-first selection:** building the interesting thing while the valuable-but-boring thing (the writeup, the cleanup, the verification) stays open.
- **Mandate bounce-back:** responding to "you decide" with a question about what they'd prefer. The polite-seeming version — a menu of options with no action — is the same failure.
- **Silent plan reversal:** deciding not to do something previously agreed and just... not doing it. The reversal may be right; the silence never is.
- **Authority inflation:** treating "do whatever you think is needed" as authorization for irreversible or outward-facing acts that were never in scope. The mandate delegates prioritization, not permission.
- **Breadth capture:** touching eight things shallowly to look productive instead of finishing the one that matters.
- **Literal-ask timidity (sustained builds):** correct-but-reactive delivery — each turn
  satisfies exactly what was asked and stops, forcing the user to supply every next idea.
  Real case (2026-07-11): across one build session the operator escalated four times
  ("you don't think 10-20 moves ahead... I keep having to give you the ideas") while every
  individual deliverable was correct. The fix is procedure step 6's anticipation clause;
  the guardrail against overcorrecting into authority inflation is step 3 (reversible only).

## Example

Mandate: "Do whatever you think you need to do next" (real case, 2026-07). Option inventory included a queued comparative study, publishing follow-ups, and housekeeping. The top-ranked move was a *negative* decision: the study's test instrument had just been shown non-discriminating, so running it would publish noise as findings. Response led with exactly that ("One significant decision up front: I'm NOT running the study yet, because...") and then executed the ranked remainder: an integrity sweep of everything public, extending the test bank at zero cost, and banking the day's lessons — ending with completed work and the study's unblock condition stated. The negative decision was later written to memory so a future session couldn't silently reverse it.

## Works with sibling skills

- **`intent-clarity`** handles underspecified *tasks*; this handles delegated *direction*. Its mission-tracking feeds step 1's option space.
- **`effort-calibration`** gates step 3 (reversibility/stakes of the chosen action); **`scope-fence`** still bounds each executed task normally.
- **`extract-approach` / `memory-hygiene`** persist direction-setting decisions (step 7) so autonomy is consistent across sessions.
- **`frontier-workflow-mode`** governs how a chosen big task is executed; this skill governs the choosing.

## Provenance and maintenance

Added 2026-07 from session evidence: repeated open mandates ("do whatever you think is needed", "go in that order") where the value came as much from disclosed negative decisions as from executed work. Re-verify by auditing open-mandate turns: if any ended with an options menu instead of action, or reversed a plan silently, the relevant step failed — name it.
