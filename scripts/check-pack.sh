#!/bin/bash
# Coherence check for the pack source repo. Run after any skill/doc change.
# Exit 0 = healthy; exit 1 = issues listed.
cd "$(dirname "$0")/.." || exit 1
python3 - <<'PYEOF'
import re, glob, os, sys
issues = []

# 1. Skills: frontmatter + required sections
skills = sorted(glob.glob('.claude/skills/*/SKILL.md'))
names = {f.split('/')[2] for f in skills}
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
       '-methodology','-engineering','-ideation','-thinking','-approach')
docs = (glob.glob('.claude/skills/*.md') + glob.glob('.claude/*.md')
        + glob.glob('.claude/learnings/*.md') + glob.glob('.claude/exemplars/README.md') + glob.glob('*.md'))
for f in docs + skills:
    for r in set(re.findall(r'[`\[]([a-z][a-z]+(?:-[a-z]+)+)[`\]]', open(f).read())):
        if r.endswith(sfx) and r not in names:
            issues.append(f'broken skill ref "{r}" in {f}')

# 3. Snippet stays lean
snip = open('.claude/skills/CLAUDE-MD-SNIPPET.md').read()
block = re.search(r'```markdown\n(.*?)```', snip, re.S)
n = len(re.findall(r'^- ', block.group(1), re.M)) if block else 0
if not block: issues.append('snippet: fenced block not found')
elif n > 15: issues.append(f'snippet has {n} rules (limit ~15)')

# 4. Version consistency
ver = open('VERSION').read().strip()
if f'## {ver}' not in open('CHANGELOG.md').read():
    issues.append(f'CHANGELOG.md has no entry for VERSION {ver}')

# 5. Key files exist
for p in ('README.md','INSTALL.md','QUICK-START.md','PACK-MANIFEST.md','install-pack.sh',
          'CLAUDE.md','.claude/FUTURE-MODEL-OPERATING-MANUAL.md','.claude/OPERATOR-GUIDE.md',
          '.claude/exemplars/README.md','.claude/learnings/_template.md'):
    if not os.path.exists(p): issues.append(f'missing file: {p}')

print(f'{len(skills)} skills checked; snippet rules: {n}; version: {ver}')
if issues:
    print('ISSUES:')
    for i in issues: print('  -', i)
    sys.exit(1)
print('COHERENCE: all checks passed')
PYEOF
