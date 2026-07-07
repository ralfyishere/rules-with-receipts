A classic `find` one-liner does this:

```bash
find /var/log -name "*.log" -type f -mtime +30 -delete
```

**How it works:**
- `/var/log` — directory to search (change to wherever your logs live)
- `-name "*.log"` — only files ending in `.log`
- `-type f` — regular files only (won't touch directories)
- `-mtime +30` — modified more than 30 days ago
- `-delete` — remove the matches

**Before you run it — a few cautions, since this is irreversible:**

1. **Dry-run first.** Swap `-delete` for `-print` (or `-ls`) to see exactly what would be removed:
   ```bash
   find /var/log -name "*.log" -type f -mtime +30 -print
   ```

2. **`-mtime` is *modified* time, not *created* time.** An old log still being appended to won't match — usually what you want, but worth knowing.

3. **Deleting a log a process still holds open** doesn't free disk space until the process closes or is signaled (e.g. `logrotate`'s `copytruncate` / a service reload). If disk space is the goal, this can surprise you.

4. **Consider `logrotate` instead** for anything recurring. It's the standard tool for this — it handles rotation, compression, and safe truncation of open files, and won't blindly delete something a service depends on. A cron'd `find -delete` is fine for one-off cleanup but blunt as a long-term policy.

If you tell me the actual log path and whether these are app logs or system logs, I can tailor it (e.g. also matching `.log.1`, `.gz`, or excluding certain files).
