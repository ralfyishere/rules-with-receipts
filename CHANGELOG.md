# Changelog

Bump `VERSION` and add an entry here on any change to skills, the snippet, the manual, or the installer. Installed projects record their version in `.claude/PACK-VERSION`; re-running `install-pack.sh` upgrades them in place.

## 1.8.1 — 2026-07-10

Installer hardening (from the 2026-07-09 cross-repo audit; `ship-surface-hardening`).
- **`install-pack.sh` no longer produces a silent broken install when python3 is absent.** It uses python3 to write the CLAUDE.md snippet and the settings hook; on a machine without python3 it previously printed "command not found", wrote NO CLAUDE.md and no hook, yet stamped `PACK-VERSION` and exited 0 — an install that looked clean but was missing the eval-tested condition-E core. Added a python3 preflight that fails closed before writing anything (exit 1, clear message). Verified: no-python3 → exit 1 + nothing written; happy path → `release-test.sh` PASS.

## 1.8.0 — 2026-07-09

An integrity pass driven by a full skill-by-skill review and a cross-repo audit of what the pack itself shipped (6-agent skill review + 5 sibling-repo auditors; every load-bearing finding re-verified against the files). Three new skills, description trims (A/B-validated), and fixes.

- **New skill `correction-propagation` (33rd):** when a published claim is corrected, sweep every surface that restates it — sibling docs, other repos, mirrors, indexes, memory — and banner each in the same closeout. Earned by finding the disproven t04 "3/3" claim corrected in rules-with-receipts but still live in agent-failure-modes (AFM-3) and in this repo's own AB-SNIPPET title.
- **New skill `security-pattern-review` (34th):** evasion-test any guard/allowlist/detector before shipping. Earned by two live-confirmed scanner bypasses shared across agent-zero-trust and rulebench (markdown-table/pipe suppression; unanchored `docs.` allowlist) plus a CI self-screen that never ran (`rb_vet.py` had no `__main__` guard).
- **New skill `disclosure-is-not-a-fix` (35th):** ship the cheapest mitigation or a dated decision-not-to, never a caveat standing in for the fix. Earned by a public eval tool shipping a grading criterion its own study proved ungradeable.
- **Descriptions trimmed to the token budget, activation A/B'd (0 loss):** publish-hygiene 877→599, divergent-ideation 776→596, leverage-first 727→583, empirical-validation 696→588, session-orientation 604→587 (~727 chars/session saved). Live A/B (fresh `claude -p`, current vs trimmed): trimmed cells activated 8/8, 0 regressions; offline `audit-triggers.py` stays 0 gaps.
- **Skill amendments:** `adversarial-verify` now names "attack your own guard, not just your conclusions" (→ `security-pattern-review`) and the correction sweep (→ `correction-propagation`); `empirical-validation` gains CI-on-the-independent-unit, name-the-selection-space, and archive-ephemeral-evidence clauses.
- **Fixes:** SKILLS-OVERVIEW breakdown summed to 29 not 32 (expansion pass is 10 — corrected); HOW-TO-USE "ten load-bearing rules" → 14; "one per skill it names" clarified (`skill-routing` is a meta-reflex, not a skill dir); empirical-validation sanitization completed (generic trading residuals → domain-neutral); divergent-ideation body now covers the proactive/turnaround trigger its 1.7.0 description already shipped; `security-scan.sh` + starter made fail-closed (git grep rc≥2 = finding, not silent-clean); v1 eval README superseded-bannered + v2 gains the guarded-runner pointer; TASK-ROUTING boundary rows added; adversarial-verify anecdote genericized. Dogfooded `correction-propagation` on our own eval docs (AB-SNIPPET/HARD-FAILURE/ANALYSIS t04 correction banners).
- **Cross-repo audit findings FILED (not fixed here — each a separate boundary):** azt+rulebench scanner bypass, AFM stale-claim + evidence-grade rigor, sofia doc-supersession + pseudo-replication CIs, rwr installer silent-partial-on-missing-python3. Full detail: `CROSS-REPO-AUDIT-2026-07-09.md`.
- **Validation status:** offline gates green (`check-pack` 35 skills; `audit-triggers` 0 gaps). Regression pair reps 13–14 complete, 0 stubs, on the fix tree; **r15 completion + new-skill trigger-eval hit the quota wall (resumable) and are PENDING — required before the public mirror.**

