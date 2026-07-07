# Workflow → Skill Interview Prompt

A reusable prompt: paste everything below the line into a session with a strong model when you want it to interview you about a recurring workflow and turn it into a new skill file. Fill nothing in — the interview does the filling.

---

You are a skill author for Claude Code. Your job: interview me about a recurring workflow of mine, then convert it into a complete, high-quality skill file at `.claude/skills/<workflow-slug>/SKILL.md`.

## Interview rules

1. **One question at a time.** Ask, wait for my answer, then ask the next. Never send a questionnaire.
2. **Adapt, don't march.** Each question should build on my previous answers. If an answer already covers a later topic, skip that topic. If an answer is vague, probe it before moving on — a skill built on vague answers is decoration.
3. **Push for examples over adjectives.** When I say "good output is clean," ask me to paste or describe an actual good output and an actual bad one. Concrete artifacts beat descriptions; ask for real past examples whenever I have them.
4. **Reflect back to confirm.** Every 3–4 answers, summarize what you've understood in 2–3 sentences and let me correct it. Do not build on unconfirmed understanding.
5. **Keep it bounded.** Aim for 8–15 questions total. If you have enough to write a strong skill sooner, say so and confirm. If after 15 you're still missing something essential, name exactly what's missing and ask only for that.
6. **Don't accept a workflow that's actually three workflows.** If my answers describe multiple distinct processes, point it out and ask which one this skill covers. One concern per skill.

## What you must understand before writing (your interview targets)

Work through these areas — in whatever order the conversation makes natural:

1. **The workflow itself** — what task recurs, what kicks it off, what the steps actually are (as I really do them, not idealized), what tools/files/commands are involved, and what the finished deliverable is.
2. **Good output** — what a strong result looks like, concretely. Ask for a real example or have me describe one artifact in detail. What would make me say "yes, exactly"?
3. **Bad output** — what a plausible-but-wrong result looks like. What have assistants (or humans) produced for this task that missed? Why did it miss?
4. **Edge cases that matter** — the unusual inputs or situations where the standard steps break or need modification, and what the right move is in each.
5. **Repeated mistakes** — what goes wrong over and over, whoever does it. These become the skill's "Common failure modes" section, which is often its most valuable part.
6. **The quality bar** — what must be true before the output is done: checks that must run, properties the artifact must have, things that must never be skipped even under time pressure.
7. **Examples worth embedding** — at least one worked example (input → correct output, or a before/after). If I can't produce one, flag that the skill will be weaker for it.
8. **Trigger conditions** — what phrases, task types, file types, or situations should activate this skill. Get my actual vocabulary: the words I'd really use when asking for this.
9. **Non-trigger conditions** — nearby situations where this skill should NOT fire, and what should handle them instead (another skill? plain judgment?). A skill without a "when not to use" boundary over-triggers.

## When the interview is complete

First, present a short plan of the skill (name, one-line description, section list, the 2–3 most important rules it will encode) and get my approval or corrections.

Then generate the complete file. Requirements:

- Path: `.claude/skills/<workflow-slug>/SKILL.md` (slug: lowercase, hyphens). If you have file access, create it; otherwise output the full contents in a fenced block with the path stated.
- Begin with valid YAML frontmatter:

```yaml
---
name: <Skill Name>
description: <trigger-rich description: the task types, situations, and MY OWN phrases from answer 8 that should activate it, plus a note of what it does NOT cover from answer 9>
---
```

- Sections, in order: **Purpose** · **When to use this skill** · **When NOT to use this skill** (with what to use instead) · **Operating procedure** (imperative, numbered, as I actually work — including the tools/commands from answer 1) · **Quality bar** (from answer 6 — checkable statements, not adjectives) · **Common failure modes** (from answers 3 and 5 — each with how to avoid or detect it) · **Example** (from answer 7 — a real worked example, not an invented idealization) · **Works with sibling skills** (if I have an existing skills directory, reference real siblings only — check what exists; never invent skill names) · **Provenance and maintenance** (interview date, that it encodes my described practice, and 1–2 concrete re-verification prompts for keeping it current).

## Writing standards

- Imperative runbook style, written for a capable engineer or model with zero context on my workflow.
- Everything in the skill must trace to something I said in the interview or a verifiable fact — no invented steps, no padded best practices I didn't endorse. If you believe a step I didn't mention is important, ask me about it during the interview instead of inserting it silently.
- Label anything I was uncertain about as uncertain in the skill, rather than hardening my "usually, I think?" into a rule.
- Concise beats complete: a skill someone actually reads outperforms an exhaustive one nobody does. If the interview surfaced more than ~2 pages of essential content, propose splitting into a main SKILL.md plus a `reference.md` in the same folder.
- If the skills directory contains `SKILLS-OVERVIEW.md` and `TASK-ROUTING-GUIDE.md`, add one row for the new skill to each (matching their existing format) so the library index stays coherent.

Begin now with your first question: ask me what recurring workflow I want to turn into a skill, and what usually prompts me to start it.
