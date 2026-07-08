# Pack Manifest

Every file in the pack and its purpose. ✦ = installed into target projects by `install-pack.sh`; unmarked files are development/evidence assets that stay in this source directory.

## Root

| File | Purpose |
|---|---|
| `README.md` | Front door: what the pack is, layout, evidence summary |
| `INSTALL.md` | Full installation instructions (scripted, manual, global, update, uninstall) |
| `QUICK-START.md` | Shortest path: copy, paste, verify |
| `install-pack.sh` | Tested installer: copies skills + layer, versioned CLAUDE.md blocks (upgrade-in-place), backups, seeds claude-context/ |
| `VERSION`, `CHANGELOG.md` | Pack version + change history; bump on any skill/snippet/manual/installer change |
| `scripts/check-pack.sh` | Executable coherence check (frontmatter, refs, snippet size, version sync) — run after any pack edit |
| `scripts/hygiene-gate.sh` + `.claude/settings.json` | Deterministic publish gate: PreToolUse hook blocks public-boundary commands without a fresh security-scan pass (unit tests: `scripts/test-hygiene-gate.sh`) |
| `scripts/security-scan.sh` (from `security-scan-starter.sh`) | Pre-push scan: secrets + machine identity across full history; a clean pass opens the gate |
| `scripts/audit-triggers.py` | Activation audit: skill descriptions vs realistic messy prompts — 0 gaps required |
| `scripts/closeout-check.sh` | Final-closeout sweep: every doc that repeats a count/version/component must agree with live state — run before any completion claim |
| `trigger-eval/` | Skill-activation eval: messy prompts through fresh sessions, expected-skill grading, quota-stub guard |
| `CLAUDE.md` | Maintainer rules for THIS source repo (evidence immutability, index sync, regression pair) + always-on rules |
| `PACK-MANIFEST.md` | This file |

**Sharing caution:** `WORKFLOW-EXTRACTION-QUEUE.md` and anything under `claude-context/` contain your business specifics — review before sharing the pack outside your org.

## `.claude/` — layer files

| File | Purpose |
|---|---|
| ✦ `FUTURE-MODEL-OPERATING-MANUAL.md` | Condensed core habits; becomes (part of) the target's CLAUDE.md |
| ✦ `CONTEXT-SYSTEM-SETUP.md` | Guide + examples for the user's `claude-context/` world-context folder |
| ✦ `GOAL-TEMPLATES.md` | 8 bounded goal-prompt patterns (finish line, proof, caps); `/goal` verified absent, `/loop` present |
| ✦ `WORKFLOW-EXTRACTION-QUEUE.md` | Recurring workflows queued for promotion into custom skills (seeded) |
| ✦ `WORKFLOW-SKILL-INTERVIEW-PROMPT.md` | Reusable one-question-at-a-time interview that turns a workflow into a SKILL.md |
| ✦ `MAINTENANCE-CADENCE.md` | Weekly/monthly upkeep: promote learnings, prune context, re-run evals, audit skills |
| ✦ `OPUS-IMPROVEMENT-EVALS.md` | 15 single-turn trap tests + conditions + rubrics (v1 spec) |
| ✦ `OPERATOR-GUIDE.md` | The user's side: warning signs → intervention phrases, second-opinion review prompt, restart-vs-push-through |
| ✦ `exemplars/` (4 + README) | Real rubric-graded PASS outputs — the reference standard to imitate (debugging, scoped diff, decision memo, delegated-work verification) |
| ✦ `learnings/README.md`, `learnings/_template.md` | Durable-note system: what belongs, promotion rules, note format |
| `learnings/2026-07-07-*.md` (2 notes) | Real learnings from this project (subagent skill-snapshot; quota-stub grading trap) — stay here; new projects grow their own |
| `settings.local.json` | This machine's local session settings — never installed |

## `.claude/skills/` — ✦ all installed

**Library docs (4):** `SKILLS-OVERVIEW.md` (catalog, combinations, core-seven), `TASK-ROUTING-GUIDE.md` (request → skills routing), `HOW-TO-USE-WITH-OPUS.md` (install/test/invoke, limitations, compounding layer), `QUALITY-CHECKLIST.md` (pre-delivery checklist), plus `CLAUDE-MD-SNIPPET.md` (the 12 always-on rules — the pack's only *replicated* eval win).

**Skills (26):** each `<slug>/SKILL.md` with trigger description, procedure, quality bar, failure modes, example, siblings, provenance.

| Group | Skills |
|---|---|
| Reasoning & planning | `intent-clarity`, `effort-calibration`, `plan-gate`, `deep-decomposition` |
| Verification & rigor | `live-state-truth`, `verification-discipline`, `adversarial-verify`, `failure-mode-awareness`, `proactive-rigor` |
| Debugging & execution | `debugging-playbook`, `change-control`, `scope-fence` |
| Output quality | `ruthless-editor`, `structured-reasoning`, `output-structuring` |
| Memory & continuity | `memory-hygiene`, `self-improvement-loop`, `extract-approach` |
| Domain & agentic | `code-reconnaissance`, `error-recovery`, `delegation-discipline`, `research-methodology`, `prompt-engineering`, `divergent-ideation`, `product-thinking` |
| Meta | `frontier-workflow-mode` |

## Evidence (stays here; not installed)

| Dir | Purpose |
|---|---|
| `eval-results/` | v1: 10 single-turn tests × 4 conditions, prompts, harness, raw outputs, scores, analysis |
| `eval-results-v2/` | v2: 12 multi-step tests × 5 conditions × 3 reps — fixtures, harness (`run-eval-v2.sh`), raw outputs+diffs, `SCORES.md`, `ANALYSIS.md`, `HARD-FAILURE-ANALYSIS.md` |

Regression pair for future changes: v2 tests t02 + t04 at n=3 (the only discriminating tests; cheap to run).
