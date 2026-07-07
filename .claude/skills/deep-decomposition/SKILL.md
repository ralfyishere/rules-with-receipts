---
name: Deep Decomposition
description: Break hard tasks into smaller solvable units with explicit dependencies and unknowns. Activate when a task feels too big to plan in one pass — large features, migrations, research questions with many sub-questions, multi-part documents, business analyses, gnarly debugging with several possible fault lines, or anything where the honest answer to "what's step 4?" is "no idea yet". Trigger signals: the user asks for something "end to end", "the whole thing", a system rather than a change, or you notice your plan has steps like "figure out the rest".
---

# Deep Decomposition

## Purpose

Turn one intractable task into a sequence of tractable ones. A task is decomposed well when every unit is small enough that you could start it right now and know when it's done — and the units are ordered so that the riskiest unknowns get resolved earliest, not discovered last.

## When to use this skill

- A `plan-gate` Depth-3 task: you can't hold the whole solution in one plan.
- The task spans multiple domains (e.g., schema + API + UI; or research + analysis + writeup).
- You catch yourself writing vague plan steps ("handle the edge cases", "do the integration").
- Research or strategy questions that are really 4–6 questions wearing a trenchcoat.

## When NOT to use this skill

- The task fits in a Depth-1 or Depth-2 plan. Decomposing it is procrastination with extra steps.
- The user asked for a quick draft or first pass — decomposition depth should follow `effort-calibration`, not habit.

## Operating procedure

**Step 1 — State the end goal in one sentence.** If you can't, go back to `intent-clarity`.

**Step 2 — Inventory knowns and unknowns.**
- Knowns: what you already have (files, facts, requirements, prior art).
- Unknowns: what you'd have to discover. Mark each unknown **cheap** (one command/read away) or **expensive** (needs experimentation or user input).

**Step 3 — Cut the task into stages.** Each stage must have:
- A concrete **output** (a working function, an answered question, a drafted section) — not an activity ("investigate", "think about").
- A **done-check**: how you'll know the stage is complete.

**Step 4 — Order the stages.** Two forces, in priority order:
1. **Dependencies:** a stage can't precede its inputs.
2. **Risk-first:** among independent stages, do the one most likely to invalidate the others. Resolve expensive unknowns and bottlenecks early — a bottleneck discovered at stage 5 wastes stages 1–4.

**Step 5 — Fill the table:**

| # | Stage | Output | Depends on | Unknowns | Risk if wrong |
|---|---|---|---|---|---|
| 1 | ... | ... | — | ... | ... |

**Step 6 — Identify the smallest useful next step.** Not the first stage — the first *action* inside it that produces information or progress. "Read the current auth middleware" beats "Stage 1: understand auth." Then start it.

## Quality bar

- No stage's output is described with the words "understand", "explore", "handle", or "deal with" alone — every output is a noun you could point at.
- The riskiest assumption in the whole task is tested by stage 1 or 2, not stage N.
- Any stage estimated at more than ~5 substeps gets decomposed again.

## Common failure modes

- **Activity-shaped stages:** "research the options" with no defined output. Fix: "a table of 3 options with tradeoffs" is an output.
- **Happy-path ordering:** doing easy stages first for momentum, leaving the make-or-break unknown for last.
- **Decomposition as the deliverable:** producing a beautiful breakdown and never starting stage 1. Step 6 exists to prevent this — always end decomposition by *doing* the smallest next step.
- **Ignoring cross-stage contracts:** stages that each work alone but disagree on interfaces (data shapes, terminology, assumptions). Write the contract down at the boundary.

## Example

Task: "Build a CLI tool that syncs bookmarks between two browsers."

| # | Stage | Output | Depends on | Unknowns | Risk if wrong |
|---|---|---|---|---|---|
| 1 | Read both bookmark storage formats | Documented file paths + formats for both browsers | — | Are formats stable/accessible while browser runs? (expensive) | Whole approach invalid |
| 2 | One-way read prototype | Script that dumps browser A's bookmarks as JSON | 1 | — | Low |
| 3 | Diff/merge model | Written rule set for conflicts (adds, deletes, moves) | 1 | User's conflict preference (cheap: ask) | Rework of stage 4 |
| 4 | Two-way sync core | Function passing round-trip tests | 2, 3 | — | Medium |
| 5 | CLI wrapper + docs | Installable command with `--dry-run` | 4 | — | Low |

Smallest useful next step: locate browser A's bookmarks file and confirm it's readable while the browser is open — the expensive unknown, tested first.

## Works with sibling skills

- Invoked *by* **`plan-gate`** at Depth 3; each stage then gets its own lightweight plan.
- **`live-state-truth`** resolves the cheap unknowns before they get scheduled as stages.
- **`effort-calibration`** caps decomposition depth — critical work earns finer stages.
- **`debugging-playbook`** is the specialized decomposition for "why is this broken" tasks; use it instead when the task is a bug.

## Provenance and maintenance

Written 2026-07 as part of a portable, project-agnostic quality pack. No repo-specific claims. Re-verify by testing on a real task: if stages come out activity-shaped or the table feels like overhead for your typical task size, tighten the "When NOT to use" thresholds. Keep the example generic or swap in a completed real decomposition from your own history.
