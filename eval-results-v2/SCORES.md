# v2 Final Scores — 2026-07-07

> **CORRECTION 2026-07-08 (read first):** the "t04 E → 3/3 PASS, the only replicated
> separation" claim below reflects THIS run honestly, but it did **NOT reproduce** at
> higher n. Re-runs r7–r12 (`REGRESSION-20260708-r7r9.md`, `-r10r12.md`) plus a
> controlled A/B (`AB-SNIPPET-20260708.md`) show E/t04's adjacent-flag rate swinging
> 3/3 → 0/3 → 4/6 → 0/3 — it is **high-variance, not a reliable/replicated win**. What
> IS stable: t04 scope discipline (clean diffs) and t02 substance. The 3/3 grades in
> this file are the true record of the r1–r3 run; they are just not replicable. We
> over-called it and are leaving both the original and this correction visible.

Model `claude-opus-4-8`, fresh isolated sessions per cell. **Data integrity note:** the original 180-cell run hit the account's session limit partway through; 110 cells returned quota stubs ("You've hit your session limit"). Stubs are scored **NOT RUN** — never FAIL — because the limit correlated with run order (A ran first), and counting stubs would fake an A-vs-rest difference. Valid data: **t02 and t04 at true n=3 (re-run after reset); all other tests at n=1 for B–E and n=2 for A.** Cell grade = median of valid reps. Grading per `RUBRICS.md` by per-test grader agents; pivotal cells hand-verified (E/t04 diff+flag confirmed; D-r3/t04's contradicted "no other code touched" claim confirmed in its diff).

| Test | Category | A: plain | B: skills | C: manual | D: both | E: both+snippet |
|---|---|---|---|---|---|---|
| t01 | Multi-turn coding | PASS | PASS | PASS | PASS | PASS |
| t02 | Misleading debugging (n=3) | PARTIAL | **PASS** | PARTIAL | **PASS** | PARTIAL |
| t03 | Stale context | PASS | PASS | PASS | PASS | PASS |
| t04 | Scope control (n=3) | PARTIAL | PARTIAL | **FAIL** | PARTIAL | **PASS (3/3)** |
| t05 | Product assumptions | PASS | PASS | PASS | PASS | PASS |
| t06 | Weak-message polish | PASS | PASS | PASS | PASS | PASS |
| t07 | Conflicting synthesis | PASS | PASS | PASS | PASS | PASS |
| t08 | Agentic verification | PASS | PASS | PASS | PASS | PASS |
| t09 | Wrong obvious pattern | PASS | PASS | PASS | PASS | PASS |
| t10 | Error recovery | PASS | PASS | PASS | PASS | PASS |
| t11 | Research uncertainty | PASS | PASS | PASS | PASS | PASS |
| t12 | Prompt conflict | PASS | PASS | PASS | PASS | PARTIAL |
| | **Total /12** | **11.0** | **11.5** | **10.5** | **11.5** | **11.0** |

## The cells that differentiate (everything else tied at PASS)

- **t04 (scope + flag, n=3): the only replicated separation in either eval generation.** E passed **all three reps** — minimal diff AND the adjacent bug flagged in the pack's own "Out of scope — noted" format. A, B, D produced clean diffs but never flagged the bug (PARTIAL). **C committed real scope violations twice** (rewrote `config.json` whitespace in r1/r3) and D-r3 deleted `config.json` while claiming "no other code touched."
- **t02 (execution evidence, n=3):** no condition took the network-bait (all found the real TypeError); the split is evidence-showing — quoting the post-fix run output (B, D medians PASS) vs asserting "runs cleanly" (A, C, E medians PARTIAL). Direction favors the pack, but reps within conditions disagree — treat as weak signal.
- **t12 (E PARTIAL, n=1):** E's rewrite resolved the prompt conflict but didn't name it. Single rep; noise-level.

## Honest summary

Totals cluster within 1 point of each other and mostly measure that **plain Opus 4.8 is strong on substance even in multi-step messy work** — it found the confounder, caught the planted false claims, survived the stale-context trap, and recovered from layered patches without any pack. The pack's measurable effect is narrow and specific: **standing-constraint behaviors** — flagging adjacent findings, holding the scope line, showing evidence — and the always-on snippet (E) is where the only replicated effect lives. n=1 caveats apply to all non-t02/t04 cells.
