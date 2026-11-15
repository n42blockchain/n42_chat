import 'package:flutter/material.dart';

import 'app_colors.dart';

/// 文字样式定义
///
/// **重要**：常量样式只承载 fontSize/fontWeight/letterSpacing/height。
/// **颜色** 不内嵌——通过 `Theme.of(context).textTheme.X` 由 [N42ChatTheme]
/// 注入；直接用 `AppTextStyles.X` 时会得到 [AppColors.textPrimary]（浅色默认）
/// 作为兜底，深色场景请用 `Theme.of(context).textTheme.X` 或显式 `.dark` 扩展。
///
/// ## 行高规范
/// - 1.2 — 紧凑（徽章、索引字母等单字符容器）
/// - 1.3 — 标题、列表项、紧凑文本
/// - 1.4 — UI 组件（按钮、输入、标签）
/// - 1.5 — 长正文段落
abstract class AppTextStyles {
  AppTextStyles._();

  /// 默认字体（跟随系统）
  static const String? fontFamily = null;

  // ============================================
  // 标题样式（与 Material textTheme.headline* 对齐）
  // ============================================

  /// 大标题 - 22sp（页面级 hero 标题）
  static const TextStyle headlineLarge = TextStyle(
    letterSpacing: 0.35,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 28 / 22,
  );

  /// 中标题 - 18sp（卡片/分组标题）
  static const TextStyle headlineMedium = TextStyle(
    letterSpacing: 0.38,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 25 / 20,
  );

  /// 小标题 - 17sp w600（导航栏标题，比 bodyLarge 17sp w400 更粗）
  static const TextStyle headlineSmall = TextStyle(
    letterSpacing: -0.41,
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 22 / 17,
  );

  // ============================================
  // 正文样式
  // ============================================

  /// 大正文 - 17sp（默认 iOS 系统字号；适合阅读密集场景）
  static const TextStyle bodyLarge = TextStyle(
    letterSpacing: -0.41,
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 22 / 17,
  );

  /// 中正文 - 15sp（默认 UI 字号）
  static const TextStyle bodyMedium = TextStyle(
    letterSpacing: -0.23,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 20 / 15,
  );

  /// 小正文 - 13sp（次级 UI 文字）
  static const TextStyle bodySmall = TextStyle(
    letterSpacing: -0.08,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 18 / 13,
  );

  // ============================================
  // 辅助文字样式
  // ============================================

  /// 辅助文字 - 12sp（时间戳、说明文字）
  static const TextStyle caption = TextStyle(
    letterSpacing: 0,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 16 / 12,
  );

  /// 超小辅助文字 - 11sp（不再 10sp——低于 iOS/Material 可读阈）
  static const TextStyle captionSmall = TextStyle(
    letterSpacing: 0.07,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    height: 13 / 11,
  );

  /// 大写小标签 - 11sp（分组段头、状态标签）
  static const TextStyle overline = TextStyle(
    letterSpacing: 0.07,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 13 / 11,
  );

  // ============================================
  // 列表样式
  // ============================================

  /// 列表标题
  static const TextStyle listTitle = TextStyle(
    letterSpacing: -0.41,
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 22 / 17,
  );

  /// 列表副标题
  static const TextStyle listSubtitle = TextStyle(
    letterSpacing: -0.08,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 18 / 13,
  );

  // ============================================
  // 聊天相关样式
  // ============================================

  /// 会话列表 - 名称
  static const TextStyle conversationName = TextStyle(
    letterSpacing: -0.41,
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 22 / 17,
  );

  /// 会话列表 - 最后消息
  static const TextStyle conversationLastMessage = TextStyle(
    letterSpacing: -0.08,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 18 / 13,
  );

  /// 会话列表 - 时间
  static const TextStyle conversationTime = TextStyle(
    letterSpacing: 0,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    height: 16 / 12,
  );

  /// 消息文字（颜色由气泡决定，调用方需 copyWith(color)）
  static const TextStyle messageText = TextStyle(
    letterSpacing: -0.41,
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 22 / 17,
  );

  /// 消息时间分隔
  static const TextStyle messageTimeSeparator = TextStyle(
    letterSpacing: 0,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    height: 16 / 12,
  );

  /// 系统消息
  static const TextStyle systemMessage = TextStyle(
    letterSpacing: 0,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    height: 16 / 12,
  );

  // ============================================
  // 按钮样式
  // ============================================

  /// 主按钮文字
  static const TextStyle buttonPrimary = TextStyle(
    letterSpacing: -0.41,
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    height: 22 / 17,
  );

  /// 次要按钮文字
  static const TextStyle buttonSecondary = TextStyle(
    letterSpacing: -0.41,
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
    height: 22 / 17,
  );

  /// 文字按钮
  static const TextStyle buttonText = TextStyle(
    letterSpacing: -0.23,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
    height: 20 / 15,
  );

  // ============================================
  // 输入框样式
  // ============================================

  /// 输入框文字
  static const TextStyle input = TextStyle(
    letterSpacing: -0.41,
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 22 / 17,
  );

  /// 输入框提示
  static const TextStyle inputHint = TextStyle(
    letterSpacing: -0.41,
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    height: 22 / 17,
  );

  /// 表单错误提示
  static const TextStyle errorText = TextStyle(
    letterSpacing: 0,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.error,
    height: 16 / 12,
  );

  // ============================================
  // 徽章样式
  // ============================================

  /// 徽章数字
  static const TextStyle badge = TextStyle(
    letterSpacing: 0.07,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    height: 13 / 11,
  );

  // ============================================
  // 通讯录索引
  // ============================================

  /// 索引字母
  static const TextStyle indexLetter = TextStyle(
    letterSpacing: 0.07,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 13 / 11,
  );

  /// 分组标题
  static const TextStyle sectionHeader = TextStyle(
    letterSpacing: -0.08,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 18 / 13,
  );
}

/// TextStyle 扩展方法
extension TextStyleExtension on TextStyle {
  /// 设置为次要颜色
  TextStyle get secondary => copyWith(color: AppColors.textSecondary);

  /// 设置为辅助颜色
  TextStyle get tertiary => copyWith(color: AppColors.textTertiary);

  /// 设置为主色
  TextStyle get primary => copyWith(color: AppColors.primary);

  /// 设置为错误颜色
  TextStyle get error => copyWith(color: AppColors.error);

  /// 加粗
  TextStyle get bold => copyWith(fontWeight: FontWeight.w600);

  /// 中等粗细
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  /// 设置深色模式主文字色
  TextStyle get dark => copyWith(color: AppColors.textPrimaryDark);

  /// 上下文感知主文字（深浅自适应）
  TextStyle onBackground(BuildContext ctx) => copyWith(
    color: Theme.of(ctx).brightness == Brightness.dark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimary,
  );
}
