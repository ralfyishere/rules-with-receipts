# Bootstrap a New Machine

From zero to the full quality system on a fresh computer. Everything installs
from the public source of truth: `github.com/ralfyishere/rules-with-receipts`.

## 1. Prerequisites

```bash
# Claude Code (see https://claude.com/claude-code for current instructions)
npm install -g @anthropic-ai/claude-code   # or the platform installer
claude --version

# GitHub CLI + auth
brew install gh          # macOS; see cli.github.com for other platforms
gh auth login            # browser flow; verify: gh auth status

# Git identity — the identity that will appear in every commit you push.
# Set it GLOBALLY before the first commit anywhere (bare commits fall back
# to user@Hostname.local and leak your machine name into public history):
git config --global user.name  "Your Name"
git config --global user.email "you@example.com"
```

## 2. Get the pack

```bash
git clone https://github.com/ralfyishere/rules-with-receipts.git ~/.quality-pack-src
```

Read what you cloned before letting an agent load it — a rules pack is
instructions an agent will follow with tool access. `rulebench vet
~/.quality-pack-src` gives a fast offline screen.

## 3. Install into a project

```bash
cd ~/.quality-pack-src
./install-pack.sh /path/to/your/project        # fresh install
./install-pack.sh --upgrade /path/to/project   # later upgrades
```

Or the one-liner (automates the same steps; see bootstrap.sh's header for the
read-before-you-run caveat):

```bash
curl -fsSL https://raw.githubusercontent.com/ralfyishere/rules-with-receipts/main/bootstrap.sh | bash -s -- /path/to/project
```

The installer is idempotent, backs up anything it touches, updates only its
managed blocks in CLAUDE.md, never overwrites `claude-context/` or
`.quality-pack/config.env`, and preserves skill folders you added yourself.

## 4. Configure the project

Edit `.quality-pack/config.env` in the project: set `QP_GH_OWNER` (enables
GitHub-surface scanning) and `QP_ALLOWED_GIT_EMAILS` (enforces identity
hygiene in history scans). Fill in `claude-context/business-summary.md` and
`current-priorities.md` — five minutes that ground every session.

## 5. Verify (all three must pass)

```bash
cd /path/to/your/project
./scripts/check-pack.sh          # skill integrity, refs, snippet — "installed mode"
./scripts/closeout-check.sh      # managed blocks match installed version, hooks wired
./scripts/test-hygiene-gate.sh   # gate unit tests (blocks risky, passes benign)
```

Then the live check — fresh session:

```bash
claude -p "List the skills available to you, names only."
```

## 6. First security scan + gates

```bash
./scripts/security-scan.sh   # clean pass opens the hygiene gate for 60 min
```

Two gates are now active:
- **Claude sessions:** the PreToolUse hook (`.claude/settings.json`) blocks
  push/release/publish commands without a fresh scan pass.
- **Any terminal:** `.githooks/pre-push` (wired via `git config
  core.hooksPath .githooks`; the installer does this when the target is a
  git repo — re-run the installer after `git init` if you initialized later).

## 7. The operating discipline you just inherited

- No "done" without shown evidence; no completion claim without
  `closeout-check`; unchecked things get named as unchecked.
- No public action (push, release, publish, visibility flip) without the
  hygiene gate.
- After hard problems, write the learning note (`.claude/learnings/`).
- Read `.claude/OPERATOR-GUIDE.md` (your side: warning signs → interventions)
  and `.claude/MAINTENANCE-CADENCE.md` (weekly/monthly upkeep).

## Troubleshooting

- Gate blocks a command it shouldn't: the block message names the way
  through; false-positive patterns go in `.quality-pack/config.env`
  (`QP_HOOKS_ENFORCED=0` exists but defeats the point).
- `check-pack`/`closeout-check` distinguish source repo vs installed project
  automatically; "installed mode" in their output is correct for projects.
- Upgrading: always via `install-pack.sh --upgrade` (or bootstrap.sh, which
  auto-detects). Never hand-edit inside managed CLAUDE.md blocks — the next
  upgrade replaces them; project notes belong outside the markers.
