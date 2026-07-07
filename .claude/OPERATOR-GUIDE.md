# Operator Guide — Supervising Sessions for Quality

The pack raises the model's floor; **you are the ceiling.** This guide is your side of the system: how to spot a session drifting, the exact words that snap it back, and a reusable second-opinion prompt for when a deliverable matters. Keep it open during important work.

## Warning signs → interventions

Say the intervention verbatim — each one triggers a specific pack behavior.

| You notice... | Say... |
|---|---|
| "This should work now" / success claimed, no output shown | **"Run it and quote the actual output."** |
| A big diff for a small ask | **"Revert everything not required for exactly what I asked. Flag the rest, don't fix it."** |
| Third attempt at the same bug, each patch on the last | **"Stop. Two-strike rule: diff against last known-good and decide revert vs fix-forward before touching anything."** |
| Confident numbers or API facts with no source | **"Label each claim fact / inference / assumption, and recompute the arithmetic showing your work."** |
| Subagent/search findings repeated as truth | **"Spot-check two of those claims against the actual source before I use this."** |
| The answer is buried under process narration | **"Give me the answer in the first two sentences, then the support."** |
| It agrees with your pushback instantly (sycophancy) | **"Before you agree — steelman your original answer. Which is actually right, and what evidence decides it?"** |
| It asks questions it could resolve itself | **"Pick the most reasonable interpretation, state it in one line, and proceed."** |
| Long session getting confused about earlier facts | **"Re-read the actual current files/state before continuing — don't work from memory."** |
| A hard problem got solved and it's moving on | **"Before we call this done: write the learning note."** |

## The Second-Opinion Review Prompt

When a deliverable matters (client-facing, irreversible, board-bound), paste this into a **fresh session** with the deliverable attached — an independent reviewer beats self-review, and a fresh context has no stake in the prior session's choices:

```
Review the attached deliverable as a skeptical senior reviewer. The original request was: [PASTE REQUEST].

1. SCOPE AUDIT: does the deliverable map 1:1 to the request? List anything extra (unrequested changes) and anything missing.
2. CLAIM AUDIT: list every load-bearing claim and label it verified / inferred / assumed / guessed. For any "verified," name the evidence. Recompute all arithmetic.
3. STRONGEST ATTACK: construct the single most damaging counterexample, edge case, or alternative explanation — and TEST it if testable here, don't just state it.
4. READER TEST: if the recipient reads only the first two sentences, do they act correctly?
5. VERDICT: ship / fix-then-ship / do not ship — with the fix list ranked by consequence.
Do not soften findings out of politeness. Boundary calls go against the deliverable.
```

## When to restart vs. push through

- **Restart the session** when: it repeats a mistake you already corrected twice, contradicts things it said earlier, or edits from memory instead of re-reading. Long-context rot is real; a fresh session reading current files beats a confused one remembering old ones.
- **Push through** when: the work is mid-flight and recoverable — use the intervention lines above first.
- **Escalate beyond the model** when: it produces a confident answer to something you know is underdetermined, twice. Some tasks need more information, not more prompting — the honest output is a triage plan, and you can demand it: *"Don't guess the answer. Give me ranked hypotheses, each with the check that would settle it."*

## Standards for what "my quality" means here

The bar the pack encodes, in one paragraph — hold sessions to it: every claim about current state traces to something observed this session; every change maps to the request with the rest flagged; every important conclusion survived one genuinely-tested attack; every deliverable leads with the outcome and ends with what's still uncertain; and hard problems leave a learning note behind. When output meets that bar, ship it. When it doesn't, one of the intervention lines above names the missing piece.

## Maintenance

Part of the quality pack (see `MAINTENANCE-CADENCE.md`). When you find yourself giving the same correction twice that this guide doesn't cover, add the row — this file compounds like everything else.
