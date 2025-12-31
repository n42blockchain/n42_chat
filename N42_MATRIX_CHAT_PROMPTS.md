# N42 Matrix Chat 客户端开发提示词系统

> 本文档为在 Cursor IDE 中使用 Claude Opus 4.5 分阶段构建类微信UI的Matrix客户端的完整提示词指南

---

## 📋 目录

1. [项目概述与架构愿景](#1-项目概述与架构愿景)
2. [开源合规与技术选型](#2-开源合规与技术选型)
3. [分阶段实施路线图](#3-分阶段实施路线图)
4. [Phase 0: 项目初始化](#phase-0-项目初始化)
5. [Phase 1: 核心架构搭建](#phase-1-核心架构搭建)
6. [Phase 2: Matrix SDK 集成](#phase-2-matrix-sdk-集成)
7. [Phase 3: 微信风格UI组件库](#phase-3-微信风格ui组件库)
8. [Phase 4: 会话列表与消息页面](#phase-4-会话列表与消息页面)
9. [Phase 5: 消息发送与接收](#phase-5-消息发送与接收)
10. [Phase 6: 通讯录与联系人](#phase-6-通讯录与联系人)
11. [Phase 7: 发现页与个人中心](#phase-7-发现页与个人中心)
12. [Phase 8: 高级功能](#phase-8-高级功能)
13. [Phase 9: 插件化封装](#phase-9-插件化封装)
14. [Phase 10: 测试与优化](#phase-10-测试与优化)
15. [Phase 11: N42钱包集成](#phase-11-n42钱包集成)

---

## 1. 项目概述与架构愿景

### 项目定位
- **产品名称**: N42 Matrix Chat
- **核心定位**: 去中心化、端对端加密的即时通讯客户端
- **UI风格**: 接近微信的简洁、高效交互体验
- **架构模式**: 可独立运行的Flutter Package，支持作为插件嵌入主应用

### 架构设计原则
```
┌─────────────────────────────────────────────────────────────┐
│                    N42 Wallet App (主应用)                    │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────────────┐ │
│  │  钱包   │  │  交易   │  │  发现   │  │   n42_chat      │ │
│  │  Tab    │  │  Tab    │  │  Tab    │  │   (插件模块)     │ │
│  └─────────┘  └─────────┘  └─────────┘  └─────────────────┘ │
├─────────────────────────────────────────────────────────────┤
│                      共享服务层                               │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
│  │  Auth       │  │  Storage    │  │  Notification       │  │
│  └─────────────┘  └─────────────┘  └─────────────────────┘  │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                 n42_chat Package (独立模块)                   │
├─────────────────────────────────────────────────────────────┤
│  Presentation Layer (UI)                                    │
│  ├── pages/          # 页面                                  │
│  ├── widgets/        # 组件                                  │
│  └── themes/         # 主题                                  │
├─────────────────────────────────────────────────────────────┤
│  Domain Layer (业务逻辑)                                      │
│  ├── entities/       # 实体                                  │
│  ├── repositories/   # 仓库接口                              │
│  └── usecases/       # 用例                                  │
├─────────────────────────────────────────────────────────────┤
│  Data Layer (数据)                                           │
│  ├── datasources/    # 数据源                                │
│  ├── models/         # 数据模型                              │
│  └── repositories/   # 仓库实现                              │
├─────────────────────────────────────────────────────────────┤
│  Core Layer (核心)                                           │
│  ├── di/             # 依赖注入                              │
│  ├── utils/          # 工具类                                │
│  └── constants/      # 常量                                  │
└─────────────────────────────────────────────────────────────┘
```

---

## 2. 开源合规与技术选型

### 许可证合规矩阵

| 依赖包 | 许可证 | 合规性 | 备注 |
|-------|-------|--------|------|
| matrix_sdk | Apache 2.0 | ✅ 商业友好 | Matrix官方Dart SDK |
| flutter_bloc | MIT | ✅ 商业友好 | 状态管理 |
| get_it | MIT | ✅ 商业友好 | 依赖注入 |
| drift | MIT | ✅ 商业友好 | 本地数据库 |
| dio | MIT | ✅ 商业友好 | HTTP客户端 |
| cached_network_image | MIT | ✅ 商业友好 | 图片缓存 |
| flutter_secure_storage | BSD-3 | ✅ 商业友好 | 安全存储 |

### 推荐技术栈
```yaml
# 核心框架
flutter: ^3.19.0
dart: ^3.3.0

# Matrix协议
matrix: ^0.24.0  # 官方Matrix Dart SDK

# 状态管理
flutter_bloc: ^8.1.0
bloc: ^8.1.0

# 依赖注入
get_it: ^7.6.0
injectable: ^2.3.0

# 本地存储
drift: ^2.15.0
sqflite: ^2.3.0
flutter_secure_storage: ^9.0.0

# 网络
dio: ^5.4.0

# UI组件
cached_network_image: ^3.3.0
shimmer: ^3.0.0
flutter_slidable: ^3.0.0
pull_to_refresh: ^2.0.0

# 工具
equatable: ^2.0.5
json_annotation: ^4.8.0
intl: ^0.18.0
```

---

## 3. 分阶段实施路线图

```
Phase 0 (1天)     → 项目初始化、目录结构、基础配置
Phase 1 (2天)     → 核心架构搭建、DI、路由、主题
Phase 2 (3天)     → Matrix SDK 集成、登录认证
Phase 3 (3天)     → 微信风格UI组件库
Phase 4 (4天)     → 会话列表、消息详情页面
Phase 5 (4天)     → 消息发送接收、实时同步
Phase 6 (3天)     → 通讯录、联系人管理
Phase 7 (2天)     → 发现页、个人中心
Phase 8 (5天)     → 高级功能(语音、图片、群聊)
Phase 9 (2天)     → 插件化封装、API设计
Phase 10 (3天)    → 测试、性能优化
Phase 11 (2天)    → N42钱包集成对接

总计: 约34天
```

---

## Phase 0: 项目初始化

### Prompt 0.1 - 创建项目结构

```
你是资深Flutter架构师，请帮我创建一个名为 n42_chat 的Flutter Package项目。

要求：
1. 这是一个可独立运行、也可作为package嵌入其他应用的聊天模块
2. 采用Clean Architecture分层架构
3. 支持作为独立App运行(example目录)和作为package引用

请执行以下操作：

1. 创建Flutter package项目结构：
```
n42_chat/
├── lib/
│   ├── n42_chat.dart              # 主入口，导出公共API
│   ├── src/
│   │   ├── core/                  # 核心层
│   │   │   ├── di/                # 依赖注入
│   │   │   ├── router/            # 路由
│   │   │   ├── theme/             # 主题
│   │   │   ├── utils/             # 工具
│   │   │   ├── constants/         # 常量
│   │   │   └── extensions/        # 扩展
│   │   ├── data/                  # 数据层
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/                # 领域层
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/          # 表现层
│   │       ├── pages/
│   │       ├── widgets/
│   │       └── blocs/
├── example/                       # 独立运行示例
├── test/                          # 测试
├── pubspec.yaml
└── README.md
```

2. 创建 pubspec.yaml，包含以下依赖（注意开源许可证合规）:
   - matrix: ^0.24.0 (Apache 2.0)
   - flutter_bloc: ^8.1.0 (MIT)
   - get_it: ^7.6.0 (MIT)
   - go_router: ^13.0.0 (BSD-3)
   - drift: ^2.15.0 (MIT)
   - dio: ^5.4.0 (MIT)
   - cached_network_image: ^3.3.0 (MIT)
   - flutter_secure_storage: ^9.0.0 (BSD-3)
   - equatable: ^2.0.5 (MIT)
   - json_annotation: ^4.8.0 (BSD-3)
   - intl: ^0.18.0 (BSD-3)
   
3. 创建基础的导出文件 n42_chat.dart

4. 配置 analysis_options.yaml 启用严格模式

请生成所有必要的文件内容。
```

### Prompt 0.2 - 创建Example应用

```
继续n42_chat项目，在example目录下创建一个可独立运行的示例应用。

要求：
1. example应用依赖父目录的n42_chat package
2. 包含完整的main.dart启动文件
3. 配置好MaterialApp和必要的初始化
4. 支持iOS和Android运行

请创建：
1. example/pubspec.yaml - 引用path依赖的n42_chat
2. example/lib/main.dart - 启动入口
3. example/README.md - 运行说明
```

---

## Phase 1: 核心架构搭建

### Prompt 1.1 - 依赖注入配置

```
你是资深Flutter架构师，请在n42_chat项目中搭建依赖注入系统。

使用 get_it + injectable 实现自动化依赖注入。

请创建以下文件：

1. lib/src/core/di/injection.dart
   - 配置GetIt实例
   - 初始化函数 configureDependencies()
   - 支持不同环境(dev, prod)

2. lib/src/core/di/register_module.dart
   - 注册第三方依赖
   - 注册单例服务

3. 基础服务接口和实现：
   - ILoggerService / LoggerServiceImpl
   - IStorageService / StorageServiceImpl (使用flutter_secure_storage)

使用@singleton, @lazySingleton, @injectable注解。
确保代码符合Clean Architecture原则。
```

### Prompt 1.2 - 路由系统

```
继续n42_chat项目，使用go_router搭建模块化路由系统。

要求：
1. 支持嵌套路由（作为主应用的子路由时）
2. 支持独立路由（作为独立应用时）
3. 路由守卫（登录状态检查）
4. 页面转场动画（模仿微信的滑动效果）

请创建：

1. lib/src/core/router/app_router.dart
   - N42ChatRouter类
   - 配置所有页面路由
   - 提供给外部使用的路由配置

2. lib/src/core/router/routes.dart
   - 定义所有路由常量

3. lib/src/core/router/route_guards.dart
   - AuthGuard 登录检查

路由表设计：
- /chat                    # 聊天Tab主页（会话列表）
- /chat/conversation/:id   # 会话详情
- /contacts                # 通讯录Tab
- /contacts/detail/:id     # 联系人详情
- /discover                # 发现Tab
- /profile                 # 我的Tab
- /profile/settings        # 设置
- /login                   # 登录页
```

### Prompt 1.3 - 主题系统（微信风格）

```
继续n42_chat项目，创建模仿微信风格的主题系统。

微信设计规范：
1. 主色调：#07C160 (微信绿)
2. 背景色：#EDEDED (浅灰)
3. 导航栏：#F7F7F7
4. 分割线：#E5E5E5
5. 文字颜色：
   - 主要文字：#181818
   - 次要文字：#888888
   - 辅助文字：#B2B2B2
6. 字体大小：
   - 标题：17sp
   - 正文：15sp
   - 辅助：12sp

请创建：

1. lib/src/core/theme/app_colors.dart
   - 所有颜色常量
   - 支持深色模式

2. lib/src/core/theme/app_text_styles.dart
   - 所有文字样式

3. lib/src/core/theme/app_theme.dart
   - ThemeData配置
   - 浅色主题
   - 深色主题

4. lib/src/core/theme/app_dimensions.dart
   - 间距、圆角等尺寸常量
```

### Prompt 1.4 - 基础工具类

```
继续n42_chat项目，创建基础工具类和扩展方法。

请创建：

1. lib/src/core/utils/date_utils.dart
   - 时间格式化（模仿微信：刚刚、几分钟前、昨天、星期几、日期）
   - 消息时间分组

2. lib/src/core/utils/string_utils.dart
   - 字符串处理
   - 表情解析

3. lib/src/core/extensions/context_extension.dart
   - BuildContext扩展
   - 快捷访问Theme、MediaQuery等

4. lib/src/core/extensions/string_extension.dart
   - String扩展方法

5. lib/src/core/constants/app_constants.dart
   - 应用常量

6. lib/src/core/constants/asset_paths.dart
   - 资源路径常量
```

---

## Phase 2: Matrix SDK 集成

### Prompt 2.1 - Matrix客户端封装

```
你是资深Flutter架构师和Matrix协议专家，请在n42_chat项目中集成Matrix SDK。

使用官方 matrix 包 (Apache 2.0许可证)。

请创建：

1. lib/src/data/datasources/matrix/matrix_client_manager.dart
   - MatrixClientManager 单例类
   - 管理Matrix Client实例
   - 处理连接、断开、重连
   - 事件监听

2. lib/src/data/datasources/matrix/matrix_auth_datasource.dart
   - 登录（用户名/密码）
   - 登录（SSO）
   - 注册
   - 登出
   - Token刷新

3. lib/src/domain/repositories/auth_repository.dart
   - IAuthRepository 接口定义

4. lib/src/data/repositories/auth_repository_impl.dart
   - AuthRepositoryImpl 实现

核心功能：
- 支持多homeserver
- 自动保存和恢复session
- 处理设备验证
- 错误处理和重试机制
```

### Prompt 2.2 - 登录页面实现

```
继续n42_chat项目，实现模仿微信风格的登录页面。

登录流程：
1. 欢迎页 → 选择登录/注册
2. 登录页 → 输入homeserver、用户名、密码
3. 支持记住登录状态

UI要求（模仿微信）：
- 简洁的表单布局
- 绿色主按钮
- 底部协议链接
- 加载状态动画

请创建：

1. lib/src/presentation/blocs/auth/
   - auth_bloc.dart
   - auth_event.dart
   - auth_state.dart

2. lib/src/presentation/pages/auth/
   - welcome_page.dart (欢迎页)
   - login_page.dart (登录页)
   - register_page.dart (注册页)

3. lib/src/presentation/widgets/auth/
   - server_input_field.dart (服务器输入)
   - auth_button.dart (登录按钮)
   - auth_text_field.dart (输入框)

使用BLoC模式管理状态，处理加载、成功、失败状态。
```

### Prompt 2.3 - Session持久化

```
继续n42_chat项目，实现Matrix会话的安全持久化存储。

要求：
1. 使用flutter_secure_storage存储敏感信息
2. 使用drift存储非敏感数据
3. 支持多账号

请创建：

1. lib/src/data/datasources/local/secure_storage_datasource.dart
   - 加密存储access_token, device_id等

2. lib/src/data/datasources/local/database/
   - app_database.dart (Drift数据库配置)
   - tables/ (表定义)
     - sessions_table.dart
     - accounts_table.dart

3. lib/src/data/models/session_model.dart
   - 会话数据模型

4. lib/src/domain/usecases/
   - restore_session_usecase.dart (恢复会话)
   - save_session_usecase.dart (保存会话)
```

---

## Phase 3: 微信风格UI组件库

### Prompt 3.1 - 基础组件

```
你是资深Flutter UI工程师，请为n42_chat创建模仿微信风格的基础UI组件库。

设计原则：
1. 简洁、高效
2. 符合微信视觉规范
3. 支持深色模式
4. 高度可定制

请创建 lib/src/presentation/widgets/common/ 目录下的组件：

1. n42_app_bar.dart
   - 微信风格导航栏
   - 支持标题、左右按钮
   - 返回按钮样式

2. n42_bottom_nav_bar.dart
   - 底部导航栏
   - 4个Tab：消息、通讯录、发现、我
   - 未读消息红点

3. n42_list_tile.dart
   - 通用列表项
   - 支持头像、标题、副标题、右侧widget
   - 点击效果

4. n42_avatar.dart
   - 圆角矩形头像（微信风格）
   - 支持网络图片、本地图片、默认头像
   - 支持群组头像九宫格

5. n42_badge.dart
   - 红点徽章
   - 数字徽章
   - 新消息提示

6. n42_button.dart
   - 主要按钮（绿色）
   - 次要按钮
   - 文字按钮
   - 加载状态

7. n42_search_bar.dart
   - 微信风格搜索框
   - 支持取消按钮
   - 搜索建议
```

### Prompt 3.2 - 聊天相关组件

```
继续n42_chat项目，创建聊天相关的UI组件。

请创建 lib/src/presentation/widgets/chat/ 目录下的组件：

1. message_bubble.dart
   - 文字消息气泡
   - 区分发送/接收样式
   - 微信绿色/白色气泡
   - 尖角设计

2. message_status_indicator.dart
   - 发送中、已发送、已读状态
   - 发送失败重试

3. chat_input_bar.dart
   - 输入框
   - 语音按钮
   - 表情按钮
   - 更多功能按钮
   - 发送按钮

4. voice_message_widget.dart
   - 语音消息显示
   - 播放动画
   - 时长显示

5. image_message_widget.dart
   - 图片消息
   - 缩略图
   - 点击放大

6. time_separator.dart
   - 消息时间分隔线

7. system_message_widget.dart
   - 系统消息（入群、退群等）

8. typing_indicator.dart
   - 对方正在输入提示
```

### Prompt 3.3 - 动画和手势

```
继续n42_chat项目，实现微信风格的动画和手势交互。

请创建：

1. lib/src/presentation/widgets/animations/
   - fade_slide_transition.dart (页面转场)
   - scale_tap_animation.dart (点击缩放)
   - loading_animation.dart (加载动画)

2. lib/src/presentation/widgets/gestures/
   - swipe_to_delete.dart (滑动删除)
   - long_press_menu.dart (长按菜单)
   - pull_to_refresh_header.dart (下拉刷新)

3. lib/src/core/utils/haptic_utils.dart
   - 触觉反馈工具

特效要求：
- 列表项点击有微小缩放
- 页面转场滑动效果
- 消息发送有弹性动画
- 下拉刷新有阻尼效果
```

---

## Phase 4: 会话列表与消息页面

### Prompt 4.1 - 会话实体和数据层

```
你是资深Flutter架构师，请实现n42_chat的会话(Conversation)功能数据层。

请创建：

1. lib/src/domain/entities/
   - conversation_entity.dart
     - id, name, avatarUrl
     - lastMessage, lastMessageTime
     - unreadCount
     - isDirect (是否单聊)
     - isEncrypted (是否加密)
     - isPinned (是否置顶)
     - isMuted (是否免打扰)

   - message_entity.dart
     - id, roomId, senderId
     - content, type (text, image, voice, file, etc.)
     - timestamp, status
     - replyTo (回复的消息)

2. lib/src/data/models/
   - conversation_model.dart (包含fromMatrix, toEntity方法)
   - message_model.dart

3. lib/src/domain/repositories/
   - conversation_repository.dart (接口)

4. lib/src/data/repositories/
   - conversation_repository_impl.dart (实现)

5. lib/src/domain/usecases/conversation/
   - get_conversations_usecase.dart
   - get_conversation_detail_usecase.dart
   - pin_conversation_usecase.dart
   - mute_conversation_usecase.dart
   - delete_conversation_usecase.dart
```

### Prompt 4.2 - 会话列表BLoC

```
继续n42_chat项目，实现会话列表的状态管理。

请创建 lib/src/presentation/blocs/conversation_list/:

1. conversation_list_bloc.dart
2. conversation_list_event.dart
   - LoadConversations
   - RefreshConversations
   - ConversationUpdated (来自Matrix同步)
   - PinConversation
   - MuteConversation
   - DeleteConversation
   - SearchConversations

3. conversation_list_state.dart
   - Initial
   - Loading
   - Loaded (conversations, pinnedConversations)
   - Error

功能要求：
- 实时监听Matrix房间更新
- 支持置顶排序
- 支持搜索过滤
- 支持分页加载
```

### Prompt 4.3 - 会话列表页面

```
继续n42_chat项目，实现微信风格的会话列表页面。

请创建：

1. lib/src/presentation/pages/conversation/
   - conversation_list_page.dart

页面结构：
- 顶部：导航栏（标题"消息"、右上角"+"按钮）
- 搜索栏（点击展开）
- 置顶会话区域
- 普通会话列表
- 空状态提示

2. lib/src/presentation/widgets/conversation/
   - conversation_list_item.dart
     - 头像（圆角方形）
     - 会话名称
     - 最后一条消息预览
     - 时间
     - 未读数红点
     - 免打扰图标
     - 滑动操作（置顶、删除）

   - conversation_search_delegate.dart
     - 搜索代理

交互效果：
- 下拉刷新
- 左滑显示操作按钮
- 长按显示菜单
- 点击进入会话详情
```

### Prompt 4.4 - 消息详情页BLoC

```
继续n42_chat项目，实现消息详情页的状态管理。

请创建 lib/src/presentation/blocs/chat/:

1. chat_bloc.dart
2. chat_event.dart
   - LoadMessages (初始加载)
   - LoadMoreMessages (加载历史)
   - SendMessage
   - DeleteMessage
   - ResendMessage
   - MessageReceived (实时接收)
   - StartTyping
   - StopTyping
   - MarkAsRead

3. chat_state.dart
   - Initial
   - Loading
   - Loaded
     - messages: List<MessageEntity>
     - hasMore: bool
     - isLoadingMore: bool
     - typingUsers: List<String>
   - Sending
   - Error

功能：
- 消息分页加载（向上滚动加载历史）
- 实时接收新消息
- 发送状态管理
- 已读回执
- 正在输入状态
```

### Prompt 4.5 - 消息详情页面

```
继续n42_chat项目，实现微信风格的消息详情页面。

请创建：

1. lib/src/presentation/pages/chat/
   - chat_page.dart

页面结构：
- 导航栏（对方名称、右上角更多按钮）
- 消息列表（倒序，新消息在底部）
- 时间分隔线（超过5分钟显示时间）
- 底部输入栏

2. lib/src/presentation/widgets/chat/
   - chat_message_list.dart
     - 使用ListView.builder
     - 滚动到底部按钮
     - 新消息提示

   - chat_input_panel.dart
     - 文本输入
     - 语音/键盘切换
     - 表情面板
     - 更多功能面板（图片、拍照、位置等）

3. 消息气泡样式：
   - 发送方：绿色背景，右对齐，右侧尖角
   - 接收方：白色背景，左对齐，左侧尖角
   - 头像显示在气泡旁边

交互：
- 长按消息显示操作菜单（复制、删除、回复等）
- 点击图片放大预览
- 滑动回复
- 键盘弹出时自动滚动
```

---

## Phase 5: 消息发送与接收

### Prompt 5.1 - 消息数据源

```
继续n42_chat项目，实现消息的数据源层。

请创建：

1. lib/src/data/datasources/matrix/
   - message_datasource.dart
     - sendTextMessage()
     - sendImageMessage()
     - sendVoiceMessage()
     - sendFileMessage()
     - getMessages() (分页)
     - deleteMessage()
     - editMessage()
     - reactToMessage()

2. lib/src/domain/repositories/
   - message_repository.dart (接口)

3. lib/src/data/repositories/
   - message_repository_impl.dart (实现)

4. lib/src/domain/usecases/message/
   - send_text_message_usecase.dart
   - send_image_message_usecase.dart
   - get_messages_usecase.dart
   - delete_message_usecase.dart

处理：
- Matrix Event转换
- 消息加密（E2EE）
- 发送队列
- 失败重试
```

### Prompt 5.2 - 实时消息同步

```
继续n42_chat项目，实现Matrix实时消息同步。

请创建：

1. lib/src/data/datasources/matrix/
   - sync_datasource.dart
     - 启动同步
     - 停止同步
     - 处理sync响应
     - 事件流

2. lib/src/core/services/
   - sync_service.dart
     - 管理同步生命周期
     - 分发事件到对应的BLoC
     - 处理网络断开重连

3. lib/src/data/datasources/matrix/
   - event_handler.dart
     - 解析不同类型的Matrix事件
     - 转换为应用实体

事件类型处理：
- m.room.message (普通消息)
- m.room.encrypted (加密消息)
- m.room.member (成员变更)
- m.typing (正在输入)
- m.receipt (已读回执)
- m.room.redaction (消息撤回)
```

### Prompt 5.3 - 多媒体消息

```
继续n42_chat项目，实现多媒体消息功能。

请创建：

1. lib/src/presentation/widgets/chat/media/
   - image_picker_sheet.dart (图片选择)
   - camera_capture.dart (拍照)
   - voice_recorder.dart (语音录制)
   - file_picker_sheet.dart (文件选择)

2. lib/src/data/datasources/
   - media_upload_datasource.dart
     - 上传图片到Matrix content repository
     - 上传语音
     - 上传文件
     - 生成缩略图

3. lib/src/core/services/
   - media_service.dart
     - 图片压缩
     - 语音编码
     - 文件类型检测

4. lib/src/presentation/widgets/chat/
   - image_message_bubble.dart (图片消息气泡)
   - voice_message_bubble.dart (语音消息气泡)
   - file_message_bubble.dart (文件消息气泡)
   - video_message_bubble.dart (视频消息气泡)

语音消息要求：
- 按住录音
- 上滑取消
- 播放动画
- 未读红点
```

### Prompt 5.4 - 本地消息缓存

```
继续n42_chat项目，实现消息的本地缓存。

请创建：

1. lib/src/data/datasources/local/database/tables/
   - messages_table.dart
   - media_cache_table.dart

2. lib/src/data/datasources/local/
   - message_cache_datasource.dart
     - 缓存消息
     - 查询消息
     - 删除过期缓存

3. lib/src/core/services/
   - cache_service.dart
     - 管理缓存策略
     - 清理过期数据
     - 缓存大小限制

功能：
- 消息本地存储
- 离线查看历史消息
- 媒体文件缓存
- 增量同步
```

---

## Phase 6: 通讯录与联系人

### Prompt 6.1 - 联系人数据层

```
继续n42_chat项目，实现联系人功能。

请创建：

1. lib/src/domain/entities/
   - contact_entity.dart
     - userId, displayName, avatarUrl
     - presence (在线状态)
     - lastActiveTime

2. lib/src/data/models/
   - contact_model.dart

3. lib/src/domain/repositories/
   - contact_repository.dart

4. lib/src/data/repositories/
   - contact_repository_impl.dart

5. lib/src/data/datasources/matrix/
   - contact_datasource.dart
     - getContacts() (从已有会话中提取)
     - searchUsers() (搜索Matrix用户)
     - addContact() (创建DM房间)
     - blockUser()
     - unblockUser()

6. lib/src/domain/usecases/contact/
   - get_contacts_usecase.dart
   - search_users_usecase.dart
   - add_contact_usecase.dart
```

### Prompt 6.2 - 通讯录页面

```
继续n42_chat项目，实现微信风格的通讯录页面。

请创建：

1. lib/src/presentation/blocs/contacts/
   - contacts_bloc.dart
   - contacts_event.dart
   - contacts_state.dart

2. lib/src/presentation/pages/contacts/
   - contacts_page.dart

页面结构（模仿微信）：
- 顶部功能入口
  - 新的朋友（好友请求）
  - 群聊
  - 标签
  - 公众号（可选）
- 联系人列表
  - 按字母分组
  - 右侧字母索引
  - 点击跳转

3. lib/src/presentation/widgets/contacts/
   - contact_list_item.dart
   - contact_index_bar.dart (右侧字母导航)
   - contact_section_header.dart (分组标题)

4. lib/src/presentation/pages/contacts/
   - contact_detail_page.dart
     - 头像、昵称
     - 发消息按钮
     - 备注设置
     - 更多操作
```

### Prompt 6.3 - 添加好友

```
继续n42_chat项目，实现添加好友功能。

请创建：

1. lib/src/presentation/pages/contacts/
   - add_contact_page.dart
     - 搜索框
     - 搜索结果列表
     - Matrix ID输入

   - friend_request_page.dart
     - 好友请求列表
     - 接受/拒绝操作

2. lib/src/presentation/widgets/contacts/
   - user_search_result_item.dart
   - friend_request_item.dart

3. 处理Matrix invite/join流程
```

---

## Phase 7: 发现页与个人中心

### Prompt 7.1 - 发现页

```
继续n42_chat项目，实现发现页面。

请创建：

1. lib/src/presentation/pages/discover/
   - discover_page.dart

页面结构（模仿微信发现页）：
- 分组列表
  - 朋友圈（可选/预留）
  - 扫一扫
  - 小程序（预留给N42 DApps）
  - 公众号（可选）

2. lib/src/presentation/widgets/discover/
   - discover_list_item.dart
   - discover_section.dart

3. lib/src/presentation/pages/discover/
   - qr_scanner_page.dart (扫码页面)
   - my_qr_code_page.dart (我的二维码)
```

### Prompt 7.2 - 个人中心

```
继续n42_chat项目，实现个人中心页面。

请创建：

1. lib/src/presentation/pages/profile/
   - profile_page.dart

页面结构（模仿微信我的页面）：
- 顶部个人卡片
  - 头像
  - 昵称
  - Matrix ID
  - 二维码入口
- 功能列表
  - 服务（预留N42钱包服务）
  - 设置
  - 账号与安全

2. lib/src/presentation/pages/profile/
   - edit_profile_page.dart (编辑资料)
   - settings_page.dart (设置)
   - account_security_page.dart (账号与安全)

3. lib/src/presentation/widgets/profile/
   - profile_header.dart
   - settings_list_item.dart

4. 设置项：
   - 新消息通知
   - 隐私设置
   - 通用设置
   - 关于
   - 退出登录
```

### Prompt 7.3 - 个人资料编辑

```
继续n42_chat项目，实现个人资料编辑功能。

请创建：

1. lib/src/presentation/blocs/profile/
   - profile_bloc.dart
   - profile_event.dart
   - profile_state.dart

2. lib/src/domain/usecases/profile/
   - get_profile_usecase.dart
   - update_display_name_usecase.dart
   - update_avatar_usecase.dart

3. lib/src/data/datasources/matrix/
   - profile_datasource.dart
     - getProfile()
     - setDisplayName()
     - setAvatarUrl()

4. 编辑页面功能：
   - 修改头像（拍照/相册）
   - 修改昵称
   - 修改签名
```

---

## Phase 8: 高级功能

### Prompt 8.1 - 群聊功能

```
继续n42_chat项目，实现群聊功能。

请创建：

1. lib/src/domain/entities/
   - group_entity.dart
     - roomId, name, avatarUrl
     - memberCount
     - topic (群公告)
     - isAdmin

2. lib/src/presentation/pages/group/
   - create_group_page.dart (创建群聊)
   - group_info_page.dart (群资料)
   - group_members_page.dart (群成员)
   - invite_members_page.dart (邀请成员)

3. lib/src/presentation/widgets/group/
   - group_avatar.dart (九宫格头像)
   - member_grid.dart (成员网格)
   - group_notice.dart (群公告)

4. lib/src/domain/usecases/group/
   - create_group_usecase.dart
   - invite_member_usecase.dart
   - kick_member_usecase.dart
   - leave_group_usecase.dart
   - update_group_info_usecase.dart
```

### Prompt 8.2 - 端对端加密

```
继续n42_chat项目，实现端对端加密(E2EE)功能。

请创建：

1. lib/src/core/services/
   - encryption_service.dart
     - 初始化加密
     - 密钥管理
     - 设备验证

2. lib/src/presentation/pages/security/
   - device_verification_page.dart (设备验证)
   - key_backup_page.dart (密钥备份)
   - encrypted_room_info.dart (加密信息)

3. lib/src/presentation/widgets/security/
   - encryption_badge.dart (加密标识)
   - verification_emoji.dart (验证表情)

4. 功能：
   - 自动加密新会话
   - 设备交叉签名
   - 密钥恢复
   - 加密状态显示
```

### Prompt 8.3 - 消息通知

```
继续n42_chat项目，实现消息通知功能。

请创建：

1. lib/src/core/services/
   - notification_service.dart
     - 本地通知
     - 推送通知处理
     - 通知点击处理

2. lib/src/data/datasources/
   - push_notification_datasource.dart
     - 注册推送
     - 处理FCM/APNs

3. 配置文件：
   - android/app/src/main/AndroidManifest.xml (通知权限)
   - ios相关配置说明

4. 通知功能：
   - 新消息通知
   - 通知分组
   - 静音会话不通知
   - 点击通知跳转到对应会话
```

### Prompt 8.4 - 消息搜索

```
继续n42_chat项目，实现消息搜索功能。

请创建：

1. lib/src/presentation/pages/search/
   - global_search_page.dart
     - 搜索联系人
     - 搜索群聊
     - 搜索聊天记录

   - chat_search_page.dart
     - 会话内搜索

2. lib/src/presentation/blocs/search/
   - search_bloc.dart
   - search_event.dart
   - search_state.dart

3. lib/src/domain/usecases/search/
   - search_messages_usecase.dart
   - search_contacts_usecase.dart
   - search_rooms_usecase.dart

4. 搜索功能：
   - 本地搜索（已缓存消息）
   - 服务器搜索（历史消息）
   - 搜索结果高亮
   - 跳转到对应消息位置
```

---

## Phase 9: 插件化封装

### Prompt 9.1 - 公共API设计

```
你是资深Flutter架构师，请为n42_chat设计clean的公共API，使其可以作为插件嵌入N42钱包。

请创建/更新：

1. lib/n42_chat.dart (主入口)
   导出所有公共API：
   - N42Chat (主类)
   - N42ChatConfig (配置)
   - N42ChatTheme (主题定制)
   - N42ChatRouter (路由配置)
   - 必要的实体类

2. lib/src/n42_chat.dart
```dart
class N42Chat {
  /// 初始化聊天模块
  static Future<void> initialize(N42ChatConfig config);
  
  /// 获取聊天主Widget（用于嵌入TabView）
  static Widget chatWidget();
  
  /// 获取路由配置（用于嵌入主应用路由）
  static List<RouteBase> routes();
  
  /// 登录
  static Future<void> login(String homeserver, String username, String password);
  
  /// 使用已有token登录
  static Future<void> loginWithToken(String homeserver, String accessToken, String userId);
  
  /// 登出
  static Future<void> logout();
  
  /// 是否已登录
  static bool get isLoggedIn;
  
  /// 未读消息数Stream
  static Stream<int> get unreadCountStream;
  
  /// 当前用户信息
  static User? get currentUser;
  
  /// 跳转到指定会话
  static void openConversation(String roomId);
  
  /// 创建新会话
  static Future<String> createDirectMessage(String userId);
  
  /// 释放资源
  static Future<void> dispose();
}
```

3. lib/src/n42_chat_config.dart
```dart
class N42ChatConfig {
  final String defaultHomeserver;
  final bool enableEncryption;
  final bool enablePushNotifications;
  final Duration syncTimeout;
  final N42ChatTheme? customTheme;
  final Function(String roomId)? onMessageTap;
  // ... 更多配置
}
```
```

### Prompt 9.2 - 集成文档

```
继续n42_chat项目，创建详细的集成文档。

请创建：

1. README.md (更新)
   - 项目介绍
   - 功能特性
   - 快速开始
   - API文档
   - 配置说明
   - 常见问题

2. INTEGRATION.md
   详细的集成指南：
   
   ## 作为Package依赖
   ```yaml
   dependencies:
     n42_chat:
       path: ../n42_chat
   ```
   
   ## 初始化
   ```dart
   await N42Chat.initialize(N42ChatConfig(
     defaultHomeserver: 'https://matrix.org',
     enableEncryption: true,
   ));
   ```
   
   ## 嵌入TabView
   ```dart
   TabBarView(
     children: [
       WalletPage(),
       N42Chat.chatWidget(),  // 聊天Tab
       DiscoverPage(),
       ProfilePage(),
     ],
   )
   ```
   
   ## 路由集成
   ```dart
   GoRouter(
     routes: [
       ...appRoutes,
       ...N42Chat.routes(),  // 聊天相关路由
     ],
   )
   ```
   
   ## 监听未读消息
   ```dart
   N42Chat.unreadCountStream.listen((count) {
     // 更新Tab徽章
   });
   ```

3. CHANGELOG.md
   - 版本记录模板

4. example/README.md
   - 示例应用说明
   - 运行方法
```

### Prompt 9.3 - 主题定制接口

```
继续n42_chat项目，实现主题定制接口，允许主应用统一视觉风格。

请创建/更新：

1. lib/src/core/theme/n42_chat_theme.dart
```dart
class N42ChatTheme {
  // 颜色
  final Color primaryColor;
  final Color backgroundColor;
  final Color surfaceColor;
  final Color textPrimaryColor;
  final Color textSecondaryColor;
  final Color messageBubbleSentColor;
  final Color messageBubbleReceivedColor;
  
  // 形状
  final double avatarRadius;
  final double messageBubbleRadius;
  
  // 字体
  final TextStyle? titleTextStyle;
  final TextStyle? bodyTextStyle;
  final TextStyle? captionTextStyle;
  
  // 预设主题
  static N42ChatTheme wechatLight();  // 微信浅色
  static N42ChatTheme wechatDark();   // 微信深色
  static N42ChatTheme fromMaterialTheme(ThemeData theme);  // 从Material主题生成
  
  const N42ChatTheme({...});
}
```

2. lib/src/core/theme/theme_provider.dart
   - 主题提供者
   - 支持动态切换

3. 确保所有组件使用N42ChatTheme而非硬编码颜色
```

---

## Phase 10: 测试与优化

### Prompt 10.1 - 单元测试

```
继续n42_chat项目，编写核心功能的单元测试。

请创建：

1. test/domain/usecases/
   - send_message_usecase_test.dart
   - get_conversations_usecase_test.dart
   - login_usecase_test.dart

2. test/data/repositories/
   - conversation_repository_test.dart
   - message_repository_test.dart
   - auth_repository_test.dart

3. test/presentation/blocs/
   - auth_bloc_test.dart
   - conversation_list_bloc_test.dart
   - chat_bloc_test.dart

4. test/mocks/
   - mock_matrix_client.dart
   - mock_repositories.dart

使用mockito进行模拟，测试覆盖：
- 正常流程
- 错误处理
- 边界情况
```

### Prompt 10.2 - Widget测试

```
继续n42_chat项目，编写关键Widget的测试。

请创建：

1. test/presentation/widgets/
   - message_bubble_test.dart
   - conversation_list_item_test.dart
   - chat_input_bar_test.dart
   - n42_avatar_test.dart

2. test/presentation/pages/
   - login_page_test.dart
   - conversation_list_page_test.dart
   - chat_page_test.dart

测试内容：
- 渲染正确
- 用户交互
- 状态变化
```

### Prompt 10.3 - 性能优化

```
继续n42_chat项目，进行性能优化。

请检查并优化：

1. lib/src/presentation/pages/chat/chat_page.dart
   - 消息列表使用ListView.builder
   - 实现const构造函数
   - 使用RepaintBoundary隔离重绘

2. lib/src/presentation/widgets/chat/
   - 图片懒加载
   - 消息缓存

3. lib/src/core/services/
   - cache_manager.dart
     - 图片缓存策略
     - 内存缓存限制
     - 磁盘缓存清理

4. lib/src/data/datasources/local/
   - 数据库索引优化
   - 查询优化

5. 创建性能监控：
   - lib/src/core/utils/performance_monitor.dart
```

---

## Phase 11: N42钱包集成

### Prompt 11.1 - 钱包集成接口

```
你是资深Flutter架构师，请设计n42_chat与N42钱包的集成接口。

考虑场景：
1. N42钱包作为主应用
2. n42_chat作为聊天模块嵌入
3. 共享用户认证
4. 支持发送/接收加密货币

请创建：

1. lib/src/integration/
   - wallet_bridge.dart
     - 钱包连接接口
     - 转账请求
     - 收款请求

```dart
abstract class IWalletBridge {
  /// 是否已连接钱包
  bool get isWalletConnected;
  
  /// 获取钱包地址
  String? get walletAddress;
  
  /// 发起转账
  Future<TransferResult> requestTransfer({
    required String toAddress,
    required String amount,
    required String token,
  });
  
  /// 生成收款请求
  Future<PaymentRequest> generatePaymentRequest({
    required String amount,
    required String token,
    String? memo,
  });
  
  /// 显示收款二维码
  Future<void> showReceiveQRCode();
}
```

2. lib/src/presentation/widgets/chat/payment/
   - transfer_message_bubble.dart (转账消息)
   - payment_request_bubble.dart (收款请求)
   - red_packet_bubble.dart (红包消息，可选)

3. lib/src/presentation/pages/payment/
   - send_transfer_page.dart (发送转账)
   - payment_request_page.dart (收款)
```

### Prompt 11.2 - 完整集成示例

```
继续n42_chat项目，在example中创建完整的集成示例。

请更新 example/ 目录：

1. example/lib/main.dart
   - 模拟N42钱包主应用结构
   - 底部TabBar (钱包、聊天、发现、我的)
   - 集成n42_chat

2. example/lib/mock/
   - mock_wallet_bridge.dart
     - 模拟钱包功能

3. example/lib/pages/
   - wallet_tab.dart (模拟钱包页)
   - main_tab_controller.dart

4. 展示功能：
   - 主题统一
   - 路由集成
   - 未读消息徽章
   - 钱包转账功能
```

---

## 附录: 常用提示词模板

### A. 错误修复模板
```
n42_chat项目中出现了以下错误：

错误信息：
[粘贴错误信息]

相关代码位置：
[文件路径]

请分析原因并提供修复方案。
```

### B. 功能扩展模板
```
在n42_chat项目中，我需要添加[功能名称]功能。

功能描述：
[详细描述]

影响范围：
- 数据层：[是/否]
- 业务层：[是/否]
- UI层：[是/否]

请按照项目现有架构实现此功能。
```

### C. 代码审查模板
```
请审查n42_chat项目中以下代码：

文件：[文件路径]

审查重点：
1. 架构合规性
2. 性能问题
3. 内存泄漏风险
4. 错误处理
5. 代码风格

请提供改进建议。
```

### D. 重构模板
```
n42_chat项目中的[模块名称]需要重构。

当前问题：
[描述问题]

期望效果：
[描述期望]

请提供重构方案，确保：
1. 不破坏现有功能
2. 保持API兼容
3. 提高可维护性
```

---

## 执行检查清单

### Phase 0 检查项
- [ ] 项目结构创建完成
- [ ] pubspec.yaml配置正确
- [ ] example应用可运行
- [ ] 分析选项配置

### Phase 1 检查项
- [ ] 依赖注入配置完成
- [ ] 路由系统可用
- [ ] 主题系统完整
- [ ] 工具类齐全

### Phase 2 检查项
- [ ] Matrix SDK集成
- [ ] 登录流程完整
- [ ] Session持久化
- [ ] 错误处理

### Phase 3 检查项
- [ ] 基础组件完整
- [ ] 聊天组件完整
- [ ] 动画效果流畅
- [ ] 深色模式支持

### Phase 4 检查项
- [ ] 会话列表功能
- [ ] 消息列表功能
- [ ] 实时更新
- [ ] 分页加载

### Phase 5 检查项
- [ ] 文字消息
- [ ] 图片消息
- [ ] 语音消息
- [ ] 消息同步

### Phase 6 检查项
- [ ] 联系人列表
- [ ] 联系人详情
- [ ] 添加好友
- [ ] 搜索功能

### Phase 7 检查项
- [ ] 发现页面
- [ ] 个人中心
- [ ] 设置页面
- [ ] 资料编辑

### Phase 8 检查项
- [ ] 群聊功能
- [ ] 端对端加密
- [ ] 消息通知
- [ ] 消息搜索

### Phase 9 检查项
- [ ] API文档完整
- [ ] 集成指南
- [ ] 主题定制
- [ ] 示例完整

### Phase 10 检查项
- [ ] 单元测试覆盖
- [ ] Widget测试
- [ ] 性能优化
- [ ] 无内存泄漏

### Phase 11 检查项
- [ ] 钱包接口设计
- [ ] 转账功能
- [ ] 集成示例
- [ ] 文档完善

---

## 版本规划

| 版本 | 功能范围 | 对应Phase |
|------|---------|-----------|
| 0.1.0 | 基础框架 | Phase 0-1 |
| 0.2.0 | 登录认证 | Phase 2 |
| 0.3.0 | 基础聊天 | Phase 3-5 |
| 0.4.0 | 通讯录 | Phase 6 |
| 0.5.0 | 完整功能 | Phase 7-8 |
| 0.9.0 | 插件化 | Phase 9 |
| 1.0.0 | 正式版 | Phase 10-11 |

---

> 本文档持续更新，请根据实际开发进度调整提示词内容。

