#!/usr/bin/env python3
"""Ratchet direct Matrix SDK imports in domain/presentation; no source contents emitted."""
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
BASELINE = Path(__file__).with_name('matrix_import_baseline.json')
IMPORT = re.compile(r'''(?:import|export)\s+['"]package:matrix/''')

def imports(root):
    return sorted(str(p.relative_to(root)) for area in ('domain', 'presentation')
                  for p in (root / 'lib/src' / area).rglob('*.dart')
                  if IMPORT.search(p.read_text()))

def main():
    actual = set(imports(ROOT))
    allowed = set(json.loads(BASELINE.read_text()))
    added, removed = sorted(actual - allowed), sorted(allowed - actual)
    for path in added:
        print(f'New SDK dependency: {path}')
    for path in removed:
        print(f'Remove resolved baseline entry: {path}')
    print(f'Matrix SDK boundary: {len(actual)} existing direct imports; {len(added)} new.')
    return int(bool(added or removed))

if __name__ == '__main__':
    sys.exit(main())
