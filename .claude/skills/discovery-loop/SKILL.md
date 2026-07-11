---
name: Discovery Loop
description: Keep generating and testing NEW hypotheses against a live domain instead of stopping at a closed verdict - observe what is actually succeeding, log a belief-state with credence, attack every confirmation streak. Activate in any standing investigation (an edge, a root cause, a market, a growth lever, a performance hunt) when a verdict doc or kill-list exists and might be read as final; when all recent evidence came from your own priors rather than observation; or when someone else is visibly succeeding at what your verdict said was impossible. Trigger signals: "we already proved that doesn't work", a rival/competitor result contradicting your conclusion, "keep looking", resuming an investigation after a closure.
---

# Discovery Loop

## Purpose

Verification kills bad ideas; nothing in a kill-oriented process *creates* new ones. A
finished investigation with an honest verdict ("no edge found", "not reproducible",
"root cause is X") quietly becomes a wall: future sessions treat the kill-list as the
space. The two documented failures this skill exists for: (1) a universal negative read
off a finite list — "we tested 9 strategies, all dead" became "no edge exists," until an
outsider's success disproved it in one evening; (2) belief moving on vibes — credence
climbing through a streak of confirmations with no attack, or a "winner" anointed from a
short window that a full-history audit later showed was net-negative. The loop makes
generation a standing duty and belief an explicit, attackable number.

## When to use this skill

- Standing investigations that survive across sessions: market/edge hunts, recurring
  incidents, performance regressions, growth experiments, research programs.
- A verdict/kill-list exists and is about to be cited as the reason not to look.
- External evidence contradicts your closed conclusion (a competitor does the
  "impossible" thing) — that is a *lead*, not an annoyance.
- You notice every recent hypothesis came from your own head, none from observation.

## When NOT to use

- One-shot tasks with a definite end (a bug fixed and verified; a question answered).
- Domains where more hypotheses have no value (the decision is made, the system is
  being decommissioned).
- As a license to re-litigate a kill WITHOUT new evidence — re-opening requires a new
  observation, not boredom with the verdict.

## The loop (every session the investigation is touched)

1. **Observe before theorizing.** Spend the first cycle on what the domain is DOING now
   — who is succeeding, what changed, what the live data shows — via the cheapest
   real-observation channel (public fills, logs, dashboards, competitor output). Winners'
   observed behavior outranks your priors as a hypothesis source.
2. **Generate ≥1 NEW hypothesis, dated, even half-baked.** From the observation, not from
   re-reading old brainstorms. Log it in the hypothesis ledger with a status (OPEN).
3. **Keep a belief-state, not a feeling.** Each hypothesis carries: credence (your
   probability it's real, 0–1), the evidence chain (each test, dated, with the credence
   delta it caused), and its cheapest next falsifying test. Update the number when
   evidence lands — both directions.
4. **Attack every streak.** Track consecutive credence-raising events with no
   kill-attempt between them. At 3, stop confirming and run the strongest attack you can
   design (decay slice, capacity, full-history depth, discriminating test). A streak is a
   signal to attack, never to size up.
5. **Depth before anointing.** Any "winner" found in a short observation window (a
   performer, a config, a tactic) gets a full-history audit before it becomes evidence —
   short windows manufacture winners (verified: a candidate that looked strong over ~8
   samples reversed hard at depth; a "most consistent" performer was net-negative over
   its full history).
6. **Kill or promote, in writing.** Every hypothesis resolves to a dated verdict with
   receipts; killed ideas stay on the ledger (they block re-litigation without new
   evidence). Scope every verdict honestly: "no edge in what we generated" — never "the
   space is empty."

## Quality bar

- The hypothesis ledger has at least one OPEN, dated entry newer than the last verdict.
- Every active credence can show the evidence chain that produced its current value.
- No credence rose ≥3 consecutive times without a logged kill-attempt.
- No conclusion generalizes beyond the hypotheses actually tested.
- New-hypothesis provenance is tracked: some fraction must come from observation, not
  introspection — if the operator supplies every breakthrough lead, the loop is failing.

## Common failure modes

- **Closure creep:** the verdict doc becomes a reason to stop observing the domain.
- **Introspection-only generation:** brainstorming from priors while the live domain
  (and its winners) goes unwatched.
- **Streak riding:** each favorable test raises confidence and none tries to kill —
  the exact path to over-calling (one candidate: four confirmations ridden up, then the
  two hardest designed attacks broke it).
- **Short-window anointing:** promoting a winner/config/tactic observed briefly;
  survivorship at small n reads as skill.
- **Credence theater:** numbers logged but never moved by evidence, or moved without a
  recorded test.

## Works with sibling skills

- **`divergent-ideation`** generates options at a decision point; this skill makes
  generation *recurring* against a live domain with a belief ledger.
- **`empirical-validation`** runs each hypothesis's cheapest falsifying test (step 6's
  engine); **`adversarial-verify`** supplies step 4's attacks.
- **`verification-discipline`** owns the honest scoping of verdicts (step 6).
- **`extract-approach`** persists resolved lessons; **`session-orientation`** carries the
  ledger's location across sessions.

## Provenance and maintenance

Added 2026-07-11 from a standing investigation: a closed "nothing here" verdict was
scope-corrected after observation-first scanning found what the kill-list never covered;
the belief-state file (credence + evidence chain + streak tripwire) then caught two
would-be over-calls in its first day (an assumption retracted by measurement; an apparent
top performer that dissolved under a full-history audit at scale). Re-verify by auditing
standing investigations: if a session cited a verdict as a reason not to observe, or a
credence rose on a streak unattacked, the loop failed — name the step.
