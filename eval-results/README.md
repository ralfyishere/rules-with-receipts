# Eval Results — Four-Condition Run

Honest evaluation of whether the quality pack changes Claude Opus 4.8 behavior. Run 2026-07-07.

## Conditions

| Cond | Setup | How it's isolated |
|---|---|---|
| **A — Plain** | Empty directory; no skills, no manual, no project instructions | Env dir created under `/tmp` (via the harness), outside any tree containing the pack — ancestor `.claude/` discovery cannot reach the skills |
| **B — Skills only** | Copy of `.claude/skills/` in the env dir | Manual not present anywhere in the env |
| **C — Manual only** | `FUTURE-MODEL-OPERATING-MANUAL.md` as the env dir's `CLAUDE.md` | No skills dir in the env |
| **D — Both** | Skills copy + manual as `CLAUDE.md` | — |

All conditions: fresh `claude -p --model claude-opus-4-8 --no-session-persistence` sessions (non-interactive print mode = new session per run, no shared state). The contaminated authoring session was **not** used for any condition — `claude -p` child sessions perform their own discovery (verified separately).

## Exact procedure

```bash
cd eval-results
./run-eval.sh                 # all 4 conditions × all prompts in prompts/
./run-eval.sh A,B test03      # subsets
MODEL=claude-opus-4-8 CONCURRENCY=5 ./run-eval.sh   # env-var overrides
```

The harness builds the condition dirs (`ENV_BASE`, default `mktemp -d`), runs each (condition, test) with a 300s timeout, and writes raw outputs to `raw/<condition>/<test>.md`.

## Contents

- `prompts/` — the exact prompt per test, byte-for-byte what each session received
- `run-eval.sh` — the harness (see header comment for usage)
- `raw/A..D/` — unedited model outputs, one file per (condition, test)
- `RUBRICS.md` — the pass/fail rubric per test + grading rules
- `SCORES.md` — the scored table
- `ANALYSIS.md` — where the pack helped, where it didn't, recommendations

## Honesty constraints observed

- Prompts submitted verbatim; zero coaching.
- Tests used: 01, 03, 04, 05, 06, 08, 09, 10, 11, 15 (covers the 11 requested categories; test 03 covers coding + debugging). Tests 02, 07, 12, 13, 14 were prepared in `OPUS-IMPROVEMENT-EVALS.md` but not run in this pass (cost control) — the harness runs them if their prompts are added to `prompts/`.
- **n = 1 per cell.** Single-cell differences are noise; only cross-test patterns are treated as signal. The eval spec itself calls for 2–3 runs per cell for stronger claims.
- Grading was performed against `RUBRICS.md` by delegated graders blind to which condition produced which output where feasible, with spot-checks against raw text; boundary calls resolved against the pack. Caveat: graders and pack share an author — an independent regrade of `raw/` against `RUBRICS.md` is the stronger protocol and everything needed for it is in this folder.
- Constant-across-conditions factors that could not be removed: installed Claude Code plugins and user-level settings (present identically in all four conditions).
