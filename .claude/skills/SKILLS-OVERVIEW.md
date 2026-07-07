# Skills Overview

A portable, project-agnostic quality pack: 26 skills that improve **process** — planning, verification, editing, debugging, decision-making — on any project. 18 form the core rigor set; 7 were added in an expansion pass for high-recurrence domains (codebase work, error recovery, delegation, research, prompts, ideation, product decisions); `extract-approach` adds the persistence layer. They add discipline, not capability; see `HOW-TO-USE-WITH-OPUS.md` for limitations.

Beyond the skills, the pack has companion layers (each one file, at `.claude/`): always-on rules (`skills/CLAUDE-MD-SNIPPET.md`), durable notes (`learnings/`), user-world context (`CONTEXT-SYSTEM-SETUP.md`), bounded objectives (`GOAL-TEMPLATES.md`), the skill pipeline (`WORKFLOW-EXTRACTION-QUEUE.md`), and upkeep (`MAINTENANCE-CADENCE.md`).

## The skills at a glance

| Skill | One-line purpose | Triggers when... |
|---|---|---|
| **Reasoning & planning** | | |
| `intent-clarity` | Serve the mission, not just the sentence | Any non-trivial task start; vague referents ("fix it", "make it better"); before asking any clarifying question |
| `effort-calibration` | Match depth to complexity and stakes | Every task start; stakes shift mid-task; torn between "just answer" and "go verify" |
| `plan-gate` | Written plan before complex work | 3+ dependent steps, multi-file work, expensive wrong starts; "build/implement/migrate" |
| `deep-decomposition` | Break hard tasks into staged, ordered units | Task too big for one plan; plan steps like "figure out the rest" |
| **Verification & rigor** | | |
| `live-state-truth` | Trust observed state over memory/docs | Before any claim about current files/code/data/docs; before editing; after changes ("run it") |
| `verification-discipline` | Label facts vs. inferences vs. assumptions vs. guesses | Any claim someone will act on; numbers, API behavior, legal/financial/product claims |
| `adversarial-verify` | Try to break your own work before presenting | Before finalizing High/Critical deliverables; high confidence + low verification |
| `failure-mode-awareness` | Ask "how does this break?" at design time | Plans, designs, proposals, recommendations — before they harden |
| `proactive-rigor` | Flag what the request didn't say — without friction | Missing constraints, weak evidence, contradictions, downstream problems |
| **Debugging & execution** | | |
| `debugging-playbook` | Symptom → repro → hypotheses → evidence → root cause | Anything broken, failing, or surprising; "it worked yesterday"; intermittent issues |
| `change-control` | Edits that are isolated, reviewable, reversible | Modifying anything that works or that others depend on; irreversible actions |
| `scope-fence` | Fix what was asked; flag what was found | Every execution task; the "while I'm here..." urge |
| **Output quality** | | |
| `ruthless-editor` | Cut fluff, strengthen wording, preserve meaning | Any prose deliverable; "tighten/polish/shorten"; your own long answers |
| `structured-reasoning` | The right framework for the decision/analysis | Choosing between options; evaluating ideas; reasoning going in circles |
| `output-structuring` | The most usable format for the reader's next action | Any substantial response; walls of text; buried answers |
| **Memory & continuity** | | |
| `memory-hygiene` | Classify and re-verify session context | Long/resumed sessions; after compaction; contradictions with memory |
| `self-improvement-loop` | Convert corrections and failures into applied lessons | User corrections; failed attempts; recurring friction; end of big tasks |
| `extract-approach` | Persist the reusable approach as a note in `.claude/learnings/` | After solving anything non-trivial that future sessions will face again |
| **Domain & agentic (expansion pass)** | | |
| `code-reconnaissance` | Understand code, conventions, and blast radius before changing it | Any feature/fix in a codebase you didn't write this session; "where should this go" |
| `error-recovery` | Stop the spiral: stabilize, revert-or-fix-forward deliberately | Second consecutive failed fix; newly broken state; patch-on-patch layering |
| `delegation-discipline` | Contract-grade briefs for subagents; verify their outputs | Spawning agents/background tasks; incorporating any delegated result |
| `research-methodology` | Multi-angle search, source independence, honest coverage claims | "Research X"; market/technical landscape questions; multi-source synthesis |
| `prompt-engineering` | Improve prompts with test cases, not vibes | "Improve this prompt"; "the model keeps doing X"; system prompts and agent instructions |
| `divergent-ideation` | Generate different mechanisms before choosing | "Brainstorm"; naming; design alternatives; stuck circling one approach |
| `product-thinking` | Decode features into user problems; grade demand evidence | "Should we build"; feature requests; MVP scoping; prioritization |
| **Meta** | | |
| `frontier-workflow-mode` | Orchestrates the pack, in order, for high-stakes work | High/Critical tasks; "this is important / production / be thorough" |

