#!/bin/bash
# Installer for the quality pack (skills + operating manual + always-on snippet
# + compounding layer). Installs the eval-tested configuration (condition E).
#
# Usage:
#   ./install-pack.sh [/path/to/target/project]
#   (prompts for the path if not given)
#
# Guarantees:
#   - never overwrites an existing file without a timestamped backup
#   - idempotent: re-running against the same target won't duplicate content
set -u
SRC="$(cd "$(dirname "$0")" && pwd)"
STAMP="$(date +%Y%m%d%H%M%S)"
VERSION="$(cat "$SRC/VERSION" 2>/dev/null | tr -d '[:space:]')"; VERSION="${VERSION:-0.0.0}"

# --- args / target -------------------------------------------------------------
UPGRADE=0
if [ "${1:-}" = "--upgrade" ]; then UPGRADE=1; shift; fi
TARGET="${1:-}"
if [ -z "$TARGET" ]; then
  printf "Target project path: "
  read -r TARGET
fi
TARGET="${TARGET/#\~/$HOME}"
if [ ! -d "$TARGET" ]; then
  echo "ERROR: '$TARGET' is not a directory." >&2; exit 1
fi
if [ "$(cd "$TARGET" && pwd)" = "$SRC" ]; then
  echo "ERROR: target is the pack itself." >&2; exit 1
fi
PREV_VERSION=""
[ -f "$TARGET/.claude/PACK-VERSION" ] && PREV_VERSION=$(awk '{print $1; exit}' "$TARGET/.claude/PACK-VERSION")
if [ "$UPGRADE" = "1" ] && [ -z "$PREV_VERSION" ]; then
  echo "ERROR: --upgrade given but no .claude/PACK-VERSION in target (fresh install? drop the flag)." >&2; exit 1
fi
if [ "$UPGRADE" = "1" ]; then
  echo "Upgrading pack   : $PREV_VERSION -> $VERSION"
else
  echo "Installing pack v$VERSION from: $SRC"
fi
echo "               into : $TARGET"
CHANGES=""
log_change() { CHANGES="$CHANGES
  - $*"; }

backup() { # $1 = path; moves aside with timestamp if it exists
  if [ -e "$1" ]; then
    cp -R "$1" "$1.bak-$STAMP"
    echo "  backed up: $1 -> $(basename "$1").bak-$STAMP"
  fi
}

# --- 1. skills ------------------------------------------------------------------
# Pack-owned skill folders and library docs are replaced; skill folders the
# PROJECT added (not shipped by the pack) are preserved untouched.
mkdir -p "$TARGET/.claude"
if [ -d "$TARGET/.claude/skills" ]; then
  backup "$TARGET/.claude/skills"
  CUSTOM=""
  for d in "$TARGET/.claude/skills"/*/; do
    [ -d "$d" ] || continue
    b=$(basename "$d")
    [ -d "$SRC/.claude/skills/$b" ] || CUSTOM="$CUSTOM $b"
  done
  for d in "$SRC/.claude/skills"/*/; do rm -rf "$TARGET/.claude/skills/$(basename "$d")"; done
  rm -f "$TARGET/.claude/skills"/*.md
  [ -n "$CUSTOM" ] && echo "  preserved project-custom skills:$CUSTOM" && log_change "preserved custom skills:$CUSTOM"
else
  mkdir -p "$TARGET/.claude/skills"
fi
cp -R "$SRC/.claude/skills/." "$TARGET/.claude/skills/"
find "$TARGET/.claude/skills" -name '.DS_Store' -delete 2>/dev/null
echo "  installed: .claude/skills ($(ls -d "$TARGET/.claude/skills"/*/ | wc -l | tr -d ' ') skills + library docs)"
log_change "skills synced to v$VERSION"

