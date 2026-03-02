import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../n42_chat.dart';
import '../di/injection.dart';
import '../../domain/repositories/conversation_repository.dart';
import '../../presentation/blocs/chat/chat_bloc.dart';
import '../../presentation/blocs/contact/contact_bloc.dart';
import '../../presentation/pages/ai/ai_assistant_page.dart';
import '../../presentation/pages/ai/ai_assistant_settings_page.dart';
import '../../presentation/pages/auth/login_page.dart';
import '../../presentation/pages/chat/chat_folder_management_page.dart';
import '../../presentation/pages/chat/chat_page.dart';
import '../../presentation/pages/contact/add_friend_page.dart';
import '../../presentation/pages/contact/contact_detail_page.dart';
import '../../presentation/pages/contact/contact_list_page.dart';
import '../../presentation/pages/conversation/conversation_list_page.dart';
import '../../presentation/pages/discover/discover_page.dart';
import '../../presentation/pages/group/create_group_page.dart';
import '../../presentation/pages/profile/edit_profile_page.dart';
import '../../presentation/pages/profile/profile_page.dart';
import '../../presentation/pages/profile/set_username_page.dart';
import '../../presentation/pages/search/global_search_page.dart';
import '../../presentation/pages/settings/settings_page.dart';
import '../../domain/entities/conversation_entity.dart';
import '../../domain/entities/user_profile_entity.dart';
import 'routes.dart';

/// N42 Chat 路由配置
///
/// 提供两种使用方式：
/// 1. 独立运行：使用 [router] 作为完整的路由配置
/// 2. 嵌入主应用：使用 [routes] 获取路由列表合并到主路由
class N42ChatRouter {
  N42ChatRouter._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter? _router;

  /// 获取完整的路由器（独立运行模式）
  ///
  /// 使用懒加载单例模式，避免每次访问创建新实例导致路由状态丢失。
  static GoRouter get router => _router ??= GoRouter(
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
          builder: (context, state) => const ConversationListPage(),
          routes: [
            // 会话详情
            GoRoute(
              path: 'conversation/:roomId',
              name: Routes.chatName,
              builder: (context, state) {
                final roomId = state.pathParameters['roomId']!;
                final conversation = state.extra as ConversationEntity?;
                return _ChatPageLoader(
                  roomId: roomId,
                  conversation: conversation,
                );
              },
            ),
          ],
        ),

        // 通讯录
        GoRoute(
          path: Routes.contacts,
          name: Routes.contactsName,
          builder: (context, state) => const ContactListPage(),
          routes: [
            // 联系人详情
            GoRoute(
              path: 'detail/:userId',
              name: Routes.contactDetailName,
              builder: (context, state) {
                final userId = state.pathParameters['userId']!;
                final extra = state.extra as Map<String, dynamic>?;
                return ContactDetailPage(
                  userId: userId,
                  displayName: extra?['displayName'] as String? ?? userId,
                  avatarUrl: extra?['avatarUrl'] as String?,
                );
              },
            ),
            // 添加联系人
            GoRoute(
              path: 'add',
              name: Routes.addContactName,
              builder: (context, state) => const AddFriendPage(),
            ),
          ],
        ),

        // 发现
        GoRoute(
          path: Routes.discover,
          name: Routes.discoverName,
          builder: (context, state) => const DiscoverPage(),
        ),

        // 个人中心
        GoRoute(
          path: Routes.profile,
          name: Routes.profileName,
          builder: (context, state) => const ProfilePage(),
          routes: [
            // 设置
            GoRoute(
              path: 'settings',
              name: Routes.settingsName,
              builder: (context, state) => const SettingsPage(),
            ),
            // 编辑资料
            GoRoute(
              path: 'edit',
              name: Routes.editProfileName,
              builder: (context, state) {
                final profile = state.extra as UserProfileEntity?;
                if (profile == null) {
                  return const _FallbackPage(title: 'Edit Profile');
                }
                return EditProfilePage(profile: profile);
              },
            ),
            // 设置用户名
            GoRoute(
              path: 'username',
              name: Routes.setUsernameName,
              builder: (context, state) => const SetUsernamePage(),
            ),
          ],
        ),

        // 登录
        GoRoute(
          path: Routes.login,
          name: Routes.loginName,
          builder: (context, state) => const LoginPage(),
        ),

        // 搜索
        GoRoute(
          path: Routes.search,
          name: Routes.searchName,
          builder: (context, state) => const GlobalSearchPage(),
        ),

        // 创建群聊
        GoRoute(
          path: Routes.createGroup,
          name: Routes.createGroupName,
          builder: (context, state) => const CreateGroupPage(),
        ),

        // AI 助手
        GoRoute(
          path: Routes.aiAssistant,
          name: Routes.aiAssistantName,
          builder: (context, state) => const AiAssistantPage(),
          routes: [
            GoRoute(
              path: 'settings',
              name: Routes.aiAssistantSettingsName,
              builder: (context, state) =>
                  const AiAssistantSettingsPage(),
            ),
          ],
        ),

        // 聊天文件夹管理
        GoRoute(
          path: Routes.chatFolderManagement,
          name: Routes.chatFolderManagementName,
          builder: (context, state) =>
              const ChatFolderManagementPage(),
        ),
      ];

  /// 路由重定向（auth guard）
  static String? _handleRedirect(BuildContext context, GoRouterState state) {
    final isLoggedIn = N42Chat.isLoggedIn;
    final isLoginPage = state.matchedLocation == Routes.login;

    if (!isLoggedIn && !isLoginPage) {
      return Routes.login;
    }

    if (isLoggedIn && isLoginPage) {
      return Routes.conversationList;
    }

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

/// ChatPage 需要 ConversationEntity，此 loader 从 roomId 异步加载
class _ChatPageLoader extends StatefulWidget {
  final String roomId;
  final ConversationEntity? conversation;

  const _ChatPageLoader({
    required this.roomId,
    this.conversation,
  });

  @override
  State<_ChatPageLoader> createState() => _ChatPageLoaderState();
}

class _ChatPageLoaderState extends State<_ChatPageLoader> {
  ConversationEntity? _conversation;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (widget.conversation != null) {
      _conversation = widget.conversation;
      _loading = false;
    } else {
      _loadConversation();
    }
  }

  Future<void> _loadConversation() async {
    try {
      final repo = getIt<IConversationRepository>();
      final conv = await repo.getConversationById(widget.roomId);
      if (!mounted) return;
      if (conv == null) {
        setState(() {
          _error = 'Conversation not found: ${widget.roomId}';
          _loading = false;
        });
      } else {
        setState(() {
          _conversation = conv;
          _loading = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null || _conversation == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(child: Text(_error ?? 'Unknown error')),
      );
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ChatBloc>()),
        BlocProvider(create: (_) => getIt<ContactBloc>()),
      ],
      child: ChatPage(
        conversation: _conversation!,
        onBack: () => Navigator.of(context).pop(),
      ),
    );
  }
}

/// EditProfilePage 需要 profile 对象，如果未传递则显示提示
class _FallbackPage extends StatelessWidget {
  final String title;
  const _FallbackPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text('$title\n(Navigate with required data)',
            textAlign: TextAlign.center),
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
    final l10n = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n?.chatError ?? 'Error'),
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
            Text(
              l10n?.commonPageNotFound ?? 'Page not found',
              style: const TextStyle(
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
              child: Text(l10n?.commonBackToHome ?? 'Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
