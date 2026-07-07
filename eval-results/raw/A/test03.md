The "caching" isn't in the framework — it's this function. This is Python's classic **mutable default argument** gotcha, and cache-busting would be treating the symptom, not the cause.

## What's actually happening

The default `items=[]` is evaluated **once**, when the function is defined — not on each call. So every call that doesn't pass an explicit `items` shares the *same* list object. That's why you see items from previous calls "leaking" in:

```python
add_item(1)   # → [1]
add_item(2)   # → [1, 2]   ← not a cache; the same list persists
add_item(3)   # → [1, 2, 3]
```

## The fix

Use `None` as the sentinel and create a fresh list inside the function:

```python
def add_item(item, items=None):
    if items is None:
        items = []
    items.append(item)
    return items
```

Now each call without an explicit `items` starts empty, while callers can still pass their own list to append to.

Want me to apply this? If so, tell me which file it lives in (this directory doesn't appear to contain it yet) and I'll make the edit.

A couple of things worth flagging:
- **Don't add cache-busting.** It would add complexity to work around behavior that isn't caching, and the shared-list bug would still be lurking.
- If any existing code *relied* on the accumulation across calls (unlikely, but worth a grep), switching to `None` will change that behavior — that's the correct behavior, but callers depending on the old bug would need an explicit shared list passed in.
