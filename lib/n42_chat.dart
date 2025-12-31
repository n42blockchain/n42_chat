/// N42 Matrix Chat - 基于Matrix协议的微信风格聊天模块
///
/// 本库提供完整的即时通讯解决方案，可独立运行或嵌入N42钱包应用。
///
/// ## 快速开始
///
/// ```dart
/// // 1. 初始化
/// await N42Chat.initialize(const N42ChatConfig(
///   defaultHomeserver: 'https://matrix.org',
/// ));
///
/// // 2. 嵌入TabView
/// N42Chat.chatWidget()
///
/// // 3. 或获取路由配置
/// N42Chat.routes()
/// ```
///
/// ## 功能特性
///
/// - 🎨 微信风格UI
/// - 🔐 端对端加密
/// - 🔌 插件化设计
/// - 💰 钱包集成支持
///
library n42_chat;

// ============================================
// 核心导出
// ============================================
export 'src/n42_chat.dart';
export 'src/n42_chat_config.dart';

// ============================================
// 主题导出
// ============================================
export 'src/core/theme/n42_chat_theme.dart';
export 'src/core/theme/app_colors.dart';
export 'src/core/theme/app_text_styles.dart';

// ============================================
// 实体导出 (供外部使用)
// ============================================
export 'src/domain/entities/conversation_entity.dart';
export 'src/domain/entities/message_entity.dart';
export 'src/domain/entities/contact_entity.dart';
export 'src/domain/entities/user_entity.dart';

// ============================================
// 集成接口导出
// ============================================
export 'src/integration/wallet_bridge.dart';

