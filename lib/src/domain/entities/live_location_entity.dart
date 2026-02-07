import 'package:equatable/equatable.dart';

/// 实时位置共享实体
class LiveLocationEntity extends Equatable {
  final String userId;
  final String displayName;
  final String? avatarUrl;
  final double latitude;
  final double longitude;
  final double? accuracy;
  final DateTime updatedAt;
  final DateTime expiresAt;
  final int durationMinutes;

  const LiveLocationEntity({
    required this.userId,
    required this.displayName,
    this.avatarUrl,
    required this.latitude,
    required this.longitude,
    this.accuracy,
    required this.updatedAt,
    required this.expiresAt,
    required this.durationMinutes,
  });

  /// 共享是否已过期
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  /// 剩余时间（秒）
  int get remainingSeconds {
    final remaining = expiresAt.difference(DateTime.now()).inSeconds;
    return remaining > 0 ? remaining : 0;
  }

  /// 格式化剩余时间
  String get formattedRemaining {
    final seconds = remainingSeconds;
    if (seconds <= 0) return '已过期';
    if (seconds < 60) return '$seconds秒';
    if (seconds < 3600) return '${seconds ~/ 60}分钟';
    return '${seconds ~/ 3600}小时${(seconds % 3600) ~/ 60}分钟';
  }

  LiveLocationEntity copyWith({
    String? userId,
    String? displayName,
    String? avatarUrl,
    double? latitude,
    double? longitude,
    double? accuracy,
    DateTime? updatedAt,
    DateTime? expiresAt,
    int? durationMinutes,
  }) {
    return LiveLocationEntity(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      accuracy: accuracy ?? this.accuracy,
      updatedAt: updatedAt ?? this.updatedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      durationMinutes: durationMinutes ?? this.durationMinutes,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        displayName,
        avatarUrl,
        latitude,
        longitude,
        accuracy,
        updatedAt,
        expiresAt,
        durationMinutes,
      ];
}
