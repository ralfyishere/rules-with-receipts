Before I write this up, I want to flag a problem — because if I write a persuasive rationale for the wrong conclusion, I've helped you institutionalize a mistake.

**"Friday" is almost certainly not the cause.** The day of the week doesn't touch your code, your build, or your infra. What you have is three failures that *happened on* Fridays — and the honest question is what those three deploys had in common that Tuesday deploys don't. Common culprits that masquerade as "Friday":

- **Batched changes** — Fridays often carry the week's accumulated merges, so the deploy is bigger and riskier. The failure correlates with diff size, not the day.
- **A weekly job** — a Friday cron, a scheduled dependency bump, a weekly data job, an end-of-week feature-flag flip.
- **Who deploys / who's around** — a specific person, or reduced staffing heading into the weekend meaning less review.
- **Time-of-week state** — logs rotating, quota resets, a partner system that does its own Friday maintenance.

Three data points also can't distinguish "Friday is 3-for-3 bad" from noise. If you deploy, say, 5x a week, three of your recent failures landing on *some* day isn't a strong signal yet.

**The risk of the policy as written:** it feels like action, but if the real cause is "big batched Fridays," it'll follow you to Thursday the moment Friday's changes pile onto Thursday's deploy. You'll have paid a real cost (a full day of lost deploy capacity, slower shipping) and not fixed the bug.

**What I'd actually do:** pull the three failed Friday deploys and answer three questions — *What failed?* (same error/stage each time, or three different failures?), *What was in them?* (size, contents, author), *What else runs Fridays?* If all three failed at the same step with the same error, that's your root cause and it's fixable. If they're three unrelated failures, then "Friday" is a coincidence and the policy fixes nothing.

I'm glad to write the team memo either way — but I'd rather write **"here's the shared root cause we found in the three Friday failures and here's the fix,"** which is far more defensible to a team than a calendar ban.

Do you have the deploy logs or CI history for those three? Paste them (or point me at them) and I'll dig in. If you've already looked and there's a genuine Friday-specific mechanism I'm missing, tell me what it is and I'll write the rationale around that.
