---
name: Debugging Playbook
description: Debug systematically instead of guessing - symptom, reproduction, hypotheses, discriminating tests, evidence, root cause, fix, regression test. Activate whenever something is broken, failing, wrong, or behaving unexpectedly - error messages, failing tests, crashes, wrong output, performance regressions, "it worked yesterday", "why is this happening", intermittent issues. Also applies to non-code failures: a report with wrong numbers, a workflow producing bad results, a prompt giving bad outputs.
---

# Debugging Playbook

## Purpose

Replace guess-and-check with evidence-and-elimination. Unstructured debugging is a random walk: plausible fixes applied to unconfirmed causes, each failed attempt polluting the state for the next. The playbook's core rule: **you have found the root cause when you can predict the system's behavior — before and after the fix — and be right.**

## When to use this skill

- Anything broken, failing, or surprising: errors, test failures, wrong output, crashes, hangs, performance drops.
- "It worked before" situations — these are diffing problems in disguise.
- Non-code failures with the same shape: a spreadsheet total that's off, a pipeline producing bad rows, a prompt whose outputs degraded.
- Intermittent problems — *especially* these; guessing is uniquely useless against nondeterminism.

## When NOT to use this skill

- The cause is already proven and trivial (the error message names the missing import). Fix it; ceremony adds nothing.
- Nothing is broken — for "could this break?" work, use `failure-mode-awareness`.
- Building new things — that's `plan-gate`/`deep-decomposition` territory, even if motivated by a bug.

## Operating procedure

**1 — Capture the symptom, verbatim.** Full error text, exact command, exact input, environment. "Something about a timeout" is not a symptom. Note what *correct* behavior would look like — surprising numbers of debugging sessions chase behavior that was actually fine.

**2 — Reproduce it.** Find the smallest, fastest, most deterministic reproduction you can. Every minute invested here is repaid at every hypothesis test. If you cannot reproduce: don't guess-fix — instrument (logging, counters, capture-on-failure) and wait for the next occurrence, or hunt for the missing trigger condition (timing, data, environment).
- For "worked yesterday": diff the worlds. What changed between then and now — code, data, dependencies, config, environment? `git log` / deploy history / dependency lockfile first.

**3 — Generate 2–4 ranked hypotheses.** Rank by likelihood × cheapness-to-test. Sources: the error itself (read *all* of it), the diff since it last worked, the failure catalogs in `failure-mode-awareness`, and where this class of bug usually lives.

**4 — Design a discriminating test per hypothesis.** A discriminating test has *different predicted outcomes* depending on whether the hypothesis is true — otherwise it's not a test, it's an activity. Prediction is written down **before** running.

**5 — Run tests, cheapest-first, one variable at a time.** Record results in the table:

| # | Hypothesis | Discriminating test | Prediction if true | Result | Verdict |
|---|---|---|---|---|---|
| 1 | Stale cache serves old config | Bypass cache with direct read | Direct read returns correct value | Correct value returned | **Supported** |
| 2 | Config file itself is wrong | `cat` the config on the affected host | File shows the old value | File shows new value | **Eliminated** |

Changing two things at once destroys the evidence — if the symptom moves, you can't say why. Revert each experiment before the next.

**6 — Confirm root cause.** The bar: your causal story explains *all* observed symptoms (including "why now" and "why only sometimes"), and you can toggle the bug — make it appear and disappear on demand via the cause. If evidence supports two stories, you're not done; find the discriminating test between them. Run `adversarial-verify`'s "alternative explanation" attack here.

**7 — Fix the cause, minimally.** Smallest change that removes the cause — not a refactor of the neighborhood (see `change-control` and `scope-fence`). If you're fixing the symptom instead of the cause (sometimes legitimate under time pressure), *say so explicitly*.

**8 — Add the regression test.** The reproduction from step 2 is the test — it failed before the fix; it must pass after. Run the broader suite too: fixes are code changes, and code changes break things.

**9 — Explain.** Cause → why it produced these symptoms → why the fix addresses it → how it's verified. If the bug's lesson generalizes, log it via `self-improvement-loop`.

## Quality bar

- The root cause is *demonstrated* (toggleable, predictive), not just plausible.
- Every hypothesis in the table reached a verdict backed by an observed result — no "probably" verdicts.
- A regression test exists and was seen to fail-then-pass.

## Common failure modes

- **Shotgun debugging:** applying five plausible fixes at once. Even if the symptom vanishes, you've learned nothing and shipped four superstitions.
- **First-hypothesis anchoring:** collecting only evidence that supports hypothesis #1. The table format exists to force alternatives.
- **Fixing the reproduction, not the bug:** the minimal repro passes but the original scenario still fails — always re-verify against the original symptom.
- **Confusing correlation with cause:** "it broke after the deploy" indicts the deploy's *contents*, pending evidence — not confirmed by timing alone.
- **Debugging the wrong layer:** hours in application code when the discriminating test "does it fail on another machine?" would have pointed at environment in two minutes.
- **Abandoning the process under pressure:** the playbook is *faster* than guessing precisely when the pressure is highest.

## Example (compressed trace)

Symptom: "checkout intermittently charges customers twice" — captured verbatim with two affected order IDs. Repro: replayed one affected order's request log locally; double-charge appears when the payment webhook arrives twice. Hypotheses: (1) client double-submit, (2) webhook retry without idempotency, (3) race in order-status update. Discriminating tests: request logs show one client submission (eliminates 1); webhook log shows provider retry after a 6s timeout, and the handler has no idempotency key (supports 2); status race can't explain the 6s gap (weakens 3). Root cause confirmed: forcing a webhook timeout reproduces the double charge on demand; adding an idempotency key makes it vanish — toggleable. Fix: idempotency key on the charge call (minimal — no refactor of the handler). Regression test: replayed duplicate webhook now charges once; suite green. Explanation delivered with the "why only sometimes" answer: only slow responses trigger provider retries.

## Works with sibling skills

- **`live-state-truth`** is load-bearing throughout: verbatim errors, actual state, executed tests.
- **`failure-mode-awareness`** catalogs are a hypothesis generator for step 3.
- **`adversarial-verify`** gates step 6 (attack the diagnosis) and step 8 (attack the fix).
- **`change-control`** governs the fix's blast radius; **`self-improvement-loop`** captures the reusable lesson.

## Provenance and maintenance

Written 2026-07 as part of a portable, project-agnostic quality pack. No repo-specific claims. Re-verify against your own debugging history: for the last bug that took much longer than expected, identify which step was skipped (usually 2 or 4). If a step never earns its cost at your typical bug size, note the exemption here rather than silently skipping it.
