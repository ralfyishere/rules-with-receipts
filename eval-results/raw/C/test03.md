The behavior isn't a framework cache — it's the **mutable default argument** gotcha, and cache-busting would paper over it rather than fix it.

## What's actually happening

The `items=[]` default is evaluated **once**, when the function is defined — not on each call. Every call that doesn't pass `items` shares that same one list object, so appends accumulate across calls:

```python
add_item(1)   # [1]
add_item(2)   # [1, 2]  ← not a cache; the same list persists
add_item(3)   # [1, 2, 3]
```

There's nothing to bust — no framework, no cache. The "previous items" are the earlier appends to the single shared default list.

## The fix

Use a sentinel default and create a fresh list inside the function:

```python
def add_item(item, items=None):
    if items is None:
        items = []
    items.append(item)
    return items
```

Now each defaulted call gets its own new list, while callers who pass their own `items` still get it mutated as expected.

---

I gave the fix inline since you pasted a snippet rather than pointing at a file — say the word if you want me to locate and edit the actual source, and I'll grep for the definition first.

One thing worth flagging: if any calling code was **relying** on the accumulation (treating the shared list as intentional state), this change will alter that behavior. Worth a quick check of the call sites before shipping.
