import 'package:equatable/equatable.dart';

/// Bot 配置实体
class BotConfig extends Equatable {
  /// 是否启用 Bot
  final bool enabled;

  /// 欢迎语模板（{name} 占位符替换为新成员名字）
  final String? welcomeMessage;

  const BotConfig({
    this.enabled = false,
    this.welcomeMessage,
  });

  factory BotConfig.fromJson(Map<String, dynamic> json) {
    return BotConfig(
      enabled: json['enabled'] as bool? ?? false,
      welcomeMessage: json['welcome_message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        if (welcomeMessage != null) 'welcome_message': welcomeMessage,
      };

  BotConfig copyWith({
    bool? enabled,
    String? welcomeMessage,
    bool clearWelcomeMessage = false,
  }) {
    return BotConfig(
      enabled: enabled ?? this.enabled,
      welcomeMessage: clearWelcomeMessage ? null : (welcomeMessage ?? this.welcomeMessage),
    );
  }

  @override
  List<Object?> get props => [enabled, welcomeMessage];
}
