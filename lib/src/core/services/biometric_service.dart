import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart' as local_auth;

/// 生物识别类型（使用 N42 前缀避免与 local_auth 冲突）
enum N42BiometricType {
  /// 指纹
  fingerprint,

  /// 面部识别
  face,

  /// 虹膜
  iris,

  /// 其他强认证
  strong,

  /// 弱认证
  weak,
}

/// 生物识别结果
class BiometricResult {
  final bool success;
  final String? errorMessage;
  final BiometricErrorCode? errorCode;

  const BiometricResult({
    required this.success,
    this.errorMessage,
    this.errorCode,
  });

  factory BiometricResult.success() => const BiometricResult(success: true);

  factory BiometricResult.failure({
    required String message,
    BiometricErrorCode? code,
  }) =>
      BiometricResult(
        success: false,
        errorMessage: message,
        errorCode: code,
      );
}

/// 生物识别错误代码
enum BiometricErrorCode {
  /// 不支持生物识别
  notAvailable,

  /// 未设置生物识别
  notEnrolled,

  /// 设备不支持
  notSupported,

  /// 用户取消
  userCanceled,

  /// 尝试次数过多
  lockedOut,

  /// 永久锁定
  permanentlyLockedOut,

  /// 其他错误
  unknown,
}

/// 生物识别服务
///
/// 封装 local_auth 插件，提供统一的生物识别接口
/// 确保 Android 和 iOS 行为一致
class BiometricService {
  final local_auth.LocalAuthentication _localAuth;

  BiometricService() : _localAuth = local_auth.LocalAuthentication();

  /// 检查设备是否支持生物识别
  Future<bool> isAvailable() async {
    try {
      final canCheck = await _localAuth.canCheckBiometrics;
      final isSupported = await _localAuth.isDeviceSupported();
      return canCheck || isSupported;
    } on PlatformException catch (e) {
      debugPrint('BiometricService: isAvailable error - $e');
      return false;
    }
  }

  /// 获取可用的生物识别类型
  Future<List<N42BiometricType>> getAvailableBiometrics() async {
    try {
      final biometrics = await _localAuth.getAvailableBiometrics();
      return biometrics.map((type) => _mapBiometricType(type)).toList();
    } on PlatformException catch (e) {
      debugPrint('BiometricService: getAvailableBiometrics error - $e');
      return [];
    }
  }

  /// 检查是否有面部识别可用
  Future<bool> hasFaceId() async {
    final biometrics = await getAvailableBiometrics();
    return biometrics.contains(N42BiometricType.face);
  }

  /// 检查是否有指纹识别可用
  Future<bool> hasFingerprint() async {
    final biometrics = await getAvailableBiometrics();
    return biometrics.contains(N42BiometricType.fingerprint);
  }

  /// 获取生物识别类型描述
  Future<String> getBiometricTypeDescription() async {
    final biometrics = await getAvailableBiometrics();

    if (biometrics.contains(N42BiometricType.face)) {
      return Platform.isIOS ? 'Face ID' : 'Face Recognition';
    } else if (biometrics.contains(N42BiometricType.fingerprint)) {
      return Platform.isIOS ? 'Touch ID' : 'Fingerprint';
    } else if (biometrics.contains(N42BiometricType.strong) ||
        biometrics.contains(N42BiometricType.weak)) {
      return 'Biometric';
    }

    return 'Biometric';
  }

  /// 执行生物识别认证
  ///
  /// [reason] 显示给用户的认证原因
  /// [useErrorDialogs] 是否使用系统错误对话框
  /// [stickyAuth] 是否保持认证状态
  /// [biometricOnly] 是否仅使用生物识别（不允许密码备用）
  Future<BiometricResult> authenticate({
    required String reason,
    bool useErrorDialogs = true,
    bool stickyAuth = true,
    bool biometricOnly = true,
  }) async {
    try {
      final authenticated = await _localAuth.authenticate(
        localizedReason: reason,
        options: local_auth.AuthenticationOptions(
          useErrorDialogs: useErrorDialogs,
          stickyAuth: stickyAuth,
          biometricOnly: biometricOnly,
        ),
      );

      if (authenticated) {
        return BiometricResult.success();
      } else {
        return BiometricResult.failure(
          message: 'Authentication failed',
          code: BiometricErrorCode.userCanceled,
        );
      }
    } on PlatformException catch (e) {
      debugPrint('BiometricService: authenticate error - $e');
      return _handlePlatformException(e);
    }
  }

  /// 取消认证
  Future<bool> cancelAuthentication() async {
    try {
      return await _localAuth.stopAuthentication();
    } on PlatformException catch (e) {
      debugPrint('BiometricService: cancelAuthentication error - $e');
      return false;
    }
  }

  /// 处理平台异常
  BiometricResult _handlePlatformException(PlatformException e) {
    BiometricErrorCode code;
    String message;

    switch (e.code) {
      case 'NotAvailable':
        code = BiometricErrorCode.notAvailable;
        message = 'Biometric authentication not available';
      case 'NotEnrolled':
        code = BiometricErrorCode.notEnrolled;
        message = 'No biometrics enrolled';
      case 'LockedOut':
        code = BiometricErrorCode.lockedOut;
        message = 'Too many attempts. Please try again later.';
      case 'PermanentlyLockedOut':
        code = BiometricErrorCode.permanentlyLockedOut;
        message = 'Biometric authentication is locked. Please use another method.';
      default:
        code = BiometricErrorCode.unknown;
        message = e.message ?? 'Unknown error';
    }

    return BiometricResult.failure(
      message: message,
      code: code,
    );
  }

  /// 映射生物识别类型
  N42BiometricType _mapBiometricType(local_auth.BiometricType type) {
    switch (type) {
      case local_auth.BiometricType.fingerprint:
        return N42BiometricType.fingerprint;
      case local_auth.BiometricType.face:
        return N42BiometricType.face;
      case local_auth.BiometricType.iris:
        return N42BiometricType.iris;
      case local_auth.BiometricType.strong:
        return N42BiometricType.strong;
      case local_auth.BiometricType.weak:
        return N42BiometricType.weak;
    }
  }
}

/// 全局单例
final biometricService = BiometricService();
