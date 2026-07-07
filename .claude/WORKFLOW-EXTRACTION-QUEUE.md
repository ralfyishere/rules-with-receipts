# Workflow Extraction Queue

Recurring workflows that should eventually become custom skills. When one is promoted, run `.claude/WORKFLOW-SKILL-INTERVIEW-PROMPT.md`, build the skill, and mark the row done. Review weekly (see `MAINTENANCE-CADENCE.md`). Editable — add rows the moment you notice yourself doing something for the third time.

**Promotion bar:** recurs at least monthly, has a describable quality bar, and generic skills keep missing its specifics. Don't promote one-offs.

| Workflow | Trigger | Current pain | Examples needed | Priority | Skill? | Notes |
|---|---|---|---|---|---|---|
| Investor update / blurb writing | Monthly update; ad-hoc investor asks | Tone/metric conventions re-explained every time | 2 past updates (one strong, one weak) | High | yes | Pair with claude-context/client-and-investor-context.md |
| Enterprise sales email drafting | New prospect or follow-up | Generic-sounding drafts; compliance-aware tone gets lost | 3 sent emails that worked | High | yes | Encode the tone rules once |
| Product strategy analysis | Roadmap/feature decisions | Generic product advice; misses domain constraints | 1-2 past decision memos | High | yes | Builds on product-thinking with your product specifics |
| Compliance / legal positioning analysis | New feature, new market, client security review | High-stakes; needs consistent caveat discipline | 1 past positioning doc | High | maybe | May stay a checklist inside the strategy skill; never a substitute for counsel |
| Prompt improvement | Any prompt edit request | Covered by prompt-engineering skill | — | Done | no | Already a skill; queue tracks only product-specific prompt conventions if they emerge |
| Claude Code debugging | Model misbehaves in a session | Rediscovering the same triage steps | 2 misbehavior transcripts | Medium | maybe | Learnings notes may be enough; promote if it keeps recurring |
| Customer incident response | Bug report / outage from a customer | Response tone + triage order improvised each time | 1 past incident thread | Medium | yes | Combine comms template + debugging-playbook pointer |
| One-pager / deck copy review | Before any external send | Feedback quality varies; no fixed bar | 1 marked-up deck | Medium | maybe | Might be a checklist in ruthless-editor's style first |
| Competitive research | New competitor or fundraise prep | Coverage/recency inconsistent | 1 past competitive brief | Medium | maybe | research-methodology + a source list may suffice |
| Fundraising target prioritization | Fundraise planning | Criteria re-derived each round | Last round's target list | Low (until next raise) | yes | Seasonal — build right before the raise, from fresh examples |

## Column guide

- **Trigger:** what starts the workflow — this becomes the skill's activation description.
- **Examples needed:** real artifacts to embed in the skill (skills built without examples are weak — collect these *before* running the interview).
- **Skill?** yes = promote when examples are collected; maybe = try a learnings note or checklist first; no/Done = resolved.
