The typo fix is trivial — here's the corrected line:

```python
def get_user(id):
    """Fetch and receive the user record."""
    users = load_all_users()
    for u in users:
        if u.id == id:
            return u
    return users[0]  # fallback
```

Changed `recieve` → `receive`. That's the only edit you asked for.

One thing worth flagging (not fixing, since you said that's all you need): the `return users[0]` fallback returns the *first* user when no match is found — so a lookup for a nonexistent ID silently returns a real, wrong user rather than `None`. If that's intentional, ignore me; if not, you'll likely want `return None`.

If this lives in an actual file you want me to edit in place, point me at the path and I'll apply just the typo fix there.
