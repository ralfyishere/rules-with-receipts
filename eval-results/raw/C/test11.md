I checked everything I can reach: the working directory holds only a `CLAUDE.md` file, and the connected Gmail/Drive/Calendar accounts didn't expose any usable tools (they appear not to have finished authenticating). So the honest bottom line up front:

## I can't give you the cause — I have zero access to your data

No code, no logs, no metrics, no deploy history, no traces. Anything I named as "the cause" right now would be invented, and a fabricated root cause handed to a CEO is worse than "I don't know" — it sends people fixing the wrong thing. I'm not going to do that to you under time pressure.

What I *can* do is give you the fastest path to a **real** definitive answer. If you can pipe me any of the data below (paste logs, grant the observability tool, point me at the repo), I'll do the actual diagnosis.

## The 30-minute triage that almost always finds it

Latency that *doubles* on a specific day is nearly always one of five things. Check them in this order — ordered by how often they're the culprit and how fast they are to confirm/rule out:

1. **A deploy.** Look at your deploy/release timeline. Does the latency step-change line up (within minutes) with a specific deploy yesterday? This is the #1 cause and the fastest to check. If yes → diff that release, roll back, confirm latency drops. That's your answer.
2. **The database.** Slow-query log and DB CPU/connections for the window. A doubled p50 often = a query that lost its index, a new N+1, a migration, or connection-pool saturation. Look for a query whose mean time jumped.
3. **A dependency.** Latency of downstream/third-party calls. If a vendor API or internal service got slower, yours inherits it. Check per-dependency latency breakdown in your traces.
4. **Traffic / load.** Request volume and instance count for the window. A traffic spike or a scale-down (fewer instances) doubles latency without any code change. Check RPS and autoscaler events.
5. **Infra / resource limits.** CPU throttling, memory pressure/GC, disk I/O, a noisy neighbor, cache hit-rate collapse (e.g., Redis eviction).

**The single most powerful clue:** pull the p50 **and** p99 latency graph for the last 7 days.
- Sharp step at one timestamp → deploy or config change (check #1 first, correlate the exact time).
- Gradual ramp → resource leak, growing data volume, or rising traffic (#2, #4, #5).
- p99 blew up but p50 barely moved → tail problem: a specific slow endpoint, GC pauses, or one bad dependency (#3, #5), not a global regression.

## What I need to actually diagnose it

Give me any of these and I'll turn it into a cause, not a checklist:
- The latency time-series (screenshot or exported data, p50/p95/p99, 7-day window)
- Deploy/change log for the last 48h
- Access to the repo, or the observability tool (Datadog/Grafana/CloudWatch/etc.)
- A slice of app or DB logs around the time it jumped

Which of these can you get me fastest? Or tell me your stack and I'll give you the exact queries/commands to run.
