# Workflow Extraction Queue

Recurring workflows that should eventually become custom skills. When one is promoted, run `.claude/WORKFLOW-SKILL-INTERVIEW-PROMPT.md`, build the skill, and mark the row done. Review weekly (see `MAINTENANCE-CADENCE.md`). Editable — add rows the moment you notice yourself doing something for the third time.

**Promotion bar:** recurs at least monthly, has a describable quality bar, and generic skills keep missing its specifics. Don't promote one-offs.

This is the shipped seed — replace the example rows with your own workflows. Filled-in queues contain your business specifics; keep yours private.

| Workflow | Trigger | Current pain | Examples needed | Priority | Skill? | Notes |
|---|---|---|---|---|---|---|
| Monthly stakeholder update | Recurring report/update deadline | Tone/metric conventions re-explained every time | 2 past updates (one strong, one weak) | High | yes | Pair with your claude-context/ files |
| Outbound email drafting | New prospect or follow-up | Generic-sounding drafts; house tone gets lost | 3 sent emails that worked | High | yes | Encode the tone rules once |
| Incident response | Bug report / outage | Response tone + triage order improvised each time | 1 past incident thread | Medium | yes | Combine comms template + debugging-playbook pointer |
| External document review | Before any external send | Feedback quality varies; no fixed bar | 1 marked-up example | Medium | maybe | Might start as a checklist in ruthless-editor's style |

## Column guide

- **Trigger:** what starts the workflow — this becomes the skill's activation description.
- **Examples needed:** real artifacts to embed in the skill (skills built without examples are weak — collect these *before* running the interview).
- **Skill?** yes = promote when examples are collected; maybe = try a learnings note or checklist first; no/Done = resolved.
