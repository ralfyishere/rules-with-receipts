# Goal Templates

Reusable goal-prompt patterns for handing Claude a bounded, provable objective.

**Command support (verified 2026-07-07 in this environment):** `claude --help` and fresh-session skill lists show **no `/goal` command exists**. `/loop` (recurring runs) and `/schedule` (cron-style cloud agents) DO exist. So: these templates are **prompt patterns** — paste one as the task message in any session. They also work as the prompt argument to `/loop` or a scheduled run, and re-verify command availability in your own environment before relying on it (`claude --help`; ask a fresh session to list its skills).

## The universal scaffold

Every goal prompt has eight parts. Omitting the caps or the proof line is how autonomous runs go feral — never hand out an uncapped goal.

```markdown
GOAL: <one sentence — the finish line, observable>
SCOPE: <what's in> | OUT OF SCOPE: <what must not be touched>
PROOF REQUIRED: <the check that must pass before claiming success — command output, test run, artifact>
FILES ALLOWED TO CHANGE: <paths/globs> | MUST NOT CHANGE: <paths/globs>
CAPS: <max attempts / turns / wall-clock — stop and report when hit>
ON FAILURE: <what to do when an attempt fails — e.g., revert, log, try next hypothesis>
IF BLOCKED: report <exact state, what was tried, what's needed> — do not improvise around the blocker.
```

## Filled templates

### 1. Coding fix
```markdown
GOAL: `python3 test_all.py` passes in <dir>; the crash reported in <issue/error> no longer reproduces.
SCOPE: the minimal fix for this bug. OUT OF SCOPE: refactors, style, other bugs (flag them instead).
PROOF: full test output pasted, plus the original repro command now succeeding.
FILES ALLOWED: src/<module>*, tests/ (new regression test only). MUST NOT CHANGE: config, CI, unrelated modules.
CAPS: 3 fix attempts. Two consecutive failures → stop patching, apply error-recovery, report.
ON FAILURE: revert to last green state before the next attempt.
IF BLOCKED: report the failing hypothesis table and current diff; do not ship a partial fix as done.
```

### 2. Refactor
```markdown
GOAL: <structure change, e.g., "extract the parser into parser.py"> with zero behavior change.
SCOPE: structure only. OUT OF SCOPE: fixing bugs found on the way (flag), renaming beyond the extraction, "improvements".
PROOF: full test suite green BEFORE (baseline shown) and AFTER; diff reviewed against intent.
FILES ALLOWED: <the modules involved>. MUST NOT CHANGE: public interfaces, tests (except imports), configs.
CAPS: one session; if the refactor cascades beyond <N> files, stop and report the real blast radius.
ON FAILURE: revert; a half-applied refactor is worse than none.
IF BLOCKED: report which coupling prevents clean extraction — that finding is a valid deliverable.
```

### 3. Test creation
```markdown
GOAL: <module> has tests covering <behaviors listed>; all pass; at least one would fail if <known risk> regressed.
SCOPE: tests only. OUT OF SCOPE: changing the code under test (if it's untestable, report why instead).
PROOF: test run output; for each named behavior, point to the test that covers it; show one test failing when the behavior is deliberately broken (then restore).
FILES ALLOWED: tests/ only. MUST NOT CHANGE: src/.
CAPS: <N> tests / one session. No tautological tests (asserting the mock you just wrote).
ON FAILURE: if a behavior can't be tested without refactoring, list it under "untestable as-is" with the reason.
IF BLOCKED: deliver the tests that work + the blocked list.
```

### 4. Research task
```markdown
GOAL: answer "<question>" with a recommendation I can act on.
SCOPE: sources <allowed set — e.g., provided docs / web>. OUT OF SCOPE: <adjacent questions>.
PROOF: every load-bearing claim labeled (fact/inference/assumption) with its source; dissenting source engaged or its absence noted; stopping rule stated.
FILES ALLOWED: a single report file. MUST NOT CHANGE: anything else.
CAPS: <time/source budget — e.g., 10 sources or 30 min>; stop at saturation.
ON FAILURE: if sources conflict irreconcilably, report the conflict as the finding — don't average.
IF BLOCKED: deliver partial findings + the specific gaps and what would fill them.
```

### 5. Business strategy audit
```markdown
GOAL: audit <plan/strategy doc> and deliver: top 3 risks, top 3 unvalidated assumptions, and a keep/change/kill recommendation per component.
SCOPE: the named plan. OUT OF SCOPE: rewriting the strategy (that's a follow-up), org/people judgments.
PROOF: each risk tied to a specific mechanism (not generic), each assumption tagged with the evidence that would validate it.
FILES ALLOWED: one audit memo. MUST NOT CHANGE: the strategy doc itself.
CAPS: one session; max one clarifying question, and only if it forks the audit.
ON FAILURE: if the plan is too vague to audit, the deliverable is the list of what must be specified first.
IF BLOCKED: deliver the partial audit with unaudited sections named.
```

### 6. Prompt improvement
```markdown
GOAL: <prompt> stops <specific failure — with the failing example attached>; existing good behavior preserved.
SCOPE: the prompt text. OUT OF SCOPE: the surrounding app code, model/config changes (flag if they're the real fix).
PROOF: before/after outputs on (a) the failing case, (b) one working case, (c) one edge case. Single-run "it looks better" doesn't count.
FILES ALLOWED: the prompt file + a versions note. MUST NOT CHANGE: other prompts.
CAPS: 3 iterations, one change per iteration.
ON FAILURE: if the failure survives all wordings, report it as a capability/context gap, not a prompt bug.
IF BLOCKED: deliver the diagnosis (failure class) even without a fix.
```

### 7. Evaluation run
```markdown
GOAL: run <eval suite> across <conditions>, produce scored table + analysis.
SCOPE: run + grade + report. OUT OF SCOPE: changing the thing being evaluated mid-run, tuning tests to pass.
PROOF: raw outputs saved per cell; grades traceable to written rubrics; differentiating cells spot-checked against raw text.
FILES ALLOWED: the eval results directory only. MUST NOT CHANGE: fixtures/rubrics once the run starts.
CAPS: <N> runs / $<budget> / <time>; if >10% of cells error, stop and fix the harness before continuing.
ON FAILURE: partial results are reportable — mark missing cells as NOT RUN, never interpolate.
IF BLOCKED: report harness state + exact resume command.
```

### 8. Documentation cleanup
```markdown
GOAL: <doc set> is accurate against the current code/product and 20-40% shorter.
SCOPE: listed docs. OUT OF SCOPE: restructuring the product, changing code to match wrong docs (flag mismatches instead).
PROOF: every remaining claim spot-verified against live state (command outputs / code refs); list of corrected-vs-cut items.
FILES ALLOWED: the docs. MUST NOT CHANGE: code, configs.
CAPS: one pass; if docs contradict code, the contradiction list is the deliverable — don't guess which is right.
ON FAILURE: n/a (this task degrades gracefully — deliver what's verified).
IF BLOCKED: deliver verified sections + the unverifiable list.
```

## Using with /loop (verified available)

`/loop <interval> <prompt>` re-runs a prompt on a schedule. Only loop goals that are **idempotent and capped** (e.g., template 7's monitoring variant). Never loop templates 1-2 — repeated autonomous edits without review compound errors. If in doubt, don't loop it.

## Maintenance

Re-verify command availability when Claude Code updates (`claude --help`). Add new templates only for goal shapes you actually hand out; delete unused ones. See `.claude/MAINTENANCE-CADENCE.md`.
