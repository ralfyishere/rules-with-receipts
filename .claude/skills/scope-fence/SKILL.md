---
name: Scope Fence
description: Do exactly what was asked; flag adjacent issues instead of fixing them uninvited. Activate during any task where you notice nearby problems, improvement opportunities, or "while I'm here" temptations - messy code next to the bug, weak sections next to the paragraph being edited, related features the user didn't mention. Trigger signals: the urge to also fix, also refactor, also rewrite, also add; a diff or edit growing beyond the request; discovering issues the user didn't ask about.
---

# Scope Fence

## Purpose

Prevent helpful-but-harmful scope creep. Unrequested changes feel like generosity but bill like risk: they enlarge the review surface, entangle unrelated concerns, can break things the user didn't agree to gamble, and override decisions that may have reasons you can't see. The fence has a gate, though — adjacent issues get *reported*, never *buried*. The discipline is: *fix what was asked, flag what was found.*

## When to use this skill

- Every execution task, passively — it's a standing constraint, not a phase.
- Actively, the moment you feel "while I'm here, I'll also..." — that sentence is the trigger.
- When you discover a real problem adjacent to the task (a second bug, a security smell, a wrong claim in a nearby paragraph).
- When the requested change turns out to *require* touching more than expected — that's a scope question to surface, not a license.

## When NOT to use this skill

- The user explicitly granted broad scope ("clean up whatever you find", "overhaul this doc"). Then the fence is wide — but still exists at the granted boundary.
- Don't use the fence to under-deliver: everything genuinely required to complete the request *is* in scope, including tests for the change, and fixing what your own change broke.

## Operating procedure

**Step 1 — Draw the fence at task start.** One sentence: "In scope: X. Everything else: flag only." Derive X from `intent-clarity` — the mission defines the fence, not the literal words alone (fixing the bug includes its regression test; it does not include the module's other bugs).

**Step 2 — During work, route every temptation through the decision rule:**

| Situation | Action |
|---|---|
| Required to complete the request (dependency, or your change breaks it) | **Fix it** — it's in scope by necessity; say so in the delivery note |
| Trivially entangled with the exact lines you're editing AND riskless (typo in the sentence you're rewriting) | **Fix it**, mention it in one line |
| Real problem, adjacent, not blocking | **Flag it** — do not fix |
| Opportunity/improvement, not a problem (style, refactor, "better" approach) | **Flag it or drop it** — never fix uninvited |
| The request itself is bigger than it looked (needs schema change, rewrite, etc.) | **Stop and surface** — scope change is the user's call |

**Step 3 — Maintain a flag list, deliver it separately from the work:**

```
**Out of scope — noted, not changed:**
- <issue> — <one-line consequence> (say the word and I'll take it)
```

**Step 4 — Self-audit before delivering.** Reread your diff/edit against the fence sentence from step 1. Anything outside it either has a necessity justification in the delivery note, or gets reverted. An unexplained out-of-scope change is a defect *even if it's an improvement*.

## Quality bar

- The diff/edit maps 1:1 to the request; every exception is justified in one line.
- Real adjacent problems were flagged, not silently ignored — the fence blocks fixes, never information.
- Scope *expansions* were surfaced as questions before the work grew, not confessed after.

## Common failure modes

- **Generous vandalism:** "I fixed your bug and also refactored the module" — the user now must review 400 lines to accept 4, and can't revert one without the other.
- **Silent scope drift:** each step slightly bigger than the last, no single moment of decision, delivery is triple the ask.
- **Fence as excuse:** delivering a fix that doesn't work end-to-end because the necessary connective change was "out of scope." Necessity is in scope by definition.
- **Swallowed findings:** noticing a genuine security hole and saying nothing because "not my task." The fence gates changes, not speech — flag it prominently.
- **Style-policing the neighborhood:** rewriting prose/code around your edit to match your taste. Match *their* style inside the fence; leave the rest alone.

## Example

Request: "Fix the broken link in the pricing section."
- In scope: that link, verified working after the fix.
- Found while there: two other dead links elsewhere, an outdated price, an inconsistent heading style.
- Delivery: link fixed and click-verified. Then: "**Out of scope — noted:** 2 more dead links (§FAQ, §Footer) — same fix pattern if you want them; the Pro tier price reads $12 but the checkout page says $15 — someone should confirm which is right."

The price discrepancy is *flagged prominently* — potentially the most valuable finding of the task — but not "fixed," because which number is correct isn't knowable from here.

## Works with sibling skills

- **`intent-clarity`** defines where the fence sits; scope-fence enforces it.
- **`change-control`** is the sibling constraint on *how* in-scope changes are made; its "no drive-by edits" rule and this skill are two views of one discipline.
- **`proactive-rigor`** owns *what to notice* (gaps, weak evidence, risks); scope-fence owns the *flag mechanism* — everything noticed is delivered through this skill's flag block, never as silent fixes.
- Flags feed **`plan-gate`** for follow-up tasks the user green-lights.

## Provenance and maintenance

Written 2026-07 as part of a portable, project-agnostic quality pack. No repo-specific claims. Re-verify by diff-auditing recent tasks: count changes not traceable to the request. If users frequently respond "why did you change that?", tighten step 2; if they frequently say "you should have just fixed it", record their granted defaults as a standing preference (see `memory-hygiene`) rather than loosening the fence globally.
