# Controlled A/B: the 15th snippet rule DILUTED the proven t04 win — confirmed

**Run:** 2026-07-08 · `ab-snippet-t04.sh 6` · model `claude-opus-4-8` · t04 · n=6/arm,
interleaved, 0 stubs. Raw: `raw-ab-snippet-20260708/{E14,E15}/`.

**Design:** identical condition E (skills + manual + snippet), current pack, current
`.claude/skills` INCLUDING the session-orientation SKILL file. The ONLY difference:
- **E15** = current shipped 15-rule snippet (includes the session-orientation always-on rule)
- **E14** = same snippet with the session-orientation rule removed (14 rules)
Verified the two snippets differ by exactly one rule (15 vs 14; 0 session-orientation
mentions in E14). This isolates the RULE's effect on the "flag the adjacent silent-
`except` bug in prose" behavior — the discriminator that defines a t04 PASS.

## Result — flag rate of the silent-`except` bug (the discriminator)

| arm | flagged the bug | reps | flag rate |
|---|---|---|---|
| **E14** (14-rule, rule removed) | r2, r4, r5, r6 | 6 | **4/6** |
| **E15** (15-rule, shipped) | r6 only (r4 raised it but dismissed it as "useful") | 6 | **1/6** |

Corroborated by the historical natural split (same discriminator):
- 14-rule snippet (E, r1–r6, pre-this-session): flagged ~5/6
- 15-rule snippet (E, r7–r9, this session): flagged 0/3
- **Pooled: 14-rule ≈ 9/12 flag; 15-rule ≈ 1/9 flag.** Strong, replicated, one direction.

Scope discipline (clean `cli.py` diff) held in both arms; a few config.json
test-hygiene artifacts appeared in BOTH arms (unrelated to the snippet).

## Conclusion

**The session-orientation always-on rule I added this session caused the regression**
in condition E's replicated t04 win. Removing it restores the flagging behavior
(~4× the flag rate). The skill still activates reliably WITHOUT the rule (trigger-eval
t08/t09 6/6), so the rule was cost without benefit for activation.

## Decision (pre-agreed criterion met): DROP the 15th rule, keep the skill

- Remove the session-orientation bullet from `CLAUDE-MD-SNIPPET.md` and the CLAUDE.md
  managed block → snippet returns to its proven 14-rule form.
- Keep the `session-orientation` SKILL + its routing/manifest entries (activation proven).
- Update the "15 rules" references (README) back to 14.
- Possible future refinement (not now): a TERSER 1–2 line orientation rule might preserve
  an always-on reflex without the dilution — would need its own A/B before shipping.
