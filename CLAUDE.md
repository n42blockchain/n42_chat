# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概览

`n42_chat` 是一个基于 Matrix 协议的微信风格聊天 Flutter Package。设计目标是**双模运行**：既能作为独立 App 运行（`example/`），也能作为 package 嵌入 N42 钱包等宿主应用。所有公开 API 都通过单例 `N42Chat` 暴露。

- Dart SDK: `>=3.9.0 <4.0.0`，Flutter `>=3.29.0`
- 加密栈：`matrix ^6.0.0` + `flutter_vodozemac`（取代旧的 `flutter_olm`，使用 vodozemac 后端）
- 入口：`lib/n42_chat.dart`（公开导出）→ `lib/src/n42_chat.dart`（`N42Chat` 单例实现）

## 常用命令

```bash
# 依赖与代码生成
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs   # drift / json_serializable / injectable
flutter gen-l10n                                                  # 重新生成 lib/l10n/app_localizations*.dart

# 运行 example（package 集成演示）
cd example && flutter run

# 静态分析与测试
flutter analyze
flutter test
flutter test test/unit/blocs/<file>_test.dart                     # 单文件
flutter test --plain-name "<test name>"                           # 按名称过滤

# Live smoke（需要可达的 Matrix 服务器，连接真实 homeserver）
dart tool/live_message_smoke.dart
dart tool/live_media_smoke.dart
flutter test test/live/                                            # 默认测试运行器版本
```

注意：`pubspec.lock`、`example/pubspec.lock`、`.flutter-plugins-dependencies` 已被 gitignore，本地拉取后必须 `flutter pub get` 重新生成。`example/android` 和 `example/ios` 也未入库，需 `flutter create --platforms=android,ios .` 在 example 目录内重新生成平台壳。

## 架构地图

代码遵循 Clean Architecture 分层，但**对外只暴露 `N42Chat` 单例**——所有页面、路由、BLoC、仓库都通过 GetIt 容器在初始化时注册。

```
lib/
├── n42_chat.dart                # 公开 API barrel（仅导出 src 的子集 + l10n）
└── src/
    ├── n42_chat.dart            # N42Chat 单例：initialize / dispose / chatWidget / routes / login / openConversation 等
    ├── n42_chat_config.dart     # N42ChatConfig + PushProtocolConfig（不可变配置）
    ├── core/
    │   ├── di/injection.dart    # GetIt 容器注册；configureDependencies(config) / resetDependencies()
    │   ├── router/app_router.dart  # N42ChatRouter.routes（GoRouter 路由表）
    │   ├── services/            # ChatLockService、N42ThemeManager、N42PushManager、N42CallFacade（part of n42_chat.dart）
    │   ├── notifications/       # FirebasePushService + PushNotificationService（FCM/APNs）
    │   └── encryption/          # E2EEManager（Olm/Megolm 设备验证）
    ├── data/
    │   ├── datasources/
    │   │   ├── matrix/          # 所有 Matrix SDK 包装层 —— 单一通信入口
    │   │   │   ├── matrix_client_manager.dart   # Client 单例 + vodozemac 初始化
    │   │   │   ├── matrix_auth_datasource.dart  # 登录 / 注册 / token / SSO
    │   │   │   ├── matrix_message_datasource.dart 等  # 每个领域一个 datasource
    │   │   │   └── message/     # 消息子模块（sender、media uploader、event mapper、poll handler 等）
    │   │   └── local/           # drift 数据库（archive_database, media_metadata_database）+ secure_storage + shared_prefs
    │   ├── repositories/        # IXxxRepository 的实现，桥接 datasource ↔ entity
    │   └── mappers/             # Matrix Event ↔ MessageEntity 转换
    ├── domain/
    │   ├── entities/            # 不可变业务对象（ConversationEntity, MessageEntity, UserEntity, …）
    │   └── repositories/        # 抽象接口（IAuthRepository, IConversationRepository, …）
    ├── presentation/
    │   ├── blocs/               # 每个功能域一个 BLoC（auth, chat, conversation, contact, group, …）
    │   ├── pages/               # 按功能组织的页面树（chat/, contact/, group/, profile/, mini_app/, voice_room/ …）
    │   └── widgets/             # 复用组件（widgets.dart 统一导出）
    ├── services/
    │   ├── auth/                # AuthMethodsService（Google/Apple/Twitter/Passkey/微信 等多渠道）
    │   ├── voip/                # CallManager、LiveKitService、WebRTCService、来电铃声
    │   └── ringtone/
    └── integration/             # 宿主集成边界
        ├── wallet_bridge.dart   # IWalletBridge（聊天内转账/红包）
        ├── api_hub_bridge.dart  # 主应用 API 转发
        └── bridge/              # Mautrix 桥（WhatsApp/Telegram/QQ 等多协议中继）
```

### 关键架构约定

