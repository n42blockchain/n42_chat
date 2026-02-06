import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import '../../data/datasources/matrix/matrix_client_manager.dart';

/// 手机通讯录联系人
class PhoneContact {
  final String id;
  final String displayName;
  final String? firstName;
  final String? lastName;
  final List<String> phones;
  final List<String> emails;
  final Uint8List? photoBytes;

  const PhoneContact({
    required this.id,
    required this.displayName,
    this.firstName,
    this.lastName,
    this.phones = const [],
    this.emails = const [],
    this.photoBytes,
  });

  /// 主要电话号码（标准化后）
  String? get primaryPhone {
    if (phones.isEmpty) return null;
    return _normalizePhone(phones.first);
  }

  /// 主要邮箱
  String? get primaryEmail {
    if (emails.isEmpty) return null;
    return emails.first.toLowerCase();
  }

  /// 标准化电话号码（移除空格、破折号等）
  static String _normalizePhone(String phone) {
    return phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');
  }
}

/// 匹配的通讯录联系人
class MatchedContact {
  final PhoneContact phoneContact;
  final String matrixUserId;
  final String? matrixDisplayName;
  final String? matrixAvatarUrl;

  const MatchedContact({
    required this.phoneContact,
    required this.matrixUserId,
    this.matrixDisplayName,
    this.matrixAvatarUrl,
  });
}

/// 通讯录同步服务
///
/// 提供手机通讯录读取和 Matrix 用户匹配功能
class ContactSyncService {
  final MatrixClientManager _clientManager;

  ContactSyncService(this._clientManager);

  /// 检查通讯录权限
  Future<bool> hasPermission() async {
    try {
      return await FlutterContacts.requestPermission(readonly: true);
    } catch (e) {
      debugPrint('ContactSyncService: Permission check error: $e');
      return false;
    }
  }

  /// 请求通讯录权限
  Future<bool> requestPermission() async {
    try {
      return await FlutterContacts.requestPermission(readonly: true);
    } catch (e) {
      debugPrint('ContactSyncService: Permission request error: $e');
      return false;
    }
  }

  /// 获取手机通讯录联系人
  Future<List<PhoneContact>> getPhoneContacts({
    bool withPhoto = false,
  }) async {
    try {
      final hasAccess = await requestPermission();
      if (!hasAccess) {
        debugPrint('ContactSyncService: No contacts permission');
        return [];
      }

      final contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: withPhoto,
      );

      return contacts.map((c) => PhoneContact(
        id: c.id,
        displayName: c.displayName,
        firstName: c.name.first,
        lastName: c.name.last,
        phones: c.phones.map((p) => p.number).toList(),
        emails: c.emails.map((e) => e.address).toList(),
        photoBytes: withPhoto ? c.photo : null,
      )).toList();
    } catch (e) {
      debugPrint('ContactSyncService: Get contacts error: $e');
      return [];
    }
  }

  /// 搜索匹配的 Matrix 用户
  ///
  /// 通过电话号码或邮箱查找已注册的 Matrix 用户
  Future<List<MatchedContact>> findMatchingUsers(
    List<PhoneContact> phoneContacts,
  ) async {
    final client = _clientManager.client;
    if (client == null) {
      debugPrint('ContactSyncService: Matrix client not available');
      return [];
    }

    final matched = <MatchedContact>[];

    // 使用邮箱搜索（Matrix 通常使用邮箱作为第三方标识符）
    for (final contact in phoneContacts) {
      if (contact.emails.isEmpty) continue;

      for (final email in contact.emails) {
        try {
          // 尝试通过邮箱查找 Matrix 用户
          // 这依赖于 Identity Server 的配置
          final response = await client.searchUserDirectory(
            email,
            limit: 5,
          );

          for (final user in response.results) {
            // 检查是否已经匹配过这个用户
            final alreadyMatched = matched.any(
              (m) => m.matrixUserId == user.userId,
            );
            if (alreadyMatched) continue;

            matched.add(MatchedContact(
              phoneContact: contact,
              matrixUserId: user.userId,
              matrixDisplayName: user.displayName,
              matrixAvatarUrl: user.avatarUrl?.toString(),
            ));
          }
        } catch (e) {
          debugPrint('ContactSyncService: Search error for $email: $e');
        }
      }
    }

    // 使用电话号码搜索（格式化为 Matrix MSISDN 格式）
    for (final contact in phoneContacts) {
      if (contact.phones.isEmpty) continue;

      for (final phone in contact.phones) {
        try {
          // 标准化电话号码
          final normalizedPhone = PhoneContact._normalizePhone(phone);

          // 搜索用户目录
          final response = await client.searchUserDirectory(
            normalizedPhone,
            limit: 5,
          );

          for (final user in response.results) {
            final alreadyMatched = matched.any(
              (m) => m.matrixUserId == user.userId,
            );
            if (alreadyMatched) continue;

            matched.add(MatchedContact(
              phoneContact: contact,
              matrixUserId: user.userId,
              matrixDisplayName: user.displayName,
              matrixAvatarUrl: user.avatarUrl?.toString(),
            ));
          }
        } catch (e) {
          debugPrint('ContactSyncService: Search error for $phone: $e');
        }
      }
    }

    return matched;
  }

  /// 同步通讯录并返回匹配的用户
  ///
  /// 这是主要的入口方法，会：
  /// 1. 请求通讯录权限
  /// 2. 读取手机通讯录
  /// 3. 搜索匹配的 Matrix 用户
  Future<ContactSyncResult> syncContacts({
    void Function(int current, int total)? onProgress,
  }) async {
    // 检查权限
    final hasPermission = await requestPermission();
    if (!hasPermission) {
      return const ContactSyncResult(
        success: false,
        error: 'Permission denied',
        phoneContacts: [],
        matchedContacts: [],
      );
    }

    // 读取通讯录
    final phoneContacts = await getPhoneContacts(withPhoto: true);
    if (phoneContacts.isEmpty) {
      return const ContactSyncResult(
        success: true,
        phoneContacts: [],
        matchedContacts: [],
      );
    }

    // 报告进度
    onProgress?.call(0, phoneContacts.length);

    // 搜索匹配用户
    final matchedContacts = await findMatchingUsers(phoneContacts);

    return ContactSyncResult(
      success: true,
      phoneContacts: phoneContacts,
      matchedContacts: matchedContacts,
    );
  }
}

/// 通讯录同步结果
class ContactSyncResult {
  final bool success;
  final String? error;
  final List<PhoneContact> phoneContacts;
  final List<MatchedContact> matchedContacts;

  const ContactSyncResult({
    required this.success,
    this.error,
    required this.phoneContacts,
    required this.matchedContacts,
  });

  /// 是否有匹配的用户
  bool get hasMatches => matchedContacts.isNotEmpty;

  /// 匹配数量
  int get matchCount => matchedContacts.length;
}
