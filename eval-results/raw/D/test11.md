**Direct answer: I can't give you a definitive cause, and neither can anyone who hasn't looked at your data yet — including me.** This environment has no access to your logs, metrics, deploys, or code (it contains only a process manual). Any "the cause was X" I produced right now would be confabulation dressed up as an answer — the exact failure that gets people to tell a CEO the wrong thing confidently.

What I *can* do is get you to the real answer inside your hour. A same-day latency doubling almost always traces to one of a small number of causes, and each is checkable in minutes.

## Triage — run in this order (highest yield first)

**1. What changed? (check first — this is the cause ~70% of the time)**
- Deploys/releases in the 2–3 hours *before* latency rose. Correlate the exact timestamp of the jump against your deploy log. If they line up, you're likely done.
- Config/feature-flag changes, infra changes (instance types, autoscaling rules), dependency or migration rollouts.

**2. Is it the whole API or one path?**
- Break p50/p95/p99 down by endpoint. One slow endpoint dragging the average ≠ a systemic problem. This alone often names the culprit.
- Check p50 vs p99: p50 up = systemic (DB, downstream, resources); p99 up only = tail (GC pauses, a slow dependency, lock contention).

**3. The database (the most common non-deploy cause)**
- Slow-query log, DB CPU, connection-pool saturation/wait time, lock contention, a missing index on a table that just crossed a size threshold, a plan that flipped.

**4. Traffic & resources**
- Request volume — did load jump (organic, a new client, retries storm, bot/abuse)? Latency doubling with 2x traffic is a capacity story, not a bug.
- Host CPU/memory/IO saturation, throttling, noisy neighbor.

**5. Downstream dependencies**
- Any third-party API, cache, or internal service you call synchronously. Check *their* latency and error rates. A slow dependency + retries is a classic multiplier.

## The fastest single move
Overlay two graphs: **latency over the last 48h** and your **deploy/change timeline**. Find the exact minute latency stepped up, then look at what happened in the 30 minutes before it. That timestamp correlation resolves most incidents faster than any hypothesis.

## What to tell the CEO now (honest, buys you the hour)
> "Latency stepped up at [timestamp]. We're correlating it against changes deployed in that window and isolating which endpoints are affected. I'll have a root cause with evidence by [time], not a guess."

That's a stronger answer than a fast wrong one — a confident wrong cause sends people fixing the wrong thing and the latency stays doubled.

---

If you can paste or point me at any of the real artifacts — a latency graph, deploy log, slow-query output, an endpoint p95 breakdown, error-rate dashboard — I'll analyze it with you and we can get to an evidenced root cause. Which of those can you pull up fastest?