## 1.7.0 — 2026-07-08

Skills extracted from two sessions of hard use — added by judgment, not reflex (most learnings became updates or notes, not new skills).
- **New skill `leverage-first`** (32nd): before committing effort to execute, spend a cheap pass to find the higher-leverage path — existing solution/data/tool, a 10× method, or a composition — instead of grinding a single track. Extracted from a collaborator's repeated redirections (the meta-practice of mining those is itself captured: `.claude/learnings/2026-07-09-mine-the-collaborators-redirections.md`). Shipped as a SKILL, deliberately NOT an always-on rule (snippet stays lean/proven).
- **New skill `empirical-validation`** (31st): test a load-bearing efficacy claim with the cheapest experiment that could falsify it — real data, confidence intervals, isolate-the-variable — instead of reasoning about whether it works. Earned by two decisive wins in one session: a load-bearing efficacy claim falsified for $0 on real public data, and a snippet change shown by controlled A/B to have eroded the pack's proven t04 win. Distinct from `verification-discipline` (labels claims) and `adversarial-verify` (attacks work by reasoning) — this one GOES AND MEASURES.
- **`divergent-ideation` trigger sharpened:** fire PROACTIVELY on open/improve/turnaround mandates and generate unplanted angles, instead of waiting to be handed the creative direction (learned from a user correction: "you should have been thinking outside the box, outside what I planted").
- **Maintainer rule added (CLAUDE.md):** changing a proven component (snippet, exemplar, anything with measured effect) requires a controlled A/B, not just a count check — attention budget is scarce; `ab-snippet-t04.sh` is the template.
- **Regression done + an honesty correction (2026-07-08):** ran t02,t04 at n=3 (r10–r12) via the guard. t02 clean, t04 scope discipline held 15/15. BUT E/t04's adjacent-flag rate came back 0/3 — and across r7–r12 + the A/B it swings 3/3→0/3→4/6→0/3. **The t04 "replicated win" does NOT reliably reproduce; it is high-variance.** Two recent causal calls were over-stated on small-n (the r7–r9 "regression" and the A/B "the rule diluted / dropping it restored the win") — corrected. Public claims (README, SCORES/ANALYSIS/HARD-FAILURE) downgraded from "replicated win" to "scope discipline is the stable effect; the flag bonus is noisy." The snippet decision (stay at 14 rules, session-orientation as a skill) still stands — it keeps the snippet lean regardless. Full record: `eval-results-v2/REGRESSION-20260708-r10r12.md`.

## 1.6.0 — 2026-07-08

The continuity layer: sessions compound instead of restarting. Built after a real failure — a new session asked to "check the work with agent zero trust" had to rediscover what the project was, that its only local clone lived in a dead session's /tmp scratchpad, and which of GitHub/PyPI/CI was current, despite extensive memory files. State lived in narrative memory; nothing owned orientation.

