# Subagents can't test skill discovery
- **Problem:** Needed clean eval conditions; subagent "fresh" runs saw stale skill lists.
- **Context:** Claude Code — any eval or test of skill triggering.
- **What worked:** Fresh `claude -p` headless runs in isolated dirs outside the pack's tree.
- **What failed:** Agent-tool subagents — they inherit the parent session's skill snapshot from session start.
- **Decision rule:** Next time behavior-under-skills must be tested, use `claude -p` in a temp dir, never a subagent.
- **Verification:** Ask the session to list its available skills; compare against the directory contents.
- **Related skills:** [delegation-discipline], [live-state-truth]
- **Disposition:** learning-note
