import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/di/injection.dart';
import '../../../domain/entities/sticker_pack_subscription.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/repositories/sticker_repository.dart';

/// Lists references directly, so loss of source-room access cannot hide removal.
class StickerSubscriptionsPage extends StatefulWidget {
  const StickerSubscriptionsPage({super.key});

  @override
  State<StickerSubscriptionsPage> createState() =>
      _StickerSubscriptionsPageState();
}

class _StickerSubscriptionsPageState extends State<StickerSubscriptionsPage> {
  late final IStickerRepository _repository = getIt<IStickerRepository>();
  IAuthRepository? _auth;
  IAccountBoundDeletionLifecycle? _lifecycle;
  AuthSessionInvalidation? _generation;
  StreamSubscription<AuthSessionInvalidation>? _invalidations;
  StreamSubscription<void>? _sessions;
  List<StickerPackSubscription> _references = [];
  BuildContext? _confirmation;
  bool _loading = true;
  bool _writing = false;
  bool _failed = false;
  bool _saveFailed = false;

  bool get _current =>
      _generation?.isCurrent == true &&
      identical(_lifecycle?.currentAccountGeneration, _generation) &&
      getIt.isRegistered<IAuthRepository>() &&
      identical(getIt<IAuthRepository>(), _auth) &&
      getIt.isRegistered<IStickerRepository>() &&
      identical(getIt<IStickerRepository>(), _repository);

  @override
  void initState() {
    super.initState();
    if (getIt.isRegistered<IAuthRepository>()) {
      final auth = getIt<IAuthRepository>();
      _auth = auth;
      if (auth is IAccountBoundDeletionLifecycle) {
        _lifecycle = auth as IAccountBoundDeletionLifecycle;
        _generation = _lifecycle!.currentAccountGeneration;
      }
      if (auth is IAccountBoundAuthInvalidation) {
        _invalidations = (auth as IAccountBoundAuthInvalidation)
            .accountInvalidationStream
            .listen((_) => _checkAccount());
      }
      if (auth is IAccountBoundSessionChanges) {
        _sessions = (auth as IAccountBoundSessionChanges).accountSessionChanges
            .listen((_) => _checkAccount());
      }
    }
    unawaited(_load());
  }

  void _closeConfirmation() {
    final owned = _confirmation;
    _confirmation = null;
    if (owned == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!owned.mounted) return;
      final route = ModalRoute.of(owned);
      if (route?.isActive == true) Navigator.of(owned).removeRoute(route!);
    });
  }

  void _checkAccount() {
    if (!mounted || _current) return;
    _closeConfirmation();
    setState(() {
      _references = [];
      _loading = false;
      _writing = false;
      _failed = false;
    });
  }

  Future<void> _load() async {
    if (_writing) return;
    if (!_current) {
      _checkAccount();
      return;
    }
    setState(() {
      _loading = true;
      _failed = false;
    });
    try {
      final references = await _repository.getPackSubscriptions();
      if (!mounted) return;
      if (!_current) {
        _checkAccount();
        return;
      }
      setState(() {
        _references = List.unmodifiable(references);
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      if (!_current) {
        _checkAccount();
        return;
      }
      setState(() {
        _loading = false;
        _failed = true;
        _saveFailed = false;
      });
    }
  }

  Future<void> _remove(StickerPackSubscription reference) async {
    if (_writing || !_current) return;
    setState(() => _writing = true);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialog) {
        _confirmation = dialog;
        final labels = S.of(dialog);
        return AlertDialog(
          scrollable: true,
          title: Text(labels?.stickerUnsubscribe ?? 'Unsubscribe'),
          content: Text(
            '${reference.roomId}${reference.stateKey.isEmpty ? '' : '\n${reference.stateKey}'}',
            textDirection: TextDirection.ltr,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialog, false),
              child: Text(labels?.commonCancel ?? 'Cancel'),
            ),
            FilledButton(
              key: const ValueKey('sticker_unsubscribe_confirm'),
              onPressed: () => Navigator.pop(dialog, true),
              child: Text(labels?.stickerUnsubscribe ?? 'Unsubscribe'),
            ),
          ],
        );
      },
    );
    _confirmation = null;
    if (!mounted) return;
    if (!_current) {
      _checkAccount();
      return;
    }
    if (confirmed != true) {
      setState(() => _writing = false);
      return;
    }
    var success = false;
    try {
      success = await _repository.setPackSubscribed(reference, enabled: false);
    } catch (_) {
      /* Keep the reference available for explicit retry. */
    }
    if (!mounted) return;
    if (!_current) {
      _checkAccount();
      return;
    }
    setState(() {
      _writing = false;
      _failed = !success;
      _saveFailed = !success;
    });
    if (success) await _load();
  }

  @override
  void dispose() {
    unawaited(_invalidations?.cancel());
    unawaited(_sessions?.cancel());
    _closeConfirmation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final labels = S.of(context);
    return PopScope(
      canPop: !_writing,
      child: Scaffold(
        appBar: AppBar(
          title: Text(labels?.stickerSubscriptions ?? 'Sticker subscriptions'),
        ),
        body: !_current
            ? Center(
                child: Text(
                  labels?.stickerImportAccountChanged ?? 'Account changed or session expired. Reopen sticker import.',
                ),
              )
            : _loading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: _load,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  children: [
                    if (_failed)
                      Text(
                        _saveFailed
                            ? labels?.commonFailedToSave ?? 'Failed to save'
                            : labels?.commonLoadFailed ?? 'Failed to load',
                        key: const ValueKey('sticker_subscription_error'),
                      ),
                    if (_failed)
                      TextButton(
                        onPressed: _writing ? null : _load,
                        child: Text(labels?.commonRetry ?? 'Retry'),
                      ),
                    if (_references.isEmpty && !_failed)
                      Text(
                        labels?.stickerSubscriptionsEmpty ??
                            'No sticker subscriptions',
                      ),
                    for (final reference in _references)
                      Card(
                        key: ValueKey(reference.packId),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                reference.roomId,
                                textDirection: TextDirection.ltr,
                              ),
                              if (reference.stateKey.isNotEmpty)
                                Text(
                                  reference.stateKey,
                                  textDirection: TextDirection.ltr,
                                ),
                              const SizedBox(height: 8),
                              OutlinedButton(
                                onPressed: _writing
                                    ? null
                                    : () => _remove(reference),
                                child: Text(
                                  labels?.stickerUnsubscribe ?? 'Unsubscribe',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}
