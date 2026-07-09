# Pack Manifest

Every shipped component: what it is, who owns it after install, what upgrades do to it, and whether it is public. **Owner:** `pack` = replaced by upgrades (never hand-edit); `project` = created once, never overwritten; `mixed` = pack updates only its fenced managed blocks. **Public:** whether the file exists in the public mirror ([rules-with-receipts](https://github.com/ralfyishere/rules-with-receipts)) — the canonical install source. Source-only files live in the private dev repo and never ship.

## Installed into target projects

| Path (in target) | Purpose | Owner | On upgrade | Public |
|---|---|---|---|---|
| `.claude/skills/` (all skill folders + library docs) | The skills + catalog, routing guide, snippet source, checklist | pack | replaced; **project-added skill folders preserved** | yes |
| `CLAUDE.md` | Project rules file | mixed | only `quality-pack:manual` / `quality-pack:snippet` fenced blocks replaced; everything else untouched | n/a |
| `.claude/settings.json` | PreToolUse hygiene-gate hook | mixed | additive JSON merge; existing hooks kept | yes |
| `.githooks/pre-push` (+ `core.hooksPath` config) | Native push gate for non-Claude terminals | pack | replaced (backup first) | yes |
| `scripts/hygiene-gate.sh`, `scripts/test-hygiene-gate.sh` | Deterministic publish gate + its unit tests | pack | replaced (backup first) | yes |
| `scripts/check-pack.sh`, `scripts/closeout-check.sh` | Verification pair; dual-mode (source vs installed) | pack | replaced (backup first) | yes |
| `scripts/security-scan.sh` | Project's scan (starter copy on first install) | project | kept; fresh starter dropped alongside as `security-scan-starter.sh` | starter: yes |
| `.quality-pack/config.env` | Project-local settings (owner, identities, patterns, mirror, enforcement) | project | never touched | template: yes |
| `.claude/FUTURE-MODEL-OPERATING-MANUAL.md` | Source of the CLAUDE.md manual block | pack | replaced | yes |
| `.claude/OPERATOR-GUIDE.md`, `.claude/MAINTENANCE-CADENCE.md`, `.claude/CONTEXT-SYSTEM-SETUP.md`, `.claude/GOAL-TEMPLATES.md`, `.claude/OPUS-IMPROVEMENT-EVALS.md`, `.claude/WORKFLOW-SKILL-INTERVIEW-PROMPT.md` | Operating docs (human side, upkeep, context system, goal patterns, v1 eval spec, skill interview) | pack | kept if present (edit freely; delete to receive fresh copy) | yes |
| `.claude/WORKFLOW-EXTRACTION-QUEUE.md` | Recurring-workflow promotion queue | project | kept | seed only — mirror ships `WORKFLOW-EXTRACTION-QUEUE.seed.md` as this file; the filled-in working copy never leaves the dev repo |
| `.claude/exemplars/` | Rubric-graded PASS outputs — the imitation standard | pack | kept if present | yes |
| `.claude/learnings/README.md`, `_template.md` | Learning-note system | pack | kept if present | yes |
| `.claude/learnings/<your notes>` | The project's own learnings | project | never touched | no |
| `claude-context/` (7 starter files) | Business/user context — the project's world | project | never touched once created | starters: yes |
| `.claude/PACK-VERSION` | Installed version stamp | pack | rewritten each run | n/a |

## Pack source repo only (public mirror = canonical, private dev = full history)

| Path | Purpose | Public |
|---|---|---|
| `install-pack.sh`, `bootstrap.sh` | Installer (`--upgrade` flag; change report; post-install verification) and curl-able fetch+install wrapper | yes |
| `README.md`, `INSTALL.md`, `QUICK-START.md`, `BOOTSTRAP-NEW-MACHINE.md`, `AGENTS.md`, `CONTRIBUTING.md`, `LICENSE` | Front door, install paths, new-machine setup, agent-facing summary | yes (README/AGENTS/CONTRIBUTING/LICENSE are mirror-specific) |
| `VERSION`, `CHANGELOG.md`, `PACK-MANIFEST.md` | Version, history, this file | yes |
| `scripts/audit-triggers.py` | Description-vs-messy-prompt activation audit | yes |
| `scripts/security-scan-starter.sh` | The generic scan shipped to installs | yes |
| `RELEASE-CHECKLIST.md` | Release governance: 13 items, AUTO-enforced vs MANUAL-attested | yes |
| `SECURITY.md` | Rules-files-are-untrusted-code policy, reporting channel, deliberate gate properties | yes |
| `scripts/release-test.sh` | Cold-start behavioral test of an install from a given pack source (checklist 4/9/10/11) | yes |
| `trigger-eval/` | Skill-activation eval suite + published results | yes |
| `eval-results/`, `eval-results-v2/` | The receipts: harnesses, fixtures, rubrics, raw outputs, scores (immutable once graded) | yes |
| `scripts/security-scan.sh` | Maintainer's personal scan (private repo list, clone-based public sweep) | **no — never shipped** |
| `scripts/mirror-public.sh`, `scripts/make-release-bundle.sh` | Mirror sync + release bundling — the bundle script enforces every AUTO item in RELEASE-CHECKLIST.md before cutting from a fresh public clone | no (dev tooling) |
| `.claude/learnings/` (dev notes), `study-draft/`, `.claude/settings.local.json` | Private working assets | **no** |
| `ACTIVE-PROJECTS.md`, `SESSION-START.md` | Continuity layer: machine-specific project registry + orientation procedure (the generic procedure ships as the `session-orientation` skill) | **no — never shipped** |
| `scripts/registry-check.sh` | Registry drift check: every registry entry vs live GitHub/PyPI/clone state | no (dev tooling) |

## Skills shipped (one folder per slug under `.claude/skills/`)

| Group | Skills |
|---|---|
| Reasoning & planning | `intent-clarity`, `effort-calibration`, `plan-gate`, `deep-decomposition`, `leverage-first` |
| Verification & rigor | `live-state-truth`, `verification-discipline`, `adversarial-verify`, `empirical-validation`, `failure-mode-awareness`, `proactive-rigor` |
| Debugging & execution | `debugging-playbook`, `change-control`, `scope-fence` |
| Output quality | `ruthless-editor`, `structured-reasoning`, `output-structuring` |
| Memory & continuity | `memory-hygiene`, `self-improvement-loop`, `extract-approach`, `session-orientation` |
| Domain & agentic | `code-reconnaissance`, `error-recovery`, `delegation-discipline`, `research-methodology`, `prompt-engineering`, `divergent-ideation`, `product-thinking`, `human-handoff`, `open-mandate` |
| Boundaries & delegation of judgment | `publish-hygiene` |
| Meta | `frontier-workflow-mode` |

Library docs alongside them: `SKILLS-OVERVIEW.md`, `TASK-ROUTING-GUIDE.md`, `HOW-TO-USE-WITH-OPUS.md`, `QUALITY-CHECKLIST.md`, `CLAUDE-MD-SNIPPET.md` (the always-on rules; count and content verified by `scripts/check-pack.sh`, which prints both).

**Sharing caution:** `claude-context/` and filled-in `WORKFLOW-EXTRACTION-QUEUE.md` contain your business specifics; project learnings are private by default. The release bundle is cut from the public mirror, so none of these can ship by construction.

Regression pair for pack changes: v2 tests t02 + t04 (see `eval-results-v2/README.md` for the immutable-evidence re-run form).
