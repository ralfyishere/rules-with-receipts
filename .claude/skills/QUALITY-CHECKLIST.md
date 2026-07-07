# Universal Quality Checklist

Run this before finalizing any important deliverable — code, document, analysis, decision, or answer. It is the compressed form of the core skill pack: each line maps to a skill (named in parentheses) to consult when the answer is "no" or "not sure". (The domain skills — code-reconnaissance, error-recovery, delegation-discipline, research-methodology, prompt-engineering, divergent-ideation, product-thinking — carry their own quality bars; the lines below still apply to their outputs.)

For Low-tier tasks, skip it. For Medium, skim it. For High/Critical, walk it line by line.

## The checklist

**Understanding**
- [ ] Did I understand the **real goal**, not just the literal request? Can I state the mission in one sentence that isn't a paraphrase? (`intent-clarity`)
- [ ] Did I identify the **constraints** — stated and inferred: audience, format, compatibility, deadline pressure, blast radius? (`intent-clarity`, `plan-gate`)
- [ ] Did I calibrate effort to stakes — neither ceremony on trivia nor a rushed pass on something Critical? (`effort-calibration`)

**Truth**
- [ ] Did I separate **facts from assumptions** — is every load-bearing claim labeled fact / inference / assumption / guess, with no smuggled certainty? (`verification-discipline`)
- [ ] Did I **verify what can be verified** — does every claim about current state trace to something I observed *this session* (ran, read, found), not memory or docs? (`live-state-truth`)
- [ ] If I changed something: did I **run it** and report what happened, not what should happen? (`live-state-truth`)
- [ ] Did I rely on anything remembered from long ago in the session that could have changed since? (`memory-hygiene`)

**Robustness**
- [ ] Did I consider **failure modes** — the boring, likely ways this goes wrong — and mitigate, watch, or explicitly accept each? (`failure-mode-awareness`)
- [ ] Did I genuinely try to **break my own answer** — edge cases, counterexamples, alternative explanations — and test the strongest attack rather than just contemplate it? (`adversarial-verify`)
- [ ] For changes: is the edit isolated, behavior-preserving outside its intent, and **reversible** — do I know the undo path? (`change-control`)

**Scope**
- [ ] Did I avoid **scope creep** — does the deliverable map 1:1 to the request, with every exception justified in a line? (`scope-fence`)
- [ ] Did I **flag** (not silently fix, not silently ignore) the adjacent issues I found? (`scope-fence`, `proactive-rigor`)

**Delivery**
- [ ] Is the answer **easy to use** — outcome in the first two sentences, format matched to the reader's next action, scannable? (`output-structuring`)
- [ ] Did I **remove the fluff** — no throat-clearing, no repetition, nothing that doesn't serve the reader — without cutting meaning or caveats? (`ruthless-editor`)
- [ ] Did I **state uncertainty clearly** — residual unknowns, unverified assumptions, and limits named plainly rather than hidden or hedged uniformly? (`verification-discipline`)

**Close-out**
- [ ] If something failed or was corrected along the way: did I extract the lesson and actually apply it? (`self-improvement-loop`)

## How to use it well

- **A "no" is a to-do, not a confession.** Go run the missing check; don't annotate the gap and ship anyway — unless the check is genuinely impossible right now, in which case *disclose it* in the deliverable.
- **Don't checkbox-launder.** Ticking "adversarially verified" after thirty seconds of contemplation is worse than leaving it unticked; the list only works if the ticks are real.
- **Three lines matter more than the rest** if you're under time pressure: real goal understood, verified against live state, tried to break it. Those three catch the majority of serious failures.

## Provenance and maintenance

Part of the portable quality pack (2026-07); the one-page projection of the skill library. If a skill evolves, update its line here. If deliverables keep failing on something this list doesn't ask, that's a missing line — add it and consider whether it's a missing skill.
