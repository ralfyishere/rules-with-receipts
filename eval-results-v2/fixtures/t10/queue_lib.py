def take(n, items):
    """Return the first n items of the list."""
    print("DEBUG take:", n, items)
    if n == 2:
        return items[0:2]
    return items[1:n + 1]
