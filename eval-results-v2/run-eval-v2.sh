#!/bin/bash
# v2 eval harness: multi-step/messy tests, 5 conditions, n reps, isolated workspaces.
#
# Conditions:
#   A plain | B skills | C manual-as-CLAUDE.md | D skills+manual | E D + always-on snippet
#
# Each cell (condition, test, rep) gets a FRESH workspace: fixtures copied in,
# condition layer applied, then one `claude -p` session per turn (turn 2+ via
# --resume of the same session). Captures every turn's text + a final diff of
# the workspace against the fixtures.
#
# Usage: ./run-eval-v2.sh [conds] [tests] [reps]
#   ./run-eval-v2.sh                 # A,B,C,D,E  all tests  3 reps
#   ./run-eval-v2.sh A,E t04 1

set -u
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PACK_ROOT="$(dirname "$SCRIPT_DIR")"
MODEL="${MODEL:-claude-opus-4-8}"
CONCURRENCY="${CONCURRENCY:-8}"
ENV_BASE="${ENV_BASE:-$(mktemp -d /tmp/pack-eval2-XXXXXX)}"
RAW="$SCRIPT_DIR/raw"

CONDS="${1:-A,B,C,D,E}"; [ "$CONDS" = "all" ] && CONDS="A,B,C,D,E"
TESTS="${2:-all}"
REPS="${3:-3}"

snippet_block() {  # extract the fenced block from CLAUDE-MD-SNIPPET.md
  awk '/^```markdown$/{f=1;next} /^```$/{f=0} f' "$PACK_ROOT/.claude/skills/CLAUDE-MD-SNIPPET.md"
}

setup_workspace() {  # $1 cond  $2 test  $3 workdir
  local cond="$1" test="$2" work="$3"
  rm -rf "$work"; mkdir -p "$work"
  [ -d "$SCRIPT_DIR/fixtures/$test" ] && cp -R "$SCRIPT_DIR/fixtures/$test/." "$work/"
  case "$cond" in
    B) mkdir -p "$work/.claude"; cp -R "$PACK_ROOT/.claude/skills" "$work/.claude/skills" ;;
    C) cp "$PACK_ROOT/.claude/FUTURE-MODEL-OPERATING-MANUAL.md" "$work/CLAUDE.md" ;;
    D) mkdir -p "$work/.claude"; cp -R "$PACK_ROOT/.claude/skills" "$work/.claude/skills"
       cp "$PACK_ROOT/.claude/FUTURE-MODEL-OPERATING-MANUAL.md" "$work/CLAUDE.md" ;;
    E) mkdir -p "$work/.claude"; cp -R "$PACK_ROOT/.claude/skills" "$work/.claude/skills"
       cp "$PACK_ROOT/.claude/FUTURE-MODEL-OPERATING-MANUAL.md" "$work/CLAUDE.md"
       { echo; snippet_block; } >> "$work/CLAUDE.md" ;;
  esac
}

run_cell() {  # $1 cond  $2 test  $3 rep
  local cond="$1" test="$2" rep="$3"
  local work="$ENV_BASE/$cond-$test-r$rep"
  local out_dir="$RAW/$cond"; mkdir -p "$out_dir"
  local out="$out_dir/$test.r$rep.md"
  setup_workspace "$cond" "$test" "$work"
  : > "$out"
  local sid="" turn=1 rc=0
  for pf in "$SCRIPT_DIR/prompts/$test".turn*.txt; do
    [ -e "$pf" ] || continue
    local resp
    if [ -z "$sid" ]; then
      resp=$( cd "$work" && claude -p --output-format json --model "$MODEL" \
              --permission-mode bypassPermissions "$(cat "$pf")" 2>"$out.err" )
    else
      resp=$( cd "$work" && claude -p --resume "$sid" --output-format json --model "$MODEL" \
              --permission-mode bypassPermissions "$(cat "$pf")" 2>>"$out.err" )
    fi
    rc=$?
    sid=$(printf '%s' "$resp" | jq -r '.session_id // empty' 2>/dev/null)
    { echo "## TURN $turn RESPONSE"
      printf '%s' "$resp" | jq -r '.result // "(!) no result field"' 2>/dev/null || printf '%s\n' "$resp"
      echo; } >> "$out"
    turn=$((turn+1))
  done
  { echo "## FINAL WORKSPACE DIFF (vs fixtures; excludes condition files)"
    if [ -d "$SCRIPT_DIR/fixtures/$test" ]; then
      diff -ru -x '.claude' -x 'CLAUDE.md' -x '__pycache__' -x '*.pyc' \
        "$SCRIPT_DIR/fixtures/$test" "$work" 2>/dev/null || true
    else
      echo "(no fixtures for this test)"
    fi; } >> "$out"
  [ -s "$out.err" ] || rm -f "$out.err"
  echo "[done rc=$rc] $cond/$test r$rep"
}

tests=()
if [ "$TESTS" = "all" ]; then
  for f in "$SCRIPT_DIR"/prompts/*.turn1.txt; do tests+=("$(basename "$f" .turn1.txt)"); done
else
  IFS=',' read -ra tests <<< "$TESTS"
fi

echo "run: conds=$CONDS tests=${tests[*]} reps=$REPS model=$MODEL envbase=$ENV_BASE"
jobs_running=0
for r in $(seq "${REP_START:-1}" "$REPS"); do
  for c in $(echo "$CONDS" | tr ',' ' '); do
    for t in "${tests[@]}"; do
      run_cell "$c" "$t" "$r" &
      jobs_running=$((jobs_running+1))
      if [ "$jobs_running" -ge "$CONCURRENCY" ]; then wait -n 2>/dev/null || wait; jobs_running=$((jobs_running-1)); fi
    done
  done
done
wait
echo "ALL RUNS COMPLETE -> $RAW"

# Quota-stub guard: non-empty outputs containing only a session-limit message are
# NOT RUN, never gradeable (see .claude/learnings/2026-07-07-eval-outputs-can-be-quota-stubs.md)
stubs=$(grep -rl "hit your session limit" "$RAW" 2>/dev/null | wc -l | tr -d ' ')
if [ "$stubs" != "0" ]; then
  echo "WARNING: $stubs output file(s) are quota-limit stubs — score them NOT RUN, do not grade:"
  grep -rl "hit your session limit" "$RAW" | sed 's/^/  /'
fi
