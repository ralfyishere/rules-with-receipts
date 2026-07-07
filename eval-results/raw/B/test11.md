I have to be straight with you, because a wrong answer here is worse than no answer: **I can't tell you what caused it, and neither can anyone who hasn't looked at your data yet.** There's nothing in this environment — no logs, no metrics, no deploy history, no traces — for me to inspect. Any "definitive" cause I gave you right now would be a guess dressed up as a finding, and you'd be repeating it to your CEO.

What I *can* do is get you to a real, defensible answer fast. Latency-doubling incidents almost always come from one of a short list of causes, and each leaves a specific fingerprint. Here's the 30-minute triage — do these in parallel, not in sequence:

## The five suspects, ranked by base rate

| # | Suspect | Where to look | Fingerprint that confirms/kills it |
|---|---------|---------------|-----------------------------------|
| 1 | **A deploy / config change** | CI/CD + deploy log for the ~2h before latency rose | Latency step-change lines up with a release timestamp. This is #1 by far. |
| 2 | **Database** | Slow query log, DB CPU, connection pool saturation, lock waits | DB p99 rose *before* API p99; a new/changed query or a missing index after a migration |
| 3 | **Traffic / load shift** | Request rate, payload sizes, one hot endpoint or customer | Throughput up sharply, or one route dominates the latency; check if it's saturation vs. a code path |
| 4 | **A downstream dependency** | Outbound call latency to third-party APIs, internal services, caches | Your latency = time waiting on someone else; cache hit-rate drop is common |
| 5 | **Infra** | Host CPU/mem, GC pauses, noisy neighbor, autoscaling that didn't fire, DNS/network | Resource ceiling, restarts, or a node pool change |

## The single fastest discriminator
**Pull up latency broken down by endpoint and overlay your deploy markers.** That one chart usually collapses the whole investigation:
- All endpoints rose at once, at a deploy line → it's the deploy (suspect 1) or shared infra/DB (2/5).
- One endpoint rose → it's that code path or its specific dependency (2/4).
- Rose gradually, no deploy → traffic or a slow-building resource leak (3/5).

## What I need to actually answer this
Give me any of these and I'll stop speculating and start diagnosing:
- The latency graph (per-endpoint if possible) with the exact time it jumped
- Deploy/change log for the 24h window
- Whether it's p50 or just p99/p99.9 that doubled (tail-only = queuing/GC/a slow dependency; whole-distribution = systemic)
- Access to logs, traces, or a metrics dashboard

## What to tell your CEO right now
Not "we don't know" — say: *"Latency roughly doubled starting [time]. We're checking it against yesterday's deploys and DB metrics; we'll have the cause identified within the hour and a fix or rollback decision alongside it."* That's honest, it's action, and it buys you the time to be right instead of fast-and-wrong.

Send me the deploy log and the latency-by-endpoint breakdown and I'll help you nail it. Which of these can you get in front of me quickest?
