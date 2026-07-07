---
name: Change Control
description: Keep edits controlled, reversible, and easy to review. Activate whenever modifying existing artifacts - code, documents, configs, prompts, workflows, plans - especially edits to things that currently work, changes others depend on, batch modifications, or anything hard to undo. Trigger signals: "update", "refactor", "change", "edit", "migrate", "replace", touching shared or production material, or noticing an edit growing beyond its original intent.
---

# Change Control

## Purpose

A change is good when it does what it intends, does nothing else, and can be understood and undone by someone who isn't you. This skill governs *how* changes are made — sized, isolated, documented, and reversible — independent of what they are. It applies equally to code, documents, prompts, configs, and strategy plans: anything with a working current state that an edit could damage.

## When to use this skill

- Editing anything that currently works or that others depend on.
- Changes that are hard to reverse (sent, deployed, deleted, published, migrated).
- Multi-part edits where review will matter later ("what changed and why?").
- Editing prompts or workflows whose behavior is sensitive to wording.

## When NOT to use this skill

- Greenfield creation — nothing exists yet to protect (though `plan-gate` still applies).
- Your own scratch work and drafts no one depends on.

## Operating procedure

**Step 1 — Classify the change by risk before touching anything:**

| Class | Definition | Handling |
|---|---|---|
| **R0 — Cosmetic** | No behavior/meaning change: formatting, typos, comments | Make it. Don't mix it into R2+ changes. |
| **R1 — Local, behavior-preserving** | Internal restructuring; external behavior/meaning identical | Verify preservation (tests, before/after comparison). |
| **R2 — Behavior-changing** | Output, meaning, interface, or policy changes | Requires intent statement, verification of both the new behavior and non-regression of the old. |
| **R3 — Hard to reverse** | Deletes, sends, deploys, migrations, published artifacts, anything external-facing | All of R2, plus a rollback answer *before* executing, plus explicit confirmation if acting for someone else. |

**Step 2 — State intent in one line.** "This change makes X do Y because Z." If you can't fill that sentence, you're not ready to edit. If it needs the word "and" twice, it's two changes — split them.

**Step 3 — Make the change, honoring the isolation rules:**
- **One concern per change.** Bug fix ≠ refactor ≠ cleanup. Reviewers can verify one intent; they rubber-stamp three.
- **No drive-by edits.** Adjacent ugliness you noticed goes to the flag list (`scope-fence`), not into this diff.
- **Preserve existing behavior by default.** Anything not explicitly targeted should work/read exactly as before — including things you consider bugs (they may be load-bearing).
- **Match the local style,** even where you'd have chosen differently. Consistency reviews cheaper than taste.
- **Keep it minimal but not cryptic:** the smallest change that fully accomplishes the intent.

**Step 4 — Preserve reversibility:**
- Code: small commits/diffs, no unrelated file churn, note the revert path if non-obvious.
- Documents/plans/prompts: keep the prior version recoverable (version history, dated copy, or quoted original); mark what changed and why.
- R3: write the rollback down first. "How do I undo this?" answered *after* a migration is a very different conversation.

**Step 5 — Verify at the class-appropriate level** (`live-state-truth`): R1 → prove preservation; R2 → prove new behavior *and* old behavior's survival; R3 → verify in the safest available mode first (dry-run, staging, one-item sample).

**Step 6 — Document tradeoffs.** If the change accepts a cost (slower but clearer, shorter but less nuanced, quick fix over proper fix), record it where the next person will find it — commit message, doc changelog, or delivery note.

## Quality bar

- A reviewer can state the change's intent from the diff alone.
- Nothing outside the stated intent changed — verified, not assumed.
- The undo path is known, and for R3, was known *before* execution.

## Common failure modes

- **The kitchen-sink diff:** fix + refactor + formatting in one change. The bug fix is now unreviewable and unrevertable on its own.
- **Silent behavior change during "refactoring":** an R1 that was actually an R2. The label you assign is a claim — verify it.
- **Fixing "obviously wrong" existing behavior uninvited:** it may be compensating for something you can't see. Flag it; don't fold it in.
- **Irreversible-by-carelessness:** overwriting the only copy of a doc, force-pushing, deleting before confirming the backup exists. R3 handling exists precisely for the two seconds this saves.
- **Prompt/config edits without a diff:** wording changes to prompts are behavior changes (R2) with invisible blast radius — keep the old version and compare outputs.

## Example

Request: "Fix the off-by-one in the pagination."
- Do: the one-line fix (R2: intent stated, boundary test added, suite run) — done.
- Don't: also rename the confusing variable, also reformat the file, also "modernize" the loop. Those go to the flag list: "Noticed while here (not changed): `pgIdx` naming is misleading; file has mixed indentation."

## Works with sibling skills

- **`scope-fence`** decides *what* is in scope; this skill governs *how* the in-scope change is executed. They're enforced together.
- **`plan-gate`** produces the intent that step 2 states; **`live-state-truth`** performs step 5's verification.
- **`debugging-playbook`** step 7 (minimal fix) is this skill applied to bug fixes.
- **`effort-calibration`**: R3 changes are automatically Critical-tier.

## Provenance and maintenance

Written 2026-07 as part of a portable, project-agnostic quality pack. No repo-specific claims. Re-verify by inspecting your last few substantive diffs/edits: if any contains changes its stated intent doesn't cover, isolation discipline is slipping. Map the R-classes onto your team's actual review/deploy gates if you have them.
