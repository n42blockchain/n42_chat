# N42 Matrix Chat 快速启动指南

## 🚀 开始之前

### 环境要求
- Flutter SDK >= 3.19.0
- Dart SDK >= 3.3.0
- Android Studio / VS Code + Flutter插件
- Cursor IDE (使用Claude Opus 4.5)

### 工作流程
1. 打开Cursor IDE
2. 复制对应Phase的提示词
3. 粘贴到聊天窗口
4. 等待AI生成代码
5. 检查、测试、修正
6. 进入下一个Phase

---

## 📋 Phase 0: 项目初始化 (复制以下内容到Cursor)

```
你是资深Flutter架构师，请帮我创建一个名为 n42_chat 的Flutter Package项目。

要求：
1. 这是一个可独立运行、也可作为package嵌入其他应用的聊天模块
2. 采用Clean Architecture分层架构
3. 支持作为独立App运行(example目录)和作为package引用
4. 开源许可证合规（只使用MIT、Apache 2.0、BSD等商业友好许可）

请创建完整的项目结构：

n42_chat/
├── lib/
│   ├── n42_chat.dart              # 主入口
│   └── src/
│       ├── core/                  # 核心层（di, router, theme, utils, constants）
│       ├── data/                  # 数据层（datasources, models, repositories）
│       ├── domain/                # 领域层（entities, repositories接口, usecases）
│       └── presentation/          # 表现层（pages, widgets, blocs）
├── example/                       # 独立运行示例应用
├── test/
├── pubspec.yaml
├── analysis_options.yaml
└── README.md

pubspec.yaml核心依赖：
- matrix: ^0.24.0 (Matrix官方SDK, Apache 2.0)
- flutter_bloc: ^8.1.0 (状态管理, MIT)
- get_it: ^7.6.0 (依赖注入, MIT)
- go_router: ^13.0.0 (路由, BSD-3)
- drift: ^2.15.0 (本地数据库, MIT)
- dio: ^5.4.0 (HTTP, MIT)
- cached_network_image: ^3.3.0 (图片缓存, MIT)
- flutter_secure_storage: ^9.0.0 (安全存储, BSD-3)
- equatable: ^2.0.5 (MIT)
- json_annotation: ^4.8.0 (BSD-3)

请生成所有文件的完整内容，包括example应用的配置。
```

---

## 📋 Phase 1: 核心架构 (复制以下内容到Cursor)

### Step 1.1 - 依赖注入
```
继续n42_chat项目，使用get_it搭建依赖注入系统。

请创建：
1. lib/src/core/di/injection.dart - GetIt配置和初始化
2. lib/src/core/di/register_module.dart - 模块注册
3. 基础服务：ILoggerService, IStorageService 及其实现

使用@singleton和@lazySingleton注解，确保单例正确。
```

### Step 1.2 - 路由系统
```
继续n42_chat项目，使用go_router搭建路由系统。

路由表：
- /chat (会话列表)
- /chat/conversation/:id (会话详情)  
- /contacts (通讯录)
- /contacts/detail/:id (联系人详情)
- /discover (发现)
- /profile (我的)
- /login (登录)

要求：
1. 支持嵌套路由（作为主应用子路由）
2. 登录状态守卫
3. 微信风格转场动画

请创建 lib/src/core/router/ 下的所有文件。
```

### Step 1.3 - 微信风格主题
```
继续n42_chat项目，创建微信风格主题系统。

微信设计规范：
- 主色: #07C160
- 背景: #EDEDED  
- 导航: #F7F7F7
- 分割线: #E5E5E5
- 主文字: #181818
- 次文字: #888888

请创建 lib/src/core/theme/ 下：
1. app_colors.dart (颜色常量，支持深色模式)
2. app_text_styles.dart (文字样式)
3. app_theme.dart (完整ThemeData)
4. app_dimensions.dart (尺寸常量)
```

---

## 📋 Phase 2: Matrix集成 (复制以下内容到Cursor)

