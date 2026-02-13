import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../core/services/ai_service.dart';
import '../../../domain/entities/ai_assistant_entity.dart';
import '../../../domain/repositories/ai_repository.dart';
import 'ai_assistant_event.dart';
import 'ai_assistant_state.dart';

/// AI 助手 BLoC
class AiAssistantBloc extends Bloc<AiAssistantEvent, AiAssistantState> {
  final IAiRepository _aiRepository;
  final Uuid _uuid = const Uuid();

  StreamSubscription<String>? _streamSubscription;

  AiAssistantBloc({
    required IAiRepository aiRepository,
  })  : _aiRepository = aiRepository,
        super(AiAssistantState.initial()) {
    on<InitializeAiAssistant>(_onInitialize);
    on<SendAiMessage>(_onSendMessage);
    on<AiStreamChunkReceived>(_onStreamChunk);
    on<AiStreamCompleted>(_onStreamCompleted);
    on<AiStreamError>(_onStreamError);
    on<ClearAiChatHistory>(_onClearHistory);
    on<SwitchAiAssistant>(_onSwitchAssistant);
    on<StopAiGeneration>(_onStopGeneration);
    on<SummarizeMessages>(_onSummarize);
    on<RewriteMessage>(_onRewrite);
    on<SummarizeLink>(_onSummarizeLink);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }

  Future<void> _onInitialize(
    InitializeAiAssistant event,
    Emitter<AiAssistantState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      final assistant = event.assistantId != null
          ? (await _aiRepository.getAssistants())
              .firstWhere(
                (a) => a.id == event.assistantId,
                orElse: () => AiAssistantEntity.defaultAssistant,
              )
          : await _aiRepository.getDefaultAssistant();

      final history = await _aiRepository.getChatHistory(assistant.id);

      emit(state.copyWith(
        assistant: assistant,
        messages: history,
        isLoading: false,
        isAvailable: _aiRepository.isAvailable,
      ));
    } catch (e) {
      debugPrint('AiAssistantBloc: Initialize failed: $e');
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to initialize AI assistant',
        isAvailable: _aiRepository.isAvailable,
      ));
    }
  }

  Future<void> _onSendMessage(
    SendAiMessage event,
    Emitter<AiAssistantState> emit,
  ) async {
    if (state.isGenerating || !_aiRepository.isAvailable) return;

    final assistant = state.assistant ?? AiAssistantEntity.defaultAssistant;

    // 创建用户消息
    final userMessage = AiChatMessage(
      id: _uuid.v4(),
      role: 'user',
      content: event.text,
      timestamp: DateTime.now(),
    );

    final updatedMessages = [...state.messages, userMessage];
    emit(state.copyWith(
      messages: updatedMessages,
      isGenerating: true,
      streamingText: '',
      clearError: true,
    ));

    // 保存用户消息
    await _aiRepository.saveChatMessage(assistant.id, userMessage);

    // 构建 AI 消息列表（保留上下文窗口内的消息）
    final contextMessages = _buildContextMessages(updatedMessages, assistant);

    // 启动流式响应
    try {
      unawaited(_streamSubscription?.cancel());
      final stream = _aiRepository.aiService.streamCompletion(
        contextMessages,
        systemPrompt: assistant.systemPrompt,
        model: assistant.model,
        temperature: assistant.temperature,
        maxTokens: assistant.maxTokens,
      );

      _streamSubscription = stream.listen(
        (chunk) {
          if (!isClosed) add(AiStreamChunkReceived(chunk));
        },
        onDone: () {
          if (!isClosed) add(const AiStreamCompleted());
        },
        onError: (Object error) {
          if (!isClosed) add(AiStreamError(error.toString()));
        },
      );
    } catch (e) {
      debugPrint('AiAssistantBloc: Stream error: $e');
      emit(state.copyWith(
        isGenerating: false,
        error: e.toString(),
      ));
    }
  }

  void _onStreamChunk(
    AiStreamChunkReceived event,
    Emitter<AiAssistantState> emit,
  ) {
    emit(state.copyWith(
      streamingText: state.streamingText + event.chunk,
    ));
  }

  Future<void> _onStreamCompleted(
    AiStreamCompleted event,
    Emitter<AiAssistantState> emit,
  ) async {
    final assistant = state.assistant ?? AiAssistantEntity.defaultAssistant;
    final responseText = state.streamingText;

    if (responseText.isEmpty) {
      emit(state.copyWith(isGenerating: false, streamingText: ''));
      return;
    }

    // 创建 AI 响应消息
    final aiMessage = AiChatMessage(
      id: _uuid.v4(),
      role: 'assistant',
      content: responseText,
      timestamp: DateTime.now(),
    );

    final updatedMessages = [...state.messages, aiMessage];

    emit(state.copyWith(
      messages: updatedMessages,
      isGenerating: false,
      streamingText: '',
    ));

    // 保存 AI 响应
    await _aiRepository.saveChatMessage(assistant.id, aiMessage);
  }

  void _onStreamError(
    AiStreamError event,
    Emitter<AiAssistantState> emit,
  ) {
    emit(state.copyWith(
      isGenerating: false,
      streamingText: '',
      error: event.error,
    ));
  }

  Future<void> _onClearHistory(
    ClearAiChatHistory event,
    Emitter<AiAssistantState> emit,
  ) async {
    final assistant = state.assistant ?? AiAssistantEntity.defaultAssistant;
    await _aiRepository.clearChatHistory(assistant.id);
    emit(state.copyWith(messages: [], clearError: true));
  }

  Future<void> _onSwitchAssistant(
    SwitchAiAssistant event,
    Emitter<AiAssistantState> emit,
  ) async {
    final history = await _aiRepository.getChatHistory(event.assistant.id);
    emit(state.copyWith(
      assistant: event.assistant,
      messages: history,
      clearError: true,
    ));
  }

  Future<void> _onStopGeneration(
    StopAiGeneration event,
    Emitter<AiAssistantState> emit,
  ) async {
    unawaited(_streamSubscription?.cancel());
    _streamSubscription = null;

    // 如果有部分文本，直接在此处保存为消息（避免事件重入）
    final partialText = state.streamingText;
    if (partialText.isNotEmpty) {
      final assistant = state.assistant ?? AiAssistantEntity.defaultAssistant;
      final aiMessage = AiChatMessage(
        id: _uuid.v4(),
        role: 'assistant',
        content: partialText,
        timestamp: DateTime.now(),
      );
      final updatedMessages = [...state.messages, aiMessage];
      emit(state.copyWith(
        messages: updatedMessages,
        isGenerating: false,
        streamingText: '',
      ));
      await _aiRepository.saveChatMessage(assistant.id, aiMessage);
    } else {
      emit(state.copyWith(isGenerating: false));
    }
  }

  /// 群聊消息摘要
  Future<void> _onSummarize(
    SummarizeMessages event,
    Emitter<AiAssistantState> emit,
  ) async {
    if (!_aiRepository.isAvailable) {
      emit(state.copyWith(error: 'AI service not available'));
      return;
    }

    emit(state.copyWith(isSummarizing: true, clearSummary: true, clearError: true));

    try {
      final combinedText = event.messageTexts.join('\n');
      final summary = await _aiRepository.aiService.summarize(
        combinedText,
        language: event.language,
      );
      emit(state.copyWith(
        summaryResult: summary,
        isSummarizing: false,
      ));
    } catch (e) {
      debugPrint('AiAssistantBloc: Summarize failed: $e');
      emit(state.copyWith(
        isSummarizing: false,
        error: 'Failed to summarize: $e',
      ));
    }
  }

  /// 消息改写
  Future<void> _onRewrite(
    RewriteMessage event,
    Emitter<AiAssistantState> emit,
  ) async {
    if (!_aiRepository.isAvailable) {
      emit(state.copyWith(error: 'AI service not available'));
      return;
    }

    emit(state.copyWith(isRewriting: true, clearRewrite: true, clearError: true));

    try {
      final rewritten = await _aiRepository.aiService.rewriteMessage(
        event.text,
        event.tone,
      );
      emit(state.copyWith(
        rewriteResult: rewritten,
        isRewriting: false,
      ));
    } catch (e) {
      debugPrint('AiAssistantBloc: Rewrite failed: $e');
      emit(state.copyWith(
        isRewriting: false,
        error: 'Failed to rewrite: $e',
      ));
    }
  }

  /// 链接摘要
  Future<void> _onSummarizeLink(
    SummarizeLink event,
    Emitter<AiAssistantState> emit,
  ) async {
    if (!_aiRepository.isAvailable) {
      emit(state.copyWith(error: 'AI service not available'));
      return;
    }

    emit(state.copyWith(isSummarizingLink: true, clearLinkSummary: true, clearError: true));

    try {
      final summary = await _aiRepository.aiService.summarizeUrl(
        event.url,
        event.pageContent,
      );
      emit(state.copyWith(
        linkSummaryResult: summary,
        isSummarizingLink: false,
      ));
    } catch (e) {
      debugPrint('AiAssistantBloc: Link summarize failed: $e');
      emit(state.copyWith(
        isSummarizingLink: false,
        error: 'Failed to summarize link: $e',
      ));
    }
  }

  /// 构建上下文消息（保留窗口内的最近 N 轮对话）
  List<AiMessage> _buildContextMessages(
    List<AiChatMessage> messages,
    AiAssistantEntity assistant,
  ) {
    final contextSize = assistant.contextWindow;
    final recentMessages = messages.length > contextSize
        ? messages.sublist(messages.length - contextSize)
        : messages;

    return recentMessages.map((m) {
      return AiMessage(
        role: m.isUser ? AiRole.user : AiRole.assistant,
        content: m.content,
      );
    }).toList();
  }
}
