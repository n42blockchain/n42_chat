import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../../core/services/ai_service.dart';
import '../../core/utils/debug_log.dart';

/// AI API 数据源实现
///
/// 使用 OpenAI 兼容 API（支持 OpenAI, Claude via proxy, DeepSeek 等）
/// 支持 SSE 流式响应
class AiDatasource implements AiService {
  final Dio _dio;
  final String _baseUrl;
  final String _apiKey;
  final String _defaultModel;
  final bool _useProxyEndpoint;

  AiDatasource({
    required String baseUrl,
    required String apiKey,
    String defaultModel = 'gpt-4o-mini',
    bool useProxyEndpoint = false,
    Dio? dio,
  })  : _baseUrl = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl,
        _apiKey = apiKey,
        _defaultModel = defaultModel,
        _useProxyEndpoint = useProxyEndpoint,
        _dio = dio ?? Dio() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.headers = {
      'Content-Type': 'application/json',
      if (_apiKey.isNotEmpty) 'Authorization': 'Bearer $_apiKey',
    };
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(minutes: 3);
  }

  @override
  bool get isAvailable =>
      _baseUrl.isNotEmpty && (_apiKey.isNotEmpty || _useProxyEndpoint);

  String get _chatCompletionsUrl =>
      _useProxyEndpoint ? _baseUrl : '/v1/chat/completions';

  /// 消息总字符数上限（约 ~32k tokens）
  static const int _maxTotalCharacters = 128000;

  /// 校验消息总长度
  void _validateMessageLength(List<AiMessage> messages, String? systemPrompt) {
    var totalLength = systemPrompt?.length ?? 0;
    for (final m in messages) {
      totalLength += m.content.length;
    }
    if (totalLength > _maxTotalCharacters) {
      throw AiServiceException(
        'Total message length exceeds limit ($totalLength > $_maxTotalCharacters characters)',
      );
    }
  }

  @override
  Stream<String> streamCompletion(
    List<AiMessage> messages, {
    String? systemPrompt,
    String? model,
    double temperature = 0.7,
    int maxTokens = 2048,
  }) async* {
    _validateMessageLength(messages, systemPrompt);

    final allMessages = <Map<String, String>>[];
    if (systemPrompt != null) {
      allMessages.add({'role': 'system', 'content': systemPrompt});
    }
    allMessages.addAll(messages.map((m) => m.toJson()));

    try {
      final response = await _dio.post<ResponseBody>(
        _chatCompletionsUrl,
        data: {
          'model': model ?? _defaultModel,
          'messages': allMessages,
          'temperature': temperature,
          'max_tokens': maxTokens,
          'stream': true,
        },
        options: Options(responseType: ResponseType.stream),
      );

      if (response.data == null) {
        throw const AiServiceException('Empty response from server');
      }
      final stream = response.data!.stream;
      final buffer = StringBuffer();

      await for (final chunk in stream) {
        buffer.write(utf8.decode(chunk));

        // 处理 SSE 数据
        var bufferStr = buffer.toString();
        while (bufferStr.contains('\n')) {
          final newlineIndex = bufferStr.indexOf('\n');
          final line = bufferStr.substring(0, newlineIndex).trim();
          bufferStr = bufferStr.substring(newlineIndex + 1);
          buffer
            ..clear()
            ..write(bufferStr);

          if (line.isEmpty || line.startsWith(':')) continue;
          if (!line.startsWith('data: ')) continue;

          final data = line.substring(6).trim();
          if (data == '[DONE]') return;

          try {
            final json = jsonDecode(data) as Map<String, dynamic>;
            final choices = json['choices'] as List<dynamic>?;
            if (choices == null || choices.isEmpty) continue;

            final delta = choices[0]['delta'] as Map<String, dynamic>?;
            final content = delta?['content'] as String?;
            if (content != null) {
              yield content;
            }
          } catch (e) {
            // 跳过无法解析的行
            debugLog('AiDatasource: Failed to parse SSE data: $e');
          }
        }
      }
    } on DioException catch (e) {
      debugLog('AiDatasource: Stream completion error: ${e.message}');
      final errorMsg = _parseErrorMessage(e);
      throw AiServiceException(errorMsg);
    }
  }

  @override
  Future<AiCompletionResult> completion(
    List<AiMessage> messages, {
    String? systemPrompt,
    String? model,
    double temperature = 0.7,
    int maxTokens = 2048,
  }) async {
    _validateMessageLength(messages, systemPrompt);

    final allMessages = <Map<String, String>>[];
    if (systemPrompt != null) {
      allMessages.add({'role': 'system', 'content': systemPrompt});
    }
    allMessages.addAll(messages.map((m) => m.toJson()));

    try {
      final response = await _dio.post<Map<String, dynamic>>(
        _chatCompletionsUrl,
        data: {
          'model': model ?? _defaultModel,
          'messages': allMessages,
          'temperature': temperature,
          'max_tokens': maxTokens,
          'stream': false,
        },
      );

      final data = response.data;
      if (data == null) {
        throw const AiServiceException('Empty response from server');
      }
      final choices = data['choices'] as List<dynamic>?;
      if (choices == null || choices.isEmpty) {
        throw const AiServiceException('No choices in response');
      }
      final message = choices[0]['message'] as Map<String, dynamic>?;
      final content = message?['content'] as String? ?? '';
      final usage = data['usage'] as Map<String, dynamic>?;

      return AiCompletionResult(
        text: content,
        promptTokens: usage?['prompt_tokens'] as int? ?? 0,
        completionTokens: usage?['completion_tokens'] as int? ?? 0,
        model: data['model'] as String?,
      );
    } on DioException catch (e) {
      debugLog('AiDatasource: Completion error: ${e.message}');
      final errorMsg = _parseErrorMessage(e);
      throw AiServiceException(errorMsg);
    }
  }

  @override
  Future<String> summarize(
    String text, {
    String? language,
    int maxLength = 200,
  }) async {
    final lang = language ?? 'the same language as the input text';
    final result = await completion(
      [AiMessage(role: AiRole.user, content: text)],
      systemPrompt:
          'You are a concise summarizer. Summarize the following text in $lang. '
          'Keep the summary under $maxLength characters. '
          'Focus on key points and main ideas. Output only the summary, no extra text.',
      temperature: 0.3,
      maxTokens: 512,
    );
    return result.text.trim();
  }

  @override
  Future<String> rewriteMessage(String text, AiTone tone) async {
    final toneDesc = switch (tone) {
      AiTone.formal => 'formal and polite',
      AiTone.casual => 'casual and relaxed',
      AiTone.playful => 'playful and fun',
      AiTone.professional => 'professional and business-like',
    };

    final result = await completion(
      [AiMessage(role: AiRole.user, content: text)],
      systemPrompt:
          'Rewrite the following message in a $toneDesc tone. '
          'Keep the same meaning and language. '
          'Output only the rewritten message, no explanation.',
      temperature: 0.6,
      maxTokens: 512,
    );
    return result.text.trim();
  }

  @override
  Future<String> translateMessage(String text, String targetLanguage) async {
    final result = await completion(
      [AiMessage(role: AiRole.user, content: text)],
      systemPrompt:
          'Translate the following text to $targetLanguage. '
          'Output only the translation, no explanation or original text.',
      temperature: 0.3,
      maxTokens: 1024,
    );
    return result.text.trim();
  }

  @override
  Future<String> summarizeUrl(String url, String pageContent) async {
    // 截取前 4000 字符避免 token 超限（避免截断多字节字符）
    final truncated = pageContent.length > 4000
        ? String.fromCharCodes(pageContent.runes.take(4000))
        : pageContent;

    final result = await completion(
      [
        AiMessage(
          role: AiRole.user,
          content: 'URL: $url\n\nContent:\n$truncated',
        ),
      ],
      systemPrompt:
          'Summarize the content of this web page in 2-3 sentences. '
          'Focus on the main topic and key information. '
          'Use the same language as the page content. '
          'Output only the summary.',
      temperature: 0.3,
      maxTokens: 256,
    );
    return result.text.trim();
  }

  String _parseErrorMessage(DioException e) {
    if (e.response?.data != null) {
      try {
        final data = e.response!.data;
        if (data is Map<String, dynamic>) {
          final error = data['error'];
          if (error is Map<String, dynamic>) {
            return error['message'] as String? ?? 'API error';
          }
          if (error is String) return error;
        }
      } catch (e) {
        debugLog('Error: $e');
      }
    }

    return switch (e.type) {
      DioExceptionType.connectionTimeout => 'Connection timeout',
      DioExceptionType.receiveTimeout => 'Response timeout',
      DioExceptionType.connectionError => 'Connection failed',
      _ => e.message ?? 'Unknown error',
    };
  }

  @override
  void dispose() {
    _dio.close();
  }
}

/// AI 服务异常
class AiServiceException implements Exception {
  final String message;
  const AiServiceException(this.message);

  @override
  String toString() => 'AiServiceException: $message';
}
