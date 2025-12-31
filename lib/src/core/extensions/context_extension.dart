import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/n42_chat_theme.dart';

/// BuildContext 扩展方法
extension ContextExtension on BuildContext {
  // ============================================
  // 主题相关
  // ============================================

  /// 获取当前ThemeData
  ThemeData get theme => Theme.of(this);

  /// 获取ColorScheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// 获取TextTheme
  TextTheme get textTheme => theme.textTheme;

  /// 是否为深色模式
  bool get isDarkMode => theme.brightness == Brightness.dark;

  // ============================================
  // 屏幕尺寸
  // ============================================

  /// 获取MediaQueryData
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// 屏幕宽度
  double get screenWidth => mediaQuery.size.width;

  /// 屏幕高度
  double get screenHeight => mediaQuery.size.height;

  /// 状态栏高度
  double get statusBarHeight => mediaQuery.padding.top;

  /// 底部安全区域高度
  double get bottomSafeArea => mediaQuery.padding.bottom;

  /// 键盘高度
  double get keyboardHeight => mediaQuery.viewInsets.bottom;

  /// 键盘是否可见
  bool get isKeyboardVisible => keyboardHeight > 0;

  /// 设备像素比
  double get devicePixelRatio => mediaQuery.devicePixelRatio;

  /// 是否为平板
  bool get isTablet => screenWidth > 600;

  /// 是否为横屏
  bool get isLandscape => mediaQuery.orientation == Orientation.landscape;

  // ============================================
  // 导航相关
  // ============================================

  /// 返回上一页
  void pop<T>([T? result]) => Navigator.of(this).pop(result);

  /// 是否可以返回
  bool get canPop => Navigator.of(this).canPop();

  /// 使用GoRouter导航
  void goTo(String location, {Object? extra}) => go(location, extra: extra);

  /// 推入新页面
  void pushTo(String location, {Object? extra}) => push(location, extra: extra);

  /// 替换当前页面
  void replaceTo(String location, {Object? extra}) =>
      pushReplacement(location, extra: extra);

  // ============================================
  // 焦点相关
  // ============================================

  /// 隐藏键盘
  void hideKeyboard() => FocusScope.of(this).unfocus();

  /// 请求焦点
  void requestFocus(FocusNode node) => FocusScope.of(this).requestFocus(node);

  // ============================================
  // SnackBar / Dialog
  // ============================================

  /// 显示SnackBar
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 2),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// 显示错误SnackBar
  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// 显示成功SnackBar
  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF07C160),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// 显示确认对话框
  Future<bool> showConfirmDialog({
    required String title,
    required String content,
    String confirmText = '确定',
    String cancelText = '取消',
    bool isDanger = false,
  }) async {
    final result = await showDialog<bool>(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              cancelText,
              style: const TextStyle(color: Color(0xFF888888)),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              confirmText,
              style: TextStyle(
                color: isDanger ? Colors.red : const Color(0xFF07C160),
              ),
            ),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// 显示加载对话框
  void showLoadingDialog({String? message}) {
    showDialog<void>(
      context: this,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF07C160)),
              ),
              if (message != null) ...[
                const SizedBox(width: 16),
                Text(message),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// 隐藏加载对话框
  void hideLoadingDialog() {
    if (canPop) {
      pop<void>();
    }
  }
}

/// N42ChatTheme BuildContext 扩展
extension N42ChatThemeExtension on BuildContext {
  /// 获取N42ChatTheme
  ///
  /// 如果没有找到，返回默认的微信浅色主题
  N42ChatTheme get n42Theme {
    // TODO: 从InheritedWidget获取
    return isDarkMode ? N42ChatTheme.wechatDark() : N42ChatTheme.wechatLight();
  }
}