## Which skills work best together

- **The universal spine (every non-trivial task):** `intent-clarity` → `effort-calibration` → (tier decides the rest). These two are cheap and always run first.
- **Building things (in existing code):** `code-reconnaissance` → `plan-gate` + `deep-decomposition` + `live-state-truth` + `change-control` + `scope-fence`, closed by `adversarial-verify`.
- **Fixing things:** `debugging-playbook` (which internally leans on `live-state-truth` and `adversarial-verify`) + `change-control` for the fix; `error-recovery` fires if the fixing itself starts failing.
- **Deciding things:** `structured-reasoning` + `verification-discipline` + `failure-mode-awareness`, delivered via `output-structuring` (decision memo). For product decisions, `product-thinking` frames the problem first.
- **Writing things:** `intent-clarity` (audience!) + `output-structuring` + `ruthless-editor`, in that order — format before polish.
- **Researching things:** `deep-decomposition` → `research-methodology` → `verification-discipline` → `output-structuring`.
- **Generating options:** `divergent-ideation` (diverge) → `structured-reasoning` (converge) → `product-thinking` if the options are product ideas.
- **Agentic fan-out:** `deep-decomposition` (partitions) → `delegation-discipline` (briefs + verification) → `adversarial-verify` on the synthesis.
- **Standing constraints (always on, no invocation needed):** `scope-fence`, `change-control`, `verification-discipline`, `memory-hygiene`.
- **The full stack:** `frontier-workflow-mode` sequences everything for High/Critical work.

Boundary notes (commonly confused pairs):
- `failure-mode-awareness` attacks **plans** (before); `adversarial-verify` attacks **finished work** (after).
- `scope-fence` decides **what** to change; `change-control` governs **how** to change it.
- `memory-hygiene` decides **when** memory is suspect; `live-state-truth` **goes and looks**.
- `structured-reasoning` produces the analysis; `output-structuring` shapes its presentation.
- `live-state-truth` says **read before you edit**; `code-reconnaissance` says **what to read** and what to extract (exemplars, conventions, callers).
- `debugging-playbook` diagnoses defects in **the artifact**; `error-recovery` manages **your own failing fix process** (two-strike rule, revert vs. fix forward).
- `verification-discipline` labels claims **after collection**; `research-methodology` governs **how they're collected** (angles, independence, stopping rules).
- `structured-reasoning` **converges** on an option set; `divergent-ideation` **builds** the option set first.
- `intent-clarity` decodes **this conversation's** user; `product-thinking` decodes **the product's** users.

## Recommended core seven for Opus 4.8

**Install the always-on layer first:** paste the block from `CLAUDE-MD-SNIPPET.md` into your project's `CLAUDE.md`. Skills trigger per-task; the standing constraints (verify before claiming, scope discipline, change hygiene) need to be permanently in context to bite reliably.

Then, if adopting skills incrementally, these seven eliminate the most common quality failures per unit of overhead:

1. **`live-state-truth`** — kills phantom success ("should work now") and stale-read edits; the single highest-value habit for coding work.
2. **`intent-clarity`** — prevents building the wrong thing efficiently; governs when (not) to ask questions.
3. **`plan-gate`** — stops rushed starts on complex work while explicitly exempting trivial tasks.
4. **`adversarial-verify`** — the pre-delivery attack pass; converts "confident" into "checked".
5. **`scope-fence`** — keeps diffs reviewable and trust intact; flags instead of freelancing.
6. **`error-recovery`** — the two-strike circuit breaker; stops the patch-on-patch spiral that turns a bad hour into a bad day.
7. **`code-reconnaissance`** — makes changes native to the codebase instead of foreign to it (skip if your work is non-coding; take `research-methodology` instead).

Add `frontier-workflow-mode` once these feel natural — it's the conductor, and it's only as good as the orchestra. For agentic fan-out work, `delegation-discipline` is non-optional.
