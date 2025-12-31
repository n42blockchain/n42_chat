# N42 Matrix Chat

基于 [Matrix](https://matrix.org/) 协议的微信风格即时通讯模块，专为 N42 钱包设计。

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.19.0-blue.svg)](https://flutter.dev)

## ✨ 功能特性

- 🎨 **微信风格UI** - 熟悉的交互体验，中国用户友好
- 🔐 **端对端加密** - 基于 Matrix Olm/Megolm 协议
- 🔌 **插件化设计** - 可独立运行或嵌入主应用
- 💰 **钱包集成** - 支持聊天内加密货币转账
- 🌐 **去中心化** - 支持任意 Matrix 服务器
- 📱 **跨平台** - iOS、Android、Web、Desktop

## 🏗️ 架构设计

```
n42_chat/
├── lib/
│   ├── n42_chat.dart              # 主入口
│   └── src/
│       ├── core/                  # 核心层
│       │   ├── di/                # 依赖注入
│       │   ├── router/            # 路由
│       │   ├── theme/             # 主题
│       │   ├── utils/             # 工具
│       │   ├── constants/         # 常量
│       │   └── extensions/        # 扩展
│       ├── data/                  # 数据层
│       │   ├── datasources/       # 数据源
│       │   ├── models/            # 数据模型
│       │   └── repositories/      # 仓库实现
│       ├── domain/                # 领域层
│       │   ├── entities/          # 实体
│       │   ├── repositories/      # 仓库接口
│       │   └── usecases/          # 用例
│       ├── presentation/          # 表现层
│       │   ├── pages/             # 页面
│       │   ├── widgets/           # 组件
│       │   └── blocs/             # BLoC
│       └── integration/           # 集成接口
├── example/                       # 示例应用
└── test/                          # 测试
```

## 🚀 快速开始

### 安装

```yaml
dependencies:
  n42_chat:
    path: ../n42_chat  # 本地路径
    # 或者
    # git:
    #   url: https://github.com/n42/n42_chat.git
```

### 初始化

```dart
import 'package:n42_chat/n42_chat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化聊天模块
  await N42Chat.initialize(
    N42ChatConfig(
      defaultHomeserver: 'https://matrix.org',
      enableEncryption: true,
    ),
  );

  runApp(MyApp());
}
```

### 嵌入到 TabView

```dart
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          WalletPage(),
          N42Chat.chatWidget(),  // 聊天Tab
          DiscoverPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        // ...
      ),
    );
  }
}
```

### 监听未读消息

```dart
N42Chat.unreadCountStream.listen((count) {
  // 更新Tab徽章
  setState(() => _unreadCount = count);
});
```

### 路由集成

```dart
GoRouter(
  routes: [
    ...appRoutes,
    ...N42Chat.routes(),  // 聊天相关路由
  ],
);
```

## 🎨 主题定制

```dart
// 使用预设主题
N42ChatConfig(
  customTheme: N42ChatTheme.wechatLight(),
  // 或 N42ChatTheme.wechatDark()
);

// 自定义主题
N42ChatConfig(
  customTheme: N42ChatTheme(
    primaryColor: Color(0xFF07C160),
    backgroundColor: Color(0xFFEDEDED),
    // ...
  ),
);

// 从 Material 主题生成
N42ChatConfig(
  customTheme: N42ChatTheme.fromMaterialTheme(Theme.of(context)),
);
```

## 💰 钱包集成

实现 `IWalletBridge` 接口以启用转账功能：

```dart
class MyWalletBridge implements IWalletBridge {
  @override
  bool get isWalletConnected => _wallet.isConnected;

  @override
  Future<TransferResult> requestTransfer({
    required String toAddress,
    required String amount,
    required String token,
    String? memo,
  }) async {
    // 实现转账逻辑
    final tx = await _wallet.transfer(toAddress, amount, token);
    return TransferResult.success(tx.hash);
  }

  // ... 其他方法
}

// 配置时传入
N42Chat.initialize(N42ChatConfig(
  walletBridge: MyWalletBridge(),
));
```

## 📚 API 参考

### N42Chat

| 方法 | 说明 |
|------|------|
| `initialize(config)` | 初始化模块 |
| `chatWidget()` | 获取聊天Widget |
| `routes()` | 获取路由配置 |
| `login(...)` | 用户名密码登录 |
| `loginWithToken(...)` | Token登录 |
| `logout()` | 登出 |
| `isLoggedIn` | 登录状态 |
| `currentUser` | 当前用户 |
| `unreadCountStream` | 未读消息流 |
| `openConversation(roomId)` | 打开会话 |
| `createDirectMessage(userId)` | 创建私聊 |
| `dispose()` | 释放资源 |

### N42ChatConfig

| 配置项 | 默认值 | 说明 |
|--------|--------|------|
| `defaultHomeserver` | `matrix.org` | 默认服务器 |
| `enableEncryption` | `true` | 启用E2EE |
| `enablePushNotifications` | `true` | 启用推送 |
| `syncTimeout` | `30s` | 同步超时 |
| `customTheme` | `null` | 自定义主题 |
| `walletBridge` | `null` | 钱包桥接 |
| `onMessageTap` | `null` | 消息点击回调 |

## 📦 依赖项

所有依赖均使用商业友好的开源许可证：

| 包名 | 许可证 | 用途 |
|------|--------|------|
| matrix | Apache 2.0 | Matrix SDK |
| flutter_bloc | MIT | 状态管理 |
| get_it | MIT | 依赖注入 |
| go_router | BSD-3 | 路由 |
| drift | MIT | 本地数据库 |
| dio | MIT | HTTP客户端 |
| cached_network_image | MIT | 图片缓存 |
| flutter_secure_storage | BSD-3 | 安全存储 |

## 🧪 开发

```bash
# 获取依赖
flutter pub get

# 运行示例应用
cd example && flutter run

# 运行测试
flutter test

# 代码分析
flutter analyze

# 生成代码（如果使用build_runner）
flutter pub run build_runner build
```

## 📄 许可证

MIT License - 详见 [LICENSE](LICENSE)

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📞 联系

- GitHub: [https://github.com/n42/n42_chat](https://github.com/n42/n42_chat)
- Email: dev@n42.io

