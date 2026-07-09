---
name: Divergent Ideation
description: Generate genuinely different options before choosing - for brainstorms, naming, design alternatives, and any open problem where the first workable idea is about to become the only idea. Activate on "brainstorm", "give me ideas/options/names", "what could we build", "how else could we do this", first design attempts on open-ended problems, and whenever you notice all your "options" share the same core mechanism. PROACTIVELY on open/improve/turnaround mandates ("improve this", "what would you do", "print money", "do what you think") — generate unplanted angles yourself instead of waiting to be handed the direction; if every option traces back to something the user or the material planted, the divergent pass hasn't run yet. Not for problems with a known correct answer.
---

# Divergent Ideation

## Purpose

The default failure of idea generation isn't bad ideas — it's *narrow* ones: the first workable concept arrives, and everything after is that concept wearing different hats. Real option value comes from ideas with different core mechanisms. This skill separates divergence (generate wide, judgment off) from convergence (filter hard, judgment on), because doing both at once does both badly.

## When to use this skill

- Explicit generation asks: brainstorms, naming, campaign concepts, feature ideas, alternative designs.
- The first attempt at any open-ended problem — before committing to an approach that arrived unexamined (`plan-gate`'s risk section deserves real alternatives).
- Mid-task, when stuck: circling one approach that isn't working is a divergence trigger, not a push-harder trigger.

## When NOT to use this skill

- Problems with a verifiable correct answer — go verify, don't ideate.
- Established-convention decisions (code formatting, standard patterns) where novelty is a cost, not a value.
- When the user has chosen and wants execution: re-opening the option space uninvited is `scope-fence` territory.

## Operating procedure

**1 — Frame the actual problem** (one line, from `intent-clarity`): what the ideas must accomplish and the 2–3 real constraints. Under-constrained ideation produces volume without relevance; over-constrained reproduces the status quo.

**2 — Diverge with judgment OFF.** Generate 8–15 raw options. The count is functional, not decorative: the first ~3 ideas are the obvious ones everyone has; the different-mechanism ideas live past them. No evaluating, no "but that wouldn't work" — evaluation mid-generation kills exactly the unusual candidates this phase exists to surface.

**3 — Force variety with axes** (when generation converges, switch axes):
- **Invert an assumption:** what if the constraint everyone accepts were false?
- **Change the actor:** solved by the user themselves? by automation? by a partner? by nobody (eliminate the need)?
- **Change the resource frame:** 10× the budget; zero budget; 10× the timeline; ship tomorrow.
- **Steal across domains:** how do games / logistics / restaurants / biology solve the analogous problem?
- **Combine:** pair two mediocre options and check the hybrid.
- **Subtract:** remove the feature/step/component instead of adding one.

**4 — Include deliberately "wrong" candidates.** At least two ideas that are infeasible as stated — too expensive, too weird, against policy. Infeasible ideas are frequently a feasible idea plus one removable defect, and they stretch the space the feasible ideas get drawn from.

**5 — Converge with judgment ON.** Now switch modes: cluster near-duplicates (count each mechanism once), name the selection criteria, and score honestly — hand real decisions to `structured-reasoning` (matrix or tradeoff). Select 2–3, each with a one-line why.

**6 — Present the shortlist AND the longlist.** Lead with your 2–3 picks and reasoning; attach the full list compactly below. The user's context differs from yours — their winner is regularly one you'd have culled, and showing discards costs three lines.

## Quality bar

- The shortlisted options have *different core mechanisms* — the test: does each one fail for different reasons? Options that would all fail the same way are one option.
- Generation genuinely preceded evaluation (detectable: the longlist contains ideas the shortlist reasoning argues against).
- At least two axes from step 3 were used — the list isn't fifteen synonyms of the first idea.
- Constraints from step 1 were honored by the *shortlist* (the longlist is allowed to break them; that's what it's for).

## Common failure modes

- **First-idea anchoring:** idea #1 arrives, ideas #2–10 are its variations. Check mechanisms, not surface descriptions.
- **Premature convergence:** evaluating each idea as it's generated, killing the weird ones in utero. The phases exist because the mindsets are incompatible.
- **Safe-list syndrome:** every option is defensible and none is interesting — usually means step 4 was skipped and no assumption was inverted.
- **Volume theater:** twenty options, three mechanisms — padding a narrow list with rephrasings to hit a count. The count serves diversity; diversity is the target.
- **Hidden discards:** presenting only the winners. The discarded list is cheap to include and regularly contains the user's actual pick.
- **Ideating past the decision:** the user said "option B, go" and the response reopens the space. Divergence has a season; respect its end.

## Example

Ask: "Ideas for reducing our app's support ticket volume."
Obvious first three: better docs, chatbot, FAQ. Axis switches — *change the actor:* let power users answer (community forum with rep points); *invert the assumption ("tickets are inevitable"):* instrument the top-5 ticket-generating screens and fix the confusion at the source; *subtract:* remove the feature that generates 20% of tickets and serves 2% of users; *cross-domain (restaurants):* a "kitchen open" livestream — public real-time status page killing "is it down?" tickets; *"wrong" idea:* charge for support (infeasible as stated → kernel: free tier gets community support, paid gets human). Shortlist: instrument-and-fix (attacks cause), status page (cheap, kills a whole category), community tier (scales). Different mechanisms: one reduces confusion, one reduces uncertainty, one redistributes load. Longlist attached.

## Works with sibling skills

- **`intent-clarity`** frames step 1; **`structured-reasoning`** owns step 5's selection — this skill builds the option set that makes selection meaningful.
- **`product-thinking`** supplies the value lens when the ideas are product ideas; **`failure-mode-awareness`** stress-tests the shortlist afterward.
- The convergent skills (`adversarial-verify`, `verification-discipline`) stay *out* of step 2 by design — they re-enter at step 5.

## Provenance and maintenance

Added 2026-07 in the expansion pass: every core skill is convergent (narrowing, verifying, filtering); generation had no owner, and first-idea anchoring is the observable result. Techniques are standard creative-process craft. Re-verify by mechanism-counting recent brainstorm outputs: shortlists whose options all share one mechanism mean steps 3–4 aren't firing.
