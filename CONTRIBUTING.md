# Contributing

The highest-value contributions, in order:

1. **Replications.** Run the eval harness (`eval-results-v2/run-eval-v2.sh`) and report your numbers — especially if they disagree with ours. Include raw outputs and your model/version. Disconfirming evidence is welcome here, not defended against.
2. **New trap tests.** A test where baseline models fail and rules-bearing configs pass (or vice versa) is worth more than any new rule. Fixtures must be verified by execution; rubrics written before running.
3. **Skill improvements with evidence.** PRs that change a skill should say what failure the change prevents and, ideally, show a before/after run.
4. **Failure reports.** If a session with the pack installed did something the pack claims to prevent, open an issue with the transcript excerpt — these feed the learnings system.

House rules: keep the always-on snippet at ≤15 rules (something comes out for something to go in); run `scripts/check-pack.sh` before submitting; no claims without receipts — that includes ours.
