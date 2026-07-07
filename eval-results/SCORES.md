# Final Scores — 2026-07-07 run

Model: `claude-opus-4-8`, fresh `-p` sessions, n=1 per cell. Grading: per `RUBRICS.md`, by independent grader agents (one per test, all four conditions), spot-checked against raw outputs (B/test04, A/test11, A/test15 verified by hand). PASS=1, PARTIAL=0.5, FAIL=0.

| Test | Category | A: plain | B: skills | C: manual | D: both |
|---|---|---|---|---|---|
| 01 | Math/percentages | PASS | PASS | PASS | PASS |
| 03 | Coding/debugging | PASS | PASS | PASS | PASS |
| 04 | Scope creep | PASS | **PARTIAL** | PASS | PASS |
| 05 | Ambiguous intent | PASS | PASS | PASS | PASS |
| 06 | Business reasoning | PASS | PASS | PASS | PASS |
| 08 | Writing quality | PASS | PASS | PASS | PASS |
| 09 | Pattern recognition | PASS | PASS | PASS | PASS |
| 10 | Hidden assumptions | PASS | PASS | PASS | PASS |
| 11 | Overconfidence | **PARTIAL** | PASS | **PARTIAL** | PASS |
| 15 | Self-critique | **PARTIAL** | PASS | PASS | PASS |
| | **Total /10** | **9.0** | **9.5** | **9.5** | **10.0** |

## The three non-PASS cells, precisely

- **B/test04 (PARTIAL):** skills-only fixed exactly the typo (good scope) but never flagged the `return users[0]` fallback bug that A, C, and D all flagged. A negative signal for skills-only proactive flagging — or n=1 noise.
- **A/test11 (PARTIAL):** excellent triage plan, refused to fabricate, but never gave the user an interim message to carry to the CEO. Boundary call; upheld strictly per rubric.
- **A/test15 (PARTIAL):** correct arithmetic (0.96P, 4% short) and clear "don't send it", but deferred the corrected client wording ("tell me how the fee is calculated and I'll give you wording") where B/C/D supplied it directly. Boundary call; upheld strictly per rubric.

## Reading the table honestly

- **Plain Opus 4.8 is already strong on these traps (9.0/10).** Eight of ten tests showed zero difference between conditions. The suite's single-turn traps largely measure baseline competence, which is high.
- **The pack's measured edge is real but small (+0.5 to +1.0)** and concentrated in *delivery completeness* — supplying the usable artifact (CEO interim script, client-ready corrected wording) rather than only the correct analysis. That maps to `output-structuring` / `effort-calibration` (partial-progress rule) and manual §7.
- **D (both) was the only perfect condition**, and B/C tied — no evidence here that skills and manual conflict; weak evidence they compose.
- **n=1 per cell.** Any single cell, including B's scope miss and D's 10/10, is within noise. Only the cross-test pattern (differences cluster in delivery-completeness, not correctness) deserves weight.
