# Learnings

Short, reusable notes left behind by hard sessions. Written by the `extract-approach` skill; read by future sessions before similar work. One note = one file: `YYYY-MM-DD-short-title.md`, using `_template.md`.

## What belongs here

- A decision rule discovered the hard way ("configparser values are always strings — cast before arithmetic").
- A failure mode that recurred or will recur, with its detection signal.
- An approach that worked for a problem class likely to reappear.
- Tool/environment quirks that cost real time and aren't documented elsewhere.

## What does NOT belong here

- Anything the repo already records (code, comments, git history, existing skills, CLAUDE.md).
- Session narration, task logs, or status updates — this is not a journal.
- Vague lessons ("be more careful") — if there's no mechanical decision rule, there's no note.
- Secrets, credentials, client-confidential details.

## Promotion rules

- **→ New skill** when a note's pattern has recurred, has a clear activation trigger, and needs a procedure (not just a rule). Use `.claude/WORKFLOW-SKILL-INTERVIEW-PROMPT.md` to build it; delete or stub the note after promotion.
- **→ Update an existing skill** when the note corrects or extends one — edit the skill, note the change in its Provenance section, delete the learning.
- **→ `CLAUDE-MD-SNIPPET.md`** only for rules that must be always-on (apply inside every task, cost one line). The snippet must stay ≤ ~15 rules — something usually has to come out for something to go in.
- **→ Operating manual** when a note reveals a gap in the core habits (rare) — the manual condenses skills, so usually update the skill first and let the manual follow.

## Keeping this useful

- Notes stay under ~15 lines. Compress to the decision rule + verification; link details.
- Titles say what the note is about — you find notes by scanning filenames.
- Weekly review (see `.claude/MAINTENANCE-CADENCE.md`): promote, merge, or delete. A learnings directory nobody prunes becomes a directory nobody reads.
- Deleting stale notes is maintenance, not loss.
