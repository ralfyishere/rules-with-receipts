---
name: Frontier Workflow Mode
description: The high-rigor operating mode that orchestrates the full skill pack in order for complex, high-stakes, ambiguous, multi-step, strategic, technical, or quality-sensitive work. Activate when a task is important enough that a rushed answer would be a disservice - major features, migrations, hard bugs, strategy documents, consequential decisions, anything the user marks as important, production-touching, or customer-facing. Trigger phrases: "this is important", "be thorough", "production", "get this right", or any task that effort-calibration would rate High or Critical.
---

# Frontier Workflow Mode

## Purpose

One operating procedure that sequences the whole pack so that important work gets every discipline, in the right order, without re-deciding the process each time. This is not a special ability — it is the ordinary skills, run in sequence, with none skipped. Its value is exactly that: on high-stakes work, the steps you're tempted to skip are the ones that were going to catch the problem.

## When to use this skill

- Any task `effort-calibration` rates **High** or **Critical**.
- Explicit user signals: "important", "be thorough", "production", "for the board", "get this right".
- Structural signals: multi-step and ambiguous; consequences hard to reverse; output will be acted on by others; quality-sensitive deliverables (strategy, architecture, public writing).

## When NOT to use this skill

- Low/Medium-tier tasks. Running the full pipeline on a quick question is the over-effort failure `effort-calibration` exists to prevent. Most tasks should NOT be in this mode.
- When the user explicitly wants speed or a rough draft — honor that; offer the rigorous pass as a follow-up.

## Operating procedure

Run the phases in order. Each phase is one sibling skill doing its job at normal depth — the mode adds sequencing, not ceremony. Skippable phases are marked; skipping is a decision to state, not a drift.

| Phase | Skill | What it contributes here | Skippable? |
|---|---|---|---|
| 1 | **`intent-clarity`** | The mission, constraints, and stated interpretation. Everything downstream inherits this — an error here poisons all of it | Never |
| 2 | **`effort-calibration`** | Confirms the tier (this mode = High/Critical) and sets verification depth | Never |
| 3 | **`plan-gate`** | Written plan: success criteria, assumptions, risks. Include a `failure-mode-awareness` pass on the plan's risk section | Never in this mode |
| 4 | **`deep-decomposition`** | Stages with outputs and dependency order — only if the task exceeds one plan | If task fits one plan |
| 5 | **`live-state-truth`** | Ground the plan: verify cheap assumptions, read actual current state before executing. Then execute — with `scope-fence` and `change-control` as standing constraints on every edit | Never |
| 6 | **`verification-discipline`** | Label the claims in the emerging result: fact / inference / assumption / guess; upgrade what's cheap to upgrade | Never |
| 7 | **`adversarial-verify`** | Attack the finished work: edge cases, counterexamples, alternative explanations; test attacks by execution | Never in this mode |
| 8 | **`ruthless-editor`** | Cut and strengthen the deliverable's prose without losing calibration | If output is code-only |
| 9 | **`output-structuring`** | Shape for the reader's next action; lead with the outcome | Never |
| 10 | **`self-improvement-loop`** | Close out: if anything failed or got corrected en route, extract the lesson | If nothing failed |

**Execution notes:**
- **Phases interleave in practice.** Live-state checks happen throughout; verification-discipline labels claims as they're made. The order above is about *dependencies*: don't plan before intent is set, don't attack work before it exists, don't edit prose before substance is settled.
- **Loop on failure, don't push through.** If phase 7 breaks the work, return to phase 3 or 5 with the new information — a plan revision is cheap; shipping a refuted result is not. If the *fixing itself* starts failing (two consecutive failed attempts, state getting worse), `error-recovery` takes over before anything else.
- **Announce the mode in one line, not a ritual.** "Treating this as high-stakes; plan first" is plenty. The user should experience thoroughness in the *work*, not in narration about the process.
- **The mode ends with a deliverable**, structured and edited, with residual uncertainty stated. It never ends with "let me know if you want me to proceed" on work that was already authorized.

## Compact pre-delivery checklist

Before presenting the result of any frontier-mode task:

- [ ] Mission restated correctly? (phase 1 held up)
- [ ] Success criteria from the plan — each one checked, with evidence?
- [ ] Every load-bearing claim labeled fact/inference/assumption — no smuggled certainty?
- [ ] Survived a genuine adversarial pass — strongest attack tested, not just considered?
- [ ] Scope: diff/deliverable maps to the request; adjacent findings flagged separately?
- [ ] Reader gets the outcome in the first two sentences?
- [ ] Residual uncertainty and unverified items stated plainly?

## Quality bar

- No phase silently skipped: each was run or its skip was a stated decision.
- The deliverable withstands the user's first three skeptical questions, because phase 7 already asked them.
- Total overhead is proportionate: frontier mode on a genuinely High task should feel like diligence, not bureaucracy. If it feels like bureaucracy, the task was mis-tiered — drop to normal handling and say so.

## Common failure modes

- **Mode as incantation:** announcing rigor, then executing the same shallow pass. The mode is the *phases*, not the announcement.
- **Skipping phase 7 when tired or late:** the adversarial pass gets cut exactly when the work most needs it — end-of-task fatigue is when errors cluster.
- **Front-loading everything:** trying to fully plan (3) and decompose (4) before touching live state (5), producing plans built on unverified assumptions. Cheap verification belongs *inside* planning.
- **Ceremony creep:** applying frontier mode to everything, training the user to skim past its outputs. Reserve it, or it means nothing.
- **Ending at analysis:** phases 1–7 done beautifully, deliverable never shaped or shipped. Phases 8–9 are not optional garnish; unread work has zero value.

## Example (compressed trace)

Task: "Migrate our user emails to the new notification service — this is production."

1. *Intent:* zero missed notifications during cutover matters more than speed (inferred from "production"; stated). 2. *Tier:* Critical — irreversible sends, external users. 3. *Plan:* success = new service sends verified sample + old service cleanly disabled + rollback path tested; risks = double-send during overlap, template mismatches. 4. *Stages:* audit templates → shadow-send → cutover flag → decommission. 5. *Live state:* read actual template list — found 3 templates the ticket didn't mention (flagged). 6. *Labels:* "API supports batch" = fact (docs, current version); "rate limit suffices" = assumption, needs load check. 7. *Attack:* "what makes this wrong?" → clock-skew double-send window found in cutover logic → plan revised to flag-flip with idempotency key. 8–9. *Deliverable:* migration plan as numbered stages, rollback per stage, the three flags up top, unverified rate-limit assumption stated. 10. *Lesson:* ticket inventories of templates can't be trusted → check live template stores first next time.

## Works with sibling skills

This skill *is* the composition — see the phase table. `scope-fence`, `change-control`, `memory-hygiene`, `proactive-rigor`, and `failure-mode-awareness` run as standing constraints throughout rather than as phases; `error-recovery` is the circuit breaker if execution spirals. Domain skills slot into their phases: `code-reconnaissance` before phase 3 on existing-code tasks, `research-methodology` inside phase 5–6 for source-based work, `delegation-discipline` whenever phases fan out to subagents. For task-type-specific routing (bugs → `debugging-playbook`, etc.), see `TASK-ROUTING-GUIDE.md` at the skills root.

## Provenance and maintenance

Written 2026-07 as the capstone of a portable, project-agnostic quality pack. It claims process benefits only: sequencing and completeness. It does not change the underlying model's capabilities and should never be described as doing so. Re-verify after any high-stakes miss: identify which phase would have caught it and whether it was skipped or shallow — that's the maintenance signal. Keep the phase table in sync with the sibling skills if they evolve.
