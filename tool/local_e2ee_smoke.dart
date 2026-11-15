// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:matrix/encryption/ssss.dart';

import 'package:matrix/matrix.dart';
import 'package:n42_chat/src/core/encryption/e2ee_manager.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:vodozemac/vodozemac.dart' as vod;

import 'live_smoke_credentials.dart';

/// Explicit loopback-only encrypted group and device-revocation protocol check.
/// Requires N42_TEST_HOMESERVER and N42_TEST_INVITE_CODE. Creates random users;
/// no existing accounts, credentials, recovery keys, or production endpoints.
Future<void> main() => runLocalE2eeSmoke();

Future<void> runLocalE2eeSmoke({Map<String, String>? environment}) async {
  final env = environment ?? Platform.environment;
  final uri = Uri.tryParse(env['N42_TEST_HOMESERVER'] ?? '');
  if (uri == null ||
      uri.scheme != 'http' ||
      !{'127.0.0.1', 'localhost', '::1'}.contains(uri.host) ||
      uri.userInfo.isNotEmpty ||
      uri.hasQuery ||
      uri.hasFragment) {
    throw StateError('Explicit loopback HTTP homeserver required.');
  }
  if (env['N42_TEST_USERNAME']?.isNotEmpty == true ||
      env['N42_TEST_PASSWORD']?.isNotEmpty == true) {
    throw StateError('Only generated disposable accounts are supported.');
  }
  final attempts = int.tryParse(env['N42_QA_RECOVERY_ATTEMPTS'] ?? '1');
  if (attempts == null || attempts < 1 || attempts > 30) {
    throw StateError('N42_QA_RECOVERY_ATTEMPTS must be between 1 and 30.');
  }
  final stamp = DateTime.now().microsecondsSinceEpoch;
  final credentials = List.generate(
    3,
    (index) => LiveSmokeCredentials.fromEnvironment(
      env,
      temporaryUsername: () => 'n42e2ee${stamp}_$index',
    ),
  );
  await vod.init();
  sqfliteFfiInit();
  final clients = <Client>[];
  final directory = await Directory.systemTemp.createTemp('n42-e2ee-qa-');
  try {
    for (var i = 0; i < credentials.length; i++) {
      final db = await databaseFactoryFfi.openDatabase(
        '${directory.path}/client-$i.sqlite',
      );
      final database = await MatrixSdkDatabase.init(
        'e2ee-$i',
        database: db,
        sqfliteFactory: databaseFactoryFfi,
      );
      final client = Client('e2ee-$i', database: database);
      clients.add(client);
      await client.checkHomeserver(uri);
      final credential = credentials[i];
      Future<RegisterResponse> register(String? session) => client.register(
        username: credential.username,
        password: credential.password,
        initialDeviceDisplayName: 'Isolated E2EE QA',
        auth: _TokenAuth(env['N42_TEST_INVITE_CODE']!.trim(), session: session),
      );
      try {
        await register(null);
      } on MatrixException catch (error) {
        if (error.response?.statusCode != 401) rethrow;
        final session =
            (jsonDecode(error.response!.body) as Map)['session'] as String?;
        if (session == null) rethrow;
        await register(session);
      }
      if (!client.encryptionEnabled) {
        throw StateError('Encryption not initialized');
      }
    }
    final roomId = await clients.first.createRoom(
      name: 'Isolated encrypted QA',
      preset: CreateRoomPreset.privateChat,
      initialState: [
        StateEvent(
          type: EventTypes.Encryption,
          content: {'algorithm': 'm.megolm.v1.aes-sha2'},
        ),
      ],
    );
    await _until(clients, () => clients.first.getRoomById(roomId) != null);
    final ownerRoom = clients.first.getRoomById(roomId)!;
    for (final client in clients.skip(1)) {
      await ownerRoom.invite(client.userID!);
      await client.joinRoom(roomId);
    }
    await _until(
      clients,
      () => clients.every((c) => c.getRoomById(roomId)?.encrypted == true),
    );
    var deliveries = 0;
    for (var sender = 0; sender < clients.length; sender++) {
      final body = 'isolated encrypted payload $stamp/$sender 中文🙂';
      final eventId = await clients[sender]
          .getRoomById(roomId)!
          .sendTextEvent(body);
      if (eventId == null) throw StateError('Missing event id');
      final raw = await clients[sender].getOneRoomEvent(roomId, eventId);
      if (raw.type != EventTypes.Encrypted ||
          jsonEncode(raw.content).contains(body)) {
        throw StateError('Server event is not opaque ciphertext');
      }
      for (final recipient in clients) {
        await _until(clients, () async {
          final event = await recipient
              .getRoomById(roomId)!
              .getEventById(eventId);
          return event?.type == EventTypes.Message &&
              event?.content['body'] == body;
        });
        deliveries++;
      }
    }
    final extraDb = await databaseFactoryFfi.openDatabase(
      '${directory.path}/owner-second-device.sqlite',
    );
    final extraDatabase = await MatrixSdkDatabase.init(
      'owner-second-device',
      database: extraDb,
      sqfliteFactory: databaseFactoryFfi,
    );
    final extra = Client('owner-second-device', database: extraDatabase);
    clients.add(extra);
    await extra.checkHomeserver(uri);
    await extra.login(
      LoginType.mLoginPassword,
      identifier: AuthenticationUserIdentifier(
        user: credentials.first.username,
      ),
      password: credentials.first.password,
      initialDeviceDisplayName: 'Isolated owner second device',
    );
    if (extra.userID != clients.first.userID ||
        extra.deviceID == clients.first.deviceID ||
        !extra.encryptionEnabled) {
      throw StateError('Second-device identity or encryption mismatch');
    }
    await _until(clients, () => extra.getRoomById(roomId)?.encrypted == true);
    await _until(clients, () async {
      await clients[1].updateUserDeviceKeys(additionalUsers: {extra.userID!});
      return clients[1].userDeviceKeys[extra.userID]?.deviceKeys.containsKey(
            extra.deviceID,
          ) ==
          true;
    });
    final freshBody = 'post-login encrypted payload $stamp';
    final freshId = await clients[1]
        .getRoomById(roomId)!
        .sendTextEvent(freshBody);
    if (freshId == null) throw StateError('Missing fresh event id');
    final freshRaw = await clients[1].getOneRoomEvent(roomId, freshId);
    if (freshRaw.type != EventTypes.Encrypted ||
        jsonEncode(freshRaw.content).contains(freshBody)) {
      throw StateError('Fresh server event is not opaque ciphertext');
    }
    for (final recipient in clients) {
      await _until(clients, () async {
        final event = await recipient
            .getRoomById(roomId)!
            .getEventById(freshId);
        return event?.type == EventTypes.Message &&
            event?.content['body'] == freshBody;
      });
      deliveries++;
    }
    // Keep the revoked device's existing keys for a meaningful offline check.
    await extra.abortSync();
    final revokedToken = extra.accessToken!;
    Future<void> revoke(String? session) => clients.first.deleteDevice(
      extra.deviceID!,
      auth: AuthenticationPassword(
        session: session,
        password: credentials.first.password,
        identifier: AuthenticationUserIdentifier(user: clients.first.userID!),
      ),
    );
    try {
      await revoke(null);
    } on MatrixException catch (error) {
      if (error.response?.statusCode != 401) rethrow;
      final session =
          (jsonDecode(error.response!.body) as Map)['session'] as String?;
      if (session == null) rethrow;
      await revoke(session);
    }
    final http = HttpClient();
    try {
      final request = await http.getUrl(
        uri.resolve('/_matrix/client/v3/account/whoami'),
      );
      request.headers.set(
        HttpHeaders.authorizationHeader,
        'Bearer $revokedToken',
      );
      final response = await request.close();
      final responseBody =
          jsonDecode(await utf8.decoder.bind(response).join()) as Map;
      if (response.statusCode != 401 ||
          responseBody['errcode'] != 'M_UNKNOWN_TOKEN') {
        throw StateError('Revoked device session remained authorized');
      }
    } finally {
      http.close(force: true);
    }
    final activeClients = clients.take(3).toList();
    await _until(activeClients, () async {
      await clients[1].updateUserDeviceKeys(additionalUsers: {extra.userID!});
      return clients[1].userDeviceKeys[extra.userID]?.deviceKeys.containsKey(
            extra.deviceID,
          ) ==
          false;
    });
    final afterBody = 'after-revocation encrypted payload $stamp';
    final afterId = await clients[1]
        .getRoomById(roomId)!
        .sendTextEvent(afterBody);
    if (afterId == null) throw StateError('Missing post-revocation event id');
    final afterRaw = await clients[1].getOneRoomEvent(roomId, afterId);
    if (afterRaw.type != EventTypes.Encrypted ||
        jsonEncode(afterRaw.content).contains(afterBody) ||
        afterRaw.content['session_id'] == freshRaw.content['session_id']) {
      throw StateError('Revocation did not rotate the encrypted session');
    }
    for (final recipient in activeClients) {
      await _until(activeClients, () async {
        final event = await recipient
            .getRoomById(roomId)!
            .getEventById(afterId);
        return event?.type == EventTypes.Message &&
            event?.content['body'] == afterBody;
      });
      deliveries++;
    }
    if (!extra.encryptionEnabled) {
      throw StateError('Revoked offline crypto was cleared');
    }
    final retainedEvent = await extra.encryption!.decryptRoomEvent(
      Event.fromMatrixEvent(freshRaw, extra.getRoomById(roomId)!),
    );
    if (retainedEvent.type != EventTypes.Message ||
        retainedEvent.content['body'] != freshBody) {
      throw StateError(
        'Revoked offline device lost its previously received keys',
      );
    }
    final revokedEvent = await extra.encryption!.decryptRoomEvent(
      Event.fromMatrixEvent(afterRaw, extra.getRoomById(roomId)!),
    );
    if (revokedEvent.type == EventTypes.Message ||
        revokedEvent.content['body'] == afterBody) {
      throw StateError('Revoked device decrypted a fresh session');
    }
    final ownerEncryption = E2EEManager(clients.first);
    final recoveryKey = await ownerEncryption.createRecoveryKey(
      passphrase: credentials.first.password,
    );
    if (recoveryKey == null || recoveryKey.isEmpty) {
      throw StateError('App backup setup did not return a recovery key');
    }
    ownerEncryption.clearCachedRecoveryKey();
    for (final peer in activeClients) {
      await peer.abortSync();
    }
    var completedRecoveries = 0;
    var wrongKeyRejections = 0;
    final restoredSessionCounts = <int>[];
    for (var attempt = 0; attempt < attempts; attempt++) {
      final recoveryDb = await databaseFactoryFfi.openDatabase(
        '${directory.path}/recovery-device-$attempt.sqlite',
      );
      final recoveryDatabase = await MatrixSdkDatabase.init(
        'recovery-device-$attempt',
        database: recoveryDb,
        sqfliteFactory: databaseFactoryFfi,
      );
      final recovery = Client(
        'recovery-device-$attempt',
        database: recoveryDatabase,
      );
      clients.add(recovery);
      await recovery.checkHomeserver(uri);
      await retryRateLimited(
        () => recovery.login(
          LoginType.mLoginPassword,
          identifier: AuthenticationUserIdentifier(
            user: credentials.first.username,
          ),
          password: credentials.first.password,
          initialDeviceDisplayName: 'Isolated key recovery device',
        ),
      );
      await _until([
        recovery,
      ], () => recovery.getRoomById(roomId)?.encrypted == true);
      await recovery.abortSync();
      final historicalSession = afterRaw.content['session_id'] as String;
      final beforeRestore = await recovery.encryption!.keyManager
          .loadInboundGroupSession(roomId, historicalSession);
      if (beforeRestore?.isValid == true) {
        throw StateError(
          'Recovery device unexpectedly already owns the historical key',
        );
      }
      final recoveryManager = E2EEManager(recovery);
      final wrongKey = SSSS.encodeRecoveryKey(
        Uint8List.fromList(
          List.generate(32, (_) => Random.secure().nextInt(256)),
        ),
      );
      var wrongKeyRejected = false;
      try {
        await recoveryManager.unlockWithRecoveryKey(wrongKey);
      } on E2EEException {
        wrongKeyRejected = true;
      }
      if (!wrongKeyRejected ||
          await recoveryManager.getRecoveryKey() != null ||
          (await recovery.encryption!.keyManager.loadInboundGroupSession(
                roomId,
                historicalSession,
              ))?.isValid ==
              true) {
        throw StateError(
          'Wrong recovery key was accepted or changed historical keys',
        );
      }
      wrongKeyRejections++;
      final restored = await recoveryManager.unlockWithRecoveryKey(recoveryKey);
      recoveryManager.clearCachedRecoveryKey();
      if (restored < 1) {
        throw StateError('App restore did not recover any sessions');
      }
      final restoredEvent = await recovery.encryption!.decryptRoomEvent(
        Event.fromMatrixEvent(afterRaw, recovery.getRoomById(roomId)!),
      );
      if (restoredEvent.type != EventTypes.Message ||
          restoredEvent.content['body'] != afterBody) {
        throw StateError(
          'Historical message did not decrypt after app key recovery',
        );
      }
      restoredSessionCounts.add(restored);
      completedRecoveries++;
    }
    print(
      jsonEncode({
        'clients': clients.length,
        'app_backup_recovery_passed': true,
        'restored_sessions_per_attempt': restoredSessionCounts,
        'recovery_attempts': completedRecoveries,
        'wrong_valid_recovery_keys_rejected': wrongKeyRejections,
        'historical_key_absent_before_restore': true,
        'historical_message_decrypted_after_restore': true,
        'encrypted_events': 5,
        'revoked_session_rejected': true,
        'revoked_device_retains_previous_session_keys': true,
        'revoked_device_cannot_decrypt_new_session': true,
        'distinct_accounts': credentials.length,
        'same_account_second_device': true,
        'decrypted_deliveries': deliveries,
        'server_ciphertext_checks': 5,
        'passed': true,
        'scope': 'isolated protocol and backup recoveries; not UI or physical-device acceptance',
      }),
    );
  } finally {
    for (final client in clients.reversed) {
      try {
        if (client.isLogged()) await client.logout();
      } catch (_) {
        print('QA session logout failed; local disposal continues');
      } finally {
        await client.dispose();
      }
    }
    await directory.delete(recursive: true);
  }
}

