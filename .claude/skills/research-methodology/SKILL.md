---
name: Research Methodology
description: Run multi-source research with search strategy, source triangulation, and honest coverage claims. Activate for "research X", "what's the state of the art", "compare the options on the market", "what do we know about", literature or market or technical landscape questions, and any task where the answer must be assembled from multiple sources rather than derived or observed. Not for single-fact lookups or questions answerable from provided material alone.
---

# Research Methodology

## Purpose

Research fails in a characteristic way: one search angle, the first three convincing sources, a confident synthesis — which is really the loudest narrative in the index, not the state of the truth. This skill is the *acquisition* process: how to search from multiple angles, when sources count as independent, when to stop, and how to report what the research does and doesn't cover. (`verification-discipline` governs how the resulting claims are labeled; this governs how they're gathered.)

## When to use this skill

- Questions answered by assembling external sources: markets, tools, techniques, prior art, "what's known about X".
- Comparisons where the options' claims about themselves are part of the evidence problem.
- Any deliverable that will cite sources — the citing standard starts at collection time.

## When NOT to use this skill

- Single stable facts — one reliable source and done.
- Questions answerable from provided material (`live-state-truth`: read it) or by direct observation/derivation (run it, compute it) — observation beats testimony; don't research what you can check.
- Pure reasoning tasks — `structured-reasoning` — though hybrids are common (research the inputs, then reason).

## Operating procedure

**1 — Decompose the question** into sub-questions with answerable form (`deep-decomposition`): "Is X better than Y?" becomes "What does X/Y each claim? What do practitioners report? What are the failure stories? What's the cost structure?"

**2 — Plan the search angles before searching.** Multiple vocabularies (the marketing term, the academic term, the practitioner slang, the error message), multiple source *types* — vendor/official docs, practitioner reports (forums, postmortems, issue trackers), data (benchmarks, filings), and critics. Any question researched through only one source type inherits that type's bias wholesale.

**3 — Apply the independence rule.** Load-bearing claims need 2+ *independent* sources. Independent means: not citing each other, not derived from the same press release/paper/announcement, not the same author twice. Twenty articles tracing to one origin are one source with good SEO — this is **citation laundering**, and detecting it (check who cites whom, look for identical phrasings) is a core research act.

**4 — Actively search for the dissent.** After the picture starts forming, invert: search for the strongest source that *disagrees* ("X problems", "X vs", "why we moved off X", negative results). A synthesis that never found dissent didn't look for it — consensus you didn't test is just your search engine agreeing with itself.

**5 — Grade as you collect** (feeds `verification-discipline`): primary data > official docs > named practitioner experience > anonymous anecdote > vendor marketing > speculation. Note each source's *date* — a 2021 comparison of fast-moving tools is history, not evidence.

**6 — Apply a stopping rule, and say which one fired.** Stop when: (a) **saturation** — new sources repeat what you have; (b) **sufficiency** — remaining unknowns no longer change the recommendation; or (c) **budget** — time/effort cap reached. Never stop silently: (c) especially must be disclosed ("time-boxed; deeper areas listed below").

**7 — Synthesize with the seams showing.** Claims mapped to sources; agreement, dissent, and gaps each stated; coverage claimed at the level actually achieved ("checked the 4 major options, not exhaustive") — then shaped by `output-structuring`.

## Quality bar

- Every load-bearing claim has 2+ independent sources or is labeled single-source.
- At least one genuine dissenting source was found and engaged — or the search for one is documented and came up empty (which is itself a finding).
- The synthesis discloses its stopping rule and coverage boundary; "comprehensive" appears only if it's true.
- Source dates are known for anything time-sensitive.

## Common failure modes

- **Single-angle syndrome:** one search vocabulary → the SEO-winning narrative becomes "the answer."
- **Citation laundering (missed):** triangulating a claim across five articles that all cite one blog post. You verified the echo, not the claim.
- **Confirmation vacuuming:** the emerging conclusion silently reshapes subsequent queries toward supporting results. Step 4 is the structural antidote.
- **Recency blindness:** authoritative-but-stale sources presented as current, especially for tools, pricing, and APIs.
- **Coverage overclaim:** "a comprehensive review" after forty minutes and six sources. State the actual boundary; readers calibrate on it.
- **Quote drift:** paraphrasing a source into a stronger claim than it makes. When it's load-bearing, quote it and check the quote.
- **Research-as-stalling:** collecting past the sufficiency point because synthesis is harder than searching. The stopping rule is a commitment, not a suggestion.

## Example

Question: "Should we adopt tool X for our data pipeline?"
Sub-questions: capability fit / operational burden / failure stories / cost trajectory. Angles: official docs (capabilities), the tool's issue tracker + "X postmortem" searches (burden and failures), two migration writeups — one *to* X, one *away from* X (dissent, deliberately sought), pricing page + a user's cost report (trajectory; the two disagreed → flagged, not averaged). Independence check: three glowing comparisons all traced to the vendor's benchmark — counted once, labeled vendor-sourced. Stopped at saturation on capabilities, at budget on cost (disclosed). Synthesis: fit confirmed (multi-source), operational burden real but bounded (practitioner-sourced), cost claim labeled uncertain with the discrepancy shown.

## Works with sibling skills

- **`verification-discipline`** labels what this skill collects; **`deep-decomposition`** structures step 1; **`structured-reasoning`** (evidence grading, tradeoffs) turns findings into recommendations; **`output-structuring`** shapes the report.
- **`adversarial-verify`** attacks the finished synthesis ("what source would refute this?"); step 4 is its in-process twin.
- **`delegation-discipline`** applies when fanning research across subagents — the independence and verification rules extend to delegated findings.
- **`live-state-truth`**: anything checkable by direct observation gets observed, not researched.

## Provenance and maintenance

Added 2026-07 in the expansion pass: the core pack labeled claims after collection but had no owner for the collection process itself — search strategy, independence, dissent-seeking, and stopping rules. Method claims are standard research practice, not repo facts. Re-verify by auditing a recent research deliverable: trace three key claims to their sources and test independence; if two trace to one origin, step 3 needs teeth.