# --- 2. compounding-layer files (skip any that already exist) ------------------
# The operating manual is pack-owned (it IS the CLAUDE.md manual block's
# source) — always synced so the file can't drift from the block:
if ! cmp -s "$SRC/.claude/FUTURE-MODEL-OPERATING-MANUAL.md" "$TARGET/.claude/FUTURE-MODEL-OPERATING-MANUAL.md" 2>/dev/null; then
  [ -e "$TARGET/.claude/FUTURE-MODEL-OPERATING-MANUAL.md" ] && backup "$TARGET/.claude/FUTURE-MODEL-OPERATING-MANUAL.md"
  cp "$SRC/.claude/FUTURE-MODEL-OPERATING-MANUAL.md" "$TARGET/.claude/FUTURE-MODEL-OPERATING-MANUAL.md"
  echo "  synced: .claude/FUTURE-MODEL-OPERATING-MANUAL.md (pack-owned)"
  log_change "operating manual synced"
fi
for f in CONTEXT-SYSTEM-SETUP.md GOAL-TEMPLATES.md \
         WORKFLOW-EXTRACTION-QUEUE.md WORKFLOW-SKILL-INTERVIEW-PROMPT.md \
         MAINTENANCE-CADENCE.md OPUS-IMPROVEMENT-EVALS.md OPERATOR-GUIDE.md; do
  if [ -e "$TARGET/.claude/$f" ]; then
    echo "  kept existing: .claude/$f"
  else
    cp "$SRC/.claude/$f" "$TARGET/.claude/$f"
    echo "  installed: .claude/$f"
  fi
done
if [ ! -d "$TARGET/.claude/exemplars" ]; then
  cp -R "$SRC/.claude/exemplars" "$TARGET/.claude/exemplars"
  echo "  installed: .claude/exemplars/ (graded reference artifacts)"
else
  echo "  kept existing: .claude/exemplars/"
fi
if [ ! -d "$TARGET/.claude/learnings" ]; then
  mkdir -p "$TARGET/.claude/learnings"
  cp "$SRC/.claude/learnings/README.md" "$SRC/.claude/learnings/_template.md" "$TARGET/.claude/learnings/"
  echo "  installed: .claude/learnings/ (README + template; notes stay per-project)"
else
  echo "  kept existing: .claude/learnings/"
fi

# --- 3. CLAUDE.md (manual + snippet = tested condition E) ----------------------
# Pack content lives between versioned BEGIN/END markers so re-running the
# installer UPGRADES the blocks in place; the user's own content is untouched.
CM="$TARGET/CLAUDE.md"
snippet_block() { awk '/^```markdown$/{f=1;next} /^```$/{f=0} f' "$SRC/.claude/skills/CLAUDE-MD-SNIPPET.md"; }
SNIP="$(snippet_block)" PACK_VERSION="$VERSION" BAK_STAMP="$STAMP" \
python3 - "$CM" "$SRC/.claude/FUTURE-MODEL-OPERATING-MANUAL.md" <<'PYEOF'
import os, re, shutil, sys
cm, manual_file = sys.argv[1], sys.argv[2]
ver, stamp = os.environ["PACK_VERSION"], os.environ["BAK_STAMP"]
blocks = {
    "manual": open(manual_file).read().rstrip(),
    "snippet": os.environ["SNIP"].rstrip(),
}
pointer = ("Business/user context lives in claude-context/ — "
           "see claude-context/claude-instructions.md for when to read what.")
old = open(cm).read() if os.path.exists(cm) else ""
new, actions = old, []
for name, content in blocks.items():
    begin, end = f"<!-- quality-pack:{name}:BEGIN v{ver} -->", f"<!-- quality-pack:{name}:END -->"
    block = f"{begin}\n{content}\n{end}"
    pat = re.compile(rf"<!-- quality-pack:{name}:BEGIN[^>]*-->.*?<!-- quality-pack:{name}:END -->", re.S)
    if pat.search(new):
        replaced = pat.sub(lambda m: block, new, count=1)
        if replaced != new:
            actions.append(f"upgraded {name} block to v{ver}")
        new = replaced
    else:
        new = (new.rstrip() + "\n\n" if new.strip() else "") + block + "\n"
        actions.append(f"added {name} block v{ver}")
