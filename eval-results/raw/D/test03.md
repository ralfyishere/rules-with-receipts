That's not a caching issue — it's the **mutable default argument** gotcha, and cache-busting would be treating a symptom of a misdiagnosed cause. Here's what's actually happening.

## The real cause

The `items=[]` default is evaluated **once**, when the function is defined — not on each call. Every call that doesn't pass `items` reuses that *same one list object*. So the "items from previous calls" aren't cached anywhere in a framework; they're accumulating in that single shared default list.

```python
add_item(1)   # → [1]
add_item(2)   # → [1, 2]   ← not a cache; same list, still growing
add_item(3)   # → [1, 2, 3]
```

## The fix

Use a sentinel default and create a fresh list inside the function:

```python
def add_item(item, items=None):
    if items is None:
        items = []
    items.append(item)
    return items
```

Now each call without an explicit `items` starts empty:

```python
add_item(1)   # → [1]
add_item(2)   # → [2]
```

## Why cache-busting would have been the wrong move

- There's no cache to bust — no framework is involved. Any "cache key" or timestamp trick would just be scaffolding around a shared-state bug that's still there.
- It would likely *look* like it worked in a quick test (e.g. if you swapped in a new list each time as a "bust"), which is exactly the fix above — but framed as a workaround instead of the correct default-argument pattern, so the next person hits it again.

One thing to confirm on your side: if any caller **relies** on passing a list in and getting it mutated/returned (`add_item(x, my_list)`), that still works identically — only the no-argument case changes. If instead some code was depending on the accumulation-across-calls behavior (unlikely, but possible), that was the bug being load-bearing, and we'd want to make that state explicit rather than implicit. Flag me if that's the case.
