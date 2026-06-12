import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/services/chat_lock_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSecureStorage extends Mock implements FlutterSecureStorage {}

/// PIN 哈希存储与 legacy 迁移：
/// 实现已从 SharedPreferences 迁到 FlutterSecureStorage（PBKDF2 + salt），
/// 测试通过注入的内存版 secure storage 断言新格式与迁移路径。
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Map<String, String> secureStore;
  late MockSecureStorage secureStorage;
  late ChatLockService service;

  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    secureStore = <String, String>{};
    secureStorage = MockSecureStorage();
    when(() => secureStorage.read(key: any(named: 'key'))).thenAnswer(
      (inv) async => secureStore[inv.namedArguments[#key] as String],
    );
    when(
      () => secureStorage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((inv) async {
      secureStore[inv.namedArguments[#key] as String] =
          inv.namedArguments[#value] as String;
    });
    when(() => secureStorage.delete(key: any(named: 'key'))).thenAnswer(
      (inv) async => secureStore.remove(inv.namedArguments[#key] as String),
    );
    service = ChatLockService(secureStorage: secureStorage);
  });

  group('lockChat / verifyPin', () {
    test('stores salted pin hash in secure storage for newly locked chats',
        () async {
      await service.lockChat('room-1', pin: '1234');

      final hash = secureStore['chat_lock_pin_room-1'];
      final salt = secureStore['chat_lock_pin_salt_room-1'];
      final legacyHash = sha256.convert(utf8.encode('1234')).toString();

      expect(hash, isNotNull);
      expect(salt, isNotNull);
      expect(hash, isNot(equals(legacyHash)),
          reason: '新格式必须是 PBKDF2+salt，不是裸 SHA-256');
      expect(await service.verifyPin('room-1', '1234'), isTrue);
      expect(await service.verifyPin('room-1', '9999'), isFalse);
    });

    test(
        'migrates legacy SharedPreferences pin to secure storage '
        'after successful verification', () async {
      final legacyHash = sha256.convert(utf8.encode('4321')).toString();
      SharedPreferences.setMockInitialValues(<String, Object>{
        'chat_lock_pin_room-legacy': legacyHash,
      });

      final verified = await service.verifyPin('room-legacy', '4321');

      final prefs = await SharedPreferences.getInstance();
      final migratedHash = secureStore['chat_lock_pin_room-legacy'];
      final salt = secureStore['chat_lock_pin_salt_room-legacy'];

      expect(verified, isTrue);
      expect(salt, isNotNull, reason: '迁移后必须带 salt');
      expect(migratedHash, isNotNull, reason: '迁移后哈希进 secure storage');
      expect(migratedHash, isNot(equals(legacyHash)),
          reason: '迁移后必须升级为 PBKDF2 格式');
      expect(prefs.getString('chat_lock_pin_room-legacy'), isNull,
          reason: '迁移后清理旧 SharedPreferences 数据');
      // 迁移完成后再次验证走新格式。
      expect(await service.verifyPin('room-legacy', '4321'), isTrue);
      expect(await service.verifyPin('room-legacy', '0000'), isFalse);
    });

    test('verifyPin returns false when no pin was ever set', () async {
      expect(await service.verifyPin('room-unset', '1234'), isFalse);
    });

    test('unlockChat removes pin material from secure storage', () async {
      await service.lockChat('room-2', pin: '5678');
      expect(secureStore.containsKey('chat_lock_pin_room-2'), isTrue);

      await service.unlockChat('room-2');

      expect(secureStore.containsKey('chat_lock_pin_room-2'), isFalse);
      expect(secureStore.containsKey('chat_lock_pin_salt_room-2'), isFalse);
      expect(await service.isChatLocked('room-2'), isFalse);
    });
  });
}