### Step 2.1 - Matrix客户端
```
继续n42_chat项目，集成Matrix SDK。

请创建：
1. lib/src/data/datasources/matrix/matrix_client_manager.dart
   - 单例管理Matrix Client
   - 连接、断开、重连
   - 事件监听

2. lib/src/data/datasources/matrix/matrix_auth_datasource.dart  
   - 登录（用户名/密码）
   - 注册
   - 登出
   - Token刷新

3. 对应的Repository接口和实现

要求：支持多homeserver，自动保存session，错误处理。
```

### Step 2.2 - 登录页面
```
继续n42_chat项目，实现微信风格登录页面。

请创建：
1. lib/src/presentation/blocs/auth/ (auth_bloc, event, state)
2. lib/src/presentation/pages/auth/
   - welcome_page.dart
   - login_page.dart  
   - register_page.dart
3. 相关输入组件

UI要求：简洁表单，绿色按钮，加载状态，错误提示。
使用BLoC管理状态。
```

---

## 📋 Phase 3: UI组件库 (复制以下内容到Cursor)

```
继续n42_chat项目，创建微信风格UI组件库。

请创建 lib/src/presentation/widgets/common/：
1. n42_app_bar.dart - 导航栏
2. n42_bottom_nav_bar.dart - 底部Tab导航
3. n42_list_tile.dart - 列表项
4. n42_avatar.dart - 圆角方形头像
5. n42_badge.dart - 红点徽章
6. n42_button.dart - 按钮组件
7. n42_search_bar.dart - 搜索框

请创建 lib/src/presentation/widgets/chat/：
1. message_bubble.dart - 消息气泡（绿色发送/白色接收）
2. chat_input_bar.dart - 输入栏
3. message_status_indicator.dart - 消息状态
4. time_separator.dart - 时间分隔线

所有组件支持深色模式，使用主题颜色。
```

---

## 📋 Phase 4-5: 聊天功能 (复制以下内容到Cursor)

```
继续n42_chat项目，实现完整的聊天功能。

请创建：

【数据层】
1. lib/src/domain/entities/
   - conversation_entity.dart
   - message_entity.dart

2. lib/src/data/models/ (带fromMatrix转换)
3. lib/src/domain/repositories/ (接口)
4. lib/src/data/repositories/ (实现)

【业务层】
5. lib/src/presentation/blocs/conversation_list/ (会话列表BLoC)
6. lib/src/presentation/blocs/chat/ (聊天BLoC)

【UI层】
7. lib/src/presentation/pages/conversation/
   - conversation_list_page.dart (会话列表)
8. lib/src/presentation/pages/chat/
   - chat_page.dart (聊天详情)

功能要求：
- 会话列表：置顶、未读数、最后消息、滑动删除
- 聊天页：消息列表、发送接收、时间分组、实时更新

模仿微信交互体验。
```

---

## 📋 Phase 6-7: 通讯录和个人中心 (复制以下内容到Cursor)

```
继续n42_chat项目，实现通讯录和个人中心。

【通讯录】
1. lib/src/presentation/pages/contacts/
   - contacts_page.dart (按字母分组，右侧索引)
   - contact_detail_page.dart
   - add_contact_page.dart

【发现页】
2. lib/src/presentation/pages/discover/
   - discover_page.dart (扫一扫、小程序入口预留)

【个人中心】
3. lib/src/presentation/pages/profile/
   - profile_page.dart (个人卡片+功能列表)
   - settings_page.dart
   - edit_profile_page.dart

4. 相关BLoC和数据层

模仿微信的页面布局和交互。
```

---

## 📋 Phase 8: 高级功能 (复制以下内容到Cursor)