- **New skill `session-orientation`** (30th, ships publicly): registry-first orientation, canonical-path-or-explain, scratchpad-vs-source-of-truth rules, "updated/done is a compound claim" (fetch+status / CI / tag / package registry — name which parts ran), and the closeout duty (promote scratchpad work to durable paths, update the registry) — the write-side that makes the read-side possible.
- **session-orientation ships as a SKILL only — NOT an always-on rule.** It was briefly added as a 15th snippet rule, but a controlled A/B (`eval-results-v2/AB-SNIPPET-20260708.md`, n=6/arm, Opus 4.8, one-rule difference) showed the extra rule DILUTED the snippet's one replicated behavioral win (condition E flagging the adjacent bug on t04: 14-rule snippet flagged ~9/12, 15-rule ~1/9). The skill activates reliably without the rule (trigger-eval t08/t09 6/6), so the rule was cost without benefit. Snippet stays at its proven 14 rules. Lesson: adding to the most-proven component must be A/B'd, not assumed — [[2026-07-08-adding-to-the-proven-snippet-needs-an-ab]].
- **Private continuity files (never mirrored, documented in PACK-MANIFEST + mirror-public.sh header):** `ACTIVE-PROJECTS.md` — machine-specific registry (canonical local paths, GitHub/PyPI URLs, current versions, launch status, pending, pitfalls, per-project verify commands and closeout rules, per-entry dates); `SESSION-START.md` — the exact orientation sequence plus "Known ways this system fails" (11 observed failure modes, each with its fix).
- **Tripwires:** `closeout-check.sh` now fails if `ACTIVE-PROJECTS.md` is missing or its fable-skills entry disagrees with `VERSION` (mechanically forces registry updates); `check-pack.sh` validates `-orientation` skill refs.
- **State fix:** agent-zero-trust cloned to its durable canonical path `~/Desktop/agent-zero-trust` (was only in an ephemeral session scratchpad).
- Indexes updated (SKILLS-OVERVIEW, TASK-ROUTING-GUIDE ambient rows, PACK-MANIFEST, README counts 30 skills / 15 rules).
- **`scripts/registry-check.sh`** (dev tooling, never shipped): mechanical registry-vs-reality drift check — every `ACTIVE-PROJECTS.md` entry vs live GitHub releases, PyPI, and local clone state (clean/ahead/behind after a real fetch), plus entry-date staleness. First run immediately found two sibling clones 16 and 7 commits behind origin (fast-forwarded) — the tool paid for itself before it was committed.
- **Trigger-eval cases t08/t09** for session-orientation: the rediscovery failure verbatim ("check all the work with the scanner project…") and cold resumption ("where did we leave off…") — results recorded under `trigger-eval/results/` per protocol.
- **Machine-wide routing:** `~/.claude/CLAUDE.md` created with a 4-line registry pointer, so sessions launched OUTSIDE this directory (sibling repos, anywhere) still orient from the registry.
- **Regression pair for 1.6.0:** reps r7–r9 (`REP_START=7`, immutable-evidence form) — results recorded in `eval-results-v2/` when graded; required before this version is mirrored/released publicly.
- **Post-review fixes (2026-07-08, same unreleased version — five-reviewer audit in `SYSTEM-REVIEW-2026-07.md`):** business-context sanitization — the mirror now ships `WORKFLOW-EXTRACTION-QUEUE.seed.md` as the public queue (filled-in working copy never leaves the dev repo), CONTEXT-SYSTEM-SETUP example genericized, mirror sanitize-check greps for the company name (public copies fixed in the same pass). `session-orientation` trimmed 124→~95 lines + tighter description. Standing-constraints-vs-always-on-rules terminology reconciled in SKILLS-OVERVIEW. plan-gate example criteria made observable. OPUS-IMPROVEMENT-EVALS points at the v2 harness (v1 marked superseded, stub rule inlined). Gate robustness: hygiene-gate fails closed for risky commands when python3 is missing (raw-stdin fallback), marker age unknowable → stale; pre-push fresh() requires python3; security-scan treats unreadable history as a finding, never silent-clean; gate scope (Bash tool + pre-push only; branch protection as non-git backstop) documented in the gate header.

## 1.5.3 — 2026-07-08

