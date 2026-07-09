#!/bin/bash
# Coherence check for the quality pack. Dual-mode:
#   - pack SOURCE repo (VERSION + install-pack.sh at root): full checks
#   - INSTALLED project (.claude/PACK-VERSION): skill integrity + refs + snippet
# Exit 0 = healthy; exit 1 = issues listed.
cd "$(dirname "$0")/.." || exit 1
python3 - <<'PYEOF'
import re, glob, os, sys
issues = []
SOURCE = os.path.exists('VERSION') and os.path.exists('install-pack.sh')

# 1. Skills: frontmatter + required sections
skills = sorted(glob.glob('.claude/skills/*/SKILL.md'))
names = {f.split('/')[2] for f in skills}
if not skills:
    issues.append('no skills found under .claude/skills/')
for f in skills:
    t = open(f).read()
    m = re.match(r'^---\n(.*?)\n---\n', t, re.S)
    if not m or not re.search(r'^name: .+', m.group(1), re.M) or not re.search(r'^description: .+', m.group(1), re.M):
        issues.append(f'frontmatter: {f}')
    for sec in ('## Purpose', 'When to use', 'When NOT', 'Quality bar', 'failure modes', 'Provenance'):
        if sec.lower() not in t.lower():
            issues.append(f'missing section "{sec}": {f}')

# 2. Skill references resolve (kebab-case refs that look like skill names)
sfx = ('-verify','-gate','-clarity','-calibration','-decomposition','-truth','-discipline',
       '-awareness','-rigor','-playbook','-control','-fence','-editor','-reasoning',
       '-structuring','-hygiene','-loop','-mode','-reconnaissance','-recovery',
       '-methodology','-engineering','-ideation','-thinking','-approach','-orientation')
docs = glob.glob('.claude/skills/*.md') + glob.glob('.claude/*.md') + glob.glob('.claude/learnings/*.md')
docs += glob.glob('.claude/exemplars/README.md')
# In an installed project, root *.md files belong to the project; only CLAUDE.md
# carries pack refs. In the source repo, all root docs are pack-owned.
docs += glob.glob('*.md') if SOURCE else (['CLAUDE.md'] if os.path.exists('CLAUDE.md') else [])
for f in docs + skills:
    for r in set(re.findall(r'[`\[]([a-z][a-z]+(?:-[a-z]+)+)[`\]]', open(f).read())):
        if r.endswith(sfx) and r not in names:
            issues.append(f'broken skill ref "{r}" in {f}')

# 3. Snippet stays lean
snip_path = '.claude/skills/CLAUDE-MD-SNIPPET.md'
n = 0
if os.path.exists(snip_path):
    block = re.search(r'```markdown\n(.*?)```', open(snip_path).read(), re.S)
    n = len(re.findall(r'^- ', block.group(1), re.M)) if block else 0
    if not block: issues.append('snippet: fenced block not found')
    elif n > 15: issues.append(f'snippet has {n} rules (limit ~15)')
else:
    issues.append(f'missing file: {snip_path}')

# 4. Version consistency
if SOURCE:
    ver = open('VERSION').read().strip()
    if f'## {ver}' not in open('CHANGELOG.md').read():
        issues.append(f'CHANGELOG.md has no entry for VERSION {ver}')
else:
    pv = '.claude/PACK-VERSION'
    ver = open(pv).read().split()[0] if os.path.exists(pv) else 'UNKNOWN'
    if ver == 'UNKNOWN': issues.append('missing .claude/PACK-VERSION (not an installed pack?)')

# 5. Key files exist
key = ['.claude/FUTURE-MODEL-OPERATING-MANUAL.md', '.claude/OPERATOR-GUIDE.md',
       '.claude/learnings/_template.md', 'CLAUDE.md']
if SOURCE:
    key += ['README.md','INSTALL.md','QUICK-START.md','PACK-MANIFEST.md','install-pack.sh',
            '.claude/exemplars/README.md']
for p in key:
    if not os.path.exists(p): issues.append(f'missing file: {p}')

mode = 'source' if SOURCE else 'installed'
print(f'{len(skills)} skills checked; snippet rules: {n}; version: {ver} ({mode} mode)')
if issues:
    print('ISSUES:')
    for i in issues: print('  -', i)
    sys.exit(1)
print('COHERENCE: all checks passed')
PYEOF
