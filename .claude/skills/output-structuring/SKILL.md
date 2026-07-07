---
name: Output Structuring
description: Present answers in the most usable format for the reader's next action - direct answer, table, checklist, numbered plan, executive summary, decision memo, email draft, prompt block, implementation plan, or critique. Activate when composing any substantial response, when a deliverable's format is unspecified, or when a draft has grown into a wall of text. Trigger signals: the user will scan rather than read, will act on the output, will forward it, or asked a question whose answer is currently buried in paragraph three.
---

# Output Structuring

## Purpose

Format is a usability decision, not decoration. The same content in the wrong shape fails: an answer buried under context goes unread; a narrative where a checklist was needed gets half-executed; a table forced onto nuanced tradeoffs amputates the nuance. Choose the format from one question: **what will the reader do with this, and what shape makes that action easiest?**

## When to use this skill

- Composing any substantial response or deliverable, especially when format wasn't specified.
- A draft has become a wall of text, or a single format is straining (a "table" whose cells hold paragraphs).
- The output will be scanned, forwarded, executed step-by-step, or used to make a decision — each implies a different shape.

## When NOT to use this skill

- Short conversational answers. A one-line question gets a one-line answer, not sections. Over-structure is a failure mode, not thoroughness.
- The user specified the format — deliver that, even if you'd have chosen differently.

## Operating procedure

**Step 1 — Identify the reader's next action.** Decide? Execute? Understand? Forward? Fix?

**Step 2 — Pick the primary format:**

| Format | Use when the reader will... | Key rule |
|---|---|---|
| **Direct answer** | Get one fact/verdict and move on | Answer in sentence one; context only if it changes the action |
| **Table** | Compare items across the same few attributes | Short enumerable cells; nuance goes in prose around it, never crammed in cells |
| **Checklist** | Verify or perform unordered items | Each item independently checkable, starts with a verb |
| **Numbered plan** | Execute steps in order | Order = dependency; each step has a done-condition |
| **Executive summary** | Decide whether to read further / brief someone | 3–6 sentences: situation, finding, recommendation. Never a teaser — the actual conclusions |
| **Decision memo** | Make a choice | Recommendation first, then options considered, criteria, risks, what would change the answer |
| **Email draft** | Send it | Ready to send verbatim: subject, right register, the ask explicit and early |
| **Prompt block** | Paste it into a tool | Fenced code block, zero commentary inside the fence, variables clearly marked |
| **Implementation plan** | Build it (or hand to someone who will) | Stages with outputs and done-checks (see `deep-decomposition`); risks and open questions separate from steps |
| **Critique** | Improve their work | Ranked by importance, specific locations, each point actionable; what's *good* stated too (so they keep it) |

**Step 3 — Apply the universal rules:**
- **Lead with the outcome.** Verdict/answer/recommendation in the first two sentences, in every format. Supporting material follows.
- **One primary format.** Others may nest inside it (a table inside a memo), but the reader should never wonder which part is the deliverable.
- **Structure for scanning:** informative headers (a header should carry content: "Rollback requires the v2 snapshot", not "Considerations"), bold for the load-bearing phrases, whitespace between ideas.
- **Prose where prose wins:** explanation, causality, and nuance read better as sentences than as fragment-bullets. Bullets enumerate; prose explains.

**Step 4 — Render, then scan-test.** Read only your headers, bold text, and first sentences. If that skim delivers the message, the structure works. If the key point lives in the middle of paragraph four, restructure.

## Quality bar

- A reader with 15 seconds gets the conclusion; a reader with 5 minutes gets the full reasoning; neither has to read twice.
- Format matches the next action (execution got numbered steps; comparison got a table; a decision got a recommendation-first memo).
- No structure for its own sake: every header, bullet, and table earns its formatting.

## Common failure modes

- **The buried lede:** three paragraphs of methodology before the answer. The reader asked a question; answer it, then justify.
- **Bullet shrapnel:** everything atomized into fragments, causality and flow destroyed. If the bullets need to be read in order to make sense, it wanted to be prose or a numbered plan.
- **Table torture:** paragraph-length cells, or tables for things with one attribute. Tables are for *comparison across identical dimensions*.
- **Teaser summaries:** an executive summary that says "we analyze three options" instead of "Option B — buy — is the recommendation because..." The summary *is* the memo for most readers.
- **Format ceremony on small answers:** headers, sections, and a summary for what needed two sentences.
- **Unforwardable drafts:** an "email draft" wrapped in meta-commentary the user must strip before sending. Deliver send-ready.

## Example

Question: "Which of these three libraries should we use for PDF generation?"

Wrong shape: 600 words of narrative walking through each library's history, verdict in the final sentence.

Right shape: "**Recommendation: library B.** It's the only one of the three that handles your right-to-left text requirement (verified in its docs), and its license permits commercial use." Then a 3×4 table (RTL support, license, maintenance activity, bundle size), then two sentences on when A would win instead. Decision first, comparison scannable, sensitivity noted.

## Works with sibling skills

- Runs near the end of the pipeline: substance is settled (`adversarial-verify`), then shaped here, then polished by **`ruthless-editor`**. If Pass 1 of ruthless-editor keeps fighting the format, return here — the format is wrong.
- **`intent-clarity`** supplies the reader and their next action; **`structured-reasoning`**'s outputs (matrices, tradeoffs) map directly onto the decision-memo and table formats.
- **`effort-calibration`**: format ceremony scales with tier — Low-tier answers are almost always direct answers.

## Provenance and maintenance

Written 2026-07 as part of a portable, project-agnostic quality pack. No repo-specific claims. Re-verify with the scan test on recent outputs: skim headers/bold/first-sentences of your last five substantial answers — if the message doesn't survive the skim, step 3 discipline is slipping. Add organization-specific formats (RFC template, ticket format) as new table rows.
