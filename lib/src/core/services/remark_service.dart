import 'package:flutter/foundation.dart';

import '../../data/datasources/local/secure_storage_datasource.dart';
import '../di/injection.dart';

/// 全局备注名服务
/// 
/// 用于在所有地方获取和设置联系人备注名
class RemarkService {
  static RemarkService? _instance;
  
  /// 单例实例
  static RemarkService get instance {
    _instance ??= RemarkService._();
    return _instance!;
  }
  
  RemarkService._();
  
  /// 备注缓存
  final Map<String, String> _remarkCache = {};
  
  /// 是否已初始化
  bool _initialized = false;
  
  /// 初始化服务，加载所有备注
  Future<void> initialize() async {
    if (_initialized) return;
    
    try {
      final storage = getIt<SecureStorageDataSource>();
      final remarks = await storage.getContactRemarks();
      _remarkCache.clear();
      _remarkCache.addAll(remarks);
      _initialized = true;
      debugPrint('RemarkService: Initialized with ${_remarkCache.length} remarks');
    } catch (e) {
      debugPrint('RemarkService: Failed to initialize - $e');
    }
  }
  
  /// 获取用户的备注名
  /// 
  /// 如果没有备注，返回 null
  String? getRemark(String userId) {
    return _remarkCache[userId];
  }
  
  /// 获取用户的显示名称
  /// 
  /// 优先返回备注名，如果没有备注则返回原始名称
  String getDisplayName(String userId, String originalName) {
    final remark = _remarkCache[userId];
    if (remark != null && remark.isNotEmpty) {
      return remark;
    }
    return originalName;
  }
  
  /// 设置用户的备注名
  Future<void> setRemark(String userId, String? remark) async {
    try {
      final storage = getIt<SecureStorageDataSource>();
      await storage.setContactRemark(userId, remark);
      
      if (remark == null || remark.isEmpty) {
        _remarkCache.remove(userId);
      } else {
        _remarkCache[userId] = remark;
      }
      
      debugPrint('RemarkService: Set remark for $userId to "$remark"');
    } catch (e) {
      debugPrint('RemarkService: Failed to set remark - $e');
    }
  }
  
  /// 刷新缓存
  Future<void> refresh() async {
    _initialized = false;
    await initialize();
  }
  
  /// 获取所有备注
  Map<String, String> getAllRemarks() {
    return Map.from(_remarkCache);
  }
}

