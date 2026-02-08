import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../core/services/ai_service.dart';
import '../../domain/entities/ai_assistant_entity.dart';
import '../../domain/repositories/ai_repository.dart';
import '../datasources/local/secure_storage_datasource.dart';

/// AI 仓库实现
class AiRepositoryImpl implements IAiRepository {
  static const String _keyAssistants = 'n42_chat_ai_assistants';
  static const String _keyChatHistoryPrefix = 'n42_chat_ai_history_';

  final AiService _aiService;
  final SecureStorageDataSource _storage;

  AiRepositoryImpl({
    required AiService aiService,
    required SecureStorageDataSource storage,
  })  : _aiService = aiService,
        _storage = storage;

  @override
  AiService get aiService => _aiService;

  @override
  bool get isAvailable => _aiService.isAvailable;

  @override
  Future<List<AiAssistantEntity>> getAssistants() async {
    try {
      final data = await _storage.read(_keyAssistants);
      if (data == null) {
        return [AiAssistantEntity.defaultAssistant];
      }
      final list = jsonDecode(data) as List<dynamic>;
      final assistants = list
          .map((e) => AiAssistantEntity.fromJson(e as Map<String, dynamic>))
          .toList();
      // 确保默认助手总是存在
      if (!assistants.any((a) => a.id == 'default')) {
        assistants.insert(0, AiAssistantEntity.defaultAssistant);
      }
      return assistants;
    } catch (e) {
      debugPrint('AiRepository: Failed to load assistants: $e');
      return [AiAssistantEntity.defaultAssistant];
    }
  }

  @override
  Future<AiAssistantEntity> getDefaultAssistant() async {
    final assistants = await getAssistants();
    return assistants.firstWhere(
      (a) => a.id == 'default',
      orElse: () => AiAssistantEntity.defaultAssistant,
    );
  }

  @override
  Future<void> saveAssistant(AiAssistantEntity assistant) async {
    try {
      final assistants = await getAssistants();
      final index = assistants.indexWhere((a) => a.id == assistant.id);
      if (index >= 0) {
        assistants[index] = assistant;
      } else {
        assistants.add(assistant);
      }
      final data = jsonEncode(assistants.map((a) => a.toJson()).toList());
      await _storage.write(_keyAssistants, data);
    } catch (e) {
      debugPrint('AiRepository: Failed to save assistant: $e');
    }
  }

  @override
  Future<void> deleteAssistant(String assistantId) async {
    if (assistantId == 'default') return; // 不允许删除默认助手
    try {
      final assistants = await getAssistants();
      assistants.removeWhere((a) => a.id == assistantId);
      final data = jsonEncode(assistants.map((a) => a.toJson()).toList());
      await _storage.write(_keyAssistants, data);
      // 同时清除该助手的历史
      await clearChatHistory(assistantId);
    } catch (e) {
      debugPrint('AiRepository: Failed to delete assistant: $e');
    }
  }

  @override
  Future<List<AiChatMessage>> getChatHistory(String assistantId) async {
    try {
      final data = await _storage.read('$_keyChatHistoryPrefix$assistantId');
      if (data == null) return [];
      final list = jsonDecode(data) as List<dynamic>;
      return list
          .map((e) => AiChatMessage.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('AiRepository: Failed to load chat history: $e');
      return [];
    }
  }

  @override
  Future<void> saveChatMessage(String assistantId, AiChatMessage message) async {
    try {
      final history = await getChatHistory(assistantId);
      history.add(message);

      // 保持最近 100 条消息
      final trimmed = history.length > 100
          ? history.sublist(history.length - 100)
          : history;

      final data = jsonEncode(trimmed.map((m) => m.toJson()).toList());
      await _storage.write('$_keyChatHistoryPrefix$assistantId', data);
    } catch (e) {
      debugPrint('AiRepository: Failed to save chat message: $e');
    }
  }

  @override
  Future<void> clearChatHistory(String assistantId) async {
    try {
      await _storage.delete('$_keyChatHistoryPrefix$assistantId');
    } catch (e) {
      debugPrint('AiRepository: Failed to clear chat history: $e');
    }
  }
}
