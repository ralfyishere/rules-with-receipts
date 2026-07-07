# How to Use This Skill Pack with Opus 4.8

A practical guide to installing, testing, and getting value from the pack in Claude Code sessions running Opus 4.8 (or any Claude model — nothing here is version-locked).

## What this pack is (and is not)

**Is:** a process-quality layer — planning discipline, verification habits, scope control, editing rigor — encoded as skills the model can load when the task matches.

**Is not:** an upgrade to the model's raw intelligence, knowledge, or context window. These skills improve *how* work gets done: fewer skipped verifications, fewer scope surprises, better-structured output. A hard problem that exceeds the model's capability stays hard. Do not expect, or describe, these skills as making one model equivalent to another.

## Installing

**Per-project:** copy the `.claude/skills/` directory into any project root. Claude Code discovers `SKILL.md` files under `.claude/skills/<slug>/` automatically.

**Everywhere (all your projects):** copy the skill folders into `~/.claude/skills/` instead — personal skills are available across all sessions.

**Checking discovery:** in a session in the project, ask Claude "list the skills available to you" or "which of your skills would apply to fixing a bug?" — the skill names from this pack should appear. If they don't, verify the path is exactly `.claude/skills/<slug>/SKILL.md` and the YAML frontmatter is intact (three-dash fences, `name:` and `description:` keys).

**The always-on layer (important):** skills trigger per-task, which under-serves *standing constraints* — rules like "run it before claiming it works" that apply inside every task rather than to a kind of task. For those, paste the block from `CLAUDE-MD-SNIPPET.md` into your project's `CLAUDE.md` — it keeps the ten load-bearing rules permanently in context, with the skills as the deep procedure behind each. Snippet + skills together is the intended installation; skills alone will under-deliver on the standing constraints.

## Testing whether the skills are working

Skills activate when the task matches their `description`. To smoke-test:

1. **Trigger test:** give a matching task — "I have a failing test, can you fix it?" — and watch whether the behavior follows the skill (asks for/finds the verbatim error, reproduces before diagnosing) rather than jumping to a guess-fix.
2. **Explicit test:** name it — "use the debugging-playbook skill on this." Explicit invocation should always work; if it does but implicit triggering doesn't, the `description` may need more of your vocabulary in it (see Maintenance).
3. **Negative test:** ask something trivial ("what does HTTP 304 mean?") and confirm you get a two-sentence answer, *not* a plan and a checklist. Over-triggering is a real failure; `effort-calibration` and each skill's "When NOT to use" section are the guard.

## Invoking naturally

You rarely need skill names. These phrasings reliably engage the right ones:

- "**Plan first**, then implement" → `plan-gate`
- "**This is important / production / get it right**" → `frontier-workflow-mode`
- "**Verify that** / don't just tell me it works, **show me**" → `live-state-truth`
- "**Try to poke holes** in this before you give it to me" → `adversarial-verify`
- "**Just fix exactly this**, nothing else" → `scope-fence`
- "**Tighten this up**" → `ruthless-editor`
- "**What could go wrong** with this approach?" → `failure-mode-awareness`
- "**Quick and rough is fine**" → suppresses the heavy skills (this is a feature — honor it)

## Suggested usage patterns by domain

**Coding.** Let the routing run (`TASK-ROUTING-GUIDE.md` covers bugs, features, refactors, migrations). The habit that pays most: end every change request with "run it and show me the output" until `live-state-truth` behavior is the default you observe.

**Writing.** State the audience and their decision in the request ("summary for the board — they care about runway"). That single sentence powers `intent-clarity`, `output-structuring`, and `ruthless-editor` better than any invocation.

**Research.** Ask for graded claims: "distinguish what's verified from what's inferred." Then ask the follow-up the pack trains for: "what would make this conclusion wrong?"

**Business strategy.** Request the frame explicitly when you know it: "run this as a risk/reward analysis with a steelman of the do-nothing option." Ask for the sensitivity note ("what would flip this recommendation?") — it's the most reusable part of any analysis.

