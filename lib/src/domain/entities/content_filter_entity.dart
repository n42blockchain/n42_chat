import 'package:equatable/equatable.dart';

/// 关键词过滤动作
enum FilterAction {
  /// 将匹配内容替换为 ***
  replace,

  /// 完全隐藏消息
  hide,
}

/// 关键词过滤配置
class ContentFilterConfig extends Equatable {
  /// 是否启用
  final bool enabled;

  /// 禁止词列表
  final List<String> forbiddenWords;

  /// 过滤动作
  final FilterAction action;

  const ContentFilterConfig({
    this.enabled = false,
    this.forbiddenWords = const [],
    this.action = FilterAction.replace,
  });

  factory ContentFilterConfig.fromJson(Map<String, dynamic> json) {
    final actionStr = json['action'] as String? ?? 'replace';
    return ContentFilterConfig(
      enabled: json['enabled'] as bool? ?? false,
      forbiddenWords: (json['forbidden_words'] as List?)?.cast<String>() ?? [],
      action: actionStr == 'hide' ? FilterAction.hide : FilterAction.replace,
    );
  }

  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'forbidden_words': forbiddenWords,
        'action': action == FilterAction.hide ? 'hide' : 'replace',
      };

  ContentFilterConfig copyWith({
    bool? enabled,
    List<String>? forbiddenWords,
    FilterAction? action,
  }) {
    return ContentFilterConfig(
      enabled: enabled ?? this.enabled,
      forbiddenWords: forbiddenWords ?? this.forbiddenWords,
      action: action ?? this.action,
    );
  }

  @override
  List<Object?> get props => [enabled, forbiddenWords, action];
}
