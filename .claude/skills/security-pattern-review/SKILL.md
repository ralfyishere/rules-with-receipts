---
name: Security Pattern Review
description: Adversarially test any defensive pattern you ship before it ships. Activate when adding or reviewing an allowlist, denylist, suppression rule, detection regex, sanitizer, validator, guard, auth check, rate limit, or filter; writing a scanner or linter rule; shipping a security or validation heuristic. Trigger signals: "does this rule catch X", "is this pattern safe", "will this block the attack", a regex or matcher meant to keep something out. A guard that silently fails to bite is worse than no guard - it manufactures false assurance.
---

# Security Pattern Review

## Purpose

A guard that catches the textbook case but not its one-token variant is not a weak guard - it is a liability, because it manufactures false assurance while an attacker walks past. The recurring failure mode is authoring a defensive pattern and testing only that it catches the obvious payload, never that a determined attacker can trivially slip around it. This skill makes evasion testing a precondition of shipping: every allowlist, denylist, regex, sanitizer, or guard is attacked against known evasion classes before it ships, and any residual bypass is written down rather than left silent.

## When to use this skill

- Before shipping any allowlist, denylist, suppression rule, detection regex, sanitizer, validator, guard, auth check, rate limit, or filter.
- When reviewing someone else's defensive pattern or scanner/linter rule for coverage.
- Whenever the question is "does this rule catch X", "is this pattern safe", or "will this block the attack".
- Before relying on a CI security step or entrypoint guard - confirm it actually runs, don't trust a green check.

## When NOT to use this skill

- On patterns with no security or gate-keeping role - a display-formatting regex that fails open harms nothing.
- On throwaway or exploratory matchers the user explicitly asked for rough, that will not ship as a control.
- As a substitute for `live-state-truth`: reasoning that an input would trip the guard is weaker than running it. If the guard is executable, execute the evasion input against it.

## The procedure

**Step 1 - State the contract.** Write down exactly what the pattern MUST catch (the payloads it exists to stop) and exactly what it MUST allow (the benign inputs it must not break). A guard with no stated allow-set will be tuned into either uselessness or a denial-of-service.

**Step 2 - Enumerate the evasion classes for THIS pattern** (pick the ones that apply):
- **Append-a-token / wrap:** put the payload in a table cell, extra pipes, or surrounding markup so a naive "looks like a table" heuristic disables or downgrades the rule.
- **Affix bypass (unanchored allowlist):** a `docs.` prefix or `github.com.` suffix that matches attacker-controlled domains (`docs.evil.example`, `github.com.evil.example`) because the match was never boundary-anchored.
- **Reorder / multi-stage:** the dangerous action split or reordered across a pipeline (`curl x | tr ... | sh`) so a single-token match misses it.
- **Encoding / obfuscation / whitespace:** URL/base64/hex encoding, inserted whitespace or comments, homoglyphs, zero-width characters.
- **Case:** upper/lower/mixed case defeating a case-sensitive match.
- **The guard that never runs:** a CI step or entrypoint with no `__main__` guard, a script that exits before the check, a rule shadowed by an earlier one - it reports green because it never executed.

**Step 3 - Write one failing-input test per applicable class.** Each is an input that MUST still trip the guard, plus at least one benign input that MUST NOT trip it. These are concrete strings, not descriptions.

**Step 4 - Run them.** A crafted input that passes the guard is a finding, not a nuance. Do not rationalize it as an edge case the attacker "wouldn't bother with" - the whole point is that they would.

**Step 5 - Prove the guard can fail.** Confirm the guard actually executed and is capable of failing: feed it an input you KNOW is malicious and watch it fail loudly. A check that cannot produce a failure is not a check - it is decoration with a green light.

**Step 6 - Tighten and re-test, or ledger the residual.** Anchor the allowlist to boundaries, close the wrapper downgrade, add the missing `__main__` guard - then re-run the full class set. Any bypass you choose not to close is recorded explicitly (in the code comment, the PR, or a risk ledger) with its evasion class named. Silent residual bypasses are forbidden.

## Quality bar

- Every shipped guard has an evasion test for each applicable class - not just the happy-path payload.
- Allowlists and denylists are boundary-anchored; no affix (prefix/suffix) can smuggle an attacker string through.
- The guard is proven able to fail on a known-bad input, and proven to actually run.
- Every residual known bypass is ledgered with its class named; none is left silent.

## Common failure modes

- **Happy-path-only testing:** the guard catches the textbook case and misses the one-token variant, the wrapped payload, the reordered pipeline. If every test you wrote passes, you tested the wrong inputs.
- **Unanchored affix match:** `startswith("docs.")` or `endswith("github.com")` matching `docs.evil.example` / `github.com.evil.example`. Anchor to a full label/boundary.
- **A heuristic that disables a stronger rule:** table-detection turning off a HIGH pipe-to-shell rule; a "this looks like documentation" check suppressing a real match. The convenience heuristic became the bypass.
- **The never-run guard:** green CI, no output. A self-screen script with no `__main__` guard, a check shadowed by an earlier `exit`, a step whose failure is swallowed. Verify it produced output and can fail.
- **Disclosure without a test:** noting "this could be bypassed by X" in prose while shipping no test that pins X. An unpinned bypass regresses silently the next time the pattern is edited.

## Works with sibling skills

- **`adversarial-verify`** attacks your CONCLUSIONS and finished deliverable; this skill attacks the GUARD you built - the verifier itself - which adversarial-verify would otherwise trust.
- **`failure-mode-awareness`** enumerates how a DESIGN fails in general; this is its security-pattern specialization applied at ship time, with a concrete evasion catalog.
- **`empirical-validation`** measures efficacy claims; a guard's catch-rate is exactly such a claim, and step 4 here is the cheapest experiment that could falsify "this rule catches X".

## Provenance and maintenance

Added 2026-07-09 after an audit found the SAME scanner-heuristic bypasses shipped in two public tools (agent-zero-trust and rulebench share a design): a markdown-table / extra-pipe wrapper silently downgraded a HIGH pipe-to-shell rule to a gate-passing MEDIUM, and an unanchored `docs.` allowlist let `docs.evil.example` pass - both confirmed by live exploit; plus a CI "self-screen" that never ran because its script had no `__main__` guard, so it reported green without executing. Re-verify by trying one evasion variant against any newly added guard; if it passes and wasn't ledgered, this skill's trigger failed - add the class it missed to Step 2.
