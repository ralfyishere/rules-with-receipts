---
name: Session Orientation
description: Orient from the workspace's project registry before working - canonical repo paths, current versions, pending state - instead of rediscovering them by searching. Activate at the start of any new or resumed session in a multi-project workspace, on project-state requests ("check the work on X", "is everything up to date", "continue where we left off"), before any broad audit, and before searching the filesystem for a project whose location should be known. Also owns closeout: promote scratchpad work to durable paths and update the registry before ending a session that changed state.
---

# Session Orientation

## Purpose

A fresh session starts with amnesia about everything outside its context window:
where repos live, which copy is canonical, what version is current, what is
pending. Without a fixed orientation step, every session pays a rediscovery tax —
filesystem archaeology, stale-memory guesswork, unscoped audits — and sessions
restart instead of compounding. This skill makes orientation a procedure: read the
map, verify what matters live, then work — and makes writing the map back a
closeout duty, because the read side only works if sessions keep it true.

## When to use this skill

- First substantive action in a new or resumed session in a multi-project workspace.
- Project-state requests: "check the work on X", "is GitHub up to date",
  "continue the launch", "where are we on X" — oblique names count ("the scanner").
- About to `find`/glob for a project whose canonical location should be recorded.
- About to start a broad audit with no defined scope.
- A session that changed durable project state is about to end (closeout half).

## When NOT to use

- Single-project repos where the task names its own files — orientation is one
  `git status`, not a procedure.
- Questions with no project-state component.
- Mid-session once oriented — re-run only after resume/compaction, or when
  evidence contradicts the map (`memory-hygiene` territory).

## The procedure

1. **Map before territory.** Read the workspace registry (`ACTIVE-PROJECTS.md` or
   whatever CLAUDE.md names) before any filesystem search or audit. Find the
   entry the request refers to.
2. **Trust order, stated:** live observed state > registry > memory files >
   recollection. The registry locates truth cheaply; it isn't truth. Live-verify
   any registry or memory fact that is load-bearing (the entry's verify commands,
   or `git status -sb` + a real `git fetch` at minimum).
3. **Canonical path or explain yourself.** Work happens in the registry-listed
   clone. Copies found in scratchpads, temp dirs, or other sessions' workspaces
   are never source of truth; using one requires saying so and why.
4. **"Updated/done/published" is a compound claim.** Check the parts and name
   which you checked: tree clean; local == origin after a fetch; CI at HEAD; and
   for releases: tag position, package registry, one consumer-side check (fresh
   install or raw URL). A subset checked = a subset claimed.
5. **Broad requests get scoped by the map:** registry pending list + the
   requester's emphasis, stated as an explicit scope — never an unbounded sweep.
6. **Closeout writes the map back.** Before ending a session that changed state:
   promote durable work out of scratchpad paths (they die with the session);
   update the registry entry (state, pending, pitfalls, date). A session that
   changed state but not the registry is unfinished. No registry yet and the
   workspace has outgrown one project? Creating a minimal one IS in scope.

7. **Verify the handoff — don't assume it. "Updated" ≠ "would survive a cold
   restart."** Before relying on the handoff (and always when asked "would this
   survive?"), simulate the cold-read: what does a fresh session load first
   (registry, auto-memory, git), and does it reconstruct the true current state and
   next steps — with NO stale/contradictory claims? Auto-memory drifts stale silently
   (it once asserted a result a later session had disproved); the registry can lag;
   work can sit unpushed. Actually check: registry current + has the next-steps,
   memory not contradicting live state, everything committed AND pushed. Fix what the
   cold-read would get wrong. Updating the map is not the same as testing that it works.

## Quality bar

- No filesystem search for anything the registry already locates.
- Load-bearing state claims carry their trust level and are live-verified before
  driving actions or assertions.
- No "updated/done" claim where only a subset of the compound check ran unnamed.
- Session end: no durable work stranded in scratchpads; touched registry entries
  current and dated.
- Handoff tested, not assumed: a cold-read reconstructs the true state + next steps
  with no stale/contradictory memory, and nothing is left unpushed.

## Common failure modes

- **Orientation theater:** reading the registry, then repeating it as verified
  fact. Run the verify line.
- **Registry rot:** entries nobody updates become traps — closeout is not
  optional; per-entry dates make staleness visible; live state always wins.
- **Scratchpad canonicalization:** adopting whatever copy a search finds first.
- **Audit-first instinct:** answering "is everything ok" by scanning everything
  instead of map → scope → audit the scope.

## Works with sibling skills

`live-state-truth` supplies step 2's verification reflex; `memory-hygiene` owns
memory-vs-observation conflicts; `intent-clarity` decodes which project an oblique
request means; surviving broad audits become `plan-gate` work; `publish-hygiene`
owns the public-boundary checks step 4 feeds into; `extract-approach` captures
lessons while this skill's closeout captures state — notes vs map.

## Provenance and maintenance

Added 2026-07-08 after a real failure: a session asked to "check the work" on a
project had to rediscover what it was, that its only clone sat in a dead session's
scratchpad, and which public surfaces were current — despite extensive memory
files. Root cause: state lived in narrative memory; nothing owned orientation.
Re-verify whenever a session re-derives facts a registry should have held: registry
existed but wasn't read → trigger failure; read but wrong → closeout failure.
