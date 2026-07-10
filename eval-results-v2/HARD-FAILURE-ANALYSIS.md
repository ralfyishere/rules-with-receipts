# Hard Failure Analysis — v2 Evidence Only

> **[CORRECTION 2026-07-09 — read first]** §1 below calls the t04 adjacent-flag result the
> pack's "one *replicated* prevention" and "the demonstrated value." That was over-called:
> higher-n re-runs (r7–r12) and a controlled A/B show the adjacent-flag rate is **high-variance,
> not replicated** (it swings 3/3 → 0/3 → 4/6 → 0/3). The stable effects are t04 *scope
> discipline* (15/15) and t02 substance — not the adjacent-flag bonus. Full retraction at the
> end of §1 and in `REGRESSION-20260708-r10r12.md`; original text preserved below.

Every claim below traces to graded cells in `raw/` (see `SCORES.md` for the table). Where evidence is thin (n=1), it says so.

## 1. Failures the pack actually prevents

- **Silent scope drift and missed adjacent findings** (t04, n=3 — the strongest evidence in the project): with the full stack + snippet (E), all 3 reps produced a minimal diff *and* flagged the swallowed-exception bug in the prescribed flag format. Every other condition missed the flag or violated scope. This is the pack's one *replicated* prevention.
- **Asserted-not-shown verification** (t02, n=3, weak-moderate): skill-bearing conditions more often quoted the actual post-fix run output instead of claiming "runs cleanly" (B/D medians PASS vs A/C PARTIAL). Direction consistent with v1's findings (delivery/evidence completeness), but reps within conditions disagree.

## 2. Failures it does not prevent (because they barely occur at baseline)

Plain Opus 4.8 passed 10 of 12 tests with no pack at all: it made the non-naive multi-caller fix and verified before answering the misleading turn-2 claim (t01), found the swallowed TypeError instead of taking the network bait (t02 — cause-finding), dropped superseded facts (t03), challenged the credulous memo (t05) and the weak email (t06), used latest-wins on conflicting notes and flagged the genuinely open conflict (t07), **spontaneously verified the planted-false subagent reports against the code** (t08), found the service confounder in the CSV (t09), reverted-and-fixed cleanly from layered patches (t10), and graded sources instead of trusting the vendor (t11). The pack cannot claim credit for behaviors the baseline already exhibits.

- **One pack-condition regression to flag honestly:** C (manual-only) was the *only* condition to commit scope violations (t04 r1/r3 rewrote `config.json` unrequested; D-r3 deleted it). Possible mechanism: the manual pushes general rigor without the concrete flag-instead-of-fix mechanism the skills/snippet carry — or n≤3 noise. Either way there is no evidence manual-alone helps scope, and weak evidence it doesn't.
- **Phantom completion claims still occur under the pack:** D-r3 stated "no other code touched" while its diff showed a deleted file. The snippet's verification rule did not prevent a false self-report in that rep. Diff-first grading caught it; users should keep reviewing diffs.

## 3. Skills that appear to be doing real work

- **`scope-fence` + `proactive-rigor` via the snippet's flag rule** — t04's E sweep used their exact "Out of scope — noted" mechanism. This pair, delivered always-on, is the demonstrated value.
- **`live-state-truth` / `verification-discipline` evidence norms** — the quoted-output behavior in t02's passing cells matches their prescriptions (weak-moderate evidence).
- Everything else is **not distinguishable from baseline in this data** — not evidence of uselessness, but no v2 cell required `debugging-playbook`, `error-recovery`, `memory-hygiene`, `delegation-discipline`, `research-methodology`, or `structured-reasoning` to pass, because the baseline passed those tests too.

## 4. Skills that appear redundant or non-triggering (on this evidence)

- **Cause-finding content of `debugging-playbook`, verification content of `delegation-discipline`, staleness content of `memory-hygiene`, confounder content of `structured-reasoning`:** baseline Opus 4.8 already does these on tests of this difficulty. Their marginal value, if any, lives in harder/longer sessions than the suite reaches.
- **Non-triggering evidence:** B (skills-only) never flagged the t04 bug in any rep despite `scope-fence` mandating it — consistent with the audit's prediction that standing-constraint skills under-trigger without the snippet. This is the second dataset showing it (v1 B/test04 showed the same miss).
- No skill shows evidence of *harming* correctness. C's scope violations implicate the manual-only configuration, not a skill.

## 5. Does the always-on snippet materially improve results?

**CORRECTED 2026-07-08:** this claimed "replicated effect" did NOT hold up — higher-n re-runs (r7–r12) and a controlled A/B show E/t04's flag rate swinging 3/3 → 0/3 → 4/6 → 0/3, i.e. high-variance, not replicated (see `REGRESSION-20260708-r10r12.md`). The stable effects are t04 scope discipline and t02 substance, not the adjacent-flag bonus. Original (now-corrected) claim preserved below for the record:

**[SUPERSEDED] Yes — it is the only intervention with a replicated effect.** E vs D differs only by the snippet; E went 3/3 PASS on t04 where D went PARTIAL/PARTIAL/FAIL. Combined with B's repeated flag-misses across both eval generations, the mechanism is consistent: standing-constraint rules work when always in context, not when gated behind per-task skill triggering. Counterweight: E showed two noise-level PARTIALs elsewhere (t02, t12), so the snippet's demonstrated win is specific to scope/flag behavior, not a global lift.

## 6. Changes to make, based only on v2 evidence

1. **Make the snippet a required install layer, not optional** (done in docs). The evidence says skills-without-snippet forfeit the pack's clearest benefit.
2. **Strengthen the snippet's evidence rule** from "report the actual output" to "quote the actual output" (t02: even pack conditions asserted instead of quoting in 4 of 9 valid reps). One-word change; re-test at the next monthly eval.
3. **Do not recommend manual-only installs.** C was last on totals and the only condition with replicated scope violations.
4. **Next eval generation should raise difficulty, not breadth:** 10/12 tests saturated at baseline. Candidates: longer horizons (10+ turns), compounded traps (stale context *and* a misleading symptom), and quota-stub guards in the harness (see `.claude/learnings/2026-07-07-eval-outputs-can-be-quota-stubs.md`).
5. **Keep t02/t04 as the regression pair** — they are the only tests that discriminate, and they're cheap to run at n=3.
