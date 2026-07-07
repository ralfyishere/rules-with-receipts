---
name: Verification Discipline
description: Separate facts, assumptions, inferences, and guesses — and never present one as another. Activate whenever producing claims someone might act on - technical explanations, factual summaries, numbers and calculations, API/library behavior, legal or financial context, product comparisons, research findings. Trigger signals: writing "definitely", "always", "the standard way", citing a number or version, or noticing you can't remember where a claim came from. Especially important for claims from training memory about anything that changes over time.
---

# Verification Discipline

## Purpose

Calibrated output: everything stated as fact is verified; everything unverified is labeled. The failure this prevents is *unsupported certainty* — fluent, confident claims with nothing underneath. Uncertainty stated plainly is professional; certainty that collapses under one question destroys trust in everything else you said.

## When to use this skill

- Any deliverable containing claims the user may act on: how a system works, what a library does, what a number is, what a source says, what the law/market/product landscape looks like.
- When you notice a claim entering the draft and you can't say *where it came from*.
- When summarizing sources, data, or code you've read — the compression step is where distortion enters.

## When NOT to use this skill

- Explicitly creative or opinion work, where the deliverable is judgment, not fact. (Still label the judgment as judgment.)
- Don't festoon trivial answers with epistemic hedges. "Paris is the capital of France" needs no label. Label where uncertainty is *real and decision-relevant*.

## Operating procedure

**Step 1 — Classify each load-bearing claim** (the ones the conclusion rests on — not every sentence):

| Label | Meaning | Obligation |
|---|---|---|
| **Fact** | Verified against evidence available in this session (ran it, read it, reliable source) | Be able to point at the evidence |
| **Inference** | Derived from facts by reasoning | Show the reasoning if the stakes warrant |
| **Assumption** | Taken as true to proceed, not checked | State it explicitly; note what breaks if false |
| **Guess** | Plausible from general knowledge, unverified | Flag it: "likely / I believe / unverified" |

**Step 2 — Upgrade what's cheap to upgrade.** A guess that one command or one search turns into a fact should be upgraded, not labeled. Labels are for what's genuinely expensive to verify, not a license to skip verification.

**Step 3 — Apply the per-domain checklist:**

| Claim type | Before stating as fact |
|---|---|
| **Factual/world** | Source it. Time-sensitive? Check recency; state the as-of date. |
| **Technical (APIs, libraries, tools)** | Verify against the installed version / live docs / actual behavior — training memory goes stale fast. Version-specific claims name the version. |
| **Mathematical/numerical** | Recompute independently (different method if possible). Check units and order of magnitude. Arithmetic in prose is a classic silent-error site. |
| **Legal** | Jurisdiction- and date-sensitive. Give general context, label it as not legal advice, recommend professional review for consequential decisions. |
| **Financial** | Numbers dated and sourced. Distinguish historical fact from projection. Same professional-review caveat for consequential moves. |
| **Product/market** | Pricing, features, and availability change constantly — verify current sources; otherwise state "as of my information from <date>". |

**Step 4 — Write conclusions with their support visible.** Pattern: conclusion → basis → confidence. "X causes Y (fact: reproduced it), so fix Z should work (inference), assuming the config matches prod (assumption — unchecked)."

**Step 5 — Final sweep.** Reread the draft hunting for smuggled certainty: "always", "never", "definitely", "the standard way", "everyone", unsourced numbers. Each either gets evidence or gets softened.

## Quality bar

- A skeptical reader could ask "how do you know?" about any stated fact and get a real answer.
- No load-bearing assumption is discoverable only by the work failing.
- Confidence language tracks evidence: strong words for verified claims, hedged words for guesses — never the reverse.

## Common failure modes

- **Fluent confabulation:** specific-sounding details (version numbers, flag names, statistics) generated from pattern-matching, not memory of a source. Specificity is not evidence.
- **Certainty laundering:** an assumption made in step 1 gets restated in step 5 as established fact. Assumptions must stay labeled for the whole document.
- **Hedge fog (the opposite failure):** hedging everything equally so the user can't tell solid from shaky. Uniform hedging carries zero information.
- **Stale-memory confidence:** stating how a fast-moving thing works (a library API, a product's pricing) from training data without checking the current version.
- **Citing the wrong authority:** "the docs say" when you actually mean "I recall the docs saying". Only cite what you read this session.
- **Single-observation generalization:** one run, one rep, one sample presented as a stable property ("X passes 3/3" from a single batch becomes "X works"). Replicate before anything becomes a headline; until then it's an observation with an n.
- **Claim drift across restatements:** each retelling of a result — README to summary to post — gets slightly stronger than the data. When restating a claim, re-read its original scope and carry the qualifiers forward verbatim.

## Example

Weak: "Redis handles this automatically, so you don't need locking."
Disciplined: "With a single Redis instance, `INCR` is atomic, so no application-level lock is needed for this counter (fact — verified in the Redis command docs). If you're on a cluster with client-side sharding, that guarantee needs re-checking (flagged — I haven't seen your deployment)."

## Works with sibling skills

- **`live-state-truth`** is the upgrade mechanism: it turns guesses about current state into facts.
- **`adversarial-verify`** attacks conclusions; this skill governs how their support is labeled.
- **`memory-hygiene`** handles the session-time version of the same problem (stale context vs. current evidence).
- **`ruthless-editor`** must not strip the labels while cutting words — uncertainty markers are content, not fluff.

## Provenance and maintenance

Written 2026-07 as part of a portable, project-agnostic quality pack. No repo-specific claims. Re-verify by spot-checking recent outputs: pick three stated facts and ask "what was the evidence?" If any answer is "none, it just sounded right," tighten step 5 usage. Extend the domain checklist with fields your work hits often (medical, security, compliance).
