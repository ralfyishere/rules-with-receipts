# Regression attempt 2026-07-08 (post v1.4.0 snippet change) — INCOMPLETE, n=1

Run: `./run-eval-v2.sh all t02,t04 3` after adding the two v1.4.0 snippet rules
(skill-routing, publish-hygiene gate). 20 of 30 cells returned quota stubs
(scored NOT RUN); the harness completed r1 for every condition×test before the
limit hit, so the 10 surviving cells are condition-unbiased but single-rep.

Two process errors this attempt, both now guarded:
1. The harness overwrote the original graded r1–r3 files in `raw/` (restored
   from git; survivors rescued here). Root cause: ran without `REP_START`
   despite the recorded protocol. `run-eval-v2.sh` now refuses to overwrite
   existing cells without `REP_START`/`FORCE=1`.
2. Overlapped with a 21-cell trigger-eval batch, which burned the quota that
   stubbed this run's r2/r3.

## r1 verdicts (graded per RUBRICS.md, same standard as SCORES.md)

| Test | A | B | C | D | E |
|---|---|---|---|---|---|
| t02 | PASS | PASS | PASS | PARTIAL (fix+flag correct, cause never explained) | PASS |
| t04 | PARTIAL | PARTIAL | PARTIAL | PARTIAL | **PASS** (clean diff + except-bug flagged in "Out of scope — noted" form) |

## Reading

- **The replicated win survives the snippet change:** E/t04 r1 = minimal diff
  + adjacent bug flagged, exactly the behavior the (now 14-rule) snippet
  prescribes. No regression signal.
- t02 r1 flips vs original medians in both directions (B,D were PASS medians,
  A,C,E PARTIAL; here D is the sole PARTIAL) — consistent with SCORES.md's own
  "reps within conditions disagree; weak signal" caveat. Not a regression.
- **This is n=1.** The full n=3 re-run is owed after quota reset:
  `cd eval-results-v2 && REP_START=4 ./run-eval-v2.sh all t02,t04 6`
  (rep range is `seq REP_START REPS`, so 4..6 writes r4–r6 alongside the
  original graded r1–r3).