1. **单一入口 `N42Chat`**（`lib/src/n42_chat.dart`）。它使用 Dart `part`/`part of` 把 `_N42ThemeManager`、`_N42PushManager`、`_N42CallFacade` 拼到同一个类作用域里——修改主题/推送/通话 facade 时必须同时改对应的 `core/services/n42_*_manager.dart` 文件。
2. **GetIt 容器贯穿全栈**：`configureDependencies(config)` 在 `initialize()` 里调用；`dispose()` 会 `resetDependencies()`。**不要手动 `new` 任何 datasource/repository/bloc**——它们必须从 `getIt<T>()` 拿。
3. **认证流是命令式 over Stream**：`N42Chat.login()` 等通过 `_runAuthEvent` 模式：往 `AuthBloc` 发事件 → `listen` AuthState 流 → 命中成功/错误状态时 `Completer` 完成。改任何登录/邮箱修改流程时保持这个模式，超时统一 30s。
4. **通知点击有缓冲队列**：在 `_navigatorKey` 或 `_initialized` 还没就绪时，`handleNotificationTap` 会缓存 `_pendingNotificationRoomId`，等 `setNavigatorKey` / `initialize` 后由 `_flushPendingNotificationTap` 触发。宿主接 push 时如果调用得太早**这是预期路径，不要绕过**。
5. **宿主回调钩子**：`setOpenWalletHandler` / `setOpenCardPackHandler` 让 chat 内的 `ServicesPage` 把"打开钱包/卡包"的动作委托给宿主；未注册时 ServicesPage 会降级为信息提示——保持可空语义。
6. **`chatWidget()` / `profileWidget()` 是三态控件**：未初始化时返回 `_N42ChatBootstrapWidget`（错误页 + 重试），未登录时返回欢迎页，已登录返回主框架。新增"主嵌入"控件时遵循同样三态。
7. **Matrix SDK 6 + vodozemac**：`MatrixClientManager` 负责 vodozemac 的全局初始化（一次），E2EE 走 `core/encryption/e2ee_manager.dart`。**禁止直接 `new Client()`**，永远经 `MatrixClientManager.instance` / `getIt<MatrixClientManager>()`。
8. **Moment 邀请监听**：`initialize()` 末尾会 `client.onSync.stream.listen` 自动接受 Moment 房间邀请，节流 10 秒。改 sync 监听时小心叠加多个 listener。
9. **国际化导出冲突**：`lib/n42_chat.dart` 用 `export 'l10n/app_localizations.dart' hide S;` 隐藏 `S` 类，避免和宿主应用同名 `S` 冲突。新增 l10n 不要破坏这个 hide。

### 数据流（消息发送举例）

```
ChatPage → ChatBloc → IMessageRepository (impl in data/repositories)
                   → MatrixMessageDataSource → message/matrix_message_sender.dart
                                            → MatrixClientManager.client.getRoomById().sendEvent(...)
                                            ↓ onTimelineEvent
                   ← matrix_event_mapper.dart 把 Event 转回 MessageEntity
                   ← drift 本地 archive_database 持久化
ChatBloc emit ChatState → UI 刷新
```

媒体走 `matrix_media_uploader.dart`（带 `pro_image_editor` 编辑、`google_mlkit_face_detection` 自动模糊），完成后再以 `m.image`/`m.video`/`m.file` 事件发出。

## 代码规范要点（来自 `analysis_options.yaml`）

- 启用 `strict-casts` / `strict-inference` / `strict-raw-types`：禁止隐式 `dynamic`、隐式 cast。
- `avoid_print`：调试日志统一用 `core/utils/debug_log.dart` 的 `debugLog()`，输出会被 `enableDebugLogs` config 开关控制。
- `prefer_single_quotes`、`always_declare_return_types`、`unawaited_futures` 都是 lint，违反会 CI 失败。
- 排除 `*.g.dart`、`*.freezed.dart`、`*.mocks.dart`、`*.drift.dart` —— **不要手改生成文件**，改源头后跑 `build_runner`。
- `dependency_overrides: flutter_secure_storage: ^10.0.0` 用于消解 `flutter_facebook_auth` 的旧依赖，新增依赖时若引入冲突优先在此处对齐版本。

## 工作流约定

- **`OPEN_ISSUES.md` 是未解决问题的唯一台账**（见 `AGENTS.md`）。任务结束时若留下任何 bug、未支持路径、部分实现或验证缺口，必须新增/更新条目；不要重复添加，匹配现有条目就更新 severity / 当前行为 / 下一步。仅在修复并验证后移除条目，或标 `Resolved`。
- **不记录推测性问题**——只记录在工作中实际观察到、有意推迟、或未验证的项。
- 提交相关：用户的 `~/.claude/CLAUDE.md` 全局规则要求**提交信息不要包含 Claude 字样**，本仓库遵循该约定。
- `QUICK_START.md` 是历史构建提示词，不代表当前能力；功能现状以 `README.md` 与源码为准。
