import 'dart:async';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/di/injection.dart';
import '../../../domain/entities/conversation_entity.dart';
import '../../../domain/entities/sticker_pack_entity.dart';
import '../../../domain/entities/sticker_publication_receipt_failure.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/repositories/conversation_repository.dart';
import '../../../domain/repositories/sticker_repository.dart';
import '../../widgets/chat/sticker_thumb.dart';

/// Selecting a room is read-only; a separate confirmation publishes its state.
class StickerPublishPage extends StatefulWidget {
  const StickerPublishPage({super.key, required this.packId});
  final String packId;
  @override
  State<StickerPublishPage> createState() => _StickerPublishPageState();
}

class _StickerPublishPageState extends State<StickerPublishPage> {
  late final IStickerRepository _repo = getIt<IStickerRepository>();
  late final IConversationRepository _conversations =
      getIt<IConversationRepository>();
  late final IAuthRepository _auth = getIt<IAuthRepository>();
  IAccountBoundDeletionLifecycle? _lifecycle;
  AuthSessionInvalidation? _generation;
  StreamSubscription<AuthSessionInvalidation>? _invalidations;
  BuildContext? _dialog;
  StickerPack? _pack;
  List<ConversationEntity> _rooms = [];
  ConversationEntity? _selected;
  String? _link;
  bool _receiptMissing = false;
  bool _loading = true, _busy = false, _confirming = false, _failed = false;

  bool get _current =>
      _generation?.isCurrent == true &&
      identical(_lifecycle?.currentAccountGeneration, _generation) &&
      getIt.isRegistered<IAuthRepository>() &&
      identical(getIt<IAuthRepository>(), _auth) &&
      getIt.isRegistered<IStickerRepository>() &&
      identical(getIt<IStickerRepository>(), _repo) &&
      getIt.isRegistered<IConversationRepository>() &&
      identical(getIt<IConversationRepository>(), _conversations);

  @override
  void initState() {
    super.initState();
    if (_auth is IAccountBoundDeletionLifecycle &&
        _auth is IAccountBoundAuthInvalidation) {
      _lifecycle = _auth as IAccountBoundDeletionLifecycle;
      _generation = _lifecycle!.currentAccountGeneration;
      _invalidations = (_auth as IAccountBoundAuthInvalidation)
          .accountInvalidationStream
          .listen((_) {
            if (!_current && mounted) _invalidate();
          });
    }
    unawaited(_load());
  }