if pointer not in new:
    new = new.rstrip() + "\n\n" + pointer + "\n"
    actions.append("added context pointer")
if new != old:
    if old:
        shutil.copy2(cm, f"{cm}.bak-{stamp}")
        print(f"  backed up: CLAUDE.md -> CLAUDE.md.bak-{stamp}")
    open(cm, "w").write(new)
    print(f"  {'created' if not old else 'updated'}: CLAUDE.md ({'; '.join(actions)})")
else:
    print(f"  unchanged: CLAUDE.md (already at v{ver})")
PYEOF

# record installed pack version
echo "$VERSION ($(date +%Y-%m-%d))" > "$TARGET/.claude/PACK-VERSION"

# --- 4. starter claude-context/ (never overwrite) -------------------------------
CC="$TARGET/claude-context"
if [ -d "$CC" ]; then
  echo "  kept existing: claude-context/"
else
  mkdir -p "$CC"
  today="$(date +%Y-%m-%d)"
  cat > "$CC/business-summary.md" <<EOF
# Business summary (updated $today)
- What we do: [one sentence]
- Stage/size: [stage, team size, revenue if relevant]
- Products: [product]: [who it serves]
- My role: [what you personally own]
- Strategic priorities this quarter: 1) ... 2) ... 3) ...
- Key constraints: [runway, compliance, team size...]
EOF
  cat > "$CC/current-priorities.md" <<EOF
# Priorities (updated $today)
1. [top priority] — [urgency/impact] — blocker: [what]
2. ...
Parked: [explicitly not being worked on]
EOF
  cat > "$CC/decision-log.md" <<EOF
# Decision log (append-only; fill in Result later)
## $today — [decision]
- Why: ...
- Expected: ...
- Result (fill in later): ...
EOF
  cat > "$CC/client-and-investor-context.md" <<EOF
# External relationships (updated $today)
- [Client/Investor]: [stage, sensitivities, tone that works]
- Communication standards: [update cadence, format rules]
EOF
  cat > "$CC/workflow-index.md" <<EOF
# Recurring workflows
One line per recurring workflow. Promotion pipeline: .claude/WORKFLOW-EXTRACTION-QUEUE.md
- [workflow] — [how often] — [pain point]
EOF
  cat > "$CC/claude-memory.md" <<EOF
# Durable facts (date-stamped; prune on update)
- $today: [fact that will still matter in three months]
EOF
  cat > "$CC/claude-instructions.md" <<'EOF'
# Standing instructions
- At session start for business/strategy/writing tasks: read business-summary.md
  and current-priorities.md. Read the others only when the task touches them.
- Trust these files over assumptions; trust the user's live statements over these
  files (then suggest updating the stale file).
- When a session produces a major decision, append it to decision-log.md.
- Date-stamp updates. Replace, don't accumulate.
EOF
  echo "  created: claude-context/ (7 starter files — fill in business-summary.md first)"
fi

# --- 5. gates + verification scripts (pack-owned, replaced on upgrade) ----------
mkdir -p "$TARGET/scripts"
for s in hygiene-gate.sh test-hygiene-gate.sh check-pack.sh closeout-check.sh; do
  if [ -e "$TARGET/scripts/$s" ]; then backup "$TARGET/scripts/$s"; fi
  cp "$SRC/scripts/$s" "$TARGET/scripts/$s" && chmod +x "$TARGET/scripts/$s"
done
echo "  installed: scripts/{hygiene-gate,test-hygiene-gate,check-pack,closeout-check}.sh"
log_change "gate + verification scripts synced"
if [ ! -e "$TARGET/scripts/security-scan.sh" ]; then
  cp "$SRC/scripts/security-scan-starter.sh" "$TARGET/scripts/security-scan.sh"
  chmod +x "$TARGET/scripts/security-scan.sh"
  echo "  installed: scripts/security-scan.sh (generic starter — customize via .quality-pack/config.env)"
  log_change "security-scan.sh (starter) installed"
