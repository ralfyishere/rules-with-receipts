---
name: Leverage First
description: Before committing real effort to a chosen approach, spend a cheap cycle to find the higher-leverage path - an existing solution/tool/dataset, a more efficient method, or a smarter composition - instead of grinding the first workable idea on one track. Activate when about to build a tool, collect data the slow way, or write a lot of code; on "is there a better way", "what else could we try", "how should we do this"; or when you catch yourself about to hand-roll something, poll/scrape in a loop, or test one pet hypothesis. Signals: the obvious grind; about to reinvent something.
---

# Leverage First

## Purpose

The reliable failure isn't picking a wrong idea — it's executing the first *workable*
method on a single track when a dramatically better one was one cheap question away.
Hand-rolling a tool that already exists; collecting data live for hours that history
already holds; running five separate passes that could be one; testing your pet
hypothesis when the same data answers ten questions. Each is effort spent where leverage
was available. This skill inserts one cheap step before the grind: *find the higher-leverage
path first.* It is the "work smarter, not just harder" reflex, made explicit and non-optional.

## When to use this skill

- You're about to **build** a tool, harness, or script — before writing it.
- You're about to **collect/gather** data the slow way (live polling, scraping, manual).
- You're about to **run a heavy process** or a long single-track computation.
- "How should we do this?", "is there a faster/better way?", "what else could we try?"
- You notice yourself reaching for the obvious grind, or a task that "will take hours".

## When NOT to use

- The leverage pass is itself more expensive than just doing the small task (a one-off,
  five-minute job — don't spend ten minutes looking for a shortcut to a five-minute task).
- You already did the pass this session for this problem and nothing changed.
- A true emergency where any working path now beats a better path later.

## The procedure (one cheap pass, four questions)

Before committing effort, spend a few minutes on:

1. **Don't reinvent — does it already exist?** Has someone solved this? Is there a dataset,
   API, library, tool, or community knowledge that hands you 80% of it? Search/ask before
   you build. (Free historical trade data existed instead of hours of live polling; the
   answer was a documented endpoint away.)
2. **10× not 10% — is there a fundamentally more efficient method?** Not a faster version of
   the same grind — a different shape: historical vs live, batch vs loop, existing index vs
   fresh scrape, closed-form vs simulation. If the best case is "same approach but quicker",
   keep looking for the shape change.
3. **Compose, don't isolate — can the steps share a resource and combine?** If you're about
   to run N separate passes over the same data/timeframe, make it one pass that computes all
   N — it's cheaper AND reveals interactions (overlap, complementarity) siloed runs hide.
4. **Enumerate the question space — is the pet hypothesis the best use?** A new capability
   (dataset, tool, access) usually answers many questions. List them, rank by value, and
   don't tunnel on the first one that occurred to you.

Then commit to the highest-leverage path you found. If all four come up empty, grind with
a clear conscience — but you asked.

## Quality bar

- Before any effortful build/collect/run, the four questions were actually asked (not skipped).
- You didn't hand-build what already exists, or grind live what history holds.
- Multi-pass work that could share a resource was composed into one pass.
- The effort spent is proportional to the value; leverage was sought before labor.

## Common failure modes

- **Grind reflex:** starting to build/collect the instant the task is understood, skipping the
  pass entirely. The pass is cheap; the wasted grind is not.
- **10%-thinking:** optimizing the chosen grind (faster loop, more threads) instead of asking
  if the whole approach should change. Speed-of-the-wrong-shape is still the wrong shape.
- **Tunnel on the pet hypothesis:** testing the one idea you had instead of the highest-value
  question the new capability unlocks.
- **Over-applying it:** turning a five-minute task into a research project on how to avoid a
  five-minute task. The `When NOT` clause is part of the skill.
- **Reinventing under deadline pressure:** "no time to look for a tool" — then spending hours
  building the tool that a two-minute search would have found.

## Works with sibling skills

`divergent-ideation` widens *ideas* for an open problem; this widens *method and resources*
before execution — a distinct, later trigger. `research-methodology` is the deeper
source-gathering when question #1 ("does it exist?") turns into real research.
`empirical-validation` tests a claim cheaply once you've found the efficient way to test it.
`effort-calibration` sets how much rigor the task deserves; this makes sure the effort lands
on the leveraged path. `deep-decomposition`/`plan-gate` sequence the work after the approach
is chosen.

## Provenance and maintenance

Added 2026-07 after a collaborator had to supply this move repeatedly in one session
("see how others did it", "find a more efficient way", "use them in the same timeframe",
"what other tests?") — each redirection replaced hours of grind with a cheap leverage step,
and one of them surfaced the session's actual finding. Extracted per
`.claude/learnings/2026-07-09-leverage-first-before-grinding.md` and
`…-mine-the-collaborators-redirections.md`. Deliberately shipped as a skill, NOT an
always-on snippet rule — the snippet is the proven, attention-scarce component and adding to
it can dilute it (see `…-adding-to-the-proven-snippet-needs-an-ab.md`). Re-verify by the
negative test: a session that hand-rolls what exists, or grinds live what history holds,
without asking the four questions — the trigger failed.
