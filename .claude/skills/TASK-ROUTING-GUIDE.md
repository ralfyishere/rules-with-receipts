# Task Routing Guide

Maps common request shapes to the skills that should drive them. Skills listed in rough execution order; **standing constraints** (`scope-fence`, `change-control`, `verification-discipline`, `memory-hygiene`) apply to nearly everything and are only listed where they're the star.

`intent-clarity` and `effort-calibration` run first on *every* row — they're omitted below except where they carry extra weight.

## Coding

| Request sounds like... | Route |
|---|---|
| "Fix this bug" / "why is this failing?" | `debugging-playbook` → `live-state-truth` (verbatim errors, run the repro) → `adversarial-verify` (attack the diagnosis) → `change-control` (minimal fix) |
| "Build this feature" | `code-reconnaissance` (exemplar, prior art, blast radius, green baseline) → `plan-gate` → `deep-decomposition` (if large) → `change-control` + `scope-fence` during → `adversarial-verify` before delivery |
| "My fix broke something else" / second failed attempt | `error-recovery` (stop, diff vs. known-good, revert or fix forward) → back into `debugging-playbook` with the new evidence |
| "Refactor / clean this up" | `intent-clarity` (what does "clean" mean here?) → `change-control` (R1: prove behavior preserved) → `scope-fence` (the neighborhood stays untouched) |
| "Review this code / PR" | `adversarial-verify` (attack it) + `failure-mode-awareness` (software catalog) → `output-structuring` (critique format: ranked, specific, actionable) |
| "Migrate / upgrade / delete X" | `effort-calibration` (likely Critical) → `plan-gate` (rollback answer first) → `change-control` (R3 handling) → `failure-mode-awareness` |
| "It worked yesterday" | `debugging-playbook` step 2's diff-the-worlds move → `live-state-truth` |

## Writing & communication

