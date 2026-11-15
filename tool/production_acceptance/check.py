#!/usr/bin/env python3
"""Check measured acceptance evidence. Never creates or infers passing results."""
import json
import sys
from pathlib import Path

MINIMUM = {'devices': 3, 'group_members': 20, 'mixed_messages': 10000,
           'key_recovery_attempts': 30}
ZERO = ('lost_messages', 'duplicate_messages', 'plaintext_log_leaks',
        'revoked_device_new_keys', 'automatic_wallet_executions')
SCENARIOS = ('offline_reconnect', 'device_revocation', 'key_recovery',
             'push_delivery', 'wallet_confirmation')

def failures(record):
    errors = []
    metrics = record.get('metrics', {})
    for key, minimum in MINIMUM.items():
        value = metrics.get(key)
        if type(value) is not int or value < minimum:
            errors.append(f'{key}: requires a measured integer >= {minimum}')
    for key in ZERO:
        value = metrics.get(key)
        if type(value) is not int or value != 0:
            errors.append(f'{key}: requires a measured zero')
    successes = metrics.get('key_recovery_successes')
    attempts = metrics.get('key_recovery_attempts')
    if type(successes) is not int or successes != attempts:
        errors.append('key_recovery_successes: every measured recovery must succeed')
    for key in ('chat_commit', 'host_commit', 'ios_build', 'android_build', 'test_environment', 'run_at'):
        if not isinstance(record.get(key), str) or not record[key].strip():
            errors.append(f'{key}: missing provenance')
    for scenario in SCENARIOS:
        evidence = record.get('scenarios', {}).get(scenario, {})
        if evidence.get('status') != 'passed' or not evidence.get('evidence'):
            errors.append(f'{scenario}: requires passed status and an evidence reference')
    return errors

if __name__ == '__main__':
    record = json.loads(Path(sys.argv[1]).read_text())
    errors = failures(record)
    for error in errors:
        print(error)
    print('INCOMPLETE / FAILED' if errors else 'RECORDED THRESHOLDS MET; independently review evidence')
    sys.exit(1 if errors else 0)