else
  echo "  kept existing: scripts/security-scan.sh (project-owned; new starter at scripts/security-scan-starter.sh)"
  cp "$SRC/scripts/security-scan-starter.sh" "$TARGET/scripts/security-scan-starter.sh"
  chmod +x "$TARGET/scripts/security-scan-starter.sh"
fi

# --- 5b. project config (created once, never overwritten) ------------------------
mkdir -p "$TARGET/.quality-pack"
if [ ! -e "$TARGET/.quality-pack/config.env" ]; then
  cp "$SRC/.quality-pack/config.env.template" "$TARGET/.quality-pack/config.env"
  echo "  created: .quality-pack/config.env (project-owned — set QP_GH_OWNER etc.)"
  log_change "config.env created"
else
  echo "  kept existing: .quality-pack/config.env"
fi

# --- 5c. native git pre-push hook (covers pushes from any terminal) ---------------
if [ -d "$TARGET/.git" ]; then
  mkdir -p "$TARGET/.githooks"
  if [ -e "$TARGET/.githooks/pre-push" ]; then backup "$TARGET/.githooks/pre-push"; fi
  cp "$SRC/.githooks/pre-push" "$TARGET/.githooks/pre-push" && chmod +x "$TARGET/.githooks/pre-push"
  (cd "$TARGET" && git config core.hooksPath .githooks)
  echo "  wired: .githooks/pre-push (git config core.hooksPath .githooks)"
  log_change "native pre-push hook wired"
else
  echo "  skipped: native git hook (target is not a git repo yet — re-run installer after git init)"
fi

# --- 5d. gitignore the gate marker ------------------------------------------------
if ! grep -qs '\.claude/\.hygiene-gate-pass' "$TARGET/.gitignore" 2>/dev/null; then
  echo ".claude/.hygiene-gate-pass" >> "$TARGET/.gitignore"
  echo "  gitignored: .claude/.hygiene-gate-pass"
fi
SETTINGS="$TARGET/.claude/settings.json" BAK_STAMP="$STAMP" python3 - <<'PYEOF'
import json, os, shutil
p, stamp = os.environ["SETTINGS"], os.environ["BAK_STAMP"]
cfg = {}
if os.path.exists(p):
    with open(p) as f:
        cfg = json.load(f)
pre = cfg.setdefault("hooks", {}).setdefault("PreToolUse", [])
if any("hygiene-gate.sh" in h.get("command", "")
       for e in pre for h in e.get("hooks", [])):
    print("  unchanged: .claude/settings.json (hygiene gate already wired)")
else:
    if os.path.exists(p):
        shutil.copy2(p, f"{p}.bak-{stamp}")
        print(f"  backed up: settings.json -> settings.json.bak-{stamp}")
    pre.append({"matcher": "Bash", "hooks": [{"type": "command",
        "command": "\"$CLAUDE_PROJECT_DIR\"/scripts/hygiene-gate.sh"}]})
    with open(p, "w") as f:
        json.dump(cfg, f, indent=2); f.write("\n")
    print("  wired: hygiene gate PreToolUse hook in .claude/settings.json")
PYEOF

# --- 6. change report + verification ---------------------------------------------
echo
if [ "$UPGRADE" = "1" ]; then
  echo "UPGRADED $PREV_VERSION -> $VERSION. Changes:$CHANGES"
else
  echo "INSTALLED v$VERSION. Components:$CHANGES"
fi
echo
echo "== verification (run from the target) =="
( cd "$TARGET" && ./scripts/check-pack.sh ) || echo "  ^ check-pack FAILED — inspect before using"
( cd "$TARGET" && ./scripts/closeout-check.sh ) || echo "  ^ closeout-check FAILED — inspect before using"
echo
echo "Next: ./scripts/test-hygiene-gate.sh (gate unit tests), then a fresh session:"
echo "  claude -p \"List the skills available to you, names only.\""
echo "Expect the pack's skills (plan-gate, scope-fence, publish-hygiene, ...)."
echo "New machine? See BOOTSTRAP-NEW-MACHINE.md."
