import 'dart:async';
import 'dart:typed_data';

import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:n42_chat/l10n/app_localizations.dart';

import '../../../core/di/injection.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../data/datasources/local/preferences_datasource.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../data/services/scheduled_draft_operation.dart';
import '../../../domain/repositories/message_repository.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/entities/scheduled_message_draft.dart';
import '../../../domain/entities/scheduled_recovery_copy.dart';
import '../../../domain/entities/scheduled_recovery_inspection.dart';
import '../../blocs/chat/chat_bloc.dart';
import '../../blocs/chat/chat_event.dart';
import '../../blocs/chat/scheduled_message_origin.dart';
import '../../../core/theme/app_dimensions.dart';

class ScheduledMessagesPage extends StatefulWidget {
  final String roomId;
  final String roomName;
  final Future<void> Function(Uint8List bytes)? recoveryExporter;
  final Future<Uint8List?> Function()? recoveryFilePicker;

  const ScheduledMessagesPage({
    super.key,
    required this.roomId,
    required this.roomName,
    this.recoveryExporter,
    this.recoveryFilePicker,
  });

  @override
  State<ScheduledMessagesPage> createState() => _ScheduledMessagesPageState();
}

class _ScheduledMessagesPageState extends State<ScheduledMessagesPage> {
  final PreferencesDataSource _preferences = getIt<PreferencesDataSource>();

  final IMessageRepository _messages = getIt<IMessageRepository>();
  StreamSubscription<bool>? _accountSubscription;
  String? _ownerUserId;
  final ScheduledMessageOrigin? _origin = ScheduledMessageOrigin.capture();
  int _loadVersion = 0;
  bool _isLoading = true;
  bool _loadFailed = false;
  bool _savingRecovery = false;
  DialogRoute<dynamic>? _recoveryRoute;
  final Set<String> _cancelling = {};
  List<ScheduledMessageDraft> _drafts = const [];

  @override
  void initState() {
    super.initState();
    if (getIt.isRegistered<IAuthRepository>()) {
      _accountSubscription = getIt<IAuthRepository>().loginStateStream.listen((
        _,
      ) {
        if (!mounted) return;
        _closeRecovery();
        setState(() {
          _ownerUserId = null;
          _drafts = const [];
        });
        _loadDrafts();
      });
    }
    _loadDrafts();
  }

