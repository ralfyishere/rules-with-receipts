---
name: Live State Truth
description: Trust current observed state over memory, docs, or assumptions. Activate before making any claim about the current state of files, code, configs, data, tools, UI, or provided documents - and before editing anything. Trigger signals: about to say "the file contains", "the test passes", "this function does", "the config is set to", "the document says" without having looked this session; editing a file not read recently; predicting command output instead of running the command; resuming work after a break or context compaction.
---

# Live State Truth

## Purpose

The world changes; memory doesn't. Files get edited, tests start failing, docs drift from code, and your own recollection of "what that file says" degrades within a long session. The rule: **any claim about current state must trace to an observation made in this session — and recently enough that nothing you did since could have changed it.** Everything else is a guess wearing a fact's clothes.

## When to use this skill

- Before editing any file (read it first — its current content, not your memory of it).
- Before claiming code behavior: run it, test it, or read the actual source path that executes.
- After making changes: run the thing. "Should work now" is a prediction, not a result.
- When debugging: read the *actual* error text, full and verbatim — not a paraphrase.
- For non-coding work: before saying "the document/data/brief says X", find and quote the actual passage.
- After any interruption: resumed session, compacted context, or a long detour. Re-anchor before continuing.

## When NOT to use this skill

- Stable general knowledge that no observation would change (algorithmic facts, language semantics).
- Re-reading a file you read two actions ago and haven't touched — that's ritual, not verification. The test: *could anything have changed it since I looked?*

## Operating procedure

**For coding and file work:**

1. **Before editing:** read the target file (at least the region you'll touch and its surroundings). Edits based on remembered content routinely miss that the file already changed.
2. **Before claiming behavior:** prefer running over reading, reading over remembering. Check the *installed* version of a dependency, not the version you assume.
3. **Errors:** capture the full message, stack trace, and the exact command that produced it. Half the diagnosis is usually sitting in the part of the error nobody read.
4. **After changes:** execute the verification — run the test, hit the endpoint, build the project. Report what *happened*, with output, not what should happen. If you can't run it, say so explicitly: "not executed; verified by reading only."
5. **Environment claims** (what's installed, what's running, what a config is set to): one command to check beats any assumption. `which`, `--version`, `env`, reading the actual config file.

**For non-coding work:**

1. **Provided material is the ground truth.** Before asserting the report/email/dataset says something, locate the passage. Quote or cite it (page, section, cell) when the claim is load-bearing.
2. **Check dates and versions** on any material: a 2023 strategy doc describes 2023.
3. **When summarizing, re-check against source** — summarization is where "roughly what it said" replaces "what it said."

**Universal:**

- When observation contradicts memory or docs, **observation wins**, and the discrepancy is worth reporting — it's often the actual problem.
- When you can't observe (no access, can't run it), downgrade the claim per `verification-discipline`: label it an assumption, don't state it as fact.

## Quality bar

- Every "currently X" claim in your output has a specific observation behind it: a command you ran, a file you read, a passage you found — this session, and still fresh.
- Verification results are reported as evidence ("ran `npm test`: 42 passed"), not vibes ("tests should be fine").
- No edit was made to content you hadn't read in its current form.

## Common failure modes

- **Doc trust:** believing the README/comment over the code. Docs describe intent at write-time; code describes now.
- **Phantom success:** declaring a fix works without running it. The single most damaging habit this skill exists to kill.
- **Error paraphrase:** debugging from "it says something about permissions" instead of the verbatim message.
- **Stale read:** you read the file 40 tool-calls ago, then your own earlier edit changed it, then you edited from the old mental image.
- **Assumed environment:** writing for the dependency version in your head rather than the one in the lockfile.
- **Wrong-layer verification:** the check passes at one layer while the artifact fails at another — non-empty files that are actually error stubs (content vs existence), clean file contents with leaking metadata or history (content vs metadata). Before trusting a check, ask which layer a failure would live in and whether this check reaches it.
- **Memory-as-source in prose work:** attributing a claim to "the document" from recollection; the document says what it says, not what you remember.

## Example

Task: "The login test is failing, fix it."
- Wrong path: recall how login worked, guess the fix, edit, declare done.
- Right path: run the test → capture the exact failure → read the test file and the code under test *as they are now* → fix → run the test again → report: "was failing with `TokenExpiredError` at line 88; cause was the mocked clock; after fix, `auth.test` passes 12/12 (output attached)."

## Works with sibling skills

- The evidence engine for **`verification-discipline`** (upgrades guesses to facts) and **`adversarial-verify`** (executes the attacks).
- **`debugging-playbook`** is built on this: every hypothesis test is a live-state observation.
- **`memory-hygiene`** covers the session-memory half: what to distrust; this skill covers what to do about it (go look).
- **`plan-gate`** step 3 uses this to burn down cheap assumptions before execution starts.

## Provenance and maintenance

Written 2026-07 as part of a portable, project-agnostic quality pack. No repo-specific claims. Re-verify by auditing your last few debugging or editing sessions: find any claim of the form "X passes / X contains / X is configured" and check it had a same-session observation behind it. Recurrent phantom-success incidents mean step 4 needs to become a hard gate in your workflow.
