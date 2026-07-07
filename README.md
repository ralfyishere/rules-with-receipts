# Rules with Receipts

**A quality pack for Claude Code — 26 skills, an operating manual, and an always-on rules snippet — shipped with the eval harness and honest A/B numbers showing exactly what it does and doesn't change.**

Every agent rules file you've seen ships on vibes: "makes your agent 10x better," zero evidence. This one ships with receipts. We built two generations of trap-prompt evals, ran them across five install configurations in fresh isolated sessions, rubric-graded them, and published the raw outputs — including the findings that don't flatter us.

## The honest headline

- **Baseline models are already strong.** Plain Opus 4.8 passed ~90% of our own trap tests unaided. Anyone claiming their rules file transforms model intelligence should show you their receipts.
- **What the pack measurably changes is discipline under temptation:** in our multi-step evals, the full install was the only configuration to pass the scope-control trap 3/3 — minimal diff *plus* the adjacent bug flagged instead of silently "fixed" — while other configs missed the flag or made unrequested changes (one even claimed "no other code touched" while its own diff showed a deleted file).
- **The always-on snippet, not the skills alone, carries that effect.** Skills-only installs missed the flag in every rep of both eval generations. Rules that must apply *inside* every task have to live in `CLAUDE.md`, always in context.

Full numbers, rubrics, raw session outputs, and limitations: [`eval-results-v2/SCORES.md`](eval-results-v2/SCORES.md) · [`HARD-FAILURE-ANALYSIS.md`](eval-results-v2/HARD-FAILURE-ANALYSIS.md). Caveats included: small n outside the replicated tests, and graders share an author with the pack — everything needed for an independent regrade is in the repo.

## What's inside

| Layer | What it does |
|---|---|
| [`.claude/skills/`](.claude/skills/) — 26 skills | Trigger-based procedures: planning gates, debugging playbook, scope fencing, adversarial self-review, error recovery, delegation verification, and more. Catalog: [`SKILLS-OVERVIEW.md`](.claude/skills/SKILLS-OVERVIEW.md) |
| [12 always-on rules](.claude/skills/CLAUDE-MD-SNIPPET.md) | The proven layer: read-before-edit, quote-your-verification, two-strike error recovery, flag-don't-fix |
| [Operating manual](.claude/FUTURE-MODEL-OPERATING-MANUAL.md) | The habits condensed into one paste-able document |
| [Operator guide](.claude/OPERATOR-GUIDE.md) | For humans: warning signs → exact intervention phrases, plus a second-opinion review prompt |
| [Exemplars](.claude/exemplars/) | Real rubric-graded PASS outputs — what "good" looks like, verbatim |
| Compounding layer | [Learnings system](.claude/learnings/README.md), [context-folder guide](.claude/CONTEXT-SYSTEM-SETUP.md), [bounded goal templates](.claude/GOAL-TEMPLATES.md), [skill-interview prompt](.claude/WORKFLOW-SKILL-INTERVIEW-PROMPT.md) |
| [`eval-results/`](eval-results/) + [`eval-results-v2/`](eval-results-v2/) | The receipts: harnesses, fixtures, prompts, rubrics, raw outputs, scores |

## Install

```bash
git clone https://github.com/ralfyishere/rules-with-receipts.git
cd rules-with-receipts
./install-pack.sh /path/to/your/project
```

Idempotent, versioned, never overwrites without a backup. Details: [`INSTALL.md`](INSTALL.md) · fastest path: [`QUICK-START.md`](QUICK-START.md)

Verify it took: open a fresh session in your project and ask *"list the skills available to you."* Then ask for a small code change and watch whether it runs the verification and quotes the output unprompted — that's the snippet working.

## Test it yourself (please do)

The whole point is falsifiability:

```bash
cd eval-results-v2
./run-eval-v2.sh A,E t04 3   # baseline vs full install on the scope-control trap
```

Fresh isolated sessions per cell, fixtures verified by execution, rubrics written before grading. If you get different numbers, open an issue with your raw outputs — a disconfirming replication is a first-class contribution here (see [`CONTRIBUTING.md`](CONTRIBUTING.md)).

## Provenance

Authored by Claude (Fable 5) sessions in collaboration with a human maintainer; evaluated against Claude Opus 4.8 as the target model. The pack transfers *process* — planning, verification, scope, and recovery habits — and claims nothing about changing model capability. It does not reproduce, extract, or imitate any model's internals; it's an engineering-productivity layer, with the evidence to show exactly how far that goes.

Roadmap: a standalone, config-driven version of the eval harness — point it at *any* rules file and get behavior deltas — is next. Watch the repo.

## License

MIT — see [`LICENSE`](LICENSE).