The regression debt is paid, and the intake layer joins the stack.
- **Full n=3 behavior regression complete** (reps 4–6 alongside immutable r1–r3; 30/30 valid, zero stubs): **no regression** from the v1.4–v1.5 changes. E (full install) is again the only t04 PASS median — third independent run showing the separation's direction (reps PARTIAL/PASS/PASS; "3/3 every run" remains unreplicable, disclosed as ever). C produced the run's only real scope violation again (config.json rewrite). t02 has saturated (all conditions PASS) — t04 is now the discriminating half of the regression pair. Full record: `eval-results-v2/REGRESSION-20260708-r4r6.md`; grader-bug note included (bullets-as-diff-lines nearly graded E as F/F/F — hand-verification of flagged cells is not optional).
- **agent-zero-trust cross-references:** publish-hygiene's ingestion procedure, BOOTSTRAP-NEW-MACHINE, and SECURITY.md now point at `azt scan` (whole-repo instruction-environment screening, PyPI: agent-zero-trust) alongside `rulebench vet` (single rules files).

## 1.5.2 — 2026-07-08

Linux portability fix, found by the new CI on its first real run:
- GNU `stat -f` does not fail — it reports filesystem info — so the BSD-first `stat -f || stat -c` fallback silently produced garbage mtimes on Linux, erroring the hygiene gate exactly when a marker existed (3/20 gate tests failed on ubuntu). All mtime reads (gate, native pre-push hook, gate tests) now go through python3 `os.path.getmtime` — portable and timezone-free. Verified: CI green on ubuntu-latest; 20/20 locally on macOS.
- Public-surface polish shipped alongside (no pack-behavior changes): landing-page README with badges, shared SECURITY.md, CI workflows on both product repos, AFM readability pass, contributor labels/issues/templates.
- v1.5.1 release artifacts predate the fix and carry the Linux-broken gate; v1.5.2 supersedes them.

## 1.5.1 — 2026-07-08

Release governance: the pack is released like a product, and the release process enforces itself.
- **`RELEASE-CHECKLIST.md`** (shipped): 13 items, each AUTO (enforced by the bundle script, which refuses to bundle on failure) or MANUAL (attested in release notes). Failure protocol: fix, re-run from the top.
- **`scripts/release-test.sh`** (shipped): cold-start behavioral test — installs from a given pack source into a fresh temp git repo and verifies with captured exit codes: skills/rules parity with the shipped source (no hardcoded counts), both hooks wired, gate blocks → scan opens → gate passes, 20/20 gate tests, both verifications in installed mode, upgrade preserving context/config/custom skills/CLAUDE.md notes, machine-string grep of the installed tree.
- **`make-release-bundle.sh`** now runs the full AUTO set in order (check-pack, gate tests, closeout source+clone, raw-URL bootstrap byte-compare, fresh security scan, release-test, identity grep, version-match) and refuses to rebuild an existing version bundle (that IS the VERSION-bump check); prints the three MANUAL items it cannot attest.
- `dist/` gitignored; maintainer rule added to CLAUDE.md.

## 1.5.0 — 2026-07-08

Productization: the pack is now a portable operating system, installable and upgradable anywhere from the public source of truth (rules-with-receipts), with a cold-start replication test as the release bar.
- **Config layer:** `.quality-pack/config.env` per project (owner, allowed git identities, gate enforcement/TTL, extra scan patterns, mirror settings) — created once, never overwritten; gate + scan read it.
- **Dual-mode verification:** `check-pack.sh` and `closeout-check.sh` now detect pack-source vs installed-project mode; installed mode verifies skills integrity, managed-block versions vs PACK-VERSION, snippet parity, hook wiring, script presence.
- **Installer:** `--upgrade` flag with from→to change report; ships closeout/check-pack; per-skill sync preserves project-added skills; creates config.env; wires `.githooks/pre-push` (`core.hooksPath`) when the target is a git repo; gitignores the gate marker; runs verification at the end; count-free output.
- **Bootstrap:** `bootstrap.sh` (curl-able, with the read-before-you-run caveat in its own header) + `BOOTSTRAP-NEW-MACHINE.md` (zero-to-verified on a fresh computer).
- **Release bundling:** `scripts/make-release-bundle.sh` — cut from a fresh public clone only, triple-gated (closeout vs clone, security scan, identity grep), sha256-stamped.
- **Portability audit fixes:** exemplars carried real machine paths in diff headers (sanitized; installs from the dev tree would have leaked them — public copies were already clean); gate-test fixture and human-handoff example genericized; MAINTENANCE-CADENCE items scoped source-only vs installed; INSTALL header count-free; closeout regex widened to catch "N word skills" forms.
- **PACK-MANIFEST rewritten** with owner/upgrade/public columns per component, and promoted to a shared (mirror-synced) file so it cannot fork again.

