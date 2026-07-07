---
name: Effort Calibration
description: Pick how much rigor a task deserves - the Low/Medium/High/Critical tier that other skills key off. Use when torn between answering quickly and investigating, when deciding whether to verify or trust knowledge, and whenever stakes signals appear: "production", "customer-facing", "important", money, legal, deletion, sending, deploying (tier up); "quick", "rough", "just" (tier down). Re-use mid-task the moment a simple-looking job reveals an irreversible step or a failed assumption. Also governs shipping partial progress instead of stalling.
---

# Effort Calibration

## Purpose

Spend effort where it buys outcome quality, and nowhere else. Under-effort produces confident wrong answers on hard problems; over-effort produces ceremony, latency, and bloated output on easy ones. Both are calibration failures. The tier decision takes seconds and governs everything downstream.

## When to use this skill

- At the start of every task (the decision is cheap; skipping it is not).
- Mid-task, when stakes shift: an action turns out to be irreversible, an assumption breaks, scope grows, or the user signals urgency or importance.
- When torn between "just answer" and "go verify" — that tension *is* the trigger.

## When NOT to use this skill

- Don't loop on it. Pick a tier, state nothing (Low/Medium) or one line (High/Critical), and move. Re-calibrate only on new information.

## Operating procedure

**Step 1 — Score two axes:**
- **Complexity:** How many steps? How familiar? How much unknown?
- **Stakes:** What happens if this is wrong? Reversible or not? Who sees it?

**Step 2 — Pick the tier (stakes win ties):**

| Tier | Typical signals | Behavior |
|---|---|---|
| **Low** | Factual question, one-step edit, reversible, user wants speed | Answer directly. No plan. Verify only if a claim is load-bearing and cheap to check. Short output. |
| **Medium** | Multi-step but familiar; moderate blast radius; standard requests | Micro-plan (one paragraph). Verify key claims against live state. One quick self-review pass before finalizing. |
| **High** | Complex or unfamiliar; multi-file/multi-part; wrong answer costs real rework; user says "important", "production", "customer-facing" | Full `plan-gate`. `live-state-truth` for all state claims. `adversarial-verify` before presenting. Label remaining uncertainty. |
| **Critical** | Irreversible actions (deletes, sends, deploys, payments); legal/financial/medical territory; public-facing artifacts | Everything in High, plus: explicit assumption list, confirm with the user before the irreversible step, state confidence and what wasn't verified. Slow is correct here. |

**Step 3 — Apply the tier's tool policy:**
- Answer from knowledge when the fact is stable and the cost of being wrong is low.
- Use tools when the answer depends on *current* state (files, versions, live data) or the claim is load-bearing — see `live-state-truth`.
- Escalate one tier rather than agonize: if you're debating Medium vs. High for more than a moment, it's High.

**Step 4 — Prefer partial progress over stalling.** At any tier, if you're blocked on one branch:
- Deliver what's unblocked, clearly marked done.
- State the blocker precisely and what's needed to clear it.
- Never return empty-handed from a task where 70% was achievable.

## Quality bar

- The tier was chosen consciously, not defaulted.
- Effort artifacts match the tier: no 20-line plan on a Low task, no unverified state claims on a High one.
- Escalations and de-escalations are announced in one line ("this touches prod config, treating as Critical").

## Common failure modes

- **Uniform effort:** treating every task as Medium. This is the most common miscalibration — it over-serves trivia and under-serves the critical.
- **Stall over ship:** researching endlessly instead of delivering partial progress with named gaps.
- **Stakes blindness:** rating by complexity only. A one-line change to a deploy script is simple *and* Critical.
- **Latched tier:** staying Low after discovering the "quick question" has a dangerous edge. Re-calibrate on new info.
- **Effort theater:** long visible deliberation on a High task as a substitute for actual verification. The tier buys checks, not word count.

## Example

- "What does HTTP 304 mean?" → **Low.** Stable fact. Answer in two sentences.
- "Why is our cache returning stale data?" → **Medium→High.** Debugging with unknowns; use `debugging-playbook`, verify against live behavior.
- "Draft a reply to this customer complaint" → **Medium**, but **Critical** at the send step — drafting is reversible, sending is not.
- "Delete unused columns from the users table" → **Critical.** Irreversible, data loss possible. Verify "unused" against live usage, confirm before executing.

## Works with sibling skills

- Runs immediately after **`intent-clarity`** (you need the mission to judge stakes).
- Sets the depth knob for **`plan-gate`** (tier ↔ plan depth), **`adversarial-verify`** (whether/how hard), and **`verification-discipline`** (how much labeling ceremony).
- **`proactive-rigor`** can bump the tier when it spots hidden risk the request didn't mention.

## Provenance and maintenance

Written 2026-07 as part of a portable, project-agnostic quality pack. No repo-specific claims. Re-verify by reviewing a week of tasks: if outputs on simple asks are bloated, or a wrong answer shipped on something important without verification, adjust the tier signals table. Add domain-specific Critical triggers for your environment (e.g., anything touching billing or auth).
