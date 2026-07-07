---
name: Prompt Engineering
description: Improve prompts, system prompts, and agent instructions systematically - with test cases, failure diagnosis, and one-change-at-a-time iteration instead of vibe edits. Activate for "improve this prompt", "the model keeps doing X wrong", "write a system prompt", "make the agent stop doing Y", prompt templates, and instruction files for AI tools. Trigger signal: any prompt edit about to happen without a concrete example of the failing (or desired) behavior in hand.
---

# Prompt Engineering

## Purpose

A prompt is a program whose runtime is a model: it has specifiable behavior, test cases, regressions, and bugs. Most prompt "improvement" is vibe-editing — adding emphasis and adjectives without a single concrete failing example in hand, then declaring the result better without running it. This skill imposes the engineering loop: specify behavior → diagnose the actual failure → make one precise change → test against cases → keep versions.

## When to use this skill

- Improving an existing prompt, especially "the model keeps doing X" complaints.
- Writing new system prompts, agent instructions, or reusable templates where behavior matters and the prompt will run many times.
- Reviewing a prompt that has accreted patches ("ALWAYS do A. NEVER do B. IMPORTANT: remember A...").

## When NOT to use this skill

- One-off conversational asks — just ask well; the loop's overhead needs reuse to pay off.
- When the problem is the task, not the prompt: if the model lacks the information or capability, no wording fixes it — restructure the task (provide the context, split the steps, add tools) instead of engineering the incantation.

## Operating procedure

**1 — Specify behavior with test cases first.** Before touching the prompt, write 3–5 concrete cases: input → desired output (or desired *property* of output). Include: the reported failing case, a normal case that currently works (your regression guard), and one edge case (empty/hostile/ambiguous input). No test cases = no way to know the edit helped.

**2 — Diagnose from actual failures, not descriptions of them.** Get the real failing outputs (`live-state-truth`: run the prompt if you can). Classify the failure:

| Failure class | Signature | Fix direction |
|---|---|---|
| **Ambiguity** | Model does a *reasonable* other thing | Define the term; add the disambiguating example |
| **Missing context** | Model invents what it wasn't given | Provide the facts/data in the prompt, don't demand the model "be accurate" |
| **Conflicting instructions** | Behavior flips between runs; late instructions ignored | Find and resolve the conflict — don't add a third instruction to arbitrate two |
| **Underspecified format** | Content right, shape wrong/inconsistent | Show the format: a literal example output beats three sentences describing it |
| **Buried instruction** | Long prompt; the violated rule is in the middle | Restructure: critical constraints near the top, grouped, deduplicated |
| **Capability gap** | Fails all wordings of the same demand | Restructure the task (steps, tools, context) — see "When NOT" |

**3 — Edit with precision, not emphasis.** The core discipline:
- **Specific beats emphatic.** "IMPORTANT!! be concise" loses to "answer in ≤3 sentences unless asked to elaborate." Reaching for caps, bold, or "CRITICAL" is the signal to restructure instead — emphasis is what you add when the instruction itself is vague.
- **Show, don't only tell:** one worked example for anything format-critical or judgment-critical. Examples are the highest-leverage tokens in most prompts.
- **Positive over negative where possible:** "cite a source for each claim" beats "don't make things up" — prohibitions leave the target behavior undefined.
- **Every sentence earns its place:** instructions the model already follows by default are noise that dilutes the ones it doesn't.
- **State priority for genuine conflicts:** if brevity and completeness will collide, say which wins, or the model decides per-run.

**4 — One change at a time when debugging behavior** (`change-control` for prompts): batch edits that "fix" the failure leave you not knowing which change did it — or which one broke the other case.

**5 — Test against the cases from step 1** — the failing case (fixed?), the working case (still works?), the edge case. For high-volume prompts, multiple runs: single-run success on a stochastic system is anecdote, not verification.

**6 — Version and annotate.** Keep the prior version; note what each change fixed ("v3: added output example — fixed inconsistent JSON keys"). Prompt history without annotations becomes archaeology.

## Quality bar

- Test cases existed before the edit; the edit is judged by them, not by whether it reads better.
- The diagnosis names a failure class from actual outputs, not a guess from the complaint.
- The revised prompt contains no emphasis-inflation (stacked caps/IMPORTANT/ALWAYS) standing in for specificity.
- Regression checked: the previously-working case still works.

## Common failure modes

- **Vibe-editing:** rewriting for elegance with zero failing examples in hand; "improved" is asserted, never measured.
- **Emphasis inflation:** each failure adds another "VERY IMPORTANT" — the prompt becomes a shouting match with itself, and every instruction dilutes every other.
- **Instruction pileup:** patches accreting until they conflict; nobody deletes. Prompts need pruning passes like code needs refactoring.
- **Overfitting to the complaint:** fixing the one reported case with a hyper-specific rule that degrades general behavior — the regression case in step 1 catches this.
- **Persona padding:** "You are a world-class expert with 20 years..." as the *entire* improvement. Framing has its uses; it doesn't substitute for specified behavior.
- **Testing in your head:** predicting the model's response to the new prompt instead of running it. Predictions about stochastic systems are exactly the guesses `live-state-truth` bans.

## Example

Complaint: "The summary prompt keeps producing bullet lists; we need prose paragraphs."
Test cases: the failing doc; a short doc that already summarizes fine; an edge (doc that is itself a bullet list). Actual output collected: bullets appear when the *source* has bullets — diagnosis: underspecified format + ambient mimicry, not disobedience. One change: add a two-sentence literal example of the desired prose output and the line "write flowing prose paragraphs even when the source uses bullets." Test: failing case → prose ✓; regression case → still good ✓; bullet-list source → prose ✓. Versioned: "v2: literal prose example — fixed format mimicry."

## Works with sibling skills

- **`change-control`** (one change, versions kept) and **`live-state-truth`** (run it, don't predict it) are load-bearing throughout.
- **`ruthless-editor`** polishes instruction wording — but here precision-per-word outranks brevity-per-word; cut only what tests confirm was inert.
- **`adversarial-verify`** stress-tests the finished prompt: "what input still breaks this?"
- **`intent-clarity`** decodes what behavior the prompt's *owner* actually wants — often different from the literal complaint.

## Provenance and maintenance

Added 2026-07 in the expansion pass: prompt improvement is a recurring, high-value task the routing guide previously served with a composite of general skills; the test-case loop and failure taxonomy are specific enough to earn a dedicated owner. Practices are standard prompt-engineering craft, not claims about any particular model's internals. Re-verify by auditing recent prompt edits: if any shipped without a before/after test run, step 5 isn't enforced.
