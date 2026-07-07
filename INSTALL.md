# Installing the Quality Pack

The pack = 26 process skills + operating manual + always-on snippet + compounding layer (learnings, context system, goal templates, workflow queue, maintenance cadence). The eval-tested configuration is **skills + manual-as-CLAUDE.md + snippet together** ("condition E" in `eval-results-v2/SCORES.md`) — install all three; skills alone measurably under-deliver on scope/flag discipline.

## Option 1 — Scripted install into one project (recommended)

```bash
cd "/path/to/rules-with-receipts"
./install-pack.sh /path/to/your/project
```

What it does (verified 2026-07-07 on fresh, repeat, and existing-CLAUDE.md targets):
- Copies `.claude/skills/` (backs up any existing skills dir first).
- Copies the layer files into `.claude/` (`FUTURE-MODEL-OPERATING-MANUAL.md`, `CONTEXT-SYSTEM-SETUP.md`, `GOAL-TEMPLATES.md`, `WORKFLOW-EXTRACTION-QUEUE.md`, `WORKFLOW-SKILL-INTERVIEW-PROMPT.md`, `MAINTENANCE-CADENCE.md`, `OPUS-IMPROVEMENT-EVALS.md`, `learnings/` README+template) — existing files are kept, never overwritten.
- Creates `CLAUDE.md` = operating manual + always-on snippet + context pointer; if one exists, it's backed up (`CLAUDE.md.bak-<timestamp>`) and the manual/snippet are appended below your content, guarded by markers so re-runs never duplicate.
- Creates a starter `claude-context/` (7 files) if missing; never touches an existing one.
- Idempotent: safe to re-run, e.g. after pack updates.

## Option 2 — Manual install into one project

```bash
cp -R "/path/to/rules-with-receipts/.claude/skills" /path/to/project/.claude/skills
```
Then build the project `CLAUDE.md`:
1. Paste the contents of `.claude/FUTURE-MODEL-OPERATING-MANUAL.md`.
2. Append the fenced rules block from `.claude/skills/CLAUDE-MD-SNIPPET.md` (the part inside the ```markdown fence).
3. Add one line: `Business/user context lives in claude-context/ — see claude-context/claude-instructions.md for when to read what.`

Keep CLAUDE.md lean beyond this: always-on rules live here; procedures live in skills.

## Option 3 — Global install (all projects)

```bash
cp -R "/path/to/rules-with-receipts/.claude/skills" ~/.claude/skills
```
Personal skills in `~/.claude/skills/` are discovered in every project. For the always-on rules everywhere, put the manual + snippet in `~/.claude/CLAUDE.md` (create it; it currently doesn't exist on this machine). Trade-off: global CLAUDE.md content loads into *every* session on this machine — if you work in projects where the pack isn't wanted, prefer per-project installs.

## claude-context/ setup

The skills improve behavior; `claude-context/` supplies your world (business, priorities, decision log, relationship context). The installer creates 7 starter files — fill in `business-summary.md` and `current-priorities.md` first; the rest can grow lazily. Full guide with examples: `.claude/CONTEXT-SYSTEM-SETUP.md`.

## Confirming skills are discovered

From inside the target project, in a **fresh** session:
```bash
claude -p "List the skills available to you, names only."
```
Expect the pack's skill names (plan-gate, scope-fence, live-state-truth, extract-approach, ...) alongside your plugins. Two verified gotchas:
- Test with a fresh session or `claude -p` — an already-open session snapshots skills at startup and won't see newly installed ones (restart it).
- Subagents inherit their parent's snapshot; they can't verify discovery.

Behavior smoke test: ask for a trivial code change and confirm the session *runs and quotes* verification output unprompted; ask "fix exactly this typo" in a messy file and confirm you get a typo-only diff plus an "Out of scope — noted" flag block. Full test protocol: `.claude/OPUS-IMPROVEMENT-EVALS.md`.

## Updating an installed project

Re-run the same command. The installer replaces the versioned pack blocks in `CLAUDE.md` in place (your own content above them is untouched), refreshes `.claude/skills/` (old copy backed up), and records the version in `.claude/PACK-VERSION`. Check what changed between versions in `CHANGELOG.md`.

## Uninstalling

Delete from the target project: `.claude/skills/`, the pack's `.claude/*.md` layer files, `.claude/PACK-VERSION`, and the two `<!-- quality-pack:...:BEGIN -->...<!-- ...:END -->` blocks from `CLAUDE.md`. Keep `claude-context/` and `.claude/learnings/` — those hold *your* content, not the pack's.

## After installing

- Skim `QUICK-START.md` (2 minutes) and `.claude/skills/SKILLS-OVERVIEW.md`.
- Put the weekly/monthly upkeep in your calendar: `.claude/MAINTENANCE-CADENCE.md`.
- Known limits (honest): the pack improves process discipline — scope, flags, verification evidence — not raw model capability; plain Opus 4.8 already handles most tasks well. Evidence: `eval-results-v2/SCORES.md` and `HARD-FAILURE-ANALYSIS.md`.
