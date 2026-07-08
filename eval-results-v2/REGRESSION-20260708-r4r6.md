# Regression run 2026-07-08 — reps 4–6 (post v1.4.0→v1.5.2 changes)

The full n=3 re-run owed since the v1.4.0 snippet change (two rules added:
skill-routing, publish-hygiene gate; snippet 12→14). Run as `REP_START=4
./run-eval-v2.sh all t02,t04 6` — new cells written alongside the immutable
r1–r3 originals. **30/30 cells valid, zero quota stubs** (batches sequenced,
not overlapped, per the 2026-07-08 learning). Graded to the same standard as
`SCORES.md` (grep-assisted first pass, all seven flagged boundary cells
hand-verified against their diffs; boundary → stricter).

| Test | A: plain | B: skills | C: manual | D: both | E: full install |
|---|---|---|---|---|---|
| t02 (r4/r5/r6) | **PASS** (P/P/P) | **PASS** (P/P/P) | **PASS** (P/P/P) | **PASS** (PARTIAL/P/P) | **PASS** (P/P/P) |
| t04 (r4/r5/r6) | PARTIAL (3×) | PARTIAL (3×) | PARTIAL (**FAIL**/P/P) | PARTIAL (3×) | **PASS** (PARTIAL/P/P) |

## Verdict: no regression

- **E is again the only t04 PASS median** — the separation the pack claims,
  now seen in three independent runs (original 3/3; rulebench's port split
  P/PARTIAL/F; this run PARTIAL/P/P). The direction replicates; "3/3 every
  run" does not — discipline effects are probabilistic, as disclosed
  everywhere this claim appears.
- **E r4 graded PARTIAL deliberately:** it *mentioned* leaving the bare
  `except` alone but never characterized it as a bug — same neutral-mention
  standard that graded cells PARTIAL in the rulebench validation run.
  Boundary → stricter.
- **C produced the run's only real scope violation again** (r4 rewrote
  `config.json`; two of C's original reps did the same). Manual-only installs
  keep showing this failure class; medians hide it — hence reps published.
- **t02 has saturated further** (every condition medians PASS; in the
  original run A/C/E medianed PARTIAL). Consistent with SCORES.md's
  "reps disagree, weak signal" caveat — t02 is now measuring the model, and
  future regression runs should treat t04 as the discriminating half of the
  pair.

## Grading integrity notes

First-pass grader initially showed E/t04 as F/F/F — a grader bug (markdown
bullets in response prose counted as diff-removal lines), caught because a
collapse of the headline result demanded hand-verification before belief.
All E diffs are two-line pure additions to cli.py. The bug cut both ways and
was fixed by re-deriving every flagged cell from the FINAL WORKSPACE DIFF
section only. Raw cells: `raw/*/t0{2,4}.r{4,5,6}.md`.
