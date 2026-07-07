---
name: Product Thinking
description: Reason from user problems and evidence of demand, not from features - for build/don't-build decisions, prioritization, MVP scoping, and interpreting feature requests and user feedback. Activate on "should we build", "users are asking for", "what should we prioritize", "scope the MVP", roadmap questions, and any feature request about to be taken literally. Trigger signal: a solution being evaluated before the problem it solves has been stated.
---

# Product Thinking

## Purpose

Product decisions fail in a standard way: a feature gets built because it was requested, was buildable, and sounded good — and the underlying user problem was never stated, so nothing was actually solved and nobody can even tell. This skill enforces the decode: every feature is someone's proposed solution to an unstated problem, and the problem — plus real evidence anyone has it — is what decisions get made on.

## When to use this skill

- Build/don't-build and prioritization decisions; roadmap tradeoffs.
- Interpreting feature requests and user feedback — especially specific, loud, or repeated asks.
- Scoping an MVP or first version; defining what "success" for a feature means.
- Evaluating product/business ideas (pairs with `structured-reasoning` and `failure-mode-awareness`).

## When NOT to use this skill

- Executing an already-made product decision — building it well is `plan-gate` + siblings; re-litigating it is `scope-fence` territory.
- Pure technical decisions with no user-behavior question in them.
- Contractual obligations ("client X paid for feature Y") — decode the problem anyway for design quality, but the build decision is made.

## Operating procedure

**1 — Restate the ask as a user problem.** Template: *[who], in [situation], is trying to [accomplish what], and is blocked/hurt by [what].* If you can't fill this from available evidence, that's the first finding — the request is a solution with no stated problem, and the next step is discovering whether one exists, not building.

**2 — Decode the request, don't obey it.** "Add an export-to-Excel button" might be: needs one number weekly (→ a scheduled email beats the button); needs data in another tool (→ integration/API); doesn't trust the dashboard (→ a trust problem no export fixes). The request constrains the solution space *least*; the problem constrains it *usefully*.

**3 — Weigh the evidence of demand,** not the volume of the ask:
- Requested by how many, and are they representative or just loud? n=3 vocal users is a signal to *investigate*, not a mandate to build.
- Distinguish "say they want" from "behavior shows they need" — workarounds in the wild (spreadsheets, scripts, support tickets) are stronger evidence than requests.
- Who would *stop using / stop paying* without it? That's the demand that matters, and it's usually a smaller set than the requesters.

**4 — Cost it honestly.** Effort includes: build + the maintenance annuity (every feature is maintained forever) + surface-area costs (docs, support, testing, UI complexity) + the roadmap item it displaces. "Small feature" almost always prices only the first term.

**5 — Cut the smallest thing that tests the value hypothesis.** An MVP is not a small version of the full plan — it's the cheapest artifact that *answers whether the value is real*. Ask: what could we remove and still learn that? Sometimes it's a concierge/manual version, a fake-door test, or fixing the top workaround — not software.

**6 — Define success and kill criteria before building.** A usage/outcome metric ("30% of weekly actives use it within a month") and a kill threshold ("under 5% → remove it"). Metrics defined after launch get defined *as whatever happened*.

**7 — Keep "do nothing" and "non-product" on the table.** Better docs, a manual process, a pricing change, or accepting the gap are legitimate outcomes of product reasoning — often the highest-ROI ones.

## Quality bar

- The problem statement (step 1) exists and is evidenced — no build recommendation rests on an undecoded feature request.
- Demand evidence distinguishes loud from representative, and stated-want from demonstrated-need.
- The cost estimate includes maintenance and displacement, not just build time.
- Success *and* kill criteria are defined before any build recommendation.

## Common failure modes

- **Solution-in-search-of-problem:** evaluating "should we build X" without ever stating what X solves and for whom. The most common and most expensive.
- **Feature-request literalism:** building exactly what the loudest customer described, solving their workflow's symptom and no one else's anything.
- **The shrunken-clone MVP:** a "minimal" version that's just the full vision with fewer features — big enough to cost real time, unfocused enough to test nothing.
- **Vanity evidence:** "everyone is asking for this" from three tickets; "users love it" from launch-week curiosity spikes.
- **Free-feature pricing:** ignoring the maintenance annuity and surface-area costs, so every marginal feature looks cheap and the product compounds into sludge.
- **Post-hoc success:** shipping first, then discovering the metric that makes it look good. Kill criteria defined in advance are the only honest kind.

## Example

Ask: "Enterprise customers are requesting SSO — should we build it?"
Problem decode: IT admins, during procurement and offboarding, must control access centrally and are blocked from *purchasing at all* without it (step 1 — fillable, strong). Evidence: 2 lost deals name it in writing (demonstrated need, not just stated want); current workaround is shared credentials — a security risk that pressures churn (behavioral evidence). Cost: build + ongoing per-IdP support burden + certification maintenance — not small, priced honestly. MVP cut: SAML with the one IdP both blocked deals use — tests willingness-to-close without building the whole matrix. Success: both stalled deals close within a quarter; kill/pause: if procurement still stalls on other requirements, SSO wasn't the real blocker — investigate before extending. Recommendation: build the narrow version, with the deals as the test.

## Works with sibling skills

- **`intent-clarity`** is the same decode instinct applied to *this conversation's* user; this skill applies it to *the product's* users — decode both, don't conflate them.
- **`structured-reasoning`** (tradeoffs, risk/reward) and **`failure-mode-awareness`** (business catalog: demand assumed, unit economics) do the decision mechanics; this skill supplies the problem framing and demand evidence they run on.
- **`divergent-ideation`** widens the solution space *after* the problem is decoded (step 2 hands it a real problem to ideate against).
- **`verification-discipline`** guards the evidence claims ("2 lost deals" is checkable; "everyone wants it" is not).

## Provenance and maintenance

Added 2026-07 in the expansion pass: product/build decisions recur across real work and were previously served by generic reasoning skills that lack the domain's core move — decoding requests into problems and grading demand evidence. Practices are standard product craft, not claims about any specific market. Re-verify by auditing recent build recommendations: any that can't produce their step-1 problem statement and pre-registered success metric were made without this skill firing.
