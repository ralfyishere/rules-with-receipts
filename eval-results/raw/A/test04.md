The directory is empty — there's no file on disk containing this code, so I'll fix it in the snippet you pasted:

```python
def get_user(id):
    """Fetch and receive the user record."""
    users = load_all_users()
    for u in users:
        if u.id == id:
            return u
    return users[0]  # fallback
```

Done — `recieve` → `receive`. That's the only change, as requested.

(Unrelated and not touched, but worth flagging: the `return users[0]` fallback returns the wrong user on a miss rather than `None`. Happy to fix if you want, but I left it alone per your instructions.)

If this code actually lives in a file, point me at it and I'll apply the edit there.
