---
name: Human Handoff
description: Design the human's part of a task when a step needs their hands - browser logins, account creation, approvals, physical-world actions, anything outside your tool reach. Activate whenever you're about to ask the user to do something you cannot do, especially multi-step flows you can't observe (OAuth/device flows, account setup, settings pages). Trigger signals: "you'll need to...", "please go to...", a blocked action requiring user credentials or clicks, or a human-step that already failed once.
---

# Human Handoff

## Purpose

When a step needs human hands, the handoff itself is a deliverable — and a badly designed one fails silently: the user does *something*, believes it worked, and you discover the miss two steps later. The core insight, learned the hard way: **humans can't see the system state you'd verify, so your instructions must name the completion signal — what DONE looks like — not just the actions.** A browser saying "connected" while the terminal grant never completed is the canonical failure.

## When to use this skill

- Any step requiring the user's credentials, browser, approvals, or physical presence.
- Multi-step out-of-band flows you can't observe: device-code auth, account creation, 2FA setup, settings pages.
- A human step that already failed once — the retry needs a redesigned handoff, not the same instructions louder.

## When NOT to use this skill

- Steps you can do yourself with available tools — exhaust those first; the best handoff is none (do everything possible, hand over only the irreducible remainder).
- Simple one-click asks with self-evident completion ("merge the PR") — a sentence suffices.

## Operating procedure

1. **Minimize the human surface first.** Before writing instructions, take every sub-step you can: prepare the files, pre-fill the values, stage the commands. Hand over only what genuinely requires them.
2. **Write exact steps with exact values.** Field names with the literal strings to paste, which account to be logged into, which button label to click. "Set up trusted publishing" fails; "Owner: `acme-dev`, Repository: `acme-tool`, Workflow: `publish.yml`, Environment: `pypi`" succeeds first try.
3. **Name the completion signal explicitly.** The single highest-leverage line: tell them what DONE looks like from *their* seat, and distinguish it from intermediate states that masquerade as done. "Don't close anything until the terminal prints ✓ Authentication complete — the browser saying 'connected' is not the finish line."
4. **Name the common failure point** if the flow has one (the step people skip, the screen that looks final but isn't). One sentence of "this is the part that usually gets missed" beats three retries.
5. **Verify from your side when they report back.** "Done" from the user is a claim, not a state — check the scope list, the API response, the file, whatever you *can* observe. If it didn't take, diagnose which step broke before re-asking; never resend identical instructions after a failure.
6. **Batch, don't dribble.** If the task needs three human steps, hand over all three with their completion signals at once — round-trips are the expensive resource.

## Quality bar

- The user could execute the handoff without asking a single clarifying question.
- Every multi-step flow has a stated completion signal, and it's observable from the user's seat.
- Your-side verification happened after "done", before any dependent step ran.
- Second attempts used a *changed* handoff informed by what failed, not a repeat.

## Common failure modes

- **Action-only instructions:** steps without a completion signal — the user stops at the first screen that looks finished. The single most common handoff failure.
- **Verification by user assertion:** building on "ok done" without checking; the miss surfaces later, more expensively.
- **Retry-by-repetition:** the flow failed, so you send the same steps again. If it failed once, the instructions were the bug — find the step that broke.
- **Dribbled handoffs:** five messages each asking one small thing, when one message could carry the whole human-side checklist.
- **Handing over the doable:** asking the user for things your tools could do — erodes the value of every future handoff.
- **Missing account/context disambiguation:** multi-account users approve flows in the wrong identity unless told which avatar should be in the corner.

## Example

Device-flow auth (real case, 2026-07): two failed attempts with "run `gh auth refresh` and approve in the browser" — the user's browser said "connected" and they reasonably stopped, but the grant never completed. Third attempt succeeded by changing one thing: numbering the steps and adding *"the browser saying 'connected' isn't the finish line — wait for the terminal to print ✓ Authentication complete."* The user's own words after: "the terminal part was what I didn't get before." Same session, PyPI trusted-publishing setup — five exact field values, completion signal, security note on recovery codes — worked on the first try.

## Works with sibling skills

- **`live-state-truth`** supplies step 5: the user's "done" is a claim requiring observation, same as any other unverified state.
- **`delegation-discipline`** is the sibling for delegating to *agents*; this skill covers delegating to *humans*, where the delegate can't be given a schema and can't see system state.
- **`output-structuring`**: handoffs are checklists with completion conditions — its format rules apply.
- The pack's `OPERATOR-GUIDE.md` is the mirror-image document (human instructing agent); this skill governs agent instructing human.

## Provenance and maintenance

Added 2026-07 from direct session evidence: two device-flow failures cured by naming the completion signal, and a five-field setup that succeeded first-try because of exact values. Re-verify by tracking handoff round-trips: any human step that takes more than one attempt means step 2, 3, or 4 was skipped — find which.
