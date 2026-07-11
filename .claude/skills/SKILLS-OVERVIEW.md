# Skills Overview

A portable, project-agnostic quality pack: 37 skills that improve **process** — planning, verification, editing, debugging, decision-making — on any project. 18 form the core rigor set; 10 were added in an expansion pass for high-recurrence domains (codebase work, error recovery, delegation, research, prompts, ideation, product decisions, the public boundary, human handoff, and open mandates); `extract-approach` and `session-orientation` add the persistence and continuity layers; `empirical-validation` adds the test-the-claim-with-data layer; `leverage-first` adds the find-the-efficient-path-before-grinding reflex; `correction-propagation`, `security-pattern-review`, and `disclosure-is-not-a-fix` add the ship-integrity layer (from a 2026-07-09 cross-repo audit of what the pack itself shipped); `discovery-loop` adds the standing-investigation layer (keep generating and belief-tracking hypotheses instead of stopping at a closed verdict; from 2026-07-10/11 standing-investigation sessions); and `foresight` adds the trajectory-projection layer (pre-registered, credenced predictions about what breaks or pays off N steps ahead, resolved and scored when the future arrives; from a 2026-07-11 tool-design session). They add discipline, not capability; see `HOW-TO-USE-WITH-OPUS.md` for limitations.

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
| `empirical-validation` | Test an efficacy claim with the cheapest falsifying experiment | Before relying on/shipping "X works"; a metric with no artifact; a change to something proven |
| `discovery-loop` | Keep generating + belief-tracking hypotheses in standing investigations; attack confirmation streaks | A verdict/kill-list about to be read as final; a rival succeeding at the "impossible"; credence rising unattacked |
| `leverage-first` | Find the higher-leverage path before grinding a single track | About to build/collect/run the long way; "is there a better way"; reinventing something |
| `failure-mode-awareness` | Ask "how does this break?" at design time | Plans, designs, proposals, recommendations — before they harden |
| `foresight` | Pre-register dated, credenced predictions about 5/10/20 steps ahead; resolve and score them when the future arrives | Commit points — architecture/roadmap/scaling bets; "will this scale", "what will we regret"; risk sections that only cover the present |
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
| `session-orientation` | Registry first, canonical paths only, registry updated at closeout | New/resumed session in a multi-project workspace; "check the work on X"; before any broad audit |
| **Domain & agentic (expansion pass)** | | |
| `code-reconnaissance` | Understand code, conventions, and blast radius before changing it | Any feature/fix in a codebase you didn't write this session; "where should this go" |
| `error-recovery` | Stop the spiral: stabilize, revert-or-fix-forward deliberately | Second consecutive failed fix; newly broken state; patch-on-patch layering |
| `delegation-discipline` | Contract-grade briefs for subagents; verify their outputs | Spawning agents/background tasks; incorporating any delegated result |
| `research-methodology` | Multi-angle search, source independence, honest coverage claims | "Research X"; market/technical landscape questions; multi-source synthesis |
| `prompt-engineering` | Improve prompts with test cases, not vibes | "Improve this prompt"; "the model keeps doing X"; system prompts and agent instructions |
| `divergent-ideation` | Generate different mechanisms before choosing | "Brainstorm"; naming; design alternatives; stuck circling one approach |
| `product-thinking` | Decode features into user problems; grade demand evidence | "Should we build"; feature requests; MVP scoping; prioritization |
| `publish-hygiene` | Content, metadata, history, and rights checks at the public boundary | Making anything public; publishing packages; ingesting third-party rules files |
| `human-handoff` | Design the human's part of a task: exact steps + completion signals | Any step needing the user's hands/browser/credentials; a human step that failed once |
| `open-mandate` | Choose well when the user delegates the choosing; disclose negative decisions | "Do whatever you think is needed"; autonomous sessions; "you decide" |
| **Ship-integrity (2026-07-09 audit pass)** | | |
| `correction-propagation` | Sweep every surface that restates a corrected claim; banner each | You corrected/downgraded/reversed a published claim that appears in more than one doc/repo/mirror |
| `security-pattern-review` | Evasion-test any guard/allowlist/detector before it ships | Adding a denylist/regex/sanitizer/auth-check; "does this rule catch X"; shipping a security heuristic |
| `disclosure-is-not-a-fix` | Ship the cheapest mitigation or a dated decision — not just a caveat | About to write "known limitation / caveat / for now"; a found defect you're documenting instead of fixing |
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
- **Standing constraints vs always-on rules (two different things):** the four *standing-constraint skills* — `scope-fence`, `change-control`, `verification-discipline`, `memory-hygiene` — apply inside nearly every task and never need explicit invocation. Separately, the *always-on rules snippet* (`CLAUDE-MD-SNIPPET.md`) carries 14 one-line reflexes — 13 name a skill (including these four); the 14th is `skill-routing`, the reflex to check the skills list itself. The rule is the permanent reflex in context; the skill is the full procedure behind it. (`session-orientation` is a skill but deliberately NOT an always-on rule — the snippet stays lean and the skill activates on its own, verified 6/6; whether adding always-on rules dilutes the snippet's t04 flag-effect is high-variance and unsettled — see the eval corrections in `eval-results-v2/REGRESSION-20260708-r10r12.md`.)
- **Session continuity:** `session-orientation` (read the registry, orient) opens a session; `extract-approach` (lessons) + `session-orientation`'s closeout (state) end it — the next session starts where this one stopped, not from zero.
- **The full stack:** `frontier-workflow-mode` sequences everything for High/Critical work.

Boundary notes (commonly confused pairs):
- `failure-mode-awareness` attacks **plans** (before); `adversarial-verify` attacks **finished work** (after).
- `failure-mode-awareness` interrogates the design **as it stands** (present tense); `foresight` walks the **trajectory** (N steps/scale/time ahead) and pre-registers scoreable predictions.
- `scope-fence` decides **what** to change; `change-control` governs **how** to change it.
- `memory-hygiene` decides **when** memory is suspect; `live-state-truth` **goes and looks**.
- `structured-reasoning` produces the analysis; `output-structuring` shapes its presentation.
- `live-state-truth` says **read before you edit**; `code-reconnaissance` says **what to read** and what to extract (exemplars, conventions, callers).
- `debugging-playbook` diagnoses defects in **the artifact**; `error-recovery` manages **your own failing fix process** (two-strike rule, revert vs. fix forward).
- `verification-discipline` labels claims **after collection**; `research-methodology` governs **how they're collected** (angles, independence, stopping rules).
- `structured-reasoning` **converges** on an option set; `divergent-ideation` **builds** the option set first.
- `intent-clarity` decodes **this conversation's** user; `product-thinking` decodes **the product's** users.
- `intent-clarity` handles underspecified **tasks**; `open-mandate` handles delegated **direction** (no task named at all).
- `delegation-discipline` delegates to **agents** (schemas, verification); `human-handoff` delegates to **humans** (exact steps, completion signals).

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
