---
name: Code Reconnaissance
description: Understand the relevant code, conventions, and blast radius before writing or changing code in an existing project. Activate before implementing any feature, fix, or refactor in a codebase you didn't write this session - especially "add X to the app", "where should this go", "integrate with", or any multi-file change. Trigger signals: about to write new code without having looked for an existing implementation; about to edit a function without knowing its callers; unfamiliar project structure.
---

# Code Reconnaissance

## Purpose

Code written without reconnaissance is foreign tissue: it duplicates helpers that already exist, violates conventions the rest of the codebase follows, and breaks callers the author never saw. Fifteen minutes of directed reading turns a plausible change into a native one. This is the comprehension *strategy* that runs before any plan for changing existing code — `live-state-truth` says "read before you edit"; this skill says *what* to read and what to extract from it.

## When to use this skill

- Before implementing anything in a codebase not written in this session.
- Before choosing where new code should live ("where does this belong?" is a recon question, not a taste question).
- Before editing any function/module whose callers you can't name.
- When the task says "do it the way the rest of the app does it" — explicitly or implicitly (it's always implicit).

## When NOT to use this skill

- Greenfield code with no surrounding conventions to honor.
- Code you wrote or fully mapped earlier in this session and haven't been away from (see `memory-hygiene` for when that expires).
- Don't let recon become stalling: the checklist below is minutes of reading, not a full codebase audit. Depth follows `effort-calibration`.

## Operating procedure

**1 — Locate the territory.** Search by the feature's vocabulary (user-facing terms, route names, domain nouns) to find where this concern already lives. Entry points first: routes, CLI commands, main modules, exported APIs.

**2 — Find an exemplar.** Locate one existing implementation of the *same kind of thing* you're about to build (another endpoint, another validator, another migration). This is the single highest-value recon artifact — it answers naming, structure, error handling, and test placement in one read.

**3 — Check for prior art before writing anything new.** The helper you're about to write probably exists. Search for it by behavior, not just name (utils, shared libs, an existing dependency that does it). Writing a second `formatDate` is how codebases rot.

**4 — Inventory the local conventions.** From the exemplar and neighbors: naming style, error-handling pattern (exceptions vs. results), logging idiom, how dependencies are injected, where types/interfaces live, test file layout. You will match these even where you'd prefer otherwise (`change-control`: consistency beats taste).

**5 — Map the blast radius.** For anything you'll modify: who calls it, who imports it, what tests cover it. A grep for the symbol name is the minimum. Shared code with unknown callers is an R2+ change by default.

**6 — Establish the green baseline.** Run the relevant tests (or build) *before* changing anything, and record the result. Otherwise you cannot distinguish your breakage from pre-existing failure — a distinction you will need within the hour.

**7 — Then plan.** Feed the findings into `plan-gate`: the exemplar shapes the design, the blast radius shapes the risk section, prior art shrinks the work.

## Quality bar

- You can name: the exemplar you're following, the callers of anything you'll touch, and the baseline test state — before the first edit.
- New code is indistinguishable in style from its neighbors.
- No new helper was written that duplicates an existing one you could have found in two searches.

## Common failure modes

- **Convention blindness:** correct code in a foreign idiom — camelCase in a snake_case codebase, exceptions where everything else returns results. Reviewers reject it; future readers curse it.
- **Duplicate implementation:** rebuilding an existing util because searching felt slower than writing. It wasn't.
- **Invisible callers:** "improving" a shared function's behavior for your use case, breaking three others you never listed.
- **Baseline skipped:** discovering 12 failing tests after your change and burning an hour proving 9 were already failing.
- **Recon as procrastination:** mapping the whole architecture when the task needed one exemplar and one grep. Scope the recon to the change.

## Example

Task: "Add a rate-limit config option to the API."
Recon (8 minutes): grep `config` → found `config/schema.ts` with a Zod schema — every option is declared there with a default and description (exemplar). Grep `rateLimit` → a `middleware/rateLimit.ts` already exists reading a hardcoded constant (prior art: the feature is half-built; the task is *wiring*, not building). Callers of the constant: one. Tests: `config.test.ts` has a table-driven pattern for each option; suite currently green (baseline). Plan shrinks from "build rate limiting" to "add schema field + thread it to the middleware + one table row in tests," in the house style.

## Works with sibling skills

- Runs **before `plan-gate`** on existing-code tasks — recon findings are the plan's raw material.
- **`live-state-truth`** is the underlying discipline (observe, don't assume); this skill is its directed, code-specific strategy.
- **`change-control`** consumes the blast-radius map for risk classing; **`scope-fence`** keeps recon findings (adjacent mess) as flags, not detours.
- **`debugging-playbook`** has its own investigation flow for defects; use that when something is broken, this when something is being built.

## Provenance and maintenance

Added 2026-07 in the expansion pass: the core pack governed *how to change* code but not *how to understand it first* — the gap behind duplicate helpers, foreign-idiom diffs, and broken callers. No repo-specific claims. Re-verify by reviewing recent diffs in real projects: convention mismatches or duplicated utilities appearing in merged work mean steps 2–4 are being skipped.
