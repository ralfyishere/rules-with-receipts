# Analysis — What the Run Actually Shows

## Where the pack improved behavior

1. **Delivery completeness under pressure (tests 11, 15).** The clearest pattern: skill/manual conditions didn't reason better — they *finished the job* better. B and D gave the CEO a usable interim script; B/C/D supplied client-ready corrected wording where plain A deferred it. This is the `effort-calibration` partial-progress rule and `output-structuring`'s "deliverable, not just analysis" doing visible work.
2. **D (both) was the only 10/10.** Consistent with the layers being complementary: the manual carries always-on habits; skills carry per-task depth. Weak evidence (n=1), right direction.
3. **No regressions from loading the pack** on correctness-type tests: every condition got the math, the mutable-default-argument bug, the qualifier preservation, and the Friday-deploy skepticism right.

## Where the pack did NOT improve behavior

1. **Eight of ten tests: no difference at all.** Plain Opus 4.8 already recomputes percentages, spots the mutable default argument, refuses shotgun causality, scopes the delete command, and preserves load-bearing qualifiers. On single-turn traps of this difficulty, the pack is mostly redundant with the model's defaults. **Do not cite this run as proof the pack "makes Opus better" in general.**
2. **B/test04 is a mild negative signal:** skills-only was the *only* condition that failed to flag the arbitrary-user fallback. Ironic, since `scope-fence` explicitly mandates flag-what-you-found. Possible causes: the relevant skill never triggered on a "fix this typo" prompt (exactly the standing-constraint triggering weakness the audit predicted and the CLAUDE-MD snippet exists to fix), or n=1 noise. Worth 2–3 replications before acting.
3. **The suite under-tests the pack's core claims.** The pack's designed value is multi-step sessions: plan discipline, live-state verification across many tool calls, error-recovery spirals, memory staleness. Single-turn Q&A traps cannot exercise any of that. High baseline scores here are expected and honest — not evidence the pack is useless, and not evidence it works.

## Recommendations from failures

1. **Replicate the three differentiating cells** (B/test04, A/test11, A/test15) at n=3 before drawing conclusions — one command each via `./run-eval.sh B test04` etc.
2. **Add Condition E (snippet) and rerun test 04.** If the snippet's always-on "flag what you found" rule fixes B's miss, that confirms both the diagnosis and the mitigation.
3. **Build a second, harder eval tier:** multi-turn scenarios (a planted stale-context trap mid-session, a fix that breaks a second thing, a subagent that returns a wrong claim to verify). That's where the pack's distinctive skills (`error-recovery`, `memory-hygiene`, `delegation-discipline`, `live-state-truth`) can actually differentiate. The current suite saturates: plain Opus passes 80–90%.
4. **Raise trap difficulty on saturated tests** (1, 3, 6, 9, 10): all four conditions passed comfortably; these now measure the model, not the pack.
5. **Keep tests 11 and 15 as-is** — they are the suite's only currently-discriminating instruments.

## Grading integrity notes

- Graded by independent agents against written rubrics, one grader per test, evidence quotes required; three verdicts hand-verified against raw text, including both cells graded *against* plain Opus (upheld as strict-but-correct; flagged as boundary calls in SCORES.md).
- Bias direction to worry about: graders share an author/model family with the pack. Everything needed for an independent regrade is in this folder (`prompts/`, `raw/`, `RUBRICS.md`).