| Request sounds like... | Route |
|---|---|
| "Improve this email / make it punchier" | `intent-clarity` (audience, the real ask of the email) → `ruthless-editor` → `output-structuring` (send-ready draft) |
| "Write a report / memo / summary" | `intent-clarity` (reader's decision variable!) → `output-structuring` (format first) → `verification-discipline` (label the claims) → `ruthless-editor` |
| "Document this" | `live-state-truth` (document what IS, not what you remember) → `output-structuring` → `ruthless-editor` |
| "Make this prompt better" | `prompt-engineering` (test cases → diagnose → one precise change → test) → `adversarial-verify` (what inputs still break it?) — with `ruthless-editor` and `change-control` running inside it |

## Analysis & decisions

| Request sounds like... | Route |
|---|---|
| "Analyze this business idea" | `structured-reasoning` (risk/reward + steelman) → `failure-mode-awareness` (strategy catalog) → `proactive-rigor` (what's undefined? what evidence is thin?) → `output-structuring` (decision memo) |
| "Should we do X or Y?" | `structured-reasoning` (tradeoff or matrix) → `verification-discipline` (grade the inputs) → `output-structuring` (recommendation first, sensitivity noted) |
| "Should we build this feature?" / "users are asking for X" | `product-thinking` (decode the problem, grade demand, MVP cut, kill criteria) → `structured-reasoning` → `output-structuring` (decision memo) |
| "Research topic X" | `deep-decomposition` (the sub-questions) → `research-methodology` (angles, independence, dissent, stopping rule) → `verification-discipline` (grade every claim) → `adversarial-verify` → `output-structuring` |
| "Brainstorm / give me ideas or names" | `divergent-ideation` (8–15 raw, judgment off, forced axes) → `structured-reasoning` (converge) → shortlist + longlist |
| "Review this plan / proposal" | `failure-mode-awareness` (premortem it) + `structured-reasoning` (steelman it) → `output-structuring` (critique) |
| "Will this scale?" / "what will we regret?" / committing to an architecture, roadmap, or direction | `foresight` (pre-register 3–7 dated, credenced predictions with observables; far horizon included) + `failure-mode-awareness` (present-design risks) — they catch different regret classes |
| "Check these numbers" | `live-state-truth` (the actual data) → `verification-discipline` (recompute independently, units, magnitude) |

## Ambient situations (not requests — states you notice)

| Situation | Route |
|---|---|
| Request is vague ("fix it", "make it better") | `intent-clarity` — reconstruct, state interpretation, proceed; ask only if branches diverge expensively |
| Task turning out much bigger than asked | `scope-fence` — stop and surface; scope change is the user's call |
| Two consecutive fixes failed / state is a mess | `error-recovery` — two-strike rule: stop patching, stabilize, decide revert vs. fix forward |
| About to spawn agents or use a delegated result | `delegation-discipline` — contract-grade brief; verify outputs before relying on them |
| All your "options" share one core mechanism | `divergent-ideation` — force different axes before converging |
| You're about to say "this should work" | `live-state-truth` — run it instead |
| High confidence, nothing verified | `adversarial-verify` — that mismatch is the trigger |
| About to rely on/ship "X works" (an edge, a metric, a rule change) that nobody measured | `empirical-validation` — run the cheapest experiment that could falsify it before investing |
| Standing investigation where a closed verdict is cited as "we already proved that doesn't work" — or someone is visibly succeeding at the "impossible" | `discovery-loop` — observe the domain first, log a new dated hypothesis with credence, attack any confirmation streak |
| About to build a tool / collect data the slow way / grind a single track | `leverage-first` — ask the four questions (does it exist? 10× method? compose? best question?) before the effort |
| User corrected you | `self-improvement-loop` — AAR before retry, lesson applied visibly |
| Just solved something hard with a reusable pattern | `extract-approach` — write the learning note to `.claude/learnings/` before calling it done |
| Resumed / compacted / very long session | `memory-hygiene` — re-anchor on live state before continuing |
| "Do whatever you think is needed" / "you decide" | `open-mandate` — inventory options, rank by value, lead with the decision AND the deliberate non-decisions, end with work done |
| About to ask the user to do something you can't (login, account, approval) | `human-handoff` — exact steps, exact values, completion signal named; verify from your side after "done" |
| "Make it public" / publishing / open-sourcing / loading third-party rules | `publish-hygiene` — four-layer check (content, metadata, history, rights); vet instruction files before they enter a session |
| The words "production", "irreversible", "send", "delete" appear | `effort-calibration` — bump to Critical; `change-control` R3 handling |
| Task is big, ambiguous, AND important | `frontier-workflow-mode` — run the whole pipeline |
| New/resumed session; "check the work on X" / "is everything up to date" / "continue" | `session-orientation` — read the workspace registry (ACTIVE-PROJECTS.md) BEFORE searching or auditing; verify load-bearing state live |
| About to `find`/search for a repo or start a broad "check everything" audit | `session-orientation` — the registry locates it; scope the audit from its pending list |
| Session ending after releases/launches/state changes | `session-orientation` closeout — promote scratchpad work to durable paths, update the registry entry |

## How to read a route

The arrows are dependency order, not a rigid script — skills interleave in practice (state checks happen throughout; editing comes last). If a route consistently feels heavy for a task type you handle often, the fix is tiering (`effort-calibration`), not skipping verification on the heavy tasks.

## When both seem to fit

Commonly-confused pairs and the line that splits them:

| When you're torn between... | Pick by... |
|---|---|
| `memory-hygiene` vs `live-state-truth` | `memory-hygiene` is the classifier — it decides WHEN a remembered fact is suspect; `live-state-truth` is the verifier — it GOES AND LOOKS. Suspect something you recall → `memory-hygiene`; need the current truth → `live-state-truth`. |
| `output-structuring` vs `ruthless-editor` | `output-structuring` picks the **format/shape** (table? memo? checklist?); `ruthless-editor` tightens the **prose** inside that shape. Wrong container → `output-structuring`; right container, flabby words → `ruthless-editor`. |
| `adversarial-verify` vs `failure-mode-awareness` | `adversarial-verify` attacks **finished work AFTER** it's built; `failure-mode-awareness` attacks **plans/designs BEFORE** you commit. Deliverable in hand → `adversarial-verify`; plan on the table → `failure-mode-awareness`. |
| `failure-mode-awareness` vs `foresight` | `failure-mode-awareness` interrogates the design **as it stands** (what breaks in this plan, present tense); `foresight` walks the **trajectory** (what breaks or becomes necessary 5/10/20 steps out) and pre-registers dated, credenced predictions to score later. Reviewing a plan → `failure-mode-awareness`; committing to a direction → both. |

## Provenance and maintenance

Part of the portable quality pack (2026-07). Routes reference only skills that exist in this directory. Maintain by addition: when a task type recurs that no row covers, add the row after handling it well once. Re-verify links stay valid when skills are renamed (`ls .claude/skills/` and compare against the names used here).
