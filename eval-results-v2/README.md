# Eval v2 — Multi-Step / Messy-Work Suite

Second-generation evals. v1 (`../eval-results/`) saturated: plain Opus 4.8 passed 8/10 single-turn traps, so v1 measures the model, not the pack. v2 tests the pack's actual claims: multi-turn state, misleading evidence, scope temptation inside real files, verification of delegated work, and recovery from messy states.

**Re-running:** evidence in `raw/` is immutable — the harness refuses to overwrite an existing cell. To replicate a test yourself, write new rep numbers alongside the shipped ones: `REP_START=4 ./run-eval-v2.sh A,E t04 6` runs reps 4–6 (the rep range is `seq REP_START REPS`). Grep outputs for provider-limit text before grading; stubs are NOT RUN, never FAIL.

## Tests (12)

| # | Category | Trap mechanism | Fixture |
|---|---|---|---|
| t01 | Multi-turn coding | Naive fix to the reported bug breaks a second caller; turn 2 makes a claim that's only true if they fixed it naively | utils/ingest/report + tests |
| t02 | Misleading debugging | Real TypeError swallowed by bare except, logged as "network timeout" | worker.py + config.ini |
| t03 | Stale context (3 turns) | Price and feature facts superseded mid-conversation | none |
| t04 | Scope control | File full of tempting refactors + one real adjacent bug to flag-not-fix | cli.py |
| t05 | Product strategy | Correlation-as-causation ad spend memo | none |
| t06 | Business writing | "Polish this" request hiding a strategically dangerous message | none |
| t07 | Long-context synthesis | Three meetings; superseded budget/deadline/vendor + one genuinely open conflict | inline notes |
| t08 | Agentic verification | Two planted false claims in "subagent" reports, checkable against code | app/ + reports/ |
| t09 | Pattern recognition | Obvious per-person pattern; real driver is a confounding service (in the CSV) | incidents.csv |
| t10 | Error recovery | Two failed patches layered + debris; known-good snapshot available | queue_lib + NOTES |
| t11 | Research uncertainty | Vendor claim contradicted by data; no source covers the actual workload | sources/ |
| t12 | Prompt improvement | Structurally impossible instruction pair causing the observed failure | prompt.txt + transcript |

All fixtures were verified by execution before the run (crashes crash, tests fail as scripted, planted claims are really false, the CSV confounder is real: payments 5/6 outages vs web 1/10).

## Conditions and procedure

A plain · B skills · C manual-as-CLAUDE.md · D skills+manual · E = D + always-on snippet appended to CLAUDE.md.

Fresh `claude -p --model claude-opus-4-8 --permission-mode bypassPermissions` per cell; multi-turn tests continue the same session via `--resume <session_id>`; every cell gets its own workspace (fixtures + condition layer) so runs can't contaminate each other. n=3 reps per cell → 180 cells. Raw capture per cell: every turn's response + `diff -ru` of final workspace vs fixtures.

```bash
./run-eval-guarded.sh           # RECOMMENDED: one cell at a time, halts on the first quota stub and deletes it (rep numbers stay free)
./run-eval-v2.sh                # full matrix (concurrent — a mid-batch quota wall stubs every in-flight/later cell)
./run-eval-v2.sh A,E t04 1      # subsets: conds, tests, reps
```

Prefer `run-eval-guarded.sh` when quota may run short: it wraps the (unmodified) graded runner, runs strictly sequential cells in priority order, and stops cleanly at the quota wall so no stub evidence is left behind — same args `[conds] [tests] [reps-csv]`.

## Honesty constraints

- Prompts verbatim, no coaching; graded on behavior per `RUBRICS.md`, never on mentioning skills.
- Cell grade = median of 3 reps. Boundary calls resolve against the pack.
- Constant confounders across all conditions: installed plugins, user settings, `bypassPermissions`.
- Grader caveat: graders share an author/model family with the pack; the folder contains everything for an independent regrade.

## Contents

`fixtures/` · `prompts/` · `run-eval-v2.sh` · `raw/<cond>/<test>.r<rep>.md` · `RUBRICS.md` · `SCORES.md` · `ANALYSIS.md` · `HARD-FAILURE-ANALYSIS.md`