  @override
  void dispose() {
    _accountSubscription?.cancel();
    final route = _recoveryRoute;
    _recoveryRoute = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (route?.isActive == true && route!.navigator?.mounted == true) {
        route.navigator!.removeRoute(route);
      }
    });
    super.dispose();
  }

  void _closeRecovery() {
    final route = _recoveryRoute;
    _recoveryRoute = null;
    if (route?.isActive == true) route!.navigator?.removeRoute(route);
  }

  Future<void> _saveRecoveryCopy() async {
    if (_savingRecovery || _origin?.isCurrent != true) return;
    setState(() => _savingRecovery = true);
    try {
      final owner = await _messages.getCurrentUserId();
      if (!mounted ||
          owner == null ||
          owner.isEmpty ||
          _origin?.isCurrent != true) {
        return;
      }
      final raw = await _preferences.saveScheduledRecoveryCopy(
        ownerUserId: owner,
        isCurrent: () => mounted && _origin?.isCurrent == true,
      );
      if (!mounted ||
          _origin?.isCurrent != true ||
          owner != await _messages.getCurrentUserId() ||
          !mounted ||
          _origin?.isCurrent != true) {
        return;
      }
      if (raw == null) {
        await _loadDrafts();
        return;
      }
      await _showRecoveryPreview(raw);
    } catch (_) {
      if (mounted && _origin?.isCurrent == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              S.of(context)?.commonFailedToSave ?? 'Failed to save',
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _savingRecovery = false);
    }
  }

  Future<void> _resetCorruptQueue() async {
    if (_savingRecovery || _origin?.isCurrent != true) return;
    setState(() => _savingRecovery = true);
    try {
      final owner = await _messages.getCurrentUserId();
      if (!mounted ||
          owner == null ||
          owner.isEmpty ||
          _origin?.isCurrent != true) {
        return;
      }
      final raw = await _preferences.saveScheduledRecoveryCopy(
        ownerUserId: owner,
        isCurrent: () => mounted && _origin?.isCurrent == true,
      );
      if (!mounted ||
          raw == null ||
          _origin?.isCurrent != true ||
          owner != await _messages.getCurrentUserId() ||
          !mounted ||
          _origin?.isCurrent != true) {
        return;
      }
      final route = DialogRoute<bool>(
        context: context,
        builder: (context) => AlertDialog(
          scrollable: true,
          title: Text(
            S.of(context)?.scheduledRecoveryReset ?? 'Reset damaged queue',
          ),
          content: Text(
            S.of(context)?.scheduledRecoveryResetHint ?? 'An exact copy is saved on this device. Reset all scheduled messages for this account? Some may already have been sent. Copies and attachments are kept. Nothing is resent.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(S.of(context)?.commonCancel ?? 'Cancel'),
            ),
            TextButton(
              key: const ValueKey('scheduled-recovery-reset-confirm'),
              onPressed: () => Navigator.pop(context, true),
              child: Text(S.of(context)?.commonConfirm ?? 'Confirm'),
            ),
          ],
        ),
      );
      _recoveryRoute = route;
      final confirmed = await Navigator.of(context).push(route);
      if (identical(_recoveryRoute, route)) _recoveryRoute = null;
      if (!mounted ||
          confirmed != true ||
          _origin?.isCurrent != true ||
          owner != await _messages.getCurrentUserId() ||
          !mounted ||
          _origin?.isCurrent != true) {
        return;
      }
      await _preferences.resetCorruptScheduledMessages(
        ownerUserId: owner,
        expectedRaw: raw,
        isCurrent: () => mounted && _origin?.isCurrent == true,
      );
      if (mounted && _origin?.isCurrent == true) await _loadDrafts();
    } catch (_) {
      if (mounted && _origin?.isCurrent == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              S.of(context)?.commonFailedToSave ?? 'Failed to save',
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _savingRecovery = false);
    }
  }

  Future<void> _showRecoveryPreview(String raw) async {
    final previewRunes = raw.runes.take(8001).toList(growable: false);
    final preview =
        String.fromCharCodes(previewRunes.take(8000)) +
        (previewRunes.length > 8000 ? '…' : '');
    final route = DialogRoute<String>(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        title: Text(
          S.of(context)?.scheduledRecoveryCopy ?? 'Save recovery copy',
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context)?.scheduledRecoveryCopyHint ?? 'Saved on this device without changing or sending messages. Preview shows up to 8,000 characters.',
                ),
                const SizedBox(height: 16),
                SelectableText(preview),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            key: const ValueKey('scheduled-recovery-inspect'),
            onPressed: () => Navigator.pop(context, 'inspect'),
            child: Text(S.of(context)?.chatDetails ?? 'Details'),
          ),
          TextButton(
            key: const ValueKey('scheduled-recovery-export'),
            onPressed: () => Navigator.pop(context, 'export'),
            child: Text(S.of(context)?.commonShare ?? 'Share'),
          ),
          TextButton(
            key: const ValueKey('scheduled-recovery-delete'),
            onPressed: () => Navigator.pop(context, 'delete'),
            child: Text(S.of(context)?.commonDelete ?? 'Delete'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(MaterialLocalizations.of(context).closeButtonLabel),
          ),
        ],
      ),
    );
    _recoveryRoute = route;
    final action = await Navigator.of(context).push(route);
    if (identical(_recoveryRoute, route)) _recoveryRoute = null;
    if (mounted && _origin?.isCurrent == true) {
      if (action == 'inspect') await _inspectRecoveryCopy(raw);
      if (action == 'delete') await _confirmRecoveryAction(raw);
      if (action == 'export') await _confirmRecoveryAction(raw, export: true);
    }
  }

  Future<void> _inspectRecoveryCopy(String raw) async {
    final owner = _ownerUserId;
    if (owner == null || !mounted || _origin?.isCurrent != true) return;
    final copies = await _preferences.getScheduledRecoveryCopies(
      ownerUserId: owner, isCurrent: () => mounted && _origin?.isCurrent == true,
    );
    if (!mounted || _origin?.isCurrent != true ||
        owner != await _messages.getCurrentUserId() || !mounted || _origin?.isCurrent != true) {
      return;
    }
    final matching = copies.where((copy) => copy.isIntact && copy.raw == raw);
    if (matching.length != 1) throw StateError('Recovery copy changed');
    final report = ScheduledRecoveryInspection.inspect(matching.single);
    final route = DialogRoute<void>(context: context, builder: (context) => Dialog.fullscreen(
      child: Scaffold(
        appBar: AppBar(title: Text(S.of(context)?.chatDetails ?? 'Details'),
          leading: IconButton(icon: const Icon(Icons.close),
            tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
            onPressed: () => Navigator.pop(context))),
        body: Column(children: [
          Padding(padding: const EdgeInsets.all(16), child: Text(
            S.of(context)?.scheduledRecoveryCopyHint ?? 'Saved on this device without changing or sending messages. Preview shows up to 8,000 characters.')),
          if (report.documentIssue != null) Padding(padding: const EdgeInsets.all(16),
            child: Text(S.of(context)?.commonLoadFailed ?? 'Failed to load')),
          Expanded(child: ListView.builder(itemCount: report.entries.length,
            itemBuilder: (context, index) {
              final entry = report.entries[index];
              return ListTile(key: ValueKey('scheduled-recovery-entry-$index'),
                leading: Icon(entry.issue == null ? Icons.description_outlined : Icons.error_outline),
                title: entry.draft == null
                    ? Text(S.of(context)?.commonLoadFailed ?? 'Failed to load')
                    : SelectableText(String.fromCharCodes(entry.draft!.text.runes.take(8000))),
                subtitle: Text(entry.roomId),
              );
            })),
        ]),
      ),
    ));
    _recoveryRoute = route;
    await Navigator.of(context).push(route);
    if (identical(_recoveryRoute, route)) _recoveryRoute = null;
  }

  Future<void> _confirmRecoveryAction(String raw, {bool export = false}) async {
    final owner = _ownerUserId;
    if (owner == null || !mounted || _origin?.isCurrent != true) return;
    final route = DialogRoute<bool>(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        title: Text(
          export
              ? (S.of(context)?.commonShare ?? 'Share')
              : (S.of(context)?.commonDelete ?? 'Delete'),
        ),
        content: Text(
          export
              ? (S.of(context)?.scheduledRecoveryExportHint ??
                    'This file contains unencrypted draft text and account details. Attachments are not included. Choose a trusted destination.')
              : '${S.of(context)?.scheduledRecoveryCopies ?? 'Recovery copies'}\n\n${String.fromCharCodes(raw.runes.take(100))}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(S.of(context)?.commonCancel ?? 'Cancel'),
          ),
          TextButton(
            key: ValueKey(
              export
                  ? 'scheduled-recovery-export-confirm'
                  : 'scheduled-recovery-delete-confirm',
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              export
                  ? (S.of(context)?.commonShare ?? 'Share')
                  : (S.of(context)?.commonDelete ?? 'Delete'),
            ),
          ),
        ],
      ),
    );
    _recoveryRoute = route;
    final confirmed = await Navigator.of(context).push(route);
    if (identical(_recoveryRoute, route)) _recoveryRoute = null;
    if (confirmed != true ||
        !mounted ||
        _origin?.isCurrent != true ||
        owner != await _messages.getCurrentUserId() ||
        !mounted ||
        _origin?.isCurrent != true) {
      return;
    }
    if (export) {
      final copies = await _preferences.getScheduledRecoveryCopies(
        ownerUserId: owner,
        isCurrent: () => mounted && _origin?.isCurrent == true,
      );
      if (!mounted ||
          _origin?.isCurrent != true ||
          owner != await _messages.getCurrentUserId() ||
          !mounted ||
          _origin?.isCurrent != true) {
        return;
      }
      final copy = copies.singleWhere(
        (copy) => copy.isIntact && copy.raw == raw,
      );
      final bytes = copy.exportBytes(owner);
      final exporter = widget.recoveryExporter;
      if (exporter != null) {
        await exporter(bytes);
      } else {
        final box = context.findRenderObject() as RenderBox?;
        if (box == null || !box.hasSize) {
          throw StateError('Export view unavailable');
        }
        await SharePlus.instance.share(
          ShareParams(
            files: [XFile.fromData(bytes, mimeType: 'application/json')],
            fileNameOverrides: [
              'n42-recovery-${copy.id.substring(0, 12)}.json',
            ],
            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
          ),
        );
      }
      return;
    }
    await _preferences.deleteScheduledRecoveryCopy(
      ownerUserId: owner,
      expectedRaw: raw,
      isCurrent: () => mounted && _origin?.isCurrent == true,
    );
  }

  Future<Uint8List?> _pickRecoveryFile() async {
    final file = await FilePicker.pickFile(type: FileType.custom, allowedExtensions: ['json']);
    if (file == null || !mounted || _origin?.isCurrent != true) return null;
    final size = file.lengthSync();
    if (size != null && size > ScheduledRecoveryCopy.maxImportBytes) {
      throw const FormatException('Recovery file too large');
    }
    final bytes = BytesBuilder(copy: true);
    await for (final chunk in file.readAsByteStream()) {
      if (!mounted || _origin?.isCurrent != true) return null;
      if (bytes.length + chunk.length > ScheduledRecoveryCopy.maxImportBytes) {
        throw const FormatException('Recovery file too large');
      }
      bytes.add(chunk);
    }
    return bytes.takeBytes();
  }

  Future<void> _importRecoveryCopy() async {
    if (_savingRecovery || _origin?.isCurrent != true) return;
    setState(() => _savingRecovery = true);
    try {
      final owner = await _messages.getCurrentUserId();
      bool current() => mounted && _origin?.isCurrent == true;
      if (!current() || owner == null || owner.isEmpty) return;
      final bytes = await (widget.recoveryFilePicker ?? _pickRecoveryFile)();
      if (!current() || bytes == null || owner != await _messages.getCurrentUserId() || !current()) return;
      if (!mounted) return;
      final copy = ScheduledRecoveryCopy.fromExportBytes(bytes, ownerUserId: owner);
      final route = DialogRoute<bool>(
        context: context,
        builder: (context) => AlertDialog(
          scrollable: true,
          title: Text((S.of(context)?.scheduledRecoveryImport ?? 'Import recovery copy')),
          content: SizedBox(width: double.maxFinite, child: Column(
            mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text((S.of(context)?.scheduledRecoveryImportHint ?? 'Save this preview as a recovery copy only. No messages will be scheduled or sent. Attachments are not included. The file author is not verified.')),
              const SizedBox(height: 16),
              SelectableText(String.fromCharCodes(copy.raw!.runes.take(8000))),
            ],
          )),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: Text((S.of(context)?.commonCancel ?? 'Cancel'))),
            TextButton(key: const ValueKey('scheduled-recovery-import-confirm'),
              onPressed: () => Navigator.pop(context, true), child: Text((S.of(context)?.commonConfirm ?? 'Confirm'))),
          ],
        ),
      );
      _recoveryRoute = route;
      final confirmed = await Navigator.of(context).push(route);
      if (identical(_recoveryRoute, route)) _recoveryRoute = null;
      if (!current() || confirmed != true || owner != await _messages.getCurrentUserId() || !current()) return;
      await _preferences.importScheduledRecoveryCopy(
        bytes: copy.exportBytes(owner), ownerUserId: owner, isCurrent: current,
      );
      if (current()) {
        await _showRecoveryPreview(copy.raw!);
      }
    } catch (_) {
      if (mounted && _origin?.isCurrent == true) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text((S.of(context)?.commonFailedToSave ?? 'Failed to save'))));
      }
    } finally {
      if (mounted) setState(() => _savingRecovery = false);
    }
  }

  Future<void> _openRecoveryCopies() async {
    if (_savingRecovery || _origin?.isCurrent != true) return;
    setState(() => _savingRecovery = true);
    try {
      final owner = await _messages.getCurrentUserId();
      if (!mounted ||
          owner == null ||
          owner.isEmpty ||
          _origin?.isCurrent != true) {
        return;
      }
      final copies = await _preferences.getScheduledRecoveryCopies(
        ownerUserId: owner,
        isCurrent: () => mounted && _origin?.isCurrent == true,
      );
      if (!mounted ||
          _origin?.isCurrent != true ||
          owner != await _messages.getCurrentUserId() ||
          !mounted ||
          _origin?.isCurrent != true) {
        return;
      }
      final route = DialogRoute<ScheduledRecoveryCopy>(
        context: context,
        builder: (context) => Dialog.fullscreen(
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                S.of(context)?.scheduledRecoveryCopies ?? 'Recovery copies',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              leading: IconButton(
                icon: const Icon(Icons.close),
                tooltip: MaterialLocalizations.of(context).closeButtonLabel,
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: copies.isEmpty
                ? Center(
                    child: Text(
                      S.of(context)?.backupNoBackups ?? 'No backups yet',
                    ),
                  )
                : ListView.builder(
                    itemCount: copies.length,
                    itemBuilder: (context, index) {
                      final copy = copies[index];
                      final preview = copy.isIntact
                          ? String.fromCharCodes(copy.raw!.runes.take(100))
                          : (S.of(context)?.commonLoadFailed ??
                                'Failed to load');
                      return ListTile(
                        key: ValueKey('scheduled-recovery-${copy.id}'),
                        leading: Icon(
                          copy.isIntact
                              ? Icons.description_outlined
                              : Icons.error_outline,
                        ),
                        title: Text(
                          preview,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        enabled: copy.isIntact,
                        onTap: copy.isIntact
                            ? () => Navigator.pop(context, copy)
                            : null,
                      );
                    },
                  ),
          ),
        ),
      );
      _recoveryRoute = route;
      final selected = await Navigator.of(context).push(route);
      if (identical(_recoveryRoute, route)) _recoveryRoute = null;
      if (!mounted ||
          _origin?.isCurrent != true ||
          selected?.isIntact != true ||
          owner != await _messages.getCurrentUserId() ||
          !mounted ||
          _origin?.isCurrent != true) {
        return;
      }
      await _showRecoveryPreview(selected!.raw!);
    } catch (_) {
      if (mounted && _origin?.isCurrent == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context)?.commonLoadFailed ?? 'Failed to load'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _savingRecovery = false);
    }
  }

  Future<void> _loadDrafts() async {
    if (!mounted) return;
    final version = ++_loadVersion;
    setState(() {
      _isLoading = true;
      _loadFailed = false;
    });
    try {
      final owner = _origin?.isCurrent == true
          ? await _messages.getCurrentUserId()
          : null;
      final drafts =
          owner == null || owner.isEmpty
                ? <ScheduledMessageDraft>[]
                : (await _preferences.getScheduledMessages(
                    widget.roomId,
                    ownerUserId: owner,
                  )).toList()
            ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
      final stillOwner = await _messages.getCurrentUserId();
      if (!mounted || version != _loadVersion) return;
      setState(() {
        _ownerUserId = stillOwner == owner && _origin?.isCurrent == true
            ? owner
            : null;
        _drafts = stillOwner == owner && _origin?.isCurrent == true
            ? drafts
            : const [];
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('ScheduledMessagesPage._loadDrafts error: ${e.runtimeType}');
      if (!mounted || version != _loadVersion) return;
      setState(() {
        _isLoading = false;
        _loadFailed = _origin?.isCurrent == true;
        _ownerUserId = null;
        _drafts = const [];
      });
    }
  }

  Future<void> _cancelDraft(ScheduledMessageDraft draft) async {
    if (!_cancelling.add(draft.messageId)) return;
    setState(() {});
    final owner = _ownerUserId;
    ScheduledDraftOperation? operation;
    try {
      if (_origin?.isCurrent != true ||
          owner == null ||
          owner != await _messages.getCurrentUserId() ||
          _origin?.isCurrent != true) {
        await _loadDrafts();
        return;
      }
      if (!mounted) return;
      final bloc = context.read<ChatBloc?>();
      if (bloc != null) {
        final completion = Completer<bool>();
        bloc.add(
          CancelScheduledMessage(
            draft.messageId,
            roomId: widget.roomId,
            ownerUserId: owner,
            origin: _origin,
            completion: completion,
          ),
        );
        final cancelled = await completion.future.timeout(
          const Duration(seconds: 30),
          onTimeout: () => false,
        );
        if (!cancelled) {
          await _loadDrafts();
          throw StateError('Cancellation was not confirmed');
        }
      } else {
        operation = ScheduledDraftOperation.tryAcquire(
          ownerUserId: owner,
          roomId: widget.roomId,
          messageId: draft.messageId,
        );
        if (operation == null) throw StateError('Scheduled message is busy');
        final remaining = await _preferences.getScheduledMessages(
          widget.roomId,
          ownerUserId: owner,
        );
        if (operation.receipt != null ||
            !remaining.any(
              (item) =>
                  item.messageId == draft.messageId &&
                  item.acceptedEventId == null,
            )) {
          await _loadDrafts();
          throw StateError('Scheduled draft is no longer pending');
        }
        if (!mounted || _origin?.isCurrent != true) return;
        await _preferences.removeScheduledMessage(
          widget.roomId,
          draft.messageId,
          ownerUserId: owner,
        );
      }
      if (_origin?.isCurrent != true ||
          owner != await _messages.getCurrentUserId() ||
          !mounted ||
          owner != _ownerUserId ||
          _origin?.isCurrent != true) {
        return;
      }
      setState(() {
        _drafts = _drafts
            .where((item) => item.messageId != draft.messageId)
            .toList();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            S.of(context)?.scheduledMessageCancelled ??
                'Scheduled message cancelled',
          ),
        ),
      );
    } catch (e) {
      if (_origin?.isCurrent != true ||
          !mounted ||
          owner != _ownerUserId ||
          owner != await _messages.getCurrentUserId() ||
          !mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)?.commonFailedToSave ?? 'Failed to save'),
        ),
      );
    } finally {
      operation?.release();
      _cancelling.remove(draft.messageId);
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBackground,
      appBar: AppBar(
        backgroundColor: context.surfaceColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          S.of(context)?.scheduledMessagesTitle ?? 'Scheduled messages',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: context.textPrimary,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            height: 1.3,
          ),
        ),
        actions: [
          IconButton(
            key: const ValueKey('scheduled-recovery-import'),
            icon: const Icon(Icons.file_open_outlined),
            tooltip: (S.of(context)?.scheduledRecoveryImport ?? 'Import recovery copy'),
            onPressed: _savingRecovery ? null : _importRecoveryCopy,
          ),
          IconButton(
            key: const ValueKey('scheduled-recovery-history'),
            icon: const Icon(Icons.history),
            tooltip:
                S.of(context)?.scheduledRecoveryCopies ?? 'Recovery copies',
            onPressed: _savingRecovery ? null : _openRecoveryCopies,
          ),
        ],
        leading: IconButton(
          icon: Icon(AppIcons.back, color: context.textPrimary, size: 20),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _loadDrafts,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : (_loadFailed
                  ? _buildLoadError()
                  : _drafts.isEmpty
                  ? _buildEmptyState()
                  : ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(AppDimensions.spacing),
                      itemCount: _drafts.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: AppDimensions.spacingM),
                      itemBuilder: (context, index) {
                        final draft = _drafts[index];
                        return _buildDraftCard(draft);
                      },
                    )),
      ),
    );
  }

  Widget _buildLoadError() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppDimensions.spacing),
      children: [
        const SizedBox(height: AppDimensions.spacingXXL),
        Icon(Icons.error_outline, color: context.textSecondary, size: 48),
        const SizedBox(height: AppDimensions.spacing),
        Text(
          S.of(context)?.commonLoadFailed ?? 'Failed to load',
          textAlign: TextAlign.center,
          style: TextStyle(color: context.textPrimary),
        ),
        const SizedBox(height: AppDimensions.spacing),
        Center(
          child: TextButton.icon(
            onPressed: _loadDrafts,
            icon: const Icon(Icons.refresh),
            label: Text(S.of(context)?.commonRetry ?? 'Retry'),
          ),
        ),
        Center(
          child: TextButton.icon(
            key: const ValueKey('scheduled-recovery-copy'),
            onPressed: _savingRecovery ? null : _saveRecoveryCopy,
            icon: const Icon(Icons.save_outlined),
            label: Text(
              S.of(context)?.scheduledRecoveryCopy ?? 'Save recovery copy',
            ),
          ),
        ),
        Center(
          child: TextButton.icon(
            key: const ValueKey('scheduled-recovery-reset'),
            onPressed: _savingRecovery ? null : _resetCorruptQueue,
            icon: const Icon(Icons.restart_alt),
            label: Text(
              S.of(context)?.scheduledRecoveryReset ?? 'Reset damaged queue',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacing),
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.18),
        Icon(
          Icons.schedule_send_outlined,
          size: 56,
          color: context.textSecondary,
        ),
        const SizedBox(height: AppDimensions.spacing),
        Center(
          child: Text(
            S.of(context)?.scheduledMessagesEmpty ??
                'No scheduled messages yet',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.3,
              color: context.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.spacingS),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingXXL,
          ),
          child: Text(
            S.of(context)?.scheduledMessagesHint ?? 'Long press Send, Photos, Files, a GIF or a sticker to schedule a message.',
            textAlign: TextAlign.center,

            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              color: context.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDraftCard(ScheduledMessageDraft draft) {
    final accepted =
        draft.acceptedEventId != null ||
        (_ownerUserId != null &&
            ScheduledDraftOperation.acceptedReceipt(
                  ownerUserId: _ownerUserId!,
                  roomId: widget.roomId,
                  messageId: draft.messageId,
                ) !=
                null);
    final cardColor = context.surfaceColor;
    final secondaryColor = context.textSecondary;

    return Container(
      padding: const EdgeInsets.all(AppDimensions.spacing),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(_iconForDraft(draft), size: 18, color: AppColors.info),
              const SizedBox(width: AppDimensions.spacingS),
              Expanded(
                child: Text(
                  _formatScheduledAt(draft.scheduledAt),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              onPressed: accepted || _cancelling.contains(draft.messageId)
                  ? null
                  : () => _cancelDraft(draft),
              child: Text(S.of(context)?.commonCancel ?? 'Cancel'),
            ),
          ),
          const SizedBox(height: 10),
          _buildChip(label: _localizedType(draft)),
          if (accepted) ...[
            const SizedBox(height: 10),
            Text(S.of(context)?.chatMessageSent ?? 'Sent'),
          ],
          if (!accepted && draft.deliveryUnconfirmed) ...[
            const SizedBox(height: 10),
            Text(
              S.of(context)?.scheduledDeliveryUnconfirmed ??
                  'Delivery not confirmed',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
          if (!accepted && draft.retryAt != null) ...[
            const SizedBox(height: 6),
            Text(
              '${S.of(context)?.commonRetry ?? 'Retry'}: ${_formatScheduledAt(draft.retryAt!)}',
              style: TextStyle(color: secondaryColor),
            ),
          ],
          const SizedBox(height: 10),
          Text(
            draft.text,
            style: TextStyle(fontSize: 15, color: context.textPrimary),
          ),
          if (draft.pollOptions.isNotEmpty ||
              draft.mentionsRoom ||
              draft.mentionedUserIds.isNotEmpty ||
              draft.selfDestructAfter != null) ...[
            const SizedBox(height: AppDimensions.spacingM),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (draft.pollOptions.isNotEmpty)
                  _buildChip(
                    label:
                        '${S.of(context)?.chatPollOptionsLabel ?? 'Poll Options'}: ${_formatCount(draft.pollOptions.length)}',
                  ),
                if (draft.mentionsRoom) _buildChip(label: '@all'),
                if (draft.mentionedUserIds.isNotEmpty)
                  _buildChip(
                    label:
                        '@${S.of(context)?.commonGroupMembers(draft.mentionedUserIds.length) ?? 'Members (${draft.mentionedUserIds.length})'}',
                  ),
                if (draft.selfDestructAfter != null)
                  _buildChip(
                    label:
                        '${S.of(context)?.chatSelfDestructTimer ?? 'Self-destruct'}: ${S.of(context)?.secondsRemaining(draft.selfDestructAfter!) ?? '${draft.selfDestructAfter}s'}',
                  ),
              ],
            ),
          ],
          const SizedBox(height: 10),
          Text(
            S
                    .of(context)
                    ?.scheduledMessageCreatedAt(
                      _formatScheduledAt(draft.createdAt),
                    ) ??
                'Created ${_formatScheduledAt(draft.createdAt)}',
            style: TextStyle(fontSize: 12, color: secondaryColor),
          ),
        ],
      ),
    );
  }

  IconData _iconForDraft(ScheduledMessageDraft draft) {
    if (draft.isGif) {
      return Icons.gif_box_outlined;
    }

    switch (draft.type) {
      case MessageType.poll:
        return Icons.poll_outlined;
      case MessageType.sticker:
        return Icons.emoji_emotions_outlined;
      default:
        return Icons.schedule;
    }
  }

  Widget _buildChip({required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 12, color: context.textPrimary),
      ),
    );
  }

  String _localizedType(ScheduledMessageDraft draft) {
    final l10n = S.of(context);
    if (l10n == null) return draft.typeLabel;
    if (draft.isGif) return 'GIF';
    return switch (draft.type) {
      MessageType.image => l10n.contactPhotos,
      MessageType.video => l10n.video,
      MessageType.file => l10n.commonFileLabel,
      MessageType.poll => l10n.commonPoll,
      MessageType.sticker => l10n.profileStickers,
      _ => l10n.searchMessageLabel,
    };
  }

  String _formatCount(int value) =>
      NumberFormat.decimalPattern(Localizations.localeOf(context).toString())
          .format(value);

  String _formatScheduledAt(DateTime value) {
    final local = value.toLocal();
    final material = MaterialLocalizations.of(context);
    final date = material.formatFullDate(local);
    final time = material.formatTimeOfDay(
      TimeOfDay.fromDateTime(local),
      alwaysUse24HourFormat: MediaQuery.alwaysUse24HourFormatOf(context),
    );
    return '$date $time';
  }
}
