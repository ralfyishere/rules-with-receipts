---
name: Foresight
description: Project the trajectory before committing - pre-register dated, credenced predictions about what breaks, what becomes necessary, and what pays off 5/10/20 steps ahead, then resolve them when the future arrives and score your calibration. Activate when starting any build, plan, or strategy; making architecture, roadmap, scaling, or investment bets; choosing between directions; or shipping something whose problems will surface later. Trigger signals: "will this scale", "what will we regret", "where does this break at 10x", "what will we need by then", a plan whose risk section only covers the present, or a direction justified only by today's constraints.
---

# Foresight

## Purpose

Plans reason about the present; failures and windfalls arrive from the future. The
pack already attacks present-tense blind spots (`failure-mode-awareness` enumerates
what could go wrong with the design as it stands) — but nothing owned the
trajectory: by step 10 X becomes the bottleneck, by step 20 Y is cheap and we will
wish we had started it now. Worse, anticipation kept in the head is unfalsifiable:
hindsight rewrites "I knew it" over every outcome. Pre-registration fixes both —
a prediction with a date, a credence, and an observable resolution is an asset:
it can steer today's decision, and when it resolves it measures how far ahead we
can actually see. Origin (operator, 2026-07-11): "I kept having to give you the
ideas — you should see what's coming 5, 10, 20 steps from now."

## When to use this skill

- Commit points: a plan approved, an architecture chosen, a build started, a
  direction picked over alternatives.
- Scaling-shaped decisions: growth targets, hiring, infra, pricing, market entry.
- Shipping anything whose failure modes surface on a delay (integrations, data
  models, public APIs, contracts, content).
- Reviewing a plan whose risks are all present-tense.

## When NOT to use

- Trivial or fully reversible work — a projection pass on a one-line fix is theater.
- As a substitute for `failure-mode-awareness` (present-design risks) or
  `plan-gate` (the plan itself) — this runs WITH them, on the time axis.
- To manufacture certainty: a 0.6 prediction is not a roadmap commitment, and
  foresight entries are not promises.

## The procedure

1. **Walk the trajectory, not the snapshot.** At the commit point, project along
   the axis that matters (steps, scale, time): what does this look like at 5, 10,
   20 steps ahead? At each horizon ask four questions: what breaks? what becomes
   necessary? what becomes cheap or possible? what will we wish we had started now?
2. **Pre-register 3–7 predictions.** Each carries: the claim, a credence (0–1), a
   resolve-by date, and the OBSERVABLE that resolves it. Vague predictions
   ("things will get complex") are inadmissible — if no observation could score it,
   rewrite it or drop it. Log them where the project's hypotheses live (the
   hypothesis queue, class `foresight`, or the plan doc).
3. **Keep the horizons distinct.** Near entries (≈5 steps) protect the current
   build; far entries (≈20) are allowed to be weird — they are where the value is,
   because a high-credence far prediction with a cheap present-day hedge is a TASK,
   not a note (start the data collection now; reserve the name now; design the
   schema for the split now).
4. **Include positive foresight.** Opportunities, compounding assets, and
   options-worth-buying — not only failures. Foresight is not pessimism with dates.
5. **Resolve on arrival.** When a resolve-by date passes, score the prediction
   (right / wrong / unresolvable-as-written) BEFORE writing new ones. Unresolved
   predictions past their date are debt; calibration only accrues from resolved ones.
6. **Feed the result back.** Resolved predictions are evidence: wrong ones go to
   `self-improvement-loop` (what did the projection miss?); patterns across
   resolutions become `extract-approach` notes; systematically over- or
   under-confident horizons recalibrate the next round's credences.

## Quality bar

- Every entry has all four parts: claim, credence, resolve-by, observable.
- At least one horizon is genuinely far (the uncomfortable-to-write kind).
- At least one entry is an opportunity, not a failure.
- At least one prediction changed a present-day decision — otherwise this was
  journaling, not foresight.
- Past-due predictions are resolved or explicitly marked unresolvable; none
  silently rot.

## Common failure modes

- **Journaling theater:** predictions written, never resolved — the loop's value
  is in the resolution, and skipping it also hides miscalibration.
- **Horizon collapse:** everything "foresight" is next week; the far horizon —
  where cheap hedges have the highest payoff — goes unexamined.
- **Pessimism-only:** all predictions are failures; the missed-opportunity class
  of regret is invisible.
- **Unfalsifiable-by-design:** predictions vague enough to always be right;
  the observable requirement exists to kill these at write time.
- **Hindsight rewrite:** scoring from memory instead of the dated entry — the
  pre-registration IS the defense; never edit an entry after the fact.
- **Foresight-as-commitment:** treating a credenced projection as a promised
  deliverable; the credence is the honesty mechanism, keep it visible.

## Works with sibling skills

- **`failure-mode-awareness`** owns present-design risks; this skill owns the
  time axis. Run both at commit points — they catch different regret classes.
- **`plan-gate`** plans gain a foresight section (step 2's entries).
- **`discovery-loop`** owns the standing queue the entries live in and the cadence
  that resolves them; **`empirical-validation`** is how a resolution gets measured
  when the observable needs a test.
- **`extract-approach`** and **`self-improvement-loop`** consume step 6's output.
- **`verification-discipline`** keeps credences stated as credences — a 0.6 is
  never presented as a fact.

## Provenance and maintenance

Drafted 2026-07-11 from an operator correction during hypothesis-tooling design:
the recurring failure was the operator having to supply ideas and direction the
agent should have projected itself — a standing investigation only refilled its
own hypothesis queue after external push, and an untracked forward assumption (an
unmeasured latency guess) nearly killed a live lead. Re-verify
by auditing shipped projects: if a problem landed that a projection pass would have
named, or foresight entries sit unresolved past their dates, the skill is failing —
name which step broke.
