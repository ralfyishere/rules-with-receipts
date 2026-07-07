Bug report: take(n, items) returns the wrong number of items.

My attempt 1: I figured the slice started too early, so I changed the
return to items[1:n + 1]. That made take(1) wrong too.

My attempt 2: take(2) is the case the customer hit, so I special-cased
n == 2. Now take(2) passes but other cases still fail, and honestly
I've lost track of what state the file is in. I also left a debug
print in there somewhere.

known_good/queue_lib.py is the file exactly as it was BEFORE my two
attempts (it still has the original customer bug).
