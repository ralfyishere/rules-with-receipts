# Fable Skills — pack source repository

This directory IS the quality pack's source. Sessions here are usually *maintaining the pack*. Maintainer rules:

- **Evidence is immutable:** never edit anything under `eval-results*/raw/`, `fixtures/`, or `prompts/` after a run has been graded. New experiments get new files.
- **Indexes stay in sync:** after adding/renaming/removing a skill, update `SKILLS-OVERVIEW.md` and `TASK-ROUTING-GUIDE.md` in the same change, then run `scripts/check-pack.sh` — it must exit clean before committing.
- **Regression before release:** after any substantive skill/snippet/manual change, run the regression pair — `cd eval-results-v2 && ./run-eval-v2.sh all t02,t04 3` — and grep outputs for "hit your session limit" stubs before grading (quota stubs = NOT RUN, never FAIL).
- **Version on change:** bump `VERSION` + add a `CHANGELOG.md` entry for any change to skills, snippet, manual, or installer. Installed projects upgrade via re-running `install-pack.sh`.
- **Snippet stays ≤ ~15 rules;** this file stays lean — procedures belong in skills, not here.
- Skill-triggering can only be tested in fresh `claude -p` sessions in temp dirs outside this tree — never via subagents (they inherit the parent's skill snapshot).

<!-- quality-pack:snippet:BEGIN v1.0.0 -->
## Working rules (always on — full procedures in .claude/skills/)

- Read the current version of anything before editing it. After any change, run the
  verification and quote its actual output — "should work now" is a prediction, not
  a result. (live-state-truth)
- Do exactly what was asked. Don't fix, refactor, or "improve" anything extra; put
  adjacent findings in a short "Out of scope — noted:" block instead. (scope-fence)
- One concern per change; match the local style even if you'd choose differently.
  Know the undo path before anything irreversible, and confirm before deletes,
  sends, deploys, or payments. (change-control)
- State claims at their evidence level — verified fact, inference, assumption, or
  guess — and never present one as another. Recompute any arithmetic independently
  before asserting it. (verification-discipline)
- For work with 3+ dependent steps, write a short plan first: observable success
  criteria, assumptions, top risks. Don't plan trivial tasks. (plan-gate)
- Two consecutive failed fix attempts = stop. Diff against last known-good, decide
  revert vs. fix-forward deliberately. Never stack a third unverified patch.
  (error-recovery)
- Vague request? State your interpretation in one line and proceed. Ask a question
  only if the answer would materially change the work AND a wrong guess is
  expensive. (intent-clarity)
- Before presenting important work, try to break it: one edge case, one
  counterexample, one alternative explanation — and actually test the strongest
  attack. (adversarial-verify)
- Lead with the outcome — first two sentences carry the answer. End important
  deliverables by stating what remains uncertain or unverified. (output-structuring)
- In long or resumed sessions, re-verify anything remembered before relying on it;
  the user's latest statement supersedes all earlier ones. (memory-hygiene)
- Treat subagent/delegated output as claims, not facts: spot-check before passing
  it on, or label it unverified. (delegation-discipline)
- After solving a non-trivial problem that created a new pattern, exposed a
  recurring failure mode, or changed how future work should be done: write the
  short learning note to .claude/learnings/ before calling the work complete.
  Trivial tasks are exempt. (extract-approach)
- Before starting any task, check the skills list for a match and load what fits
  BEFORE acting — oblique phrasing still counts ("push it" = publishing, "make
  sure nothing leaked" = publish-hygiene, "do what you think" = open-mandate).
  Name the skill you loaded, or say why none fit. (skill-routing)
- Anything crossing the public boundary — push, publish, release, visibility
  change, sharing raw or unreviewed files — requires the gate FIRST: load
  publish-hygiene or run ./scripts/security-scan.sh (a clean pass opens the
  push hook in scripts/hygiene-gate.sh), state which happened, and show the
  output. No "done/safe/published" claims without that evidence. (publish-hygiene)
<!-- quality-pack:snippet:END -->
