---
name: Structured Reasoning
description: Pick and apply the right reasoning framework for the problem - first principles, tradeoff analysis, decision matrix, root-cause analysis, steelman, evidence grading, risk/reward, sequencing. Activate for decisions between options, evaluations of ideas or arguments, strategy questions, prioritization, "should we X or Y", "is this a good idea", recurring problems, and any analysis where unstructured pro/con listing would produce mush. Also activate when reasoning feels stuck or circular - the fix is usually a better frame.
---

# Structured Reasoning

## Purpose

Hard questions answered with unstructured intuition produce confident mush — conclusions that feel reasoned but can't show their work. A named framework makes reasoning *inspectable*: the user can see the criteria, weights, and evidence, and disagree with a specific step instead of the vibe. The skill has two halves: choosing the right frame (most of the value) and executing it honestly.

## When to use this skill

- Choosing between options: tools, architectures, strategies, candidates, plans.
- Evaluating an idea, proposal, or argument — especially one you're inclined to agree with.
- Prioritization and ordering questions; recurring problems that keep coming back.
- When your own reasoning is circling: restating the same considerations without converging.

## When NOT to use this skill

- Questions with verifiable answers — go verify (`live-state-truth`), don't deliberate.
- Low-stakes choices where any option is fine: pick one and say why in a clause.
- Don't stack frameworks for show. One frame, well executed, beats three decorative ones. Two is the practical maximum (e.g., evidence grading feeding a decision matrix).

## Operating procedure

**Step 1 — Classify the question, pick the frame:**

| Framework | Use when | Output looks like |
|---|---|---|
| **First principles** | Inherited assumptions are suspect; novel problem; "we've always done it this way" | The problem rebuilt from known constraints upward; assumptions confirmed or discarded |
| **Tradeoff analysis** | 2–3 viable options differing along different dimensions | Per-option: what you gain, what you pay, when it wins |
| **Decision matrix** | 3+ options × 3+ criteria; transparency matters; a group must align | Weighted criteria table with scores *and the reasoning behind each score* |
| **Root-cause analysis** (5 whys / causal chain) | A problem recurs despite fixes; symptom vs. disease unclear | Causal chain from symptom to actionable cause |
| **Steelman / weakman check** | Evaluating an argument or proposal; checking your own position | Strongest version of the opposing view, engaged honestly |
| **Evidence grading** | Sources conflict; claims vary in reliability | Claims ranked: verified > strong source > weak source > anecdote > speculation |
| **Risk/reward** | Bets under uncertainty; asymmetric outcomes | Upside × probability vs. downside × probability, plus reversibility |
| **Sequencing** | Order matters; dependencies and unlock effects | Ordered plan with the "why this first" argument |

**Step 2 — Name the frame in your output.** "Treating this as a tradeoff between X and Y" — this lets the user reject the frame, which is cheaper than rejecting the conclusion.

**Step 3 — Execute honestly.** The failure mode of every framework is decoration: building the matrix *after* deciding, steelmanning weakly, grading your preferred source generously. Fill in the structure before forming the conclusion, and let the structure be allowed to surprise you.

**Step 4 — Conclude with the frame's output, plus what would change it.** "Option B wins on these weights; it flips to A if latency matters more than cost" — the sensitivity note is what makes the analysis reusable when circumstances shift.

## Framework selection heuristics

- Stuck in circles → your frame is wrong, not your effort. Step back to Step 1.
- Everyone agrees too fast → run a steelman of the rejected option.
- The decision keeps re-litigating → decision matrix; the disagreement is usually about *weights*, and the matrix surfaces that.
- The plan feels overwhelming → sequencing; the question isn't "how do all of this" but "what first."
- The argument sounds great but you can't say why → evidence grading; charisma and support are different axes.

## Quality bar

- The frame fits the question (a decision matrix for a two-option tradeoff is overhead; a pro/con list for a 5×5 decision is mush).
- The structure was filled before the conclusion was written — the analysis could in principle have come out the other way.
- Scores, weights, and grades come with their reasoning; a bare number is an opinion in a costume.
- The conclusion includes its sensitivity: what change of input flips it.

## Common failure modes

- **Framework theater:** the matrix that ratifies a pre-made decision. Detectable when every criterion happens to favor the same option — real decisions have losers on some rows.
- **Weakmanning:** "some might say X, but that's obviously wrong" — engaging the weakest opposing argument. The steelman row exists to force the strongest.
- **False precision:** weights to two decimal places on gut-feel scores. Coarse honest scores (1–3, L/M/H) beat precise invented ones.
- **Ignoring reversibility:** treating a reversible choice with Critical-grade deliberation, or an irreversible one casually. Reversibility is a first-class input to risk/reward.
- **Frame-shopping:** trying frames until one endorses your prior. If two frames disagree, *that disagreement* is the finding to report.

## Example

"Should we build the integration in-house or buy the vendor solution?"

Frame: tradeoff analysis + risk/reward (two frames, each earning its place). Build: gain control and no per-seat fees; pay 6–8 weeks of the team's roadmap and permanent maintenance. Buy: gain 2-week deployment and vendor support; pay $30k/yr and dependency on vendor roadmap. Risk asymmetry: buy is reversible (annual contract, standard data export — verified in their docs); build is not (sunk engineering). **Recommendation: buy now; revisit at renewal with real usage data. Flips if:** usage grows past ~$80k/yr equivalent, or the vendor can't meet the compliance requirement (unverified — check before signing).

## Works with sibling skills

- **`verification-discipline`** grades the inputs; a rigorous frame over ungraded claims is precision built on sand.
- **`adversarial-verify`** attacks the conclusion afterward; the steelman row is its in-frame cousin.
- **`output-structuring`** renders the result (a decision memo, usually); **`failure-mode-awareness`** feeds the downside rows of risk/reward.
- **`deep-decomposition`** uses sequencing as its ordering engine.

## Provenance and maintenance

Written 2026-07 as part of a portable, project-agnostic quality pack. Frameworks listed are standard, public reasoning tools. Re-verify by reviewing recent analyses: if conclusions never surprise (structure always ratifies the first instinct), step 3 discipline is failing. Add domain frames your work uses often (e.g., expected-value trees, pre-registered success metrics) as new rows.
