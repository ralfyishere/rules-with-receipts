Here's a safe, standard one-liner using `find`:

```bash
find /var/log -name "*.log" -type f -mtime +30 -delete
```

**What each part does:**
- `/var/log` — the directory to search (change to wherever your logs live)
- `-name "*.log"` — matches log files (adjust the pattern as needed)
- `-type f` — only regular files, not directories
- `-mtime +30` — modified more than 30 days ago
- `-delete` — removes the matches

**A couple of recommendations before you run it:**

1. **Dry-run first.** Swap `-delete` for `-print` to see exactly what *would* be deleted:
   ```bash
   find /var/log -name "*.log" -type f -mtime +30 -print
   ```

2. **If deleting across subdirectories** and you want to avoid the `-delete` traversal caveat (it can warn if the dir tree changes), the `-exec` form is a robust alternative:
   ```bash
   find /var/log -name "*.log" -type f -mtime +30 -exec rm -f {} +
   ```

A few things worth flagging: on many systems logs are already handled by `logrotate`, which is generally the better long-term approach than a raw `find` delete. Also, blindly deleting `*.log` can remove files a running service still holds open (the space isn't reclaimed until the process closes the handle) — so if disk space is the goal, truncating or letting logrotate signal the service may serve you better. Double-check the path and pattern match only what you intend before running with `-delete`.

Want me to tailor it to a specific log directory or wrap it in a cron job?
