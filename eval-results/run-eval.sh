#!/bin/bash
# Four-condition eval harness for the quality pack.
#
# Conditions:
#   A  plain            - empty dir: no skills, no manual
#   B  skills only      - .claude/skills/ copy
#   C  manual only      - FUTURE-MODEL-OPERATING-MANUAL.md as CLAUDE.md
#   D  both             - skills copy + manual as CLAUDE.md
#
# Usage:
#   ./run-eval.sh                # all conditions, all prompts in ./prompts
#   ./run-eval.sh A,C            # subset of conditions
#   ./run-eval.sh all test01     # one test across all conditions
#
# IMPORTANT: env dirs are created OUTSIDE any tree containing the pack,
# so Condition A cannot discover the skills via ancestor .claude/ lookup.
# Plugins/user-level settings apply equally to all conditions (constant, not a bias).

set -u
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PACK_ROOT="$(dirname "$SCRIPT_DIR")"            # the project containing .claude/
MODEL="${MODEL:-claude-opus-4-8}"
CONCURRENCY="${CONCURRENCY:-5}"
TIMEOUT_S="${TIMEOUT_S:-300}"
ENV_BASE="${ENV_BASE:-$(mktemp -d /tmp/pack-eval-XXXXXX)}"
RAW="$SCRIPT_DIR/raw"

CONDS="${1:-A,B,C,D}"; [ "$CONDS" = "all" ] && CONDS="A,B,C,D"
ONLY_TEST="${2:-all}"

# --- build isolated condition environments -----------------------------------
build_envs() {
  for c in A B C D; do rm -rf "$ENV_BASE/$c"; mkdir -p "$ENV_BASE/$c"; done
  mkdir -p "$ENV_BASE/B/.claude" "$ENV_BASE/D/.claude"
  cp -R "$PACK_ROOT/.claude/skills" "$ENV_BASE/B/.claude/skills"
  cp -R "$PACK_ROOT/.claude/skills" "$ENV_BASE/D/.claude/skills"
  cp "$PACK_ROOT/.claude/FUTURE-MODEL-OPERATING-MANUAL.md" "$ENV_BASE/C/CLAUDE.md"
  cp "$PACK_ROOT/.claude/FUTURE-MODEL-OPERATING-MANUAL.md" "$ENV_BASE/D/CLAUDE.md"
  echo "envs built under $ENV_BASE"
}

# --- run one (condition, test) -----------------------------------------------
run_one() {
  local cond="$1" test="$2"
  local prompt_file="$SCRIPT_DIR/prompts/$test.txt"
  local out_dir="$RAW/$cond"; mkdir -p "$out_dir"
  local out="$out_dir/$test.md"
  # 'timeout' is GNU coreutils and absent on stock macOS — use it only if present
  local TO=""
  command -v timeout >/dev/null 2>&1 && TO="timeout $TIMEOUT_S"
  command -v gtimeout >/dev/null 2>&1 && TO="gtimeout $TIMEOUT_S"
  ( cd "$ENV_BASE/$cond" && \
    $TO claude -p --model "$MODEL" --no-session-persistence \
      "$(cat "$prompt_file")" > "$out" 2>"$out.err" )
  local rc=$?
  [ -s "$out.err" ] || rm -f "$out.err"
  echo "[done rc=$rc] $cond/$test"
}

# --- main ---------------------------------------------------------------------
build_envs
tests=()
if [ "$ONLY_TEST" = "all" ]; then
  for f in "$SCRIPT_DIR"/prompts/test*.txt; do tests+=("$(basename "$f" .txt)"); done
else
  tests=("$ONLY_TEST")
fi

jobs_running=0
for c in $(echo "$CONDS" | tr ',' ' '); do
  for t in "${tests[@]}"; do
    run_one "$c" "$t" &
    jobs_running=$((jobs_running+1))
    if [ "$jobs_running" -ge "$CONCURRENCY" ]; then wait -n 2>/dev/null || wait; jobs_running=$((jobs_running-1)); fi
  done
done
wait
echo "ALL RUNS COMPLETE. Raw outputs in $RAW/<condition>/<test>.md"