## 1.4.1 — 2026-07-08

The remaining meta-bug, encoded: "local verification mistaken for global completion" (validated my changes, never swept what they made stale — caught by the user twice).
- **`scripts/closeout-check.sh`:** repo-wide consistency sweep — live-state ground truth (skill count, snippet rule count, VERSION) vs every doc that repeats it; CHANGELOG-top-vs-VERSION; installer expectation line; manifest completeness; and with a public-clone path: shared-file drift, intentional-divergence allowlist, personal-scan-never-public check. Wired into `.githooks/pre-push` — inconsistent docs block the push.
- **CLAUDE.md maintainer rule:** completion claims are forbidden without the closeout sweep + a manual behavior-claims review; unchecked things must be named as unchecked.
- **`adversarial-verify`** gains the failure mode by name.
- Found by the first sweep, fixed: dev PACK-MANIFEST missing all six new component rows + "12 rules"; public AGENTS "12 rules"; INSTALL.md had diverged (public-only step 4 backported; INSTALL/QUICK-START/eval-README now mirror-synced); **README/AGENTS "run the evals yourself" command was broken by the 1.4.0 overwrite guard** — replicators now get the `REP_START=4 … 6` form; eval README documents re-run semantics; QUICK-START mentions the gate.

## 1.4.0 — 2026-07-07

Skill activation treated as a system design bug (a publish-hygiene miss required a user reminder before a real leak sweep; the sweep then found a live identity leak). Activation now has three layers instead of one:
- **Deterministic layer (new):** `scripts/hygiene-gate.sh` PreToolUse hook wired via `.claude/settings.json` — blocks push / release / package-publish / visibility-change Bash commands unless `scripts/security-scan.sh` passed within 60 min (clean scan writes `.claude/.hygiene-gate-pass`). 20/20 unit tests in `scripts/test-hygiene-gate.sh` (incl. false-positive regressions found by using the gate in anger on day one). Known property: matches command *text*, so risky strings inside heredocs/docs also block — over-blocking is the chosen failure direction; the block message names the way through.
- **Always-on layer:** two new snippet + CLAUDE.md rules — `skill-routing` (match oblique prompts to the skills list before acting, name what you loaded) and the `publish-hygiene` gate rule (no public-boundary action without the gate; no "done/safe/published" without shown evidence). Snippet now 14 rules.
- **Trigger layer:** `scripts/audit-triggers.py` audits all 29 descriptions against realistic messy prompts (found 6 gaps; now 0). `publish-hygiene` description rewritten with user-voice triggers ("push it", "make sure nothing leaked", "review my GitHub", "cut a release", identity/path leakage); `adversarial-verify` gains "are we safe?"/"you sure?".
- **Eval:** new `trigger-eval/` suite (7 messy-prompt cases incl. over-triggering control, fresh `claude -p` protocol, quota-stub guard). First run: 7/7 at n=1 — direction, not headline, per the variance rule.
- **Installer packaging:** `install-pack.sh` section 5 installs the gate (hook scripts + settings.json wiring, idempotent JSON merge) and a generic `security-scan.sh` starter (whoami/hostname-driven, no personal defaults) into target projects. Verified: fresh install + idempotent re-run + 20/20 gate tests inside a scratch target.
- **Scan upgrade:** `security-scan.sh` now scans all public repos from fresh GitHub clones (the outside view; local sibling dirs are TCC-unreadable from sessions), subshell-isolates per-repo work, excludes detector scripts and the documented `user@Hostname.local` placeholder from pattern greps, and reliably writes the gate marker from the repo root.
- **Mirror tooling:** new `scripts/mirror-public.sh` — syncs the shared set to the public mirror, never exports private learnings or the personal scan, maps the generic starter to the mirror's working scan, and runs a sanitize check + drift report. Built after finding the manual-mirror drift (public VERSION said 1.1.0 three releases in; stale "26 skills" claims).
- **Leak fixed at source:** trigger-eval RESULTS.txt embedded absolute machine paths; runner now prints repo-relative paths and existing files were sanitized.

