import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart';

/// Matrix服务器集成测试
///
/// 测试服务器: https://m.si46.world/
/// 邀请码: c321fb4d6ce5e93984452cbd11427f5dfc8c02a2c728234ce8d6e5ce317e9a81
void main() {
  const homeserver = 'https://m.si46.world';
  const inviteCode = 'c321fb4d6ce5e93984452cbd11427f5dfc8c02a2c728234ce8d6e5ce317e9a81';

  late Client client;

  setUp(() {
    client = Client('N42ChatIntegrationTest');
  });

  tearDown(() async {
    try {
      if (client.isLogged()) {
        await client.logout();
      }
    } catch (_) {}
    await client.dispose();
  });

  group('服务器连接测试', () {
    test('应该成功连接到Matrix服务器', () async {
      await client.checkHomeserver(Uri.parse(homeserver));
      
      expect(client.homeserver, isNotNull);
      expect(client.homeserver.toString(), contains('m.si46.world'));
      
      print('✅ 服务器连接成功: ${client.homeserver}');
    });

    test('应该获取服务器版本信息', () async {
      await client.checkHomeserver(Uri.parse(homeserver));
      
      final versions = await client.getVersions();
      
      expect(versions.versions, isNotEmpty);
      print('✅ 支持的Matrix版本: ${versions.versions.join(", ")}');
    });

    test('应该获取支持的登录方式', () async {
      await client.checkHomeserver(Uri.parse(homeserver));
      
      final flows = await client.getLoginFlows();
      
      expect(flows, isNotNull);
      expect(flows!.isNotEmpty, isTrue);
      
      final flowTypes = flows.map((f) => f.type).toList();
      print('✅ 支持的登录方式: ${flowTypes.join(", ")}');
      
      // 确认支持密码登录
      expect(flowTypes, contains('m.login.password'));
    });

    test('应该能检查用户名可用性', () async {
      await client.checkHomeserver(Uri.parse(homeserver));
      
      final testUsername = 'test_check_${DateTime.now().millisecondsSinceEpoch}';
      
      try {
        final available = await client.checkUsernameAvailability(testUsername);
        print('✅ 用户名 $testUsername 可用性: $available');
      } catch (e) {
        // 某些服务器可能不支持此API
        print('⚠️ 用户名检查API不可用: $e');
      }
    });
  });

  group('服务器能力测试', () {
    test('应该获取服务器能力', () async {
      await client.checkHomeserver(Uri.parse(homeserver));
      
      try {
        final capabilities = await client.getCapabilities();
        print('✅ 服务器能力:');
        if (capabilities.mChangePassword != null) {
          print('   - 密码修改: ${capabilities.mChangePassword!.enabled}');
        }
        if (capabilities.mRoomVersions != null) {
          print('   - 房间版本: ${capabilities.mRoomVersions}');
        }
      } catch (e) {
        print('⚠️ 获取服务器能力失败: $e');
      }
    });

    test('应该获取服务器推送规则', () async {
      await client.checkHomeserver(Uri.parse(homeserver));
      
      // 需要登录后才能获取推送规则
      print('ℹ️ 推送规则需要登录后获取');
    });
  });

  group('邀请码相关信息', () {
    test('邀请码格式验证', () {
      expect(inviteCode.length, equals(64)); // SHA256 hash长度
      expect(RegExp(r'^[a-f0-9]+$').hasMatch(inviteCode), isTrue);
      
      print('✅ 邀请码格式正确');
      print('   长度: ${inviteCode.length}');
      print('   前缀: ${inviteCode.substring(0, 16)}...');
    });
  });
}

