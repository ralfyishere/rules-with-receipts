# Batch eval outputs can be quota-limit stubs that pass empty-file checks
- **Problem:** 110 of 180 eval cells "completed" as non-empty files containing only "You've hit your session limit" — invisible to empty-file/error-file integrity checks; grading them as FAIL faked a huge advantage for whichever condition ran first.
- **Context:** any batch of `claude -p` runs on a rate-limited plan (evals, fan-outs, loops).
- **What worked:** `grep -l "hit your session limit"` over outputs; treating hits as NOT RUN and scoring on valid reps only; targeted re-run of only the discriminating cells after reset.
- **What failed / almost failed:** integrity scan checked emptiness and stderr but not stub content; medians computed over stubs were biased by run *order*.
- **Decision rule:** Next time batch outputs are graded, first grep every output for limit/error stub text and exclude those cells as NOT RUN; never let run order correlate with condition without checking quota headroom first.
- **Verification:** count valid cells per condition before grading — counts must be near-equal across conditions or the comparison is invalid.
- **Related skills:** [delegation-discipline], [live-state-truth], [verification-discipline]
- **Disposition:** learning-note (add a stub-check to run-eval-v2.sh if a third eval generation is built)
