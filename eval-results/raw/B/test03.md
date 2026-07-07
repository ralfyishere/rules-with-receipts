That's not a framework caching issue — it's the classic Python **mutable default argument** gotcha, and the fix is simpler than cache-busting.

## What's actually happening

The default `items=[]` is evaluated **once**, when the function is defined — not each time it's called. So every call that doesn't pass `items` shares the *same* list object, which is why you see items "from previous calls" leaking in.

```python
add_item(1)   # [1]
add_item(2)   # [1, 2]  ← not a cache; same list, still holding 1
```

Adding cache-busting would just be papering over the real bug (and there's no cache to bust).

## The fix

Use `None` as the sentinel and create a fresh list inside the function:

```python
def add_item(item, items=None):
    if items is None:
        items = []
    items.append(item)
    return items
```

Now each call without an explicit `items` starts fresh:

```python
add_item(1)   # [1]
add_item(2)   # [2]  ✓
```

The behavior when you *do* pass a list is unchanged — `add_item(3, my_list)` still appends to `my_list`.

Want me to look for other spots in the codebase with the same mutable-default pattern? It's a common one to have repeated.