  void _closeDialog() {
    final context = _dialog;
    _dialog = null;
    if (context == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;
      final route = ModalRoute.of(context);
      if (route?.isActive == true) Navigator.of(context).removeRoute(route!);
    });
  }

  void _invalidate() {
    _closeDialog();
    setState(() {
      _pack = null;
      _rooms = [];
      _selected = null;
      _link = null;
      _receiptMissing = false;
      _loading = false;
      _busy = false;
      _confirming = false;
    });
  }

  Future<void> _load() async {
    if (!_current) {
      _invalidate();
      return;
    }
    try {
      final loaded = await _repo.getPackById(widget.packId);
      final pack = loaded?.copyWith(
        stickers: List.unmodifiable(loaded.stickers),
      );
      if (!mounted) return;
      if (!_current) {
        _invalidate();
        return;
      }
      final link = pack?.source == StickerPackSource.custom
          ? await _repo.getPackShareUrl(widget.packId, reviewedPack: pack)
          : null;
      if (!mounted) return;
      if (!_current) {
        _invalidate();
        return;
      }
      final rooms = await _conversations.getConversations();
      if (!mounted) return;
      if (!_current) {
        _invalidate();
        return;
      }
      setState(() {
        _pack = pack?.source == StickerPackSource.custom ? pack : null;
        _rooms = rooms
            .where((r) => r.isGroup && !r.isInvite && !r.isHidden)
            .toList();
        _failed = _pack == null;
        _link = link;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      if (!_current) {
        _invalidate();
        return;
      }
      setState(() {
        _failed = true;
        _loading = false;
      });
    }
  }

  Future<void> _publish() async {
    final pack = _pack;
    final room = _selected;
    if (!_current ||
        _busy ||
        _confirming ||
        pack == null ||
        room == null ||
        _link != null) {
      return;
    }
    setState(() => _confirming = true);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        _dialog = context;
        final l10n = S.of(context)!;
        return AlertDialog(
          scrollable: true,
          title: Text(pack.name),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(room.name),
              SelectableText(room.id, textDirection: TextDirection.ltr),
              const SizedBox(height: 12),
              Text(l10n.stickerPublishNotice),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l10n.commonCancel),
            ),
            FilledButton(
              key: const ValueKey('sticker_publish_confirm'),
              onPressed: () => Navigator.pop(context, true),
              child: Text(l10n.groupPublish),
            ),
          ],
        );
      },
    );
    _dialog = null;
    if (!mounted) return;
    if (!_current) {
      _invalidate();
      return;
    }
    if (confirmed != true) {
      setState(() => _confirming = false);
      return;
    }
    setState(() {
      _confirming = false;
      _busy = true;
    });
    try {
      final link = await _repo.publishPack(
        pack.id,
        room.id,
        reviewedPack: pack,
      );
      if (!mounted) return;
      if (!_current) {
        _invalidate();
        return;
      }
      setState(() {
        _link = link;
        _busy = false;
        _failed = link == null;
      });
    } on StickerPublicationReceiptFailure catch (error) {
      if (!mounted) return;
      if (!_current) {
        _invalidate();
        return;
      }
      setState(() {
        _link = error.shareUrl;
        _receiptMissing = true;
        _busy = false;
        _failed = false;
      });
    } catch (_) {
      if (!mounted) return;
      if (!_current) {
        _invalidate();
        return;
      }
      // No automatic retry: a lost receipt can still mean state was published.
      setState(() {
        _busy = false;
        _failed = true;
      });
    }
  }

  @override
  void dispose() {
    unawaited(_invalidations?.cancel());
    _closeDialog();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;
    final pack = _pack;
    return PopScope(
      canPop: !_busy,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            l10n.commonShare,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (!_current)
                    Text(l10n.stickerImportAccountChanged)
                  else ...[
                    Text(l10n.stickerPublishNotice),
                    if (_failed)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          _pack == null
                              ? l10n.commonLoadFailed
                              : l10n.stickerPublishFailed,
                        ),
                      ),
                    if (pack != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        pack.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        '${l10n.stickerPackImages}: ${MaterialLocalizations.of(context).formatDecimal(pack.stickerCount)}',
                      ),
                      if (pack.stickers.isNotEmpty)
                        SizedBox(
                          height: 100,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: pack.stickerCount,
                            separatorBuilder: (_, _) =>
                                const SizedBox(width: 8),
                            itemBuilder: (_, index) => SizedBox(
                              width: 100,
                              child: StickerThumb(
                                sticker: pack.stickers[index],
                              ),
                            ),
                          ),
                        ),
                      if (_rooms.isEmpty) Text(l10n.commonNoGroups),
                      for (final room in _rooms)
                        ListTile(
                          key: ValueKey('sticker_publish_room_${room.id}'),
                          leading: Icon(
                            _selected?.id == room.id
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                          ),
                          title: Text(room.name),
                          subtitle: Text(
                            room.id,
                            textDirection: TextDirection.ltr,
                          ),
                          enabled: !_busy && !_confirming && _link == null,
                          onTap: () => setState(() => _selected = room),
                        ),
                      if (_link == null)
                        FilledButton(
                          key: const ValueKey('sticker_publish_review'),
                          onPressed: _selected != null && !_busy
                              ? _publish
                              : null,
                          child: _busy
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(l10n.groupPublish),
                        )
                      else ...[
                        if (_receiptMissing)
                          Text(
                            l10n.stickerPublishReceiptMissing,
                            key: const ValueKey(
                              'sticker_publish_receipt_missing',
                            ),
                          ),
                        SelectableText(
                          _link!,
                          key: const ValueKey('sticker_publish_link'),
                          textDirection: TextDirection.ltr,
                        ),
                        TextButton.icon(
                          key: const ValueKey('sticker_publish_another'),
                          onPressed: () {
                            if (!_current) {
                              _invalidate();
                              return;
                            }
                            setState(() {
                              _link = null;
                              _selected = null;
                              _receiptMissing = false;
                              _failed = false;
                            });
                          },
                          icon: const Icon(Icons.add),
                          label: Text(l10n.groupPublish),
                        ),
                        Builder(
                          builder: (context) => FilledButton.icon(
                            onPressed: () {
                              if (!_current) {
                                _invalidate();
                                return;
                              }
                              final box =
                                  context.findRenderObject() as RenderBox?;
                              unawaited(
                                SharePlus.instance
                                    .share(
                                      ShareParams(
                                        text: _link!,
                                        sharePositionOrigin: box == null
                                            ? null
                                            : box.localToGlobal(Offset.zero) &
                                                  box.size,
                                      ),
                                    )
                                    .then<void>(
                                      (_) {},
                                      onError:
                                          (Object error, StackTrace stack) {
                                            if (mounted && _current) {
                                              ScaffoldMessenger.of(this.context)
                                                  .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        S
                                                            .of(this.context)!
                                                            .commonLoadFailed,
                                                      ),
                                                    ),
                                                  );
                                            }
                                          },
                                    ),
                              );
                            },
                            icon: const Icon(Icons.share_outlined),
                            label: Text(l10n.commonShare),
                          ),
                        ),
                      ],
                    ],
                  ],
                ],
              ),
      ),
    );
  }
}