**Debugging.** Paste errors verbatim and complete, never paraphrased. Ask for the hypothesis table when the bug is gnarly — it keeps long debugging sessions from circling. If a session starts patch-stacking ("now something else broke"), invoke `error-recovery` by name — the two-strike stop rule is the highest-value intervention in a failing session.

**Agentic work.** When fanning tasks out to subagents, ask for contract-grade briefs and spot-check verification of results (`delegation-discipline`) — delegated claims are the easiest place for confabulation to slip through a rigorous-looking pipeline.

## Recommended effort settings

- Let `effort-calibration` tier tasks by default; override with explicit signals ("quick pass" / "be thorough") when you know better than the signals do.
- In Claude Code, extended thinking plus this pack compound well on High/Critical tasks: thinking depth improves the reasoning, the pack ensures the reasoning gets verified. On Low-tier tasks, neither is needed.
- If you find sessions over-planning small tasks, say "skip the plan for small stuff" once — `self-improvement-loop` + `memory-hygiene` should persist that as a preference.

## Limitations (read this)

- **Process, not intelligence.** The pack reduces *unforced* errors — skipped verification, scope drift, buried conclusions. It does not expand what the model fundamentally can solve, know, or fit in context.
- **Skills are guidance, not guarantees.** A skill's presence makes its behavior likely, not certain. High-stakes work still deserves your review — the pack makes that review faster (labeled claims, stated assumptions), not unnecessary.
- **Trigger quality varies with your vocabulary.** Descriptions were written to common phrasings; if your team says "post-mortem the diff" instead of "review the change", add your phrases to the relevant `description` fields.
- **Standing constraints don't trigger reliably as skills.** Mid-task disciplines (scope, verification, memory) fire on situations, not task descriptions. The `CLAUDE-MD-SNIPPET.md` block exists for exactly this — install it; don't rely on skill triggering alone for the always-on rules.
- **Overhead is real.** Full-rigor mode on trivial tasks wastes time and tokens. The pack self-limits via `effort-calibration` and per-skill "When NOT to use" sections, but if you see ceremony on trivia, that's a bug — tune those sections.
- **The pack ages.** Its claims about tools and workflow are current as of 2026-07. Re-verify the installation instructions against current Claude Code docs when onboarding a new setup.

## When you doubt an output

`.claude/OPERATOR-GUIDE.md` is the user-side companion: warning signs mapped to exact intervention phrases, plus a second-opinion review prompt to run in a fresh session on anything that matters. And `.claude/exemplars/` holds real graded-PASS artifacts — when unsure what "good" looks like for a task type, match the exemplar's shape.

## The compounding layer

Skills improve single sessions; four small companions make sessions leave assets behind:
- **`.claude/learnings/`** — short reusable notes written by the `extract-approach` skill after hard problems. Read before similar work; prune weekly.
- **`.claude/CONTEXT-SYSTEM-SETUP.md`** — sets up a `claude-context/` folder that gives sessions your business and priorities. The pack improves behavior; context supplies your world. Keep them separate.
- **`.claude/GOAL-TEMPLATES.md`** — bounded goal-prompt patterns (finish line, proof, caps, allowed files) for handing out objectives safely.
- **`.claude/WORKFLOW-EXTRACTION-QUEUE.md`** — recurring workflows queued for promotion into custom skills via the interview prompt.
Upkeep for all of it: `.claude/MAINTENANCE-CADENCE.md`.

## Provenance and maintenance

Part of the portable quality pack (2026-07). Installation claims (paths, discovery) should be re-verified against current Claude Code documentation periodically — mechanisms evolve. Maintenance loop: when a skill misfires (didn't trigger, or triggered when it shouldn't), edit that skill's `description` (for triggering) or its "When (NOT) to use" sections (for scope); when work fails in a way no skill covers, consider a new skill folder — one concern per skill.
