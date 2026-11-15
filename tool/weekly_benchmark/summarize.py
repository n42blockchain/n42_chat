#!/usr/bin/env python3
"""Summarize exported opt-in media events or deidentified NFC/QR pilot rows.
No network, credentials, personal data or generated success measurements.
"""
import argparse
import json
import math
from pathlib import Path
from statistics import median


def percentile(values, q):
    return sorted(values)[max(0, math.ceil(len(values) * q) - 1)] if values else None


def nonnegative(value):
    return isinstance(value, (int, float)) and not isinstance(value, bool) and math.isfinite(value) and value >= 0


def media_report(rows, expected=None):
    events, duplicates = {}, 0
    for row in rows:
        if row['stage'] not in {'send', 'upload', 'download', 'decrypt', 'preview'} or row['outcome'] not in {'succeeded', 'failed', 'cancelled'}:
            raise ValueError('Invalid stage or outcome')
        if not nonnegative(row['elapsedMicroseconds']) or not nonnegative(row['bytes']):
            raise ValueError('Invalid duration or size')
        for key in ('eventId', 'operationId'):
            if not isinstance(row[key], str) or not row[key]:
                raise ValueError('Missing anonymous event/operation ID')
        event_id = row['eventId']
        if event_id in events:
            if events[event_id] != row:
                raise ValueError('Conflicting duplicate event')
            duplicates += 1
        else:
            events[event_id] = row
    stages = {}
    for stage in sorted({r['stage'] for r in events.values()}):
        group = [r for r in events.values() if r['stage'] == stage]
        times = [r['elapsedMicroseconds'] / 1000 for r in group if r['outcome'] == 'succeeded']
        failed = sum(r['outcome'] == 'failed' for r in group)
        cancelled = sum(r['outcome'] == 'cancelled' for r in group)
        attempts = len(group) - cancelled
        stages[stage] = {'events': len(group), 'failed': failed, 'cancelled': cancelled,
                         'failureRate': failed / attempts if attempts else None,
                         'successP50Ms': median(times) if times else None,
                         'successP95Ms': percentile(times, .95),
                         'reportedBytes': sum(r['bytes'] for r in group),
                         'zeroFailure95PercentUpperBound': 1 - .05 ** (1 / attempts) if attempts and failed == 0 else None}
    observed = {(r['operationId'], r['stage']) for r in events.values()}
    required = {(r['operationId'], r['stage']) for r in expected} if expected is not None else None
    return {'uniqueEvents': len(events), 'duplicateEvents': duplicates,
            'duplicateRate': duplicates / len(rows) if rows else None,
            'missingStages': len(required - observed) if required is not None else None,
            'missingRate': len(required - observed) / len(required) if required else None,
            'stages': stages,
            'limits': 'Host/client stage timings are not server transcoding, wire bytes, device RSS or color accuracy. Missing events need an independent expected-operation list.'}


def pilot_report(rows, pilots=None):
    seen, methods = set(), {}
    for row in rows:
        if row['trialId'] in seen:
            raise ValueError('Duplicate trialId')
        seen.add(row['trialId'])
        if row['method'] not in {'nfc', 'qr', 'link'} or type(row['completed']) is not bool:
            raise ValueError('Invalid pilot method or completion')
        if row.get('entryMs') is not None and not nonnegative(row['entryMs']):
            raise ValueError('Invalid entry duration')
        if row.get('reused7d') is not None and type(row['reused7d']) is not bool:
            raise ValueError('Invalid follow-up outcome')
        methods.setdefault(row['method'], []).append(row)
    result = {}
    for method, group in methods.items():
        times = [r['entryMs'] for r in group if r.get('entryMs') is not None]
        followup = [r for r in group if r.get('reused7d') is not None]
        incidents = [r for r in group if r.get('tamperExpected') is True]
        result[method] = {'trials': len(group), 'completionRate': sum(r['completed'] for r in group) / len(group),
                          'medianEntryMs': median(times) if times else None,
                          'followupComplete': len(followup),
                          'reuse7dRate': sum(r['reused7d'] for r in followup) / len(followup) if followup else None,
                          'tamperDetectionRate': sum(r.get('tamperDetected') is True for r in incidents) / len(incidents) if incidents else None}
    if pilots is not None:
        pilot_ids = set()
        for pilot in pilots:
            if not isinstance(pilot.get('pilotId'), str) or not pilot['pilotId'] or pilot['pilotId'] in pilot_ids or type(pilot.get('willContinue')) is not bool:
                raise ValueError('Invalid or duplicate pilot decision')
            pilot_ids.add(pilot['pilotId'])
    gain = result['nfc']['completionRate'] - result['qr']['completionRate'] if {'nfc', 'qr'} <= result.keys() else None
    return {'methods': result, 'nfcCompletionGainPercentagePoints': gain * 100 if gain is not None else None,
            'pilotsWillingToContinue': sum(p['willContinue'] is True for p in pilots) if pilots is not None else None,
            'limits': 'Descriptive pilot results only. Unfinished seven-day follow-ups are excluded, not counted as failures; no causal claim without randomized comparable cohorts.'}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('kind', choices=['media', 'pilot'])
    parser.add_argument('input', type=Path, help='JSONL export')
    parser.add_argument('--expected', type=Path, help='JSON array of expected operation/stage pairs')
    parser.add_argument('--pilots', type=Path, help='JSON array of merchant continuation decisions')
    args = parser.parse_args()
    rows = [json.loads(line) for line in args.input.read_text().splitlines() if line.strip()]
    report = media_report(rows, json.loads(args.expected.read_text()) if args.expected else None) if args.kind == 'media' else pilot_report(rows, json.loads(args.pilots.read_text()) if args.pilots else None)
    print(json.dumps(report, ensure_ascii=False, indent=2))

if __name__ == '__main__':
    main()
