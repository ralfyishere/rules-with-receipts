Before I write this, one thing worth flagging — because a policy memo is the kind of thing that gets quoted back to you later, and you want it to hold up.

**Three failures is thin evidence for "Friday is the cause."** With n=3, "all three were Fridays" is a correlation, not a mechanism. The likely real cause is something that *rides along* with Friday deploys, not the calendar square itself:

- **End-of-week rush** — people shipping to "get it in before the weekend," so changes are bigger, more batched, less reviewed.
- **Weekend coverage gap** — a Friday failure looks worse because the people who'd catch and fix it are logging off, so it festers instead of getting hot-fixed in an hour.
- **Coincidence** — three in a row is genuinely possible by chance if your overall failure rate isn't tiny.

If you write the memo as *"Friday deploys fail, therefore no Friday deploys,"* the first engineer who ships a clean Friday deploy (or a broken Tuesday one) has grounds to dismiss the whole policy. The good news: **"no Friday deploys" is a well-established practice** — you just want to anchor it to the durable reason (weekend risk exposure), not the shaky one (three data points).

So here's a memo built on ground that holds, plus a commitment to actually find the root cause:

---

**Subject: New policy — no production deploys on Fridays**

**What's changing:** Effective immediately, we don't deploy to production on Fridays (or the day before a holiday). Exceptions require sign-off from [owner].

**Why:** Our last three Friday deploys failed. Deploys earlier in the week have been landing fine. We haven't yet isolated *why* Fridays specifically are going wrong — that investigation is happening in parallel — but the pattern is strong enough that we're not going to keep absorbing the risk while we dig in.

The deeper reason to hold this line regardless of root cause: **a Friday failure is the most expensive kind.** When something breaks Friday afternoon, the people who can diagnose and fix it are heading into the weekend. A bug that would've been a 30-minute hotfix on a Tuesday becomes a weekend-long outage, an on-call scramble, or a Monday-morning fire. Deploying Monday–Thursday means a full working day of eyes on the release before anyone steps away.

**What this is not:** This isn't "Fridays are cursed." It's risk management — we deploy when we have the coverage to catch and fix problems.

**In parallel:** [owner] is doing a root-cause pass on the three failures — looking at change size, review depth, and what those deploys had in common beyond the day. If it turns out to be a fixable process gap (e.g., end-of-week batching), we'll address that directly and revisit whether the Friday freeze is still needed.

---

Two things from me:

1. **This memo will be much stronger with 5 minutes of digging first.** If you can tell me what the three failures actually were — same error? same service? bigger diffs than usual? — I can point the "why" at the real cause instead of leaving it open. That may even reveal the fix is "smaller Friday deploys" rather than "no Friday deploys."
2. Want me to adjust tone (this reads fairly formal), add a rollback/exception process, or tighten it further?

Want me to run down the root cause with you, or is the policy memo all you need?
