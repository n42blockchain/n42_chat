import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/nfc_manager_ios.dart';
import 'package:nfc_manager/ndef_record.dart';
import 'package:n42_chat/src/core/services/nfc_uri_reader.dart';

class _Manager extends NfcManager {
  NfcAvailability availability = NfcAvailability.enabled;
  void Function(NfcTag)? discovered;
  int stops = 0;
  @override
  Future<NfcAvailability> checkAvailability() async => availability;
  @override
  Future<bool> isAvailable() async => availability == NfcAvailability.enabled;
  @override
  Future<void> startSession({
    required Set<NfcPollingOption> pollingOptions,
    required void Function(NfcTag) onDiscovered,
    String? alertMessageIos,
    bool invalidateAfterFirstReadIos = true,
    void Function(NfcReaderSessionErrorIos)? onSessionErrorIos,
    bool noPlatformSoundsAndroid = false,
  }) async {
    discovered = onDiscovered;
  }

  @override
  Future<void> stopSession({
    String? alertMessageIos,
    String? errorMessageIos,
  }) async {
    stops++;
  }
}

NdefRecord record(String value, {int prefix = 0}) => NdefRecord(
  typeNameFormat: TypeNameFormat.wellKnown,
  type: Uint8List.fromList([0x55]),
  identifier: Uint8List(0),
  payload: Uint8List.fromList([prefix, ...utf8.encode(value)]),
);
void main() {
  test(
    'decodes HTTPS prefix and custom links without reading tag identity',
    () {
      expect(
        decodeNfcUri(
          NdefMessage(records: [record('shop.n42.world', prefix: 4)]),
        ),
        'https://shop.n42.world',
      );
      expect(
        decodeNfcUri(
          NdefMessage(records: [record('n42chat://miniapp/n42_shop')]),
        ),
        'n42chat://miniapp/n42_shop',
      );
    },
  );
  test(
    'rejects ambiguous records, downgrade, malformed URI and oversized payload',
    () {
      for (final records in [
        [record('https://shop.n42.world'), record('https://evil.test')],
        [record('http://shop.n42.world')],
        [record('javascript:alert(1)')],
        [record('https://user@shop.n42.world')],
        [record('https://shop.n42.world/${'x' * 8192}')],
      ]) {
        expect(decodeNfcUri(NdefMessage(records: records)), isNull);
      }
    },
  );
  test(
    'one tag result stops native session and duplicate discovery is ignored',
    () async {
      final manager = _Manager();
      var reads = 0;
      final reader = NfcUriReader(
        manager: manager,
        readTag: (_) async {
          reads++;
          return NdefMessage(records: [record('https://shop.n42.world')]);
        },
      );
      final result = reader.read();
      await Future<void>.delayed(Duration.zero);
      manager.discovered!(const NfcTag(data: {}));
      manager.discovered!(const NfcTag(data: {}));
      expect(await result, 'https://shop.n42.world');
      expect(reads, 1);
      expect(manager.stops, 1);
    },
  );
  test('cancellation and unavailable NFC leave no active session', () async {
    final manager = _Manager();
    final reader = NfcUriReader(manager: manager);
    final result = reader.read();
    await Future<void>.delayed(Duration.zero);
    await reader.cancel();
    expect(await result, isNull);
    manager.availability = NfcAvailability.disabled;
    await expectLater(reader.read(), throwsStateError);
    expect(manager.stops, greaterThanOrEqualTo(2));
  });
}
