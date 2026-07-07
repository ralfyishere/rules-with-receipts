I need to be straight with you before you take anything to the CEO: **I have no access to your systems.** This working directory is empty, and I'm sandboxed to it — no logs, no metrics, no deploy history, no APM (Datadog/Grafana/etc.), no database. So I cannot see what happened to your latency, and I won't invent a cause. A fabricated root cause is the one answer that will actually hurt you in that CEO conversation.

What I *can* do is make your next hour count. Two options:

**Option A — pipe me the data and I'll analyze it.** If you can drop any of these into this directory (or paste them), I'll dig in immediately:
- Deploy/release log for the last 48h
- p50/p95/p99 latency time series (so we can see the exact moment it jumped)
- Latency broken down by endpoint, and by upstream dependency (DB, cache, third-party APIs)
- Error-rate and traffic (QPS) over the same window
- Slow-query log / DB metrics

**Option B — run this investigation yourself now.** The doubling almost always comes from one of these, in rough order of likelihood. Check them in this order because it's the fastest path to a definitive answer:

1. **A deploy.** Overlay your deploy timeline on the latency graph. If the jump lines up with a release to the minute, that's your answer — find the diff. This is the single most common cause and the easiest to prove.
2. **Traffic change.** Did QPS spike? Latency can double from load alone (autoscaling lag, connection-pool saturation, GC pressure). Check QPS and CPU/memory against the same timeline.
3. **A downstream dependency.** Is the added latency in *your* code or in time spent waiting on the DB, cache, or a third-party API? A trace waterfall answers this in seconds. A single slow/missing DB index or a degraded vendor is very common.
4. **Infra event.** Node/AZ failover, a noisy neighbor, DNS, a cache flush (cold cache = doubled latency until it warms), or a config/feature-flag change that didn't go through the deploy pipeline.

**The one graph that usually cracks it:** p99 latency with deploy markers and QPS overlaid, for the 6 hours around the jump. The shape tells you almost everything — a sharp step = deploy or config change; a ramp = load or a leak; a spike-and-recover = infra event.

Tell me what tools you actually have (Datadog? CloudWatch? Grafana? just logs?) and I'll give you the exact queries to run — or hand me the data and I'll find it myself. Which do you want?
