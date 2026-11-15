import unittest
from summarize import media_report, pilot_report

class ReportsTest(unittest.TestCase):
    def test_missing_and_duplicate_media_are_distinct(self):
        event = dict(eventId='a', operationId='b', stage='upload', outcome='succeeded', elapsedMicroseconds=1000, bytes=42)
        report = media_report([event, event], [dict(operationId='b', stage='upload'), dict(operationId='b', stage='download')])
        self.assertEqual(report['duplicateEvents'], 1)
        self.assertEqual(report['missingStages'], 1)
        self.assertEqual(report['stages']['upload']['successP95Ms'], 1)
        self.assertIsNone(media_report([event])['missingStages'])

    def test_incomplete_followup_is_not_failure(self):
        report = pilot_report([dict(trialId='a', method='nfc', completed=True, entryMs=100, reused7d=True), dict(trialId='b', method='nfc', completed=False, reused7d=None), dict(trialId='c', method='qr', completed=False, entryMs=200, reused7d=False)])
        self.assertEqual(report['methods']['nfc']['reuse7dRate'], 1)
        self.assertEqual(report['methods']['nfc']['completionRate'], .5)
        self.assertEqual(report['nfcCompletionGainPercentagePoints'], 50)
        self.assertIsNone(report['pilotsWillingToContinue'])

    def test_duplicate_merchants_cannot_satisfy_continuation_goal(self):
        with self.assertRaises(ValueError):
            pilot_report([], [dict(pilotId='same', willContinue=True), dict(pilotId='same', willContinue=True)])

    def test_conflicting_duplicates_and_bad_metrics_fail(self):
        row = dict(eventId='a', operationId='b', stage='upload', outcome='failed', elapsedMicroseconds=-1, bytes=0)
        with self.assertRaises(ValueError): media_report([row])
        row['elapsedMicroseconds'] = 0
        with self.assertRaises(ValueError): media_report([row, {**row, 'bytes': 1}])

if __name__ == '__main__': unittest.main()
