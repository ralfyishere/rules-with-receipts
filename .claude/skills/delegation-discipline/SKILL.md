---
name: Delegation Discipline
description: Delegate work to subagents, background tasks, or parallel workers effectively - and verify their outputs before relying on them. Activate when spawning agents, fanning out searches or reviews, orchestrating multi-agent workflows, running background tasks, or incorporating any output produced outside your own context. Trigger signals: "use agents for this", "fan out", "in parallel", a task too large for one context, or noticing you're about to restate a subagent's claim as your own finding.
---

# Delegation Discipline

## Purpose

Delegation multiplies throughput and divides accountability — unless discipline restores it. A subagent is a capable worker with *zero context you didn't give it* and outputs that are *claims, not facts* until checked. The two failure poles: trusting delegated output blindly (their confabulations become your confabulations, with your confidence attached), and delegating so vaguely the work comes back plausible-but-useless. This skill is the contract layer between you and your delegates.

## When to use this skill

- Before spawning any subagent, background task, or parallel worker.
- When incorporating delegated results into your own deliverable — the verification half applies even if someone else did the delegating.
- When a task exceeds one context window or one attention span: broad searches, multi-file audits, independent parallel workstreams.

## When NOT to use this skill

- Two-minute lookups you can do directly — delegation overhead (writing the brief, verifying the result) exceeds the task. Delegate work, not errands.
- Judgment calls that are the actual heart of the task (the architecture decision, the final recommendation). Delegate the *inputs* to judgment — research, enumeration, verification — not the judgment itself.

## Operating procedure

**1 — Decide whether to delegate.** Delegate when: work is independent and parallelizable; it's context-heavy exploration whose *conclusion* you need but whose details you don't; it would flood your context with material you'd only skim. Keep when: it's tightly coupled to your working state; the brief would be longer than the task; verifying the result costs more than producing it.

**2 — Write the brief as a contract.** A subagent knows nothing you don't tell it. The brief includes:
- **Goal** and why (one line of mission prevents a page of misfire).
- **Inputs:** exact paths, links, constraints — not "the config file" but which one.
- **Deliverable shape:** exactly what to return (a list of file:line findings; a table of options with tradeoffs; a yes/no with evidence). Vague deliverable specs return essays.
- **Done-criteria and boundaries:** what NOT to do (don't edit, don't fix, report only), scope limits, effort cap.
- **The authoritative evidence layer**, when the delegate judges something: which source wins on conflict (the diff over the narration, the data over the summary, the code over the report). Delegates drift toward the easiest-to-read evidence unless told which layer is truth.

**3 — Partition cleanly for parallel work.** One owner per artifact — never two agents writing to the same file or answering the same question in overlapping ways you'll have to reconcile. Slice by file, by module, by sub-question. Shared read is fine; shared write is a collision.

**4 — Verify delegated output like an external PR.** Proportional to stakes (`effort-calibration`), but never zero:
- **Spot-check claims against sources:** pick 2–3 load-bearing claims and check them yourself (open the file, run the command, read the cited passage). Subagents confabulate exactly like you do — fluently.
- **Check completeness against the brief:** did it cover the whole scope or silently truncate? "Reviewed the module" may mean three files of nine.
- **Cross-check overlaps:** where two delegates' outputs touch, do they agree on interfaces, terminology, counts?
- A delegated claim you didn't verify gets `verification-discipline` labeling when you pass it on: "per the search agent (not independently verified)".

**5 — Integrate deliberately.** Reconcile naming and assumptions across workstreams; resolve conflicts by evidence, not by whichever report you read last. The synthesis is *your* work — the part that can't be delegated.

**6 — Own the result.** Accountability doesn't fan out. "The agent got it wrong" is not a defense the user should ever hear; the verification step was yours.

## Quality bar

- Every brief specifies deliverable shape and boundaries — a stranger could execute it without asking questions.
- No delegated claim reached the user unverified *and* unlabeled.
- Parallel workers never collided on an artifact; integration reconciled their seams explicitly.
- Delegation net-saved effort — briefs and verification included.

## Common failure modes

- **Trust laundering:** subagent guesses → your summary states them as facts → user relies on them. The chain looks rigorous; nothing in it was checked.
- **The vague brief:** "look into the auth system" returns ten minutes of prose about the wrong thing. Deliverable-shape specs are the cure.
- **Judgment outsourcing:** delegating "decide which approach is best" and pasting the verdict. The delegate lacked your context; you lacked their reasoning; nobody actually decided.
- **Collision partitioning:** two agents "fixing" the same file, last-write-wins destroying the first fix.
- **Completeness assumption:** treating "here's what I found" as "here's all there is." Ask what was *not* covered; silent truncation reads as full coverage.
- **Errand delegation:** spawning an agent to read one file. The overhead exceeded the task before the brief was done.

## Example

Task: audit a 40-file module for uses of a deprecated API before removal.
Brief per agent (files partitioned 10/10/10/10): "Goal: find every call site of `legacyFetch()` so removal can be planned. Search these 10 files only. Return: `file:line`, the call's purpose in ≤1 line, and whether a direct swap to `fetchV2()` looks safe (yes/no/unsure). Do not edit anything. Report files you could not check."
Verification: spot-checked 3 reported call sites (all real), grepped one partition independently — agent's count matched. One agent reported 0 findings; independent grep of its partition confirmed (completeness check — 0 is the result most worth verifying). Integration: merged table, flagged the 4 "unsure" rows for human review, noted per-agent coverage. Total: 31 verified call sites; claim passed on as fact because it was checked.

## Works with sibling skills

- **`deep-decomposition`** produces the partitions; this skill turns them into contracts.
- **`adversarial-verify`** and **`live-state-truth`** power step 4 — delegated output is exactly the "finished work" those skills attack and ground.
- **`verification-discipline`** labels whatever you pass on unverified; **`scope-fence`** boundaries go *into* the brief ("report, don't fix").
- **`effort-calibration`** sizes the verification depth per stakes.

## Provenance and maintenance

Added 2026-07 in the expansion pass: agentic multi-worker execution is a first-class workflow with a first-class failure mode (unverified trust chains) that no core skill owned. No repo-specific claims. Re-verify by auditing a recent multi-agent task: pick two claims that came from delegates and trace whether anyone checked them before they reached the final output. If not, step 4 isn't biting.
