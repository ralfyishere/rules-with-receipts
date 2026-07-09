---
name: Empirical Validation
description: Test a load-bearing efficacy claim by running the cheapest experiment that could falsify it — with real data and confidence intervals — instead of reasoning about whether it works. Activate before relying on or shipping any claim of efficacy: an inherited system's supposed edge, a prompt/rule/config change you believe helps, a cited performance number (win rate, accuracy, conversion), a "this will improve X" assumption, or a vendor/docstring metric with no artifact. Trigger signals: you're about to build on "X works" without having measured it; a metric appears with no reproduction behind it; you changed something proven and assume it still holds; someone asks "does this actually work?".
---

# Empirical Validation

## Purpose

Claims of efficacy are cheap to make and expensive to trust. An inherited service "has a
74% success rate"; a new rule "sharpens the model"; a vendor "cuts errors 40%." The
default failure is to *reason* about whether these hold — plausibility-check them, argue
both sides — and then build on them. Reasoning cannot distinguish a real effect from an
overfit artifact; only measurement can. This skill makes the reflex: when a claim is
load-bearing, find the cheapest experiment that could *falsify* it, run it against real
data with confidence intervals, and let the result decide — before you invest in it or
ship it.

It is the difference between "this metric looks predictive" and "over 52,000 samples it's
49.8%, CI excludes nothing"; between "the new rule should help" and "14-rule flagged
9/12, 15-rule 1/9 — it hurt." Both verdicts were unavailable to argument and decisive to data.

## When to use this skill

- About to rely on an inherited/abandoned system's claimed advantage (revival, due diligence).
- About to ship a change to something whose value is empirically established (a proven
  prompt, snippet, model, config, few-shot set) — verify the change didn't erode it.
- A performance number appears with no committed, re-runnable artifact behind it
  (docstring win rate, vendor ROI, "we saw a lift").
- A decision worth real money/time/reputation rests on "X works."
- Someone asks "does this actually work?" and the honest answer is "nobody measured."

## When NOT to use

- No efficacy claim is load-bearing — you're not betting on whether something works.
- The claim is already backed by a reproducible artifact you can inspect (read it instead).
- Pure correctness questions about your own output — that's `adversarial-verify`.
- The cost of the experiment exceeds the cost of being wrong (rare; usually the cheap
  experiment is far cheaper than the misplaced investment — check before assuming this).

## The procedure

1. **Name the one claim the decision lives or dies on**, in falsifiable terms. Not "the
   bot is good" but "signal S predicts the 5-min direction >52% after costs."
2. **Find the cheapest ground-truth** for it. Free public data, a held-out slice, a
   historical log, a small controlled run. The best experiments cost cents and minutes
   (Binance klines; 12 `claude -p` cells). Ask: what's the least I can gather that could
   prove this false?
3. **Design to isolate and to falsify.** Change exactly one variable (controlled A/B: same
   everything, differ only in the thing under test). Prefer a design where a *null* result
   is meaningful. Interleave arms so a partial run stays balanced.
4. **Run it and compute uncertainty.** Report rates with confidence intervals, not point
   estimates; state n; flag thin cells. A "0%" on n=12 is not the same as on n=3,000.
5. **Adversarially check the result** before trusting it: fat tails / worst cases (not just
   the average), sample-regime limits, whether your proxy equals the real settlement
   variable, whether a "positive" is an upper bound (naive fill/selection bias).
6. **Act on the verdict, and publish the artifact.** The experiment script + numbers are
   the receipt — reproducible, committed. Let a kill be a kill and a pass be a pass; update
   the plan, don't re-litigate the data.

## Quality bar

- The load-bearing claim is stated in falsifiable terms before any experiment.
- The result rests on real data with n and confidence intervals, not on argument.
- The experiment isolates the variable under test (a controlled comparison, where applicable).
- The result's limits are stated (sample regime, proxy fidelity, upper-bound caveats).
- A reproducible artifact exists; the decision follows the verdict, including "kill it."

## Common failure modes

- **Plausibility theater:** arguing a claim is reasonable instead of measuring it. If you
  can gather ground-truth for cents, reasoning about it is a choice to stay wrong.
- **Confirmation-shaped experiments:** a test that can only pass. Design so a null result
  would show; test the strongest way it could be *false*.
- **Point-estimate confidence:** "74%!" on n=8. Report CIs; small-n fractions (5/8, 2/3)
  are the canonical overfit trap.
- **Uncontrolled A/B:** changing five things and crediting one. Isolate the variable.
- **Ignoring the tail:** a mean that hides ruinous worst cases (selling tails = pennies in
  front of a steamroller if you only checked the average).
- **Proxy ≠ target:** measuring the convenient thing (spot direction) and claiming the real
  thing (a mispriced token) — name the gap.
- **Not shipping the receipt:** a verdict with no committed, re-runnable artifact is a claim,
  not evidence — exactly the thing this skill exists to stop.

## Works with sibling skills

`verification-discipline` labels a claim's evidence level; this skill goes and *generates*
the evidence when the label is "unmeasured." `adversarial-verify` attacks your finished
work by reasoning; this attacks a claim by experiment (and step 5 runs adversarial-verify
on the result). `research-methodology` gathers what others have measured; this measures it
yourself when they haven't. `product-thinking` decides whether a claimed edge is worth
building; this decides whether it's real first. `plan-gate`/`deep-decomposition` sequence
the larger work once the premise survives.

## Provenance and maintenance

Added 2026-07 after two independent wins in one session: a load-bearing efficacy claim that
looked impressive on its face was falsified for $0 on real public data — the effect was
overfit noise — and a snippet change believed to help was shown by a controlled A/B to have
eroded the pack's one proven behavioral result. In both, argument had been inconclusive and
a cheap experiment was decisive. Re-verify by the negative test: on the next "does X work?"
that gets answered by discussion rather than a runnable measurement, this skill's trigger
failed. See `.claude/learnings/2026-07-08-prove-the-premise-before-reviving.md` and
`…-adding-to-the-proven-snippet-needs-an-ab.md`.
