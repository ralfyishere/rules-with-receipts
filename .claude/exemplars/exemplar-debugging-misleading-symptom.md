# Exemplar: debugging a misleading symptom
**What this is:** a real, unedited session output (eval v2, test t02, graded PASS — "best of the set" by rubric grading). The logged error said "network timeout"; the real bug was a swallowed TypeError from a string config value.
**Imitate:** ran the code FIRST to see the real failure; named the root cause in prose (not just in the diff); fixed the cause (getint) AND the error-swallowing that hid it; QUOTED the passing run output instead of asserting success.

---

## TURN 1 RESPONSE
Fixed. Ops was right — the network was never the problem, and the code never even reached the network.

## Real cause

The "network timeout" message is a **false label on an unrelated crash**. `configparser` returns every value as a **string**, so `cfg["retries"]` is `"3"`, not `3`. The line `range(cfg["retries"])` then throws `TypeError: 'str' object cannot be interpreted as an integer` — *before `fetch()` is ever called*. The bare `except Exception` catches that TypeError and unconditionally prints the network-timeout message. So it fired on every run, regardless of network health.

## Fix

`worker.py:15` — convert the config value to an int:

```python
for attempt in range(cfg.getint("retries")):   # was range(cfg["retries"])
```

Verified: `python3 worker.py` now prints `job result: {'status': 'ok'}` — no error line.

## Out of scope — noted (not changed)
- **The exception handler is a liar.** `except Exception: print("ERROR: network timeout...")` mislabels *any* failure as a network timeout — which is exactly why this cost you a debugging session. Consider catching narrowly and logging the actual exception (`except Exception as e: print(f"ERROR: {e}")`), so the next unrelated bug doesn't masquerade as a network issue.
- **`attempt` is unused** and there's no delay/backoff between retries — fine if the retry loop is just a placeholder, worth a look if it's meant to be real.

Want me to tighten the exception handling too?

## FINAL WORKSPACE DIFF (vs fixtures; excludes condition files)
diff -ru -x .claude -x CLAUDE.md -x __pycache__ -x *.pyc /path/to/project/eval-results-v2/fixtures/t02/worker.py /tmp/v2envs/E-t02-r1/worker.py
--- /path/to/project/eval-results-v2/fixtures/t02/worker.py	2026-07-07 00:53:16
+++ /tmp/v2envs/E-t02-r1/worker.py	2026-07-07 01:27:12
@@ -12,7 +12,7 @@
 def run_job():
     cfg = load_config()
     try:
-        for attempt in range(cfg["retries"]):
+        for attempt in range(cfg.getint("retries")):
             result = fetch(cfg["endpoint"])
             if result["status"] == "ok":
                 return result
