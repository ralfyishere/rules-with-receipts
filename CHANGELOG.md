# Changelog

## 1.1.0-public — 2026-07-07
Initial public release: sanitized pack + both eval generations with raw outputs. Fresh history (development repo is private).

Bump `VERSION` and add an entry here on any change to skills, the snippet, the manual, or the installer. Installed projects record their version in `.claude/PACK-VERSION`; re-running `install-pack.sh` upgrades them in place.

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
