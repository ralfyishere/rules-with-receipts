---
name: Ruthless Editor
description: Make outputs sharper, clearer, and shorter without losing meaning. Activate before delivering any prose that matters - emails, reports, documentation, investor blurbs, strategy memos, prompts, README files, executive summaries, PR descriptions - and whenever the user asks to "tighten", "polish", "shorten", "improve", or "make this clearer". Also self-applies: run it on your own long answers before sending.
---

# Ruthless Editor

## Purpose

Cut everything that doesn't serve the reader; strengthen everything that remains. Most drafts are 20–40% padding: throat-clearing openings, repeated points, hedges stacked on hedges, abstract nouns where verbs belong. The reader pays for every word — this skill makes each one earn its place. Ruthless means aggressive about *words*, conservative about *meaning*: nothing true gets cut into falsehood.

## When to use this skill

- Before delivering any prose artifact someone will read under time pressure: emails, memos, docs, summaries, blurbs.
- On explicit request: "tighten this", "make it punchier", "this is too long".
- On your own outputs: any answer running long, any report, any explanation — you are your own first editing client.
- On prompts: instruction text especially rewards precision (every ambiguous word is a behavior bug).

## When NOT to use this skill

- Legal, contractual, or compliance text where redundancy and qualifier stacking may be deliberate.
- Voice-preserving edits: if the user wants *their* style kept, edit for errors and clarity only — don't transplant your voice.
- Substance problems: editing can't fix a wrong argument. Fix content first (`adversarial-verify`), polish second.
- Don't strip calibration: uncertainty labels from `verification-discipline` are content, not fluff.

## Operating procedure

Run four passes, in order. On short pieces they collapse into one read; on long ones, keep them separate.

**Pass 1 — Structure.** Get the skeleton right before touching sentences.
- Lede first: the answer/ask/conclusion goes in the opening lines, not after the buildup. Readers act on the first paragraph.
- One point per paragraph; sections in the reader's priority order, not the order you thought of them.
- Kill the on-ramp: openings like "In today's fast-moving landscape..." or "I wanted to reach out because..." — start where the content starts.

**Pass 2 — Cut.** Delete without mercy:
- Repetition (the same point in intro, body, and conclusion counts once).
- Filler phrases: "it's worth noting that", "in order to", "the fact that", "basically", "very", "really".
- Hedge stacks: "might possibly perhaps" → pick one, or none if you actually know.
- Explanations of the obvious to this audience; scaffolding sentences that only announce other sentences ("Now let's discuss X").
- Target: 20–40% shorter, unless the draft was already tight.

**Pass 3 — Strengthen.**
- Active voice, concrete verbs: "mistakes were made in the deployment process" → "we misconfigured the deploy".
- Numbers over adjectives: "significantly faster" → "3× faster"; "many customers" → "40 of 200".
- Specific over abstract: "improve alignment across stakeholders" → "get Legal and Sales to agree on the refund policy".
- Names and dates on action items: "this should be handled soon" → "Dana to fix by Friday".

**Pass 4 — Meaning check.** Reread the original beside the edit. Every claim, caveat, number, and commitment in the original is either present in the edit or was cut *deliberately and correctly*. Compression that changes meaning is not editing; it's damage.

## Quality bar

- The first two sentences deliver the core message; a reader who stops there acts correctly.
- No sentence can be deleted without losing information.
- Meaning, tone-appropriateness, and all calibration survived — verified by the pass-4 comparison, not assumed.

## Common failure modes

- **Lossy compression:** cutting the qualifier that made the claim true ("passes all tests *we've written so far*" → "passes all tests").
- **Tone flattening:** editing a warm personal email into a press release. Register is part of meaning.
- **Fragment disease:** compressing prose into bullet shrapnel and jargon that's shorter but *harder* to read. Clarity outranks brevity; complete sentences usually win.
- **Editing the author instead of the text:** replacing the user's voice with your defaults when they only asked for tightening.
- **Cosmetics over structure:** polishing sentences in paragraph 6 when the real problem is that paragraph 6 should be paragraph 1.

## Example

Before (43 words): "I just wanted to quickly reach out because we've been noticing that there have been some issues with the reporting dashboard, which seems to be loading quite slowly for a number of users, and we think it might be worth investigating."

After (16 words): "The reporting dashboard is loading slowly for ~30 users since Tuesday. Can your team investigate this week?"

Shorter, and *more* informative — the strengthening pass forced a count and a date the vague draft was hiding the absence of.

## Works with sibling skills

- Runs **after** substance is settled: `adversarial-verify` fixes what's wrong; this fixes how it reads. Never reverse the order.
- **`output-structuring`** picks the format (memo vs. table vs. checklist); this skill polishes within it. Pass 1 overlaps — if the whole format is wrong, go back to output-structuring.
- **`verification-discipline`** labels are protected content during Pass 2.
- **`intent-clarity`** supplies audience and tone constraints that govern Pass 3's register.

## Provenance and maintenance

Written 2026-07 as part of a portable, project-agnostic quality pack. No repo-specific claims. Re-verify by before/after sampling: if edits routinely change meaning (pass-4 failures) tighten the meaning check; if users say outputs still read long, raise the Pass-2 cut target. Add a house-style section here if your organization has one.
