/// VoIP 配置
/// 
/// 用于存储 TURN/STUN 服务器配置和 LiveKit 配置
/// 这些参数需要从服务端获取或在初始化时配置
library;

import 'package:flutter/foundation.dart';

/// VoIP 配置类
class VoIPConfig {
  /// 单例实例
  static final VoIPConfig _instance = VoIPConfig._internal();
  factory VoIPConfig() => _instance;
  VoIPConfig._internal();

  // ============================================
  // TURN/STUN 服务器配置
  // ============================================
  
  /// TURN 服务器 URI 列表
  /// 格式: ["turn:turn.example.com:3478", "turns:turn.example.com:5349"]
  List<String> turnUris = [];
  
  /// TURN 服务器用户名（从服务端获取，临时凭证）
  String? turnUsername;
  
  /// TURN 服务器密码（从服务端获取，临时凭证）
  String? turnPassword;
  
  /// TURN 凭证有效期（毫秒）
  int turnTtl = 86400000; // 24小时
  
  // ============================================
  // LiveKit 配置（多人会议）
  // ============================================
  
  /// LiveKit 服务器 URL
  /// 格式: "wss://livekit.example.com"
  String? liveKitUrl;
  
  /// LiveKit API Key（用于生成 token）
  String? liveKitApiKey;
  
  /// LiveKit API Secret（用于生成 token，仅服务端使用）
  String? liveKitApiSecret;
  
  // ============================================
  // 通话设置
  // ============================================
  
  /// 默认开启视频
  bool defaultVideoEnabled = true;
  
  /// 默认开启音频
  bool defaultAudioEnabled = true;
  
  /// 默认使用扬声器
  bool defaultSpeakerEnabled = false;
  
  /// 通话超时时间（秒）
  int callTimeout = 60;
  
  /// 最大视频分辨率
  VideoResolution maxVideoResolution = VideoResolution.hd720;
  
  /// 最大帧率
  int maxFrameRate = 30;
  
  // ============================================
  // 来电推送配置
  // ============================================
  
  /// Firebase 服务器密钥（FCM 推送）
  String? fcmServerKey;
  
  /// APNs 证书路径（iOS 推送）
  String? apnsCertPath;
  
  /// VoIP 推送证书路径（iOS VoIP 推送）
  String? voipCertPath;
  
  // ============================================
  // 公共 STUN 服务器（备用）
  // ============================================
  
  /// 公共 STUN 服务器列表
  static const List<Map<String, String>> publicStunServers = [
    {'urls': 'stun:stun.l.google.com:19302'},
    {'urls': 'stun:stun1.l.google.com:19302'},
    {'urls': 'stun:stun2.l.google.com:19302'},
    {'urls': 'stun:stun.stunprotocol.org:3478'},
  ];
  
  /// 获取 ICE 服务器配置
  List<Map<String, dynamic>> getIceServers() {
    final servers = <Map<String, dynamic>>[];
    
    // 添加 TURN 服务器
    if (turnUris.isNotEmpty && turnUsername != null && turnPassword != null) {
      for (final uri in turnUris) {
        servers.add({
          'urls': uri,
          'username': turnUsername,
          'credential': turnPassword,
        });
      }
    }
    
    // 添加公共 STUN 服务器作为备用
    servers.addAll(publicStunServers);
    
    return servers;
  }
  
  /// 从 Matrix 服务器响应更新 TURN 配置
  void updateFromTurnResponse(Map<String, dynamic> response) {
    if (response['uris'] != null) {
      turnUris = List<String>.from(response['uris']);
    }
    turnUsername = response['username'] as String?;
    turnPassword = response['password'] as String?;
    if (response['ttl'] != null) {
      turnTtl = response['ttl'] as int;
    }
    debugPrint('VoIPConfig: Updated TURN config with ${turnUris.length} URIs');
  }
  
  /// 配置 LiveKit
  void configureLiveKit({
    required String url,
    String? apiKey,
    String? apiSecret,
  }) {
    liveKitUrl = url;
    liveKitApiKey = apiKey;
    liveKitApiSecret = apiSecret;
    debugPrint('VoIPConfig: LiveKit configured with URL: $url');
  }
  
  /// 检查是否已配置 TURN
  bool get hasTurnConfig => turnUris.isNotEmpty;
  
  /// 检查是否已配置 LiveKit
  bool get hasLiveKitConfig => liveKitUrl != null && liveKitUrl!.isNotEmpty;
  
  /// 重置配置
  void reset() {
    turnUris = [];
    turnUsername = null;
    turnPassword = null;
    liveKitUrl = null;
    liveKitApiKey = null;
    liveKitApiSecret = null;
  }
  
  @override
  String toString() {
    return 'VoIPConfig('
        'turnUris: ${turnUris.length}, '
        'hasTurnCredentials: ${turnUsername != null}, '
        'liveKitUrl: $liveKitUrl'
        ')';
  }
}

/// 视频分辨率枚举
enum VideoResolution {
  /// 360p (640x360)
  sd360(640, 360),
  /// 480p (854x480)
  sd480(854, 480),
  /// 720p (1280x720)
  hd720(1280, 720),
  /// 1080p (1920x1080)
  hd1080(1920, 1080);
  
  final int width;
  final int height;
  
  const VideoResolution(this.width, this.height);
  
  Map<String, dynamic> toConstraints() {
    return {
      'width': {'ideal': width},
      'height': {'ideal': height},
    };
  }
}

