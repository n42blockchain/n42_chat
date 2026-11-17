// Visual review fixture for the full HIG audit (2026-11-17).
//
// Not a golden assertion and skipped by default: renders one representative
// page per area in light/dark at 100% and 130% text scale on a 375pt-wide
// phone and writes PNGs for before/after comparison. Pages that need
// injected services log errors without them; errors are drained so the
// layout is still captured.
//
// Run: N42_CHAT_SHOTS=1 flutter test test/goldens/hig_full_audit_screenshot_test.dart
// Output: $N42_CHAT_SHOTS_OUT or build/hig-full/.
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/theme/n42_chat_theme.dart';
import 'package:n42_chat/src/presentation/pages/contact/add_friend_page.dart';
import 'package:n42_chat/src/presentation/pages/discover/social_hub_page.dart';
import 'package:n42_chat/src/presentation/pages/favorite/favorite_list_page.dart';
import 'package:n42_chat/src/presentation/pages/game/game_center_page.dart';
import 'package:n42_chat/src/presentation/pages/group/create_group_page.dart';
import 'package:n42_chat/src/presentation/pages/profile/profile_edit_page.dart';
import 'package:n42_chat/src/presentation/pages/profile/services_page.dart';
import 'package:n42_chat/src/presentation/pages/qrcode/my_qrcode_page.dart';
import 'package:n42_chat/src/presentation/pages/search/global_search_page.dart';
import 'package:n42_chat/src/presentation/pages/settings/backup_restore_page.dart';
import 'package:n42_chat/src/presentation/pages/settings/change_password_page.dart';
import 'package:n42_chat/src/presentation/pages/settings/chat_settings_page.dart';
import 'package:n42_chat/src/presentation/pages/settings/storage_management_page.dart';
import 'package:n42_chat/src/presentation/pages/space/space_list_page.dart';
import 'package:n42_chat/src/presentation/pages/sticker/sticker_store_page.dart';
import 'package:n42_chat/src/presentation/pages/transfer/merchant_qr_page.dart';
import 'package:n42_chat/src/presentation/pages/voice_room/voice_room_list_page.dart';

const _font = 'ChatHigFullFont';
final bool _enabled = Platform.environment['N42_CHAT_SHOTS'] == '1';
final String _outDir =
    Platform.environment['N42_CHAT_SHOTS_OUT'] ?? 'build/hig-full';

final Map<String, Widget Function()> _pages = {
  'contact-add-friend': () => const AddFriendPage(),
  'discover-social-hub': () => const SocialHubPage(),
  'favorite-list': () => const FavoriteListPage(),
  'game-center': () => const GameCenterPage(),
  'group-create': () => const CreateGroupPage(),
  'profile-edit': () => const ProfileEditPage(),
  'profile-services': () => const ServicesPage(),
  'qrcode-mine': () => const MyQRCodePage(),
  'search-global': () => const GlobalSearchPage(),
  'settings-backup': () => const BackupRestorePage(),
  'settings-password': () => const ChangePasswordPage(),
  'settings-chat': () => const ChatSettingsPage(),
  'settings-storage': () => const StorageManagementPage(),
  'space-list': () => const SpaceListPage(),
  'sticker-store': () => const StickerStorePage(),
  'transfer-merchant-qr': () => const MerchantQrPage(),
  'voice-room-list': () => const VoiceRoomListPage(),
};

Future<void> _loadFont() async {
  for (final path in [
    r'C:\Windows\Fonts\msyh.ttc',
    r'C:\Windows\Fonts\segoeui.ttf',
    '/System/Library/Fonts/Supplemental/Arial Unicode.ttf',
    '/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf',
  ]) {
    final file = File(path);
    if (!file.existsSync()) continue;
    final bytes = file.readAsBytesSync();
    for (final family in [_font, 'Roboto']) {
      await (FontLoader(
        family,
      )..addFont(Future.value(ByteData.sublistView(bytes)))).load();
    }
    break;
  }
  final root = Platform.environment['FLUTTER_ROOT'];
  final icons = File(
    '${root ?? ''}/bin/cache/artifacts/material_fonts/materialicons-regular.otf',
  );
  if (root != null && icons.existsSync()) {
    await (FontLoader(
          'MaterialIcons',
        )..addFont(Future.value(ByteData.sublistView(icons.readAsBytesSync()))))
        .load();
  }
}

void main() {
  setUpAll(_loadFont);

  for (final entry in _pages.entries) {
    for (final dark in [false, true]) {
      for (final scale in [1.0, 1.3]) {
        final name =
            '${entry.key}-${dark ? 'dark' : 'light'}'
            '${scale == 1.0 ? '' : '-130'}';
        testWidgets(name, skip: !_enabled, (tester) async {
          tester.view.physicalSize = const Size(750, 1624);
          tester.view.devicePixelRatio = 2;
          addTearDown(tester.view.reset);
          final chatTheme = dark
              ? N42ChatTheme.wechatDark()
              : N42ChatTheme.wechatLight();
          final base = chatTheme.toThemeData();
          final key = GlobalKey();
          await tester.pumpWidget(
            RepaintBoundary(
              key: key,
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                locale: const Locale('en'),
                localizationsDelegates: S.localizationsDelegates,
                supportedLocales: S.supportedLocales,
                theme: base.copyWith(
                  splashFactory: InkRipple.splashFactory,
                  textTheme: base.textTheme.apply(fontFamily: _font),
                ),
                builder: (context, child) => MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: TextScaler.linear(scale)),
                  child: DefaultTextStyle.merge(
                    style: const TextStyle(fontFamily: _font),
                    child: child!,
                  ),
                ),
                home: entry.value(),
              ),
            ),
          );
          for (var i = 0; i < 6; i++) {
            await tester.pump(const Duration(milliseconds: 250));
          }
          var errors = 0;
          while (tester.takeException() != null) {
            errors++;
          }
          final boundary =
              key.currentContext!.findRenderObject() as RenderRepaintBoundary;
          await tester.runAsync(() async {
            final image = await boundary.toImage(pixelRatio: 2);
            final bytes = await image.toByteData(
              format: ui.ImageByteFormat.png,
            );
            Directory(_outDir).createSync(recursive: true);
            File(
              '$_outDir/$name.png',
            ).writeAsBytesSync(bytes!.buffer.asUint8List());
            image.dispose();
          });
          if (errors > 0) {
            debugPrint('$name: $errors drained exception(s)');
          }
          await tester.pumpWidget(const SizedBox.shrink());
          await tester.pump(const Duration(seconds: 10));
          while (tester.takeException() != null) {}
        });
      }
    }
  }
}
