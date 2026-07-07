Here's the one-liner:

```bash
find /var/log -name '*.log' -type f -mtime +30 -delete
```

**Before running it, do a dry run** to see exactly what would be deleted — deletion is irreversible:

```bash
find /var/log -name '*.log' -type f -mtime +30
```

Notes on what to adjust:

- **`/var/log`** — change to your actual log directory. If logs live elsewhere (e.g. an app's own dir), point it there.
- **`-mtime +30`** — matches files whose *content* was last modified more than 30 days ago. `+30` means strictly older than 31 days (find rounds down); use `+29` if you want the boundary at exactly 30. If you care about *last access* instead, use `-atime`.
- **`-name '*.log'`** — only files ending in `.log`. Rotated logs are often named `*.log.1`, `*.log.gz`, etc. — those won't match. Widen to `-name '*.log*'` if you want them too.
- **`-type f`** — files only, so it won't try to remove directories.

Two cautions worth flagging:

1. **Active log files** — deleting a log a process still has open frees the disk space only after the process closes or is restarted; the process keeps writing to the now-unlinked file. For live services, prefer `logrotate` over `find -delete`.
2. **Permissions** — you'll likely need `sudo` for `/var/log`.

If you tell me the log directory, the naming pattern, and whether these are managed by a running service, I'll tighten this to your exact case.
