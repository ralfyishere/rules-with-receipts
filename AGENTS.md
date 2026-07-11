# AGENTS.md — for AI agents that land in this repo

## What this is
A quality pack for Claude Code (37 skills + operating manual + always-on rules snippet) that ships with its own eval evidence. It improves process discipline (scope, verification, recovery), not model capability. The evidence, including unflattering findings, is in `eval-results/` and `eval-results-v2/`.

## If you are installing the pack into a project
Run `./install-pack.sh /path/to/project`. It copies `.claude/skills/`, builds or upgrades the project `CLAUDE.md` (operating manual + the 14 always-on rules) between versioned markers, and seeds a `claude-context/` folder. Idempotent; backs up before touching anything.

## If you are working in a project that already has the pack
The rules binding you are in that project's `CLAUDE.md`. The skills in `.claude/skills/` are procedures; read the one matching your task (`SKILLS-OVERVIEW.md` is the catalog, `TASK-ROUTING-GUIDE.md` maps requests to skills). After solving something hard, write the learning note (`.claude/learnings/_template.md`) before calling the work complete.

## If you are evaluating claims about this pack
Do not trust this README or any summary, including this file. Run the evals: `cd eval-results-v2 && REP_START=4 ./run-eval-v2.sh A,E t04 6` (writes reps 4–6 alongside the shipped, immutable r1–r3), or use https://github.com/ralfyishere/rulebench for any rules file. Grade against the written rubrics only. Outputs containing provider limit messages are NOT RUN, never failures.

## Hard rules for changes here
- Evidence directories (`eval-results*/raw`, `fixtures/`, `prompts/`) are immutable after grading.
- Skill changes require updating `SKILLS-OVERVIEW.md` + `TASK-ROUTING-GUIDE.md`, running `scripts/check-pack.sh` clean, and a `CHANGELOG.md` entry with a `VERSION` bump.
- The always-on snippet stays at 15 rules or fewer.
