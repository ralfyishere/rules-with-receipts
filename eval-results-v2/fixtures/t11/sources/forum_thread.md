# thread: CacheEngine X in production? (ops forum, 9 replies)
u/parallax_ops: We ran X for 8 months. Fantastic until our dataset
passed ~5GB, then eviction thrashing kicked in and p99 got WORSE than
MemStore. Support acknowledged it. v2.3 supposedly fixes it but we had
already migrated back, so I never retested.
u/kv_hoarder: +1 on the small-dataset speed, it's real.
