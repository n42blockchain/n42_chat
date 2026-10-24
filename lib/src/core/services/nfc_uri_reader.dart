import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/ndef_record.dart';
import 'package:nfc_manager_ndef/nfc_manager_ndef.dart';

import '../utils/secure_uri.dart';

String? decodeNfcUri(NdefMessage message) {
  if (message.records.length > 8) return null;
  final records = message.records
      .where(
        (r) =>
            r.typeNameFormat == TypeNameFormat.wellKnown &&
            r.type.length == 1 &&
            r.type.single == 0x55,
      )
      .toList();
  if (records.length != 1) return null;
  final payload = records.single.payload;
  if (payload.isEmpty || payload.length > 8192) return null;
  const prefixes = {
    0: '',
    1: 'http://www.',
    2: 'https://www.',
    3: 'http://',
    4: 'https://',
  };
  final prefix = prefixes[payload.first];
  if (prefix == null) return null;
  try {
    final value = prefix + utf8.decode(payload.sublist(1));
    final uri = parseSecureUri(value, requireHttps: false);
    if (uri == null || !{'https', 'n42', 'n42chat'}.contains(uri.scheme)) {
      return null;
    }
    return value;
  } on FormatException {
    return null;
  }
}

class NfcUriReader {
  final NfcManager? _providedManager;
  final Future<NdefMessage?> Function(NfcTag)? readTag;
  NfcUriReader({NfcManager? manager, this.readTag})
    : _providedManager = manager;
  Completer<String?>? _pending;
  NfcManager? _activeManager;
  Future<String?> read() async {
    if (_pending != null) throw StateError('NFC scan is already active.');
    if (_providedManager == null &&
        (kIsWeb ||
            !{
              TargetPlatform.android,
              TargetPlatform.iOS,
            }.contains(defaultTargetPlatform))) {
      throw UnsupportedError(
        'NFC is unavailable on this device. Use QR or a link.',
      );
    }
    final manager = _providedManager ?? NfcManager.instance;
    final pending = Completer<String?>();
    var handling = false;
    _pending = pending;
    unawaited(pending.future.then<void>((_) {}, onError: (Object _) {}));
    _activeManager = manager;
    try {
      if (await manager.checkAvailability() != NfcAvailability.enabled) {
        throw StateError('Enable NFC in device settings, or use QR or a link.');
      }
      if (!identical(_pending, pending) || pending.isCompleted) return null;
      await manager.startSession(
        pollingOptions: {NfcPollingOption.iso14443, NfcPollingOption.iso15693},
        alertMessageIos: 'Hold your phone near the service tag.',
        invalidateAfterFirstReadIos: false,
        onSessionErrorIos: (_) {
          if (!pending.isCompleted) pending.complete(null);
        },
        onDiscovered: (tag) async {
          if (handling ||
              pending.isCompleted ||
              !identical(_pending, pending)) {
            return;
          }
          handling = true;
          try {
            final ndef = readTag == null ? Ndef.from(tag) : null;
            final message = readTag != null
                ? await readTag!(tag)
                : ndef?.cachedMessage ?? await ndef?.read();
            final value = message == null ? null : decodeNfcUri(message);
            if (!pending.isCompleted) {
              if (value == null) {
                pending.completeError(
                  const FormatException(
                    'This tag does not contain one supported service link.',
                  ),
                );
              } else {
                pending.complete(value);
              }
            }
          } catch (_) {
            if (!pending.isCompleted) {
              pending.completeError(
                const FormatException('Unable to read this NFC tag.'),
              );
            }
          } finally {
            handling = false;
          }
        },
      );
      return await pending.future.timeout(
        const Duration(seconds: 45),
        onTimeout: () => null,
      );
    } finally {
      try {
        await manager.stopSession();
      } catch (_) {
        /* Session may already be stopped by iOS. */
      }
      if (identical(_pending, pending)) _pending = null;
      if (identical(_activeManager, manager)) _activeManager = null;
    }
  }

  Future<void> cancel() async {
    final pending = _pending;
    if (pending != null && !pending.isCompleted) pending.complete(null);
    try {
      await _activeManager?.stopSession();
    } catch (_) {
      /* Best-effort native cleanup. */
    }
  }
}
