import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';

class _Prefs extends Mock implements SharedPreferences {}

class _Source extends PreferencesDataSource {
  final SharedPreferences storage;
  _Source(this.storage);
  @override
  Future<SharedPreferences> get prefs async => storage;
}

void main() {
  for (final hasOtherDraft in [false, true]) {
    for (final throwsError in [false, true]) {
      test(
        'failed removal stays visible and retryable: other=$hasOtherDraft throw=$throwsError',
        () async {
          final prefs = _Prefs();
          final source = _Source(prefs);
          final stored = jsonEncode({
            'room': [
              {'messageId': 'cancel'},
              if (hasOtherDraft) {'messageId': 'keep'},
            ],
          });
          when(() => prefs.reload()).thenAnswer((_) async {});
          when(() => prefs.getString(any())).thenReturn(stored);
          if (throwsError) {
            when(() => prefs.remove(any())).thenThrow(StateError('disk'));
            when(() => prefs.setString(any(), any()))
                .thenThrow(StateError('disk'));
          } else {
            when(() => prefs.remove(any())).thenAnswer((_) async => false);
            when(() => prefs.setString(any(), any()))
                .thenAnswer((_) async => false);
          }
          await expectLater(
            source.removeScheduledMessage('room', 'cancel'),
            throwsStateError,
          );
          verify(() => prefs.reload()).called(2);
          when(() => prefs.remove(any())).thenAnswer((_) async => true);
          when(() => prefs.setString(any(), any()))
              .thenAnswer((_) async => true);
          await source.removeScheduledMessage('room', 'cancel');
          if (hasOtherDraft) {
            final writes = verify(() => prefs.setString(any(), captureAny()))
                .captured
                .cast<String>();
            expect(jsonDecode(writes.last), {
              'room': [
                {'messageId': 'keep'},
              ],
            });
          } else {
            verify(() => prefs.remove(any())).called(2);
          }
        },
      );
    }
  }
}
