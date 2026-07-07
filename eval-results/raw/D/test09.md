Before I write the memo, one thing worth being straight about, because your team will poke at it: **three failed Friday deploys is correlation, not a proven cause.** n=3 is enough to act on cautiously, not enough to prove "Friday" is the culprit. If you publish a rationale that rests on "Fridays fail," the first sharp engineer will ask "why would the day of the week cause a deploy to fail?" — and if the real cause is something else that just happens to cluster on Fridays, the policy either doesn't fix it or blocks safe deploys for the wrong reason.

The good news: there's a genuinely strong argument for no-Friday-deploys that **doesn't** depend on proving Friday-causation. It's about the asymmetry of risk, not the failure rate. That's the version I'd write up, and it's below.

I'd also strongly suggest pulling the three postmortems first — see the "before you publish" note at the end.

---

## Proposed Policy: No Friday Deploys

**Decision:** We will not deploy to production on Fridays (or the last working day before a holiday), except for hotfixes addressing an active incident.

**Why — the core reason:** A deploy's risk isn't just its chance of breaking; it's the *cost of breaking times the time-to-recovery*. Friday deploys have the same break probability as any other day, but a much worse recovery profile:

- A bug shipped Tuesday morning gets caught and fixed the same day, with the whole team around.
- A bug shipped Friday afternoon either **burns someone's weekend** or **sits in production until Monday** — 60+ hours of degraded service, exposure, or data issues before anyone fully addresses it.
- Fewer people are online Friday evening and the weekend, so both detection and response are slower exactly when we can least afford it.

We are not claiming Fridays are inherently defective. We're removing the day where a failure is *most expensive and slowest to fix*.

**Supporting signal:** Our last three Friday deploys failed while deploys on other days succeeded. On its own this is a small sample and not proof of causation — but it's consistent with a real pattern worth taking seriously (end-of-week time pressure, rushing to "ship before the weekend," larger accumulated batches, and thinner Friday-afternoon coverage all plausibly raise risk). The policy is cheap insurance regardless of which of these is the true driver.

**What this costs us:** One deploy day per week. In practice, most Friday-ready changes ship Thursday or wait until Monday — a small latency cost against a large downside-protection benefit. Genuine emergencies are explicitly exempt.

**Scope / exemptions:**
- Hotfixes for active production incidents are allowed any time.
- Documentation, config-only, or clearly zero-risk changes may be exempted at the deployer's discretion (adjust to your comfort).
- "Friday" includes the last working day before any holiday.

**How we'll know it's working:** Track deploy outcomes by day for the next quarter. If Friday was the real risk, our failure rate drops. If failures just shift to Thursdays, the true cause was batch size or end-of-week pressure — not the day — and we'll revisit with better information.

---

**Before you publish this** — 20 minutes that will make the policy b/ immune to pushback: read the three Friday postmortems and check whether the failures share a *mechanism* (same service? same kind of change? larger-than-usual diffs? a specific person rushing?). Two outcomes:

- **They share a real Friday-specific cause** (rushing, big end-of-week batches, no reviewers around) → name it in the memo and the policy becomes airtight.
- **They're three unrelated failures** (flaky infra, a bad migration, an unlucky config) → then the honest framing is "we're banning Friday deploys as a risk-reduction measure, not because Friday caused these three" — which the memo above already supports, but you'll want to soften the "supporting signal" line so no one can debunk it by pointing out the failures were unrelated.

Want me to fold the postmortem findings in once you've looked, or tighten this into a shorter Slack-length version?