Future<void> _until(
  List<Client> clients,
  FutureOr<bool> Function() ready,
) async {
  final deadline = DateTime.now().add(const Duration(seconds: 60));
  while (DateTime.now().isBefore(deadline)) {
    if (await ready()) return;
    await Future.wait(
      clients.map((c) => c.oneShotSync(timeout: Duration.zero)),
    );
    await Future<void>.delayed(const Duration(milliseconds: 250));
  }
  throw TimeoutException('Encrypted group condition not reached');
}

class _TokenAuth extends AuthenticationData {
  _TokenAuth(this.token, {super.session})
    : super(type: 'm.login.registration_token');
  final String token;
  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'token': token};
}

/// Retry only explicit server rate limits, preserving its requested delay.
Future<T> retryRateLimited<T>(
  Future<T> Function() action, {
  Future<void> Function(Duration)? wait,
  int maxRetries = 5,
}) async {
  for (var retry = 0; ; retry++) {
    try {
      return await action();
    } on MatrixException catch (error) {
      if (error.errcode != 'M_LIMIT_EXCEEDED' || retry >= maxRetries) {
        print(
          'QA login failure code=${error.errcode}; retry=${retry}; retry_after_ms=${error.retryAfterMs}',
        );
        rethrow;
      }
      final milliseconds = error.retryAfterMs ?? 60000;
      if (milliseconds < 0 || milliseconds > 900000) {
        print('QA rate-limit wait exceeds run budget: $milliseconds ms');
        rethrow;
      }
      final delay = Duration(milliseconds: milliseconds);
      print('QA login rate limited; waiting ${delay.inMilliseconds} ms');
      await (wait ?? Future<void>.delayed)(delay);
    }
  }
}
