# Local Context System Setup

**What this is, versus the skill pack:** the skill pack improves *how* Claude works (process, verification, scope). It knows nothing about *your world*. A small `claude-context/` folder gives sessions your business, priorities, and standards — so outputs land in your reality instead of a generic one. Keep the two separate: skills are portable across any project; context is yours.

## Setup

Create a `claude-context/` folder in the project(s) where you work with Claude (or one canonical copy you point sessions at). Seven small files. Everything is plain markdown; shorter is better — these get read at session start, so every stale or bloated line taxes every session.

### `business-summary.md` — one page, changes rarely
```markdown
# AcmeCo — summary (updated 2026-07-07)
- What we do: [one sentence].
- Stage/size: [e.g., seed, 6 people, $Xk MRR].
- Products: [product]: [who it serves, one line each].
- My role: [founder/CEO — what I personally own].
- Strategic priorities this quarter: 1) ... 2) ... 3) ...
- Key constraints: [runway, team size, compliance regime, etc.]
```

### `current-priorities.md` — ranked, updated weekly
```markdown
# Priorities (updated 2026-07-07)
1. [Close X] — urgent+high impact — blocker: [what]
2. [Ship Y] — high impact — owner: [who]
3. [Investor update] — recurring, due [date]
Parked: [things explicitly NOT being worked on, so Claude doesn't resurrect them]
```

### `decision-log.md` — append-only, one block per major decision
```markdown
## 2026-07-07 — Chose Bolt over Acme for warehouse migration
- Why: Acme couldn't meet SLA terms; Bolt quote 20% lower.
- Expected: migration complete Oct 15 within $65k.
- Result (fill in later): ...
```

### `client-and-investor-context.md`
```markdown
# External relationships (updated 2026-07-07)
- [Client A]: [stage, sensitivities, tone that works, current thread].
- [Investor B]: [fund, what they care about, last update sent].
- Communication standards: investor updates monthly, metric-led, ≤1 page;
  enterprise emails: short, compliance-aware, no marketing tone.
```

### `workflow-index.md`
One line per recurring workflow, pointing at `.claude/WORKFLOW-EXTRACTION-QUEUE.md` for the promotion pipeline. List what recurs; the queue tracks what becomes a skill.

### `claude-memory.md` — durable facts, date-stamped, ruthlessly short
```markdown
# Durable facts
- 2026-07-07: Prefers recommendations first, analysis after. Never send drafts without a concrete ask.
- 2026-07-07: "Board deck" numbers must be recomputed, not trusted.
```
No journaling. If a line wouldn't matter in three months, it doesn't go in. Prune when updating.

### `claude-instructions.md` — how sessions should use this folder
```markdown
# Standing instructions
- At session start for business/strategy/writing tasks: read business-summary.md
  and current-priorities.md. Read the others only when the task touches them.
- Trust these files over your assumptions about the business; trust the user's
  live statements over these files (then suggest updating the stale file).
- When a session produces a major decision, append it to decision-log.md.
- Date-stamp updates. Never bloat: replace, don't accumulate.
```

## Wiring it up

Add one line to your project `CLAUDE.md` (keep CLAUDE.md lean — this is a pointer, not content):

```markdown
Business/user context lives in claude-context/ — see claude-context/claude-instructions.md for when to read what.
```

## Maintenance

Weekly: re-rank priorities, prune `claude-memory.md`. After major decisions: append to the log, including outcomes for past entries (the log is only valuable if results get filled in). See `.claude/MAINTENANCE-CADENCE.md`.
