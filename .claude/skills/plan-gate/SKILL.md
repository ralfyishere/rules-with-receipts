---
name: Plan Gate
description: Require a written plan before starting complex or multi-step work. Activate when the task involves building a feature, implementing something new, refactoring, migrating, restructuring a document, multi-file edits, research projects, or any work with more than ~3 dependent steps, unclear requirements, or an expensive wrong start. Trigger phrases include "build", "implement", "create", "migrate", "redesign", "set up", "overhaul". Do NOT activate for single-step edits, factual questions, or quick lookups.
---

# Plan Gate

## Purpose

Prevent rushed execution. A wrong start on complex work wastes more time than any plan costs. The gate: before making the first change on non-trivial work, a plan must exist in writing — visible to the user, not just implied.

Equally important: do not over-plan. A trivial task with a ceremony plan is as much a failure as a complex task with no plan.

## When to use this skill

- The task has 3+ dependent steps, touches multiple files/sections, or has unclear requirements.
- The cost of a wrong start is high (large edits, irreversible actions, external-facing output).
- You feel the urge to "just start" on something you can't fully picture the end state of. That urge is the trigger.

## When NOT to use this skill

- Single obvious step, reversible, under ~2 minutes of work (typo fix, rename, direct factual answer). Just do it.
- The user provided the plan and asked you to execute it. Confirm you understand it; don't rewrite it.
- Pure exploration/reading with no changes — go straight to `live-state-truth` instead.

## Operating procedure

**Step 1 — Pick the planning depth.** Do this in your head; it takes five seconds.

| Depth | Task size signals | Plan required |
|---|---|---|
| **0 — None** | One step, obvious, reversible | None. Execute. |
| **1 — Micro** | 2–5 steps, familiar territory, low blast radius | One short paragraph: goal, steps, done-check |
| **2 — Structured** | Multi-file / multi-section, some unknowns, moderate stakes | Full template below |
| **3 — Staged** | Large, unfamiliar, or risky; can't hold it all in one plan | Template below + hand decomposition to `deep-decomposition`; plan only stage 1 in detail |

**Step 2 — Write the plan** (Depth 2–3 template):

```
## Plan: <one-line goal>
**Success criteria:** How we'll know it worked — observable, checkable.
**Constraints:** Stated by the user + inferred (style, compatibility, deadline pressure).
**Assumptions:** What I'm taking as true without proof. (Each is a risk.)
**Risks:** Top 2–3 ways this goes wrong, and the mitigation for each.
**Steps:** First 3–5 concrete actions. (Later steps may be rough.)
```

**Step 3 — Sanity-check the plan before executing.**
- Does every success criterion have a way to check it?
- Is any assumption cheap to verify right now? Verify it first (`live-state-truth`).
- Is step 1 actually the smallest useful first step?

**Step 4 — Execute against the plan.** When reality contradicts the plan, update the plan visibly — say what changed and why. Don't silently drift.

## Quality bar

- The plan is **falsifiable**: someone else could look at the success criteria and say "done" or "not done."
- Assumptions are written down, not embedded invisibly in the steps.
- The plan fits the task: a Depth-2 plan should be under ~15 lines.

## Common failure modes

- **Plan-as-theater:** writing a plan, then ignoring it during execution. The plan is a contract, not a warm-up.
- **Over-planning trivia:** a 10-line plan for a one-line fix. Depth 0 exists; use it.
- **Success criteria that restate the task** ("implement X" → criterion "X is implemented"). Criteria must be observable checks, e.g. "the test suite passes and the new endpoint returns 200 for the sample payload."
- **Frozen plans:** refusing to revise when step 2 reveals the plan was wrong. Revise out loud.
- **Planning past the horizon:** detailing step 9 when steps 1–3 will change everything. Plan the near steps concretely, the far ones roughly.

## Example

Bad (Depth mismatch): User: "rename this variable" → Model writes a 5-part plan. Wrong — Depth 0.

Good (Depth 2): User: "add rate limiting to the API"
```
## Plan: Add rate limiting to the public API
**Success criteria:** Requests over the limit get 429; under-limit traffic unaffected; existing tests still pass.
**Constraints:** No new external service (inferred: single-node deploy).
**Assumptions:** Middleware layer exists where this can hook in — verify first.
**Risks:** Breaking auth middleware ordering → check middleware chain before inserting.
**Steps:** 1) Read current middleware setup. 2) Pick limiter approach that fits it. 3) Implement behind existing middleware. 4) Add over/under-limit tests. 5) Run full suite.
```

## Works with sibling skills

- **`intent-clarity`** runs *before* this — you can't plan toward a goal you've misread.
- **`effort-calibration`** decides the depth tier; this skill defines what each tier requires.
- **`deep-decomposition`** takes over when the task is too big for one plan (Depth 3).
- **`change-control`** governs execution of the plan's edits; **`adversarial-verify`** checks the result against the success criteria.

## Provenance and maintenance

Written 2026-07 as part of a portable, project-agnostic quality pack. Contains no repo-specific claims. To re-verify this skill still fits your setup: confirm `.claude/skills/plan-gate/SKILL.md` is being picked up (ask Claude "which skills apply to building a feature?") and that the depth table still matches how your team sizes tasks. Update the template if your projects need extra fields (e.g., security review, stakeholder sign-off).
