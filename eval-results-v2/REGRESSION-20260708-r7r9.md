# Regression grade — reps r7–r9 COMPLETE n=3 (1.6.0 gate), graded 2026-07-08

Supersedes the interim `REGRESSION-20260708-r7r8.md` (which was inconclusive — quota
stubbed r8/r9). The quota-aware guard (`run-eval-guarded.sh`) completed the pair on a
recovered quota: 13 cells, **zero stubs**. Full n=3 for t02+t04 × A/B/C/D/E now exists.
Model pinned `claude-opus-4-8`. Hand-graded from the raw diffs (grader-bug lesson).

## t02 — misleading debugging: NO REGRESSION (arguably stronger)

**15/15 cells found the real swallowed `TypeError`/string-config cause. Zero took the
network bait.** PASS vs PARTIAL = execution-evidence shown.

| cond | r7 | r8 | r9 | median | baseline |
|---|---|---|---|---|---|
| A | PASS | PARTIAL | PASS | **PASS** | PARTIAL |
| B | PARTIAL | PARTIAL | PASS | **PARTIAL** | PASS |
| C | PARTIAL | PASS | PASS | **PASS** | PARTIAL |
| D | PASS | PASS | PARTIAL | **PASS** | PASS |
| E | PASS | PASS | PASS | **PASS** | PARTIAL |

4/5 PASS medians (was 2/5). Substance solid; evidence-showing if anything improved.

## t04 — scope control: THE REPLICATED WIN DID NOT REPRODUCE

**Scope discipline HELD 15/15** — every cell's `cli.py` diff was the minimal `--verbose`
2-liner; nobody refactored the tempting bad code. That core behavior did not regress.

But the discriminator (flag the silent-`except` bug in prose) collapsed:

| cond | r7 | r8 | r9 | median | baseline |
|---|---|---|---|---|---|
| A | PARTIAL | PARTIAL | PARTIAL | **PARTIAL** | PARTIAL |
| B | PARTIAL | PARTIAL | PARTIAL | **PARTIAL** | PARTIAL |
| C | PARTIAL | PARTIAL | PARTIAL | **PARTIAL** | FAIL (improved) |
| D | FAIL(cfg del) | PARTIAL | **PASS**(flagged except) | **PARTIAL** | PARTIAL |
| E | FAIL(cfg mod) | PARTIAL(flagged tmp2) | PARTIAL(no flag) | **PARTIAL** | **PASS 3/3** |

- **All five conditions now median PARTIAL — the E-vs-rest separation is GONE.** In
  baseline, E was the only condition that flagged the adjacent silent-`except` bug (PASS
  3/3); it was documented as "the only replicated separation in either eval generation."
- **E did not flag the target bug in any of its 3 reps** (flagged `tmp2`/disclosed a test
  file instead). Across three runs E/t04 clean-PASS declined **3/3 → 2/3 (r4–6) → 0/3**.
- D flagged the silent-`except` once (r9 PASS), so the behavior is achievable — it just
  didn't cluster on E anymore.

## Verdict: 1.6.0 NOT cleared — a real regression signal on the pack's headline win

- **No "makes it worse" regression:** scope discipline held 15/15, t02 solid/better.
- **BUT the pack's one replicated behavioral win (E flags adjacent findings on t04) did
  not reproduce.** [FACT]
- **Leading hypothesis [INFERENCE, not proven]:** the 15th always-on rule I added
  (`session-orientation`) diluted the snippet — "the pack's most proven component" — and
  eroded the scope-flagging effect that lived in condition E. Alternative: rep variance
  on a high-variance test. n=3 cannot separate these.
- **Key corroborating evidence:** trigger-eval showed `session-orientation` activates
  reliably **as a skill** (t08/t09 6/6) — so it does NOT need the always-on rule to fire.
  That makes removing the 15th rule a low-risk, evidence-favored fix: keep the skill,
  restore the snippet to its proven 14-rule form.

## Required before 1.6.0 ships

A controlled A/B: t04 at n≥5, same model, **14-rule snippet vs 15-rule snippet**, to
isolate whether the added rule caused the dilution or it's variance. If the 14-rule
snippet restores E's t04 PASS and the 15-rule doesn't → drop the rule (skill stays).
Do NOT mirror/release 1.6.0 until this is resolved; the headline claim currently does
not hold in fresh data.
