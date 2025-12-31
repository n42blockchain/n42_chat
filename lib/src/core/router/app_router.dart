import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

/// N42 Chat 路由配置
///
/// 提供两种使用方式：
/// 1. 独立运行：使用 [router] 作为完整的路由配置
/// 2. 嵌入主应用：使用 [routes] 获取路由列表合并到主路由
class N42ChatRouter {
  N42ChatRouter._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  /// 获取完整的路由器（独立运行模式）
  static GoRouter get router => GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: Routes.conversationList,
        debugLogDiagnostics: true,
        routes: routes,
        errorBuilder: (context, state) => _ErrorPage(error: state.error),
        redirect: _handleRedirect,
      );

  /// 获取路由列表（嵌入模式）
  ///
  /// 可以合并到主应用的路由配置中
  ///
  /// ```dart
  /// GoRouter(
  ///   routes: [
  ///     ...myAppRoutes,
  ///     ...N42ChatRouter.routes,
  ///   ],
  /// )
  /// ```
  static List<RouteBase> get routes => [
        // 会话列表（聊天Tab主页）
        GoRoute(
          path: Routes.conversationList,
          name: Routes.conversationListName,
          builder: (context, state) => const _PlaceholderPage(title: '消息'),
          routes: [
            // 会话详情
            GoRoute(
              path: 'conversation/:roomId',
              name: Routes.chatName,
              builder: (context, state) {
                final roomId = state.pathParameters['roomId']!;
                return _PlaceholderPage(title: '会话: $roomId');
              },
            ),
          ],
        ),

        // 通讯录
        GoRoute(
          path: Routes.contacts,
          name: Routes.contactsName,
          builder: (context, state) => const _PlaceholderPage(title: '通讯录'),
          routes: [
            // 联系人详情
            GoRoute(
              path: 'detail/:userId',
              name: Routes.contactDetailName,
              builder: (context, state) {
                final userId = state.pathParameters['userId']!;
                return _PlaceholderPage(title: '联系人: $userId');
              },
            ),
            // 添加联系人
            GoRoute(
              path: 'add',
              name: Routes.addContactName,
              builder: (context, state) =>
                  const _PlaceholderPage(title: '添加好友'),
            ),
          ],
        ),

        // 发现
        GoRoute(
          path: Routes.discover,
          name: Routes.discoverName,
          builder: (context, state) => const _PlaceholderPage(title: '发现'),
        ),

        // 个人中心
        GoRoute(
          path: Routes.profile,
          name: Routes.profileName,
          builder: (context, state) => const _PlaceholderPage(title: '我'),
          routes: [
            // 设置
            GoRoute(
              path: 'settings',
              name: Routes.settingsName,
              builder: (context, state) =>
                  const _PlaceholderPage(title: '设置'),
            ),
            // 编辑资料
            GoRoute(
              path: 'edit',
              name: Routes.editProfileName,
              builder: (context, state) =>
                  const _PlaceholderPage(title: '编辑资料'),
            ),
          ],
        ),

        // 登录
        GoRoute(
          path: Routes.login,
          name: Routes.loginName,
          builder: (context, state) => const _PlaceholderPage(title: '登录'),
        ),

        // 搜索
        GoRoute(
          path: Routes.search,
          name: Routes.searchName,
          builder: (context, state) => const _PlaceholderPage(title: '搜索'),
        ),

        // 创建群聊
        GoRoute(
          path: Routes.createGroup,
          name: Routes.createGroupName,
          builder: (context, state) =>
              const _PlaceholderPage(title: '创建群聊'),
        ),
      ];

  /// 路由重定向
  static String? _handleRedirect(BuildContext context, GoRouterState state) {
    // TODO: 检查登录状态
    // final isLoggedIn = N42Chat.isLoggedIn;
    // final isLoginPage = state.matchedLocation == Routes.login;

    // if (!isLoggedIn && !isLoginPage) {
    //   return Routes.login;
    // }

    // if (isLoggedIn && isLoginPage) {
    //   return Routes.conversationList;
    // }

    return null;
  }

  /// 微信风格页面转场
  static CustomTransitionPage<T> wechatTransition<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // 滑动进入
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

/// 占位页面（开发中）
class _PlaceholderPage extends StatelessWidget {
  final String title;

  const _PlaceholderPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFFF7F7F7),
        foregroundColor: const Color(0xFF181818),
      ),
      backgroundColor: const Color(0xFFEDEDED),
      body: Center(
        child: Text(
          '$title\n(开发中)',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF888888),
          ),
        ),
      ),
    );
  }
}

/// 错误页面
class _ErrorPage extends StatelessWidget {
  final Exception? error;

  const _ErrorPage({this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('错误'),
        backgroundColor: const Color(0xFFF7F7F7),
        foregroundColor: const Color(0xFF181818),
      ),
      backgroundColor: const Color(0xFFEDEDED),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Color(0xFFFA5151),
            ),
            const SizedBox(height: 16),
            const Text(
              '页面不存在',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFF181818),
              ),
            ),
            if (error != null) ...[
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF888888),
                ),
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(Routes.conversationList),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF07C160),
              ),
              child: const Text('返回首页'),
            ),
          ],
        ),
      ),
    );
  }
}

