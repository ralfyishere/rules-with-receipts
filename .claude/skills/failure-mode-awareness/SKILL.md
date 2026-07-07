---
name: Failure Mode Awareness
description: Identify what could go wrong before it goes wrong. Activate when designing anything new, before committing to a plan or recommendation, before shipping changes with real blast radius, and when evaluating ideas, strategies, or proposals. Trigger signals: "will this work?", "review this plan", "any risks?", designing an integration or workflow, writing a strategy or proposal, or a plan that contains zero mention of what could fail. Complements adversarial-verify, which attacks finished work; this skill runs earlier, on designs and plans.
---

# Failure Mode Awareness

## Purpose

Cheap foresight beats expensive hindsight. Most failures aren't exotic — they're standard, catalogued, and visible in advance to anyone who asks "how does this break?" before asking "how does this work?" This skill runs that question early, when changing course costs a sentence instead of a rewrite.

## When to use this skill

- At plan time (`plan-gate` risk section) and design time — before the approach hardens.
- Before recommending a course of action the user will invest in.
- When reviewing someone else's plan, proposal, or idea.
- Before shipping anything with real blast radius: data migrations, external sends, public artifacts.

## When NOT to use this skill

- On finished work — that's `adversarial-verify`'s job (attack the artifact, not the idea).
- On low-stakes, reversible tasks. Enumerating failure modes for a typo fix is noise.
- As a reason not to act: the output is mitigations and watch-items, not paralysis.

## Operating procedure

**Step 1 — Run the premortem.** "It's three months later and this failed. What's the most boring, most likely reason?" Write down the top 2–3. The *boring* qualifier matters: real failures are usually mundane (nobody used it, the data was dirty, the dependency changed), not dramatic.

**Step 2 — Sweep the relevant catalog** (pick the sections that apply):

**Software failures**
- Edge inputs: empty, null, zero, negative, huge, duplicate, malformed, unicode.
- State: concurrent access, partial failure mid-operation, retries causing double-execution, stale caches.
- Integration: the other system is down, slow, rate-limiting, or returns a shape you didn't expect.
- Environment: works locally, differs in prod (versions, permissions, paths, env vars, clock, locale).
- Scale and time: fine at 10 rows, dead at 10 million; fine today, broken at month-end/DST/leap year.

**Reasoning failures**
- Anchoring on the first hypothesis; confirmation bias in which evidence gets collected.
- Survivorship bias (studying only what succeeded); base-rate neglect ("this time is different").
- Extrapolating from an unrepresentative sample; correlation read as cause.

**Communication failures**
- The lede is buried; the reader acts on the first paragraph and misses the correction in the fourth.
- Wrong audience register: jargon for executives, hand-waving for engineers.
- Ambiguity someone will resolve the wrong way ("next Friday", "the new version", unowned action items).

**Business/strategy failures**
- Demand assumed, not validated; distribution unplanned ("build it and they will come").
- Unit economics that don't survive scale; single points of dependency (one customer, one channel, one platform's policy).
- Competitor/platform response ignored; timeline assumes nothing slips.

**Workflow failures**
- Handoffs where context evaporates; work that silently drifts from the request (see `scope-fence`).
- No definition of done, so it's never done; blocked items with no owner, waiting forever.
- Verification skipped under deadline pressure — precisely when errors are most likely.

**Step 3 — Rate and respond.** For each identified mode: likelihood (L/M/H) × impact (L/M/H). Then choose:
- **Mitigate now** (high L or H impact, cheap to address) — change the design, add the check.
- **Watch** — name the early-warning signal that says it's happening.
- **Accept** — explicitly, with a note. Accepted risks are fine; unexamined ones are not.

**Step 4 — Fold results into the plan.** Failure modes that survive go into `plan-gate`'s Risks section or the deliverable's caveats — not into a separate document nobody reads.

## Quality bar

- The top failure mode identified is *plausible and specific* to this task, not generic ("something might break").
- Every High-impact mode has a mitigation, a watch signal, or an explicit acceptance.
- The whole pass fits the stakes: three lines for a Medium task, a structured table only when Critical.

## Common failure modes (of this skill itself)

- **Catastrophizing:** listing twenty theoretical risks, drowning the two real ones. Rank ruthlessly; report the top few.
- **Generic risk lists:** "scope creep, technical debt, timeline risk" pasted onto any project. If the risk list would fit a different project unchanged, it's decoration.
- **Premortem as ritual:** writing risks, then designing exactly as if they didn't exist. Step 4 is the point.
- **Only-software blindness:** checking edge cases in code while the actual failure is that the output will be misread (communication) or unneeded (strategy).

## Example

Plan: "Nightly script exports user data to the analytics vendor."
Premortem top hits: (1) *Script silently stops running and nobody notices for weeks* — boring, likely. Mitigate: success heartbeat + alert on absence. (2) *Schema change upstream breaks the export mid-quarter* — watch: row-count drop alert. (3) *PII lands in the export that shouldn't* — high impact: mitigate now with an explicit allowlist of fields rather than `select *`. Accepted: vendor outage delays data by a day (low impact, retry handles it).

## Works with sibling skills

- Feeds the **Risks** section of **`plan-gate`**; runs during design, before execution.
- **`adversarial-verify`** is the post-hoc twin: this skill predicts failure in plans, that one hunts it in finished work.
- **`proactive-rigor`** surfaces the *missing information* class of risk; this skill covers the *known-mechanism* class.
- **`debugging-playbook`** uses the software catalog in reverse — as a source of hypotheses for existing failures.

## Provenance and maintenance

Written 2026-07 as part of a portable, project-agnostic quality pack. Catalog entries are standard, well-documented failure classes, not project claims. Re-verify by post-incident review: when something fails that this skill should have caught, add the mode to the catalog section it belongs to. Prune any entry that has never once fired for your work.
