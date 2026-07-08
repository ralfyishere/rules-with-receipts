# Changelog

Bump `VERSION` and add an entry here on any change to skills, the snippet, the manual, or the installer. Installed projects record their version in `.claude/PACK-VERSION`; re-running `install-pack.sh` upgrades them in place.

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
