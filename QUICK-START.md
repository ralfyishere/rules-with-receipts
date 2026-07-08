# Quick Start

**1. Copy** (from this directory):
```bash
./install-pack.sh /path/to/your/project
```
That's the whole install — skills, CLAUDE.md (manual + always-on rules), starter `claude-context/`, and the publish hygiene gate (a hook that blocks push/release commands until the project's security scan passes).

**2. If installing by hand instead**, copy `.claude/skills/` into the project, and paste into the project's `CLAUDE.md`: the contents of `.claude/FUTURE-MODEL-OPERATING-MANUAL.md`, then the fenced rules block from `.claude/skills/CLAUDE-MD-SNIPPET.md`.

**3. Verify** — open a fresh session in the project and ask:

> List the skills available to you, then tell me which would apply to "fix exactly this one bug, nothing else."

Pass = the pack's skills appear (plan-gate, scope-fence, live-state-truth...) and it routes to scope-fence/debugging-playbook. Then give it any small code change and check it **runs the verification and quotes the output** without being asked — that's the always-on layer working.

**4. First week:** fill in `claude-context/business-summary.md` and `current-priorities.md` (5 minutes — this is what makes outputs land in your world), and skim `.claude/skills/SKILLS-OVERVIEW.md` for what triggers what.

What to expect, honestly: same intelligence, better discipline — tighter scope, flagged findings, quoted evidence, plans before big work, and learning notes left behind after hard problems.
