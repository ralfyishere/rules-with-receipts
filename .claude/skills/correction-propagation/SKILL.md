---
name: Correction Propagation
description: When a published claim is corrected, retracted, downgraded, superseded, or reversed, sweep EVERY surface that restates it - sibling docs, other repos, mirrors, READMEs, indexes, memory files - and banner or supersede each in the SAME closeout before it's done. Activate on "I corrected/retracted/updated X", a metric downgraded, a status flipped, a conclusion reversed, a benchmark restated elsewhere, "did the correction propagate", closeout after a correction, or a claim in more than one repo/doc. Method: grep the claim's distinctive tokens (number, phrase) across ALL surfaces, top-of-file first.
---

# Correction Propagation

## Purpose

The pack can MAKE claims (`verification-discipline`) and ATTACK them (`adversarial-verify`),
but nothing owns RETRACTING one after it has spread. A claim rarely lives in one place: the
same number, verdict, or headline gets restated in sibling docs, other repos, the public
mirror, READMEs, indexes, issue trackers, and memory files. When that claim is corrected —
downgraded, superseded, reversed, disproved — fixing the doc you happened to be looking at
leaves every other copy asserting the old, now-wrong version. Readers land on the stale one
and act on it.

This skill makes correction a *sweep*, not a spot-edit: name the claim's distinctive greppable
tokens, enumerate every surface that could restate it, grep them all, banner or supersede each
hit top-of-file first and dated, then re-grep to prove the sweep is clean. Only then is the
correction done. It is the difference between "I fixed the README" and "the string '3/3' now
appears in three repos, each bannered or deleted, re-grep returns only bannered hits."

## When to use this skill

- You just corrected, retracted, downgraded, or reversed a claim you had published.
- A metric changed value, a status flipped (confirmed → disproved), or a conclusion reversed.
- A benchmark, number, or verdict you're fixing is restated somewhere else too.
- Someone asks "did the correction propagate?" or "is this still cited anywhere?"
- Closeout of any session where a correction happened.
- A claim that appears in more than one repo, doc, mirror, or memory file.

## When NOT to use

- The claim never left one file and nothing restates it — a single edit is the whole job.
- You're making or grading a fresh claim, not changing one already out — that's
  `verification-discipline` / `empirical-validation`.
- The change is additive (new claim) and contradicts nothing previously published.
- Pure session-context staleness with no cross-artifact surfaces — that's `memory-hygiene`.

## The procedure

1. **Name the claim's distinctive, greppable tokens.** The number, the exact phrase, the
   label — "3/3", "9/12", "replicated", "confirmed", the strategy name. Pick tokens specific
   enough to grep without drowning in false hits; too vague to grep = can't sweep it.
2. **Enumerate EVERY surface that could restate it** before grepping one: this doc, sibling
   docs in the same tree, other repos, the public mirror/clone, READMEs, overview/index files,
   issue trackers, changelogs, and memory files. Write the list — the miss is always a surface
   you didn't think to check, not a token that didn't match.
3. **Grep all of them for the tokens.** Every surface on the list, not just the file in hand.
   Include the public mirror path when the claim crossed the public boundary.
4. **Banner, supersede, or delete each hit — top-of-file first, dated.** A reader who lands
   mid-doc must see the correction, so the fix goes at the top (or wherever leads), not only
   at the buried line. State the old claim, the correction, and the date.
5. **Verify the sweep.** Re-grep the tokens across all surfaces; the only hits left are the
   ones you intentionally bannered or kept. An un-bannered hit = the sweep isn't done.
6. **Only then is the correction done.** "Fixed the one I was looking at" is not a corrected
   claim; a clean re-grep across all surfaces is.

## Quality bar

- No surface still asserts the old claim un-bannered — verified by a final re-grep, not by memory.
- The correction is visible top-of-file (or wherever the doc leads), not buried below stale text.
- The sweep covered other repos, the mirror, indexes, and memory files — not just the file in hand.
- Each banner is dated and states what changed, so a later reader can trust it.

## Common failure modes

- **Corrected the one I was looking at:** the classic — fix the doc in focus, leave every
  sibling copy stale. The trigger for this skill is precisely "there is more than one copy."
- **Buried correction:** the fix lands at line 31 but line 7 still leads with the wrong claim.
  A mid-doc reader never scrolls to the retraction. Fix top-of-file first.
- **Cross-repo blindness:** repo A is fixed, repo B still cites the retracted number. The
  public mirror is the most common blind spot — it's a separate surface.
- **Token too vague to grep:** the claim can't be searched, so the sweep silently misses copies.
  If the tokens don't isolate the claim, that's the first thing to fix.

## Works with sibling skills

`verification-discipline` labels a claim's evidence level WHEN it's made; this skill propagates
a CHANGE to a claim already published — one owns the birth, the other owns the retraction.
`memory-hygiene` handles session-context-vs-observation staleness; this handles cross-artifact,
cross-repo surfaces that outlive the session. `session-orientation`'s closeout owns updating the
map; this is a closeout duty whenever a correction happened. `publish-hygiene` guards leaks and
metadata across the public boundary; this guards claim *consistency* across that same boundary.

## Provenance and maintenance

Added 2026-07-09 after a cross-repo audit found a disproven benchmark claim — "only the
always-on rules flagged it 3/3" — corrected in one public repo (rules-with-receipts) but still
asserted in a sibling public repo (agent-failure-modes, AFM-3), and an internal AB-SNIPPET doc
whose title still read "confirmed" after the result was disproved; separately, an
analysis's published verdict was never amended after its own successor commit reversed it. In
each case the correction was made in one place and never propagated. Re-verify by grepping a
corrected claim's distinctive tokens across all repos after any correction — a hit that isn't
bannered is this skill's trigger having failed.
