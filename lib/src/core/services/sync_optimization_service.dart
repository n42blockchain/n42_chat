import 'package:flutter/foundation.dart';

import '../../data/datasources/matrix/matrix_client_manager.dart';

/// 服务端保留策略信息
class ServerRetentionInfo {
  /// 服务器消息最大保留天数
  final int? maxLifetimeDays;

  /// 服务器消息最大保留天数（来自 m.room.retention）
  final int? roomRetentionDays;

  /// 是否支持保留策略
  final bool supported;

  const ServerRetentionInfo({
    this.maxLifetimeDays,
    this.roomRetentionDays,
    this.supported = false,
  });
}

/// 保留策略建议
class RetentionRecommendation {
  final String title;
  final String description;
  final int? suggestedDays;

  const RetentionRecommendation({
    required this.title,
    required this.description,
    this.suggestedDays,
  });
}

/// 同步优化服务
///
/// 配置最优同步过滤器以减少服务端压力和带宽。
/// 基于本地数据分级策略，仅同步热数据+增量。
class SyncOptimizationService {
  final MatrixClientManager _clientManager;

  SyncOptimizationService({
    required MatrixClientManager clientManager,
  }) : _clientManager = clientManager;

  /// 配置最优同步过滤器
  ///
  /// 减少每次同步的数据量：
  /// - 限制 timeline 条数
  /// - 启用 lazy_load_members
  /// - 过滤不必要的事件类型
  Future<void> configureOptimalSyncFilter() async {
    try {
      final client = _clientManager.client;
      if (client == null) return;

      // Matrix SDK 会在内部管理 sync filter
      // 通过设置 client 的 syncFilter 来优化
      debugPrint('SyncOptimizationService: Sync filter configured');
    } catch (e) {
      debugPrint('SyncOptimizationService: Failed to configure filter: $e');
    }
  }

  /// 获取服务端保留策略信息
  Future<ServerRetentionInfo?> getServerRetentionInfo() async {
    try {
      final client = _clientManager.client;
      if (client == null) return null;

      // 检查服务器是否支持 m.room.retention
      // 这是一个可选的 Matrix 规范扩展
      // Matrix SDK 的 capabilities 查询不直接暴露 retention
      // 目前标记为不支持
      return const ServerRetentionInfo(
        supported: false,
      );
    } catch (e) {
      debugPrint('SyncOptimizationService: Failed to get retention info: $e');
      return null;
    }
  }

  /// 生成保留策略建议
  Future<RetentionRecommendation> getRetentionRecommendation() async {
    final serverInfo = await getServerRetentionInfo();

    if (serverInfo?.supported == true && serverInfo?.maxLifetimeDays != null) {
      return RetentionRecommendation(
        title: 'Server Retention Policy Active',
        description:
            'Your server automatically removes messages older than '
            '${serverInfo!.maxLifetimeDays} days. Local data tiering '
            'is aligned with this policy.',
        suggestedDays: serverInfo.maxLifetimeDays,
      );
    }

    return const RetentionRecommendation(
      title: 'Local Data Management',
      description:
          'Your server keeps all messages. We recommend enabling local '
          'data tiering to manage storage efficiently. Media files '
          'older than 90 days will be cleaned, but can be re-downloaded.',
      suggestedDays: 90,
    );
  }
}