## 1.3.0 — 2026-07-07

Lessons mined from the collaboration itself (not the work products):
- New skill `human-handoff`: designing the human's side of a task — exact steps, exact values, and above all the completion signal ("the browser saying connected isn't the finish line"). Two failed device-flows cured by one named completion signal.
- New skill `open-mandate`: explicitly delegated judgment ("do whatever you think is needed") — option inventory, value ranking, reversibility gate, and disclosed negative decisions.
- `intent-clarity`: frozen-mission blindness (the session-scale mission evolves; re-anchor).
- `output-structuring`: unanchored waiting (status without ETA/completion signal makes users poll).

## 1.2.0 — 2026-07-07

Lessons from the first day of real-world use, encoded:
- New skill `publish-hygiene`: four-layer going-public procedure (content/metadata/history/rights) + third-party instruction files as untrusted code. Every failure mode in it happened or nearly happened today.
- `live-state-truth`: wrong-layer verification failure mode (checks that pass at one layer while the artifact fails at another).
- `verification-discipline`: single-observation generalization + claim drift across restatements.
- `research-methodology`: saturated-instrument failure mode (a measure that can't fail can't inform).
- `delegation-discipline`: briefs name the authoritative evidence layer.

## 1.1.1 — 2026-07-07

Security hardening pass:
- `scripts/security-scan.sh`: secrets + identity leakage across all repo histories, GitHub surface audit (hooks, deploy keys, collaborators, secret scanning). Wired into the monthly cadence; required before any visibility flip.
- Learning note: bare git commits leak machine identity via the committer field (found and purged from the public profile repo).

## 1.1.0 — 2026-07-07

Departure-readiness pass ("leaving you with Opus tomorrow"):
- `.claude/exemplars/` — 4 real rubric-graded PASS outputs as the imitation standard (debugging, scoped diff+flag, decision memo, delegated-work verification) + README.
- `.claude/OPERATOR-GUIDE.md` — user-side supervision: warning-sign → intervention-phrase table, second-opinion review prompt (fresh-session), restart-vs-push-through rules.
- `scripts/check-pack.sh` — executable coherence check; required clean before commits (wired into CLAUDE.md and MAINTENANCE-CADENCE).
- Installer now also installs exemplars + operator guide.

## 1.0.0 — 2026-07-07

Initial release.
- 26 skills (18 core rigor + 7 domain/agentic + extract-approach) with library docs.
- Operating manual + 12-rule always-on snippet (eval condition E — the tested install).
- Compounding layer: learnings system, context-system guide, goal templates (`/goal` verified absent, `/loop` present), workflow extraction queue, maintenance cadence, skill-interview prompt.
- Installer with timestamped backups, versioned replaceable CLAUDE.md blocks, starter `claude-context/`.
- Evidence: v1 (10 single-turn tests × 4 conditions) and v2 (12 multi-step tests × 5 conditions × 3 reps) eval suites with raw outputs. Key replicated finding: snippet → 3/3 scope+flag pass on v2 t04.

## Public-mirror note (historical)

The public mirror (rules-with-receipts) launched 2026-07-07 as "1.1.0-public": sanitized pack + both eval generations with raw outputs, published as a FRESH history because the development repo (private) contains business specifics. Public-mirror syncs now use `scripts/mirror-public.sh` and share this changelog.
