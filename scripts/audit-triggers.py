#!/usr/bin/env python3
"""Trigger-coverage audit: do skill descriptions match what users actually say?

Each probe is a realistic (messy) user phrasing mapped to search terms; a probe
with no matching skill description is an activation gap. Run after editing any
SKILL.md description. Exit 1 if any probe is uncovered.
"""
import re, glob, os, sys

SKILLS_DIR = os.path.join(os.path.dirname(__file__), '..', '.claude', 'skills')
descs = {}
for f in glob.glob(os.path.join(SKILLS_DIR, '*', 'SKILL.md')):
    t = open(f).read()
    m = re.search(r'^description: (.+)$', t.split('---')[1], re.M)
    if m:
        descs[os.path.basename(os.path.dirname(f))] = m.group(1).lower()

PROBES = {
    '"do what you think is next"': ['do what you think', "whatever's next", 'take it from here'],
    '"publish this"': ['publish'],
    '"push it" / "git push"': ['push it', 'git push'],
    '"review my github/repos before public"': ['review my repo', 'review my github', 'my repos'],
    '"make sure nothing leaked"': ['leak'],
    '"you leaked stuff before" (correction)': ['you leaked', 'corrects your output', "that's wrong"],
    'release prep / cut a release': ['release'],
    'secret / identity / path exposure': ['secret', 'identity', 'username', 'machine path'],
    '"are we safe?" / "you sure?"': ['are we safe', 'you sure', 'is it safe'],
    '"clean this up" (vague)': ['clean this up'],
    '"where did we leave off" (resume)': ['resumed session', 'resumed', 'long or resumed'],
}

gaps = 0
for probe, terms in PROBES.items():
    hits = sorted({n for n, d in descs.items() for t in terms if t in d})
    status = ', '.join(hits) if hits else '*** NO SKILL MATCHES — ACTIVATION GAP ***'
    if not hits:
        gaps += 1
    print(f'{probe:44} -> {status}')

print(f'\n{len(descs)} skill descriptions audited, {gaps} gap(s)')
sys.exit(1 if gaps else 0)
