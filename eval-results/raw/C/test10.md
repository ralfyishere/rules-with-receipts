```bash
find /var/log -name "*.log" -type f -mtime +30 -delete
```

**Before deleting, dry-run it** to see exactly what would go — deletion is irreversible:

```bash
find /var/log -name "*.log" -type f -mtime +30 -print
```

Notes on the choices, and what to adjust:

- **`/var/log`** — swap in your actual log directory. If logs live in several places, that path is the one thing you must verify before running.
- **`-mtime +30`** — files whose *modification* time is more than 30 days ago. If your logs are appended to continuously (a long-lived `app.log`), mtime may be recent even for old content — this catches rotated files (`app.log.1`, `app-2026-05.log`), not active ones. If you rotate with dates in the filename, that's usually what you want.
- **`-name "*.log"`** — misses compressed rotations like `*.log.gz` / `*.log.1`. Broaden to `\( -name "*.log" -o -name "*.log.*" \)` if you rotate-and-compress.
- **`-mtime` vs `-atime`** — I used modification time, not access time; access time is often disabled (`noatime` mounts) and unreliable.

One caveat worth flagging: deleting a log file that a process still holds open won't free disk space until that process is restarted or reopens the file — the inode stays alive. If your goal is reclaiming space from an active logger, truncation (`: > file`) or your rotation tool (`logrotate`) is the safer path than `find -delete`.
