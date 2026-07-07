# Maintenance Cadence

The pack compounds only if it's pruned. Small, regular passes; nothing here should take more than 20 minutes.

## Weekly
- **Review new `.claude/learnings/` notes.** For each: promote to skill (via `WORKFLOW-SKILL-INTERVIEW-PROMPT.md`), fold into an existing skill, elevate to `CLAUDE-MD-SNIPPET.md` (rare — the snippet stays ≤ ~15 rules), or keep/delete. Empty week after hard work = the extract-approach trigger isn't firing; investigate.
- **Prune context files** (`claude-context/`): re-rank `current-priorities.md`, cut stale lines from `claude-memory.md`. Bloat here taxes every session.
- **Scan `WORKFLOW-EXTRACTION-QUEUE.md`:** any workflow that recurred again this week moves up; collect its example artifacts now, while they're fresh.

## After every major project or decision
- Append to `claude-context/decision-log.md` — and fill in the **Result** field of past entries that have resolved. An outcome-free decision log is a diary, not an asset.
- Run `extract-approach` if the project met its bar (new pattern / recurring failure / changed future work).

## After any repeated failure
- Same mistake twice = update the relevant skill's failure-modes section or (if it's an always-on rule) the snippet — don't just write a second identical learning note. Note the change in the skill's Provenance section.

## Monthly
- **Run the eval suite** (`eval-results-v2/run-eval-v2.sh`, or a subset) and compare against prior `SCORES.md`. Check quota headroom first and grep outputs for limit stubs before grading (see learnings/2026-07-07-eval-outputs-can-be-quota-stubs.md).
- **Skill audit:** any skill that hasn't visibly fired in a month is a candidate — tighten its `description` (if it should have fired) or merge/delete it (if it shouldn't exist). Update `SKILLS-OVERVIEW.md` and `TASK-ROUTING-GUIDE.md` after any change.
- **Coherence check:** run `scripts/check-pack.sh` (validates frontmatter, refs, snippet size, version sync) — must exit clean. Also eyeball: CLAUDE.md still lean (pointers, not content).
- **Operator guide check:** any correction you gave twice this month that `OPERATOR-GUIDE.md` doesn't cover gets a new row.

## Ownership
This cadence is the user's; sessions assist but don't self-schedule it. If a session notices a cadence item is overdue (stale priorities file, unpromoted recurring learnings), it should flag that in one line — not silently perform maintenance uninvited.
