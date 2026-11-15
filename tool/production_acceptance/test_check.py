import unittest
from check import failures, MINIMUM, ZERO, SCENARIOS

class AcceptanceTest(unittest.TestCase):
    def record(self):
        return dict(chat_commit='fixture', host_commit='fixture', ios_build='fixture', android_build='fixture',
                    test_environment='synthetic validator test', run_at='fixture',
                    metrics={**MINIMUM, **dict.fromkeys(ZERO, 0), 'key_recovery_successes': 30},
                    scenarios={s: {'status': 'passed', 'evidence': 'fixture'} for s in SCENARIOS})
    def test_missing_evidence_does_not_pass(self):
        self.assertTrue(failures({}))
    def test_thresholds_and_provenance_are_required(self):
        record = self.record()
        self.assertEqual(failures(record), [])
        record['metrics']['key_recovery_successes'] = 29
        self.assertTrue(failures(record))
        record = self.record()
        record['scenarios']['push_delivery']['evidence'] = ''
        self.assertTrue(failures(record))
    def test_false_is_not_a_measured_zero(self):
        record = self.record()
        record['metrics']['automatic_wallet_executions'] = False
        self.assertTrue(failures(record))

if __name__ == '__main__':
    unittest.main()
