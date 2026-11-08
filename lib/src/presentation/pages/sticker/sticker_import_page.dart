import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/di/injection.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../domain/entities/sticker_pack_entity.dart';
import '../../../domain/entities/sticker_pack_subscription.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/repositories/sticker_repository.dart';
import '../../widgets/chat/sticker_thumb.dart';

enum _ImportFailure { unavailable, install, account }

/// Preview is read-only. Copy installation and live subscription each need consent.
class StickerImportPage extends StatefulWidget {
  const StickerImportPage({super.key, this.initialLink = ''});
  final String initialLink;

  @override
  State<StickerImportPage> createState() => _StickerImportPageState();
}

class _StickerImportPageState extends State<StickerImportPage> {
  late final IStickerRepository _repository = getIt<IStickerRepository>();
  late final TextEditingController _link;
  IAuthRepository? _auth;
  IAccountBoundDeletionLifecycle? _lifecycle;
  AuthSessionInvalidation? _generation;
  StreamSubscription<AuthSessionInvalidation>? _invalidations;
  StickerPack? _pack;
  BuildContext? _confirmationContext;
  _ImportFailure? _failure;
  bool _previewing = false;
  bool _installing = false;
  bool _confirming = false;

  bool get _current =>
      _generation != null &&
      _generation!.isCurrent &&
      identical(_lifecycle?.currentAccountGeneration, _generation) &&
      getIt.isRegistered<IAuthRepository>() &&
      identical(getIt<IAuthRepository>(), _auth) &&
      getIt.isRegistered<IStickerRepository>() &&
      identical(getIt<IStickerRepository>(), _repository);

  @override
  void initState() {
    super.initState();
    _link = TextEditingController(text: widget.initialLink);
    final auth = getIt.isRegistered<IAuthRepository>()
        ? getIt<IAuthRepository>()
        : null;
    _auth = auth;
    if (auth is IAccountBoundDeletionLifecycle &&
        auth is IAccountBoundAuthInvalidation) {
      final lifecycle = auth as IAccountBoundDeletionLifecycle;
      _lifecycle = lifecycle;
      _generation = lifecycle.currentAccountGeneration;
      _invalidations = (auth as IAccountBoundAuthInvalidation)
          .accountInvalidationStream
          .listen((_) {
            if (!_current) _invalidate();
          });
    }
    if (!_current) _failure = _ImportFailure.account;
  }

  @override
  void dispose() {
    unawaited(_invalidations?.cancel());
    _closeConfirmation();
    _link.dispose();
    super.dispose();
  }

