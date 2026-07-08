# Release Checklist

Every release of the quality pack goes through this list — no exceptions, no
partial releases. **AUTO** items are enforced by `scripts/make-release-bundle.sh`
(it refuses to bundle if they fail); **MANUAL** items are judgment calls the
release runner performs and attests to in the release notes. The goal: every
version preserves portability, hygiene, closeout, and evidence discipline —
a release that weakens a gate is a regression even if every feature works.

## The release run (in order)

```bash
# in the pack source repo, after the release commit:
./scripts/check-pack.sh                      # source mode
./scripts/closeout-check.sh                  # source mode
git push                                     # pre-push re-runs closeout + scan
./scripts/mirror-public.sh <public-clone>    # sync; review drift report
# commit + push the public clone (gates apply there too)
./scripts/make-release-bundle.sh             # runs every AUTO item below, then bundles
```

## Items

| # | Item | How verified |
|---|---|---|
| 1 | VERSION bumped | AUTO — bundle refuses to rebuild an existing `dist/quality-pack-v<VERSION>` (FORCE=1 documented-override only) |
| 2 | CHANGELOG updated | AUTO — closeout: top entry must equal VERSION |
| 3 | PACK-MANIFEST updated | AUTO — closeout: every shipped script present in the manifest, source and public |
| 4 | install-pack.sh tested on a fresh repo | AUTO — `scripts/release-test.sh` installs from the fresh public clone into a temp git repo |
| 5 | bootstrap.sh serves from the public URL | AUTO — bundle curls the raw GitHub URL and byte-compares against the clone's copy |
| 6 | check-pack passes (source mode) | AUTO — bundle gate |
| 7 | closeout passes, source + vs fresh public clone | AUTO — bundle gate |
| 8 | security-scan passes | AUTO — bundle gate (fresh pass, not a stale marker) |
| 9 | test-hygiene-gate passes | AUTO — bundle gate, run in source AND inside the release-test target |
| 10 | Cold start proves skills / rules / hooks / gate-block / scan-open / closeout / upgrade-preservation | AUTO — `scripts/release-test.sh` (exit codes captured); the live `claude -p` skill-discovery check is MANUAL (needs auth + quota — run it, or state it wasn't run) |
| 11 | Portability grep: zero private paths, usernames, hostnames, tokens, private repo names, business context | AUTO — bundle tree grep + release-test grep of the installed tree |
| 12 | Public/private boundary reviewed | MANUAL — read the mirror drift report and closeout's intentional-divergence list; anything newly shared or newly private gets a manifest row and a changelog line |
| 13 | Release notes state what was checked, what was not, and remaining limits | MANUAL — the done-claim discipline applies to releases too; "everything passed" without the not-checked list is an invalid release note |

## Failure protocol

Any AUTO failure: fix, re-run from the top of the release run (not from the
failed step — earlier steps may have been invalidated by the fix). Any MANUAL
item skipped: say so in the release notes, or the release doesn't ship.