```
继续n42_chat项目，实现高级功能。

【群聊】
1. 群聊实体、创建群、邀请成员、群管理页面

【多媒体消息】
2. 图片选择、语音录制、文件发送
3. 对应的消息气泡组件

【端对端加密】
4. encryption_service.dart
5. 设备验证页面
6. 加密状态显示

【消息通知】
7. notification_service.dart
8. 本地通知和推送处理

【消息搜索】
9. 全局搜索和会话内搜索

请按照现有架构实现。
```

---

## 📋 Phase 9: 插件化封装 (复制以下内容到Cursor)

```
继续n42_chat项目，完成插件化封装。

请创建/更新：

1. lib/n42_chat.dart - 导出公共API

2. lib/src/n42_chat.dart - 主类
```dart
class N42Chat {
  static Future<void> initialize(N42ChatConfig config);
  static Widget chatWidget();
  static List<RouteBase> routes();
  static Future<void> login(...);
  static Future<void> loginWithToken(...);
  static Future<void> logout();
  static bool get isLoggedIn;
  static Stream<int> get unreadCountStream;
  static void openConversation(String roomId);
  static Future<void> dispose();
}
```

3. lib/src/n42_chat_config.dart - 配置类

4. lib/src/core/theme/n42_chat_theme.dart - 主题定制

5. 更新README.md和创建INTEGRATION.md集成指南

6. 更新example展示完整集成方式
```

---

## 📋 Phase 10-11: 测试与钱包集成 (复制以下内容到Cursor)

```
继续n42_chat项目，完成测试和N42钱包集成。

【单元测试】
1. test/domain/usecases/ - UseCase测试
2. test/data/repositories/ - Repository测试
3. test/presentation/blocs/ - BLoC测试

【Widget测试】
4. test/presentation/widgets/ - 组件测试
5. test/presentation/pages/ - 页面测试

【性能优化】
6. ListView优化、const构造、RepaintBoundary
7. 图片缓存策略
8. 数据库索引

【钱包集成接口】
9. lib/src/integration/wallet_bridge.dart
```dart
abstract class IWalletBridge {
  bool get isWalletConnected;
  String? get walletAddress;
  Future<TransferResult> requestTransfer(...);
  Future<PaymentRequest> generatePaymentRequest(...);
}
```

10. 转账消息、收款请求消息组件
11. example中展示钱包集成
```

---

## 🔧 常用命令

```bash
# 创建Flutter package
flutter create --template=package n42_chat

# 进入项目目录
cd n42_chat

# 获取依赖
flutter pub get

# 运行example
cd example && flutter run

# 运行测试
flutter test

# 分析代码
flutter analyze

# 生成代码（如果使用build_runner）
flutter pub run build_runner build
```

---

## ⚠️ 常见问题处理

### 1. Matrix SDK连接问题
```
请检查n42_chat项目中Matrix SDK连接失败的问题。

错误信息：[粘贴错误]

请分析原因并提供修复。
```

### 2. BLoC状态问题
```
请检查n42_chat项目中[BLoC名称]的状态管理问题。

现象：[描述问题]
期望：[期望行为]

请分析并修复。
```

### 3. UI显示问题
```
请检查n42_chat项目中[组件名称]的显示问题。

问题：[描述问题]
设备/屏幕：[信息]

请修复并确保多屏幕适配。
```

---

## 📊 进度追踪

在每个Phase完成后，记录：
- [ ] Phase 0 完成 - 日期:____
- [ ] Phase 1 完成 - 日期:____
- [ ] Phase 2 完成 - 日期:____
- [ ] Phase 3 完成 - 日期:____
- [ ] Phase 4 完成 - 日期:____
- [ ] Phase 5 完成 - 日期:____
- [ ] Phase 6 完成 - 日期:____
- [ ] Phase 7 完成 - 日期:____
- [ ] Phase 8 完成 - 日期:____
- [ ] Phase 9 完成 - 日期:____
- [ ] Phase 10 完成 - 日期:____
- [ ] Phase 11 完成 - 日期:____

---

> 💡 提示：建议每完成一个Phase就进行一次git commit，便于回滚和追踪。

