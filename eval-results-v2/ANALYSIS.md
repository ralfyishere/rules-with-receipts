# v2 Analysis

Short companion to `SCORES.md` (table, integrity notes) and `HARD-FAILURE-ANALYSIS.md` (the six evidence questions). This file: run history and the v1→v2 comparison.

## Run history (for reproducibility)

1. Full matrix launched: 5 conditions × 12 tests × 3 reps = 180 cells, concurrency 8, isolated workspaces.
2. **Quota incident:** the account's session limit tripped partway through; 110 cells "completed" as non-empty stub files. Because condition A ran first in each wave, stubs correlated with condition — scoring them as FAIL would have manufactured an A advantage. Stubs were reclassified NOT RUN; see `.claude/learnings/2026-07-07-eval-outputs-can-be-quota-stubs.md`.
3. **Targeted re-run after reset:** the two discriminating tests (t02, t04) were re-run to genuine n=3 across all five conditions (`REP_START=2 ./run-eval-v2.sh all t02,t04 3`), verified stub-free.
4. Grading: one grader agent per test with the rubric embedded, diff-first for coding tests; pivotal verdicts hand-checked (E/t04.r2's two-line diff + flag block; D-r3/t04's contradicted completion claim).

## v1 → v2 delta

| | v1 (single-turn traps) | v2 (multi-step, messy) |
|---|---|---|
| Plain Opus | 9.0/10 (90%) | 11.0/12 (92%) |
| Best condition | D (skills+manual) 10/10 | B/D 11.5 by totals; **E uniquely replicated on t04** [SUPERSEDED 2026-07-09: did NOT reproduce at higher n — high-variance, not replicated; see the row below and `REGRESSION-20260708-r10r12.md`] |
| Tests that discriminate | 2/10 (11, 15) | 2/12 (02, 04) |
| Nature of the pack's edge | Delivery completeness (usable artifact) | Standing constraints (scope, flags, quoted evidence) |
| Only replicated effect | — (all n=1) | **Snippet → t04 3/3 PASS** (CORRECTED 2026-07-08: did NOT reproduce at higher n — high-variance, not replicated; see `REGRESSION-20260708-r10r12.md`) |

Consistent story across both generations: raw problem-solving is baseline-strong; the pack's real, measurable contribution is a narrow band of discipline behaviors — and that band is delivered by the *always-on snippet*, not by skill triggering alone (B missed the t04 flag in all reps of both generations).

## Bottom line

The pack earns its install for the scope/flag/evidence layer, at small cost; it does not make Opus smarter and the data does not claim it does. Install skills + manual + snippet together (condition E); treat t02/t04 as the monthly regression pair; raise test difficulty before drawing any further conclusions.