  void _closeConfirmation() {
    final context = _confirmationContext;
    _confirmationContext = null;
    if (context == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;
      final route = ModalRoute.of(context);
      if (route?.isActive == true) Navigator.of(context).removeRoute(route!);
    });
  }

  void _invalidate() {
    if (!mounted) return;
    _closeConfirmation();
    _link.clear();
    setState(() {
      _pack = null;
      _failure = _ImportFailure.account;
      _previewing = false;
      _installing = false;
      _confirming = false;
    });
  }

  Future<void> _preview() async {
    if (_previewing || _installing || _confirming) return;
    if (!_current) {
      _invalidate();
      return;
    }
    final link = _link.text.trim();
    if (link.isEmpty) return;
    setState(() {
      _previewing = true;
      _pack = null;
      _failure = null;
    });
    StickerPack? pack;
    try {
      pack = await _repository.importPack(link);
    } catch (_) {
      /* Show a localized failure. */
    }
    if (!mounted) return;
    if (!_current) {
      _invalidate();
      return;
    }
    setState(() {
      _previewing = false;
      if (_link.text.trim() == link && pack?.origin != null) {
        _pack = pack;
      } else {
        _failure = _ImportFailure.unavailable;
      }
    });
  }

  Future<void> _install({bool subscribe = false}) async {
    final pack = _pack;
    if (_previewing || _installing || _confirming || pack == null) return;
    if (!_current) {
      _invalidate();
      return;
    }
    final route = ModalRoute.of(context);
    final navigator = Navigator.of(context);
    setState(() => _confirming = true);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        _confirmationContext = context;
        final l10n = S.of(context);
        return AlertDialog(
          scrollable: true,
          title: Text(pack.name, maxLines: 3, overflow: TextOverflow.ellipsis),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${l10n?.stickerPackImages ?? 'Images'}: ${MaterialLocalizations.of(context).formatDecimal(pack.stickerCount)}',
              ),
              const SizedBox(height: 8),
              Text(
                subscribe
                    ? (l10n?.stickerSubscribeNotice ??
                          'Follow future changes made by this pack’s administrators. Images and metadata are not end-to-end encrypted. You can unsubscribe later; this does not join the source chat.')
                    : l10n?.stickerImportCopyNotice ?? 'Add a private copy of this pack. Its images and metadata are not end-to-end encrypted.',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l10n?.commonCancel ?? 'Cancel'),
            ),
            FilledButton(
              key: ValueKey(
                subscribe
                    ? 'sticker_subscribe_confirm'
                    : 'sticker_import_confirm',
              ),
              onPressed: () => Navigator.pop(context, true),
              child: Text(
                subscribe
                    ? (l10n?.stickerSubscribe ?? 'Subscribe to updates')
                    : l10n?.commonAdd ?? 'Add',
              ),
            ),
          ],
        );
      },
    );
    _confirmationContext = null;
    if (!mounted) return;
    if (!_current || !identical(_pack, pack)) {
      _invalidate();
      return;
    }
    if (confirmed != true) {
      setState(() => _confirming = false);
      return;
    }
    setState(() {
      _confirming = false;
      _installing = true;
      _failure = null;
    });
    var success = false;
    try {
      success = subscribe
          ? await _repository.setPackSubscribed(
              StickerPackSubscription(
                roomId: pack.origin!.roomId,
                stateKey: pack.origin!.stateKey,
              ),
              enabled: true,
            )
          : await _repository.installPack(pack.id);
    } catch (_) {
      /* Keep the preview for retry. */
    }
    if (!mounted) return;
    if (!_current) {
      _invalidate();
      return;
    }
    setState(() {
      _installing = false;
      if (!success) _failure = _ImportFailure.install;
    });
    if (success) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted ||
            !_current ||
            !navigator.mounted ||
            route?.isActive != true) {
          return;
        }
        if (route!.isCurrent) {
          navigator.pop(true);
        } else {
          navigator.removeRoute(route, true);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final pack = _pack;
    final notice =
        l10n?.stickerImportCopyNotice ??
        'Add a private copy of this pack. Its images and metadata are not end-to-end encrypted.';
    final failure = switch (_failure) {
      _ImportFailure.account =>
        l10n?.stickerImportAccountChanged ??
            'Account changed or session expired. Reopen sticker import.',
      _ImportFailure.install =>
        l10n?.stickerImportFailed ?? 'Could not add this pack. Try again.',
      _ImportFailure.unavailable =>
        l10n?.stickerImportUnavailable ??
            'This pack is unavailable or you do not have access.',
      null => null,
    };
    return PopScope(
      canPop: !_installing,
      child: Scaffold(
        backgroundColor: context.pageBackground,
        appBar: AppBar(
          title: Text(
            l10n?.stickerImportTitle ?? 'Import sticker pack',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      key: const ValueKey('sticker_import_link'),
                      controller: _link,
                      enabled:
                          _current &&
                          !_previewing &&
                          !_installing &&
                          !_confirming,
                      textDirection: TextDirection.ltr,
                      keyboardType: TextInputType.url,
                      maxLines: 2,
                      minLines: 1,
                      decoration: InputDecoration(
                        labelText:
                            l10n?.stickerImportLinkHint ??
                            'Matrix sticker pack link',
                      ),
                      onChanged: (_) => setState(() {
                        _pack = null;
                        _failure = null;
                      }),
                    ),
                    const SizedBox(height: 12),
                    FilledButton.icon(
                      key: const ValueKey('sticker_import_preview'),
                      onPressed:
                          _current &&
                              !_previewing &&
                              !_installing &&
                              _link.text.trim().isNotEmpty
                          ? _preview
                          : null,
                      icon: _previewing
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.visibility_outlined),
                      label: Text(l10n?.stickerImportPreview ?? 'Preview'),
                    ),
                    const SizedBox(height: 12),
                    Text(notice, key: const ValueKey('sticker_import_notice')),
                    if (failure != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        failure,
                        key: const ValueKey('sticker_import_error'),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ],
                    if (pack != null) ...[
                      const SizedBox(height: 20),
                      Text(
                        pack.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      if (pack.author != null) Text(pack.author!),
                      const SizedBox(height: 8),
                      Text(l10n?.stickerPackSourceRoom ?? 'Source chat'),
                      if (pack.origin!.roomName?.isNotEmpty == true)
                        Text(pack.origin!.roomName!),
                      SelectableText(
                        pack.origin!.roomId,
                        key: const ValueKey('sticker_import_origin'),
                        textDirection: TextDirection.ltr,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${l10n?.stickerPackImages ?? 'Images'}: ${MaterialLocalizations.of(context).formatDecimal(pack.stickerCount)}',
                      ),
                    ],
                  ],
                ),
              ),
            ),
            if (pack != null)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 120,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                        StickerThumb(sticker: pack.stickers[index]),
                    childCount: pack.stickerCount,
                  ),
                ),
              ),
          ],
        ),
        bottomNavigationBar: pack == null
            ? null
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FilledButton(
                        key: const ValueKey('sticker_import_add'),
                        onPressed: _current && !_installing && !_confirming
                            ? () => _install()
                            : null,
                        child: _installing
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(l10n?.commonAdd ?? 'Add'),
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton(
                        key: const ValueKey('sticker_import_subscribe'),
                        onPressed: _current && !_installing && !_confirming
                            ? () => _install(subscribe: true)
                            : null,
                        child: Text(
                          (l10n?.stickerSubscribe ?? 'Subscribe to updates'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
