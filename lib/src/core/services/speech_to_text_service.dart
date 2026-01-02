import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// 语音转文字服务
/// 
/// 支持多种后端：
/// 1. Google Cloud Speech-to-Text API
/// 2. Microsoft Azure Speech Service
/// 3. 本地 Whisper 模型（需要服务端支持）
/// 
/// 注意：需要在使用前配置 API Key
class SpeechToTextService {
  static final SpeechToTextService _instance = SpeechToTextService._internal();
  factory SpeechToTextService() => _instance;
  SpeechToTextService._internal();

  final Dio _dio = Dio();
  
  // API 配置
  String? _googleApiKey;
  String? _azureApiKey;
  String? _azureRegion;
  String? _whisperServerUrl;
  
  /// 当前使用的服务类型
  SpeechProvider _currentProvider = SpeechProvider.none;

  /// 配置 Google Cloud Speech API
  void configureGoogle(String apiKey) {
    _googleApiKey = apiKey;
    _currentProvider = SpeechProvider.google;
  }

  /// 配置 Azure Speech Service
  void configureAzure(String apiKey, String region) {
    _azureApiKey = apiKey;
    _azureRegion = region;
    _currentProvider = SpeechProvider.azure;
  }

  /// 配置本地 Whisper 服务器
  void configureWhisper(String serverUrl) {
    _whisperServerUrl = serverUrl;
    _currentProvider = SpeechProvider.whisper;
  }

  /// 语音转文字
  /// 
  /// [audioPath] - 本地音频文件路径
  /// [language] - 语言代码，如 'zh-CN', 'en-US'
  /// 
  /// 返回识别的文本，失败返回 null
  Future<String?> transcribe(String audioPath, {String language = 'zh-CN'}) async {
    try {
      switch (_currentProvider) {
        case SpeechProvider.google:
          return await _transcribeWithGoogle(audioPath, language);
        case SpeechProvider.azure:
          return await _transcribeWithAzure(audioPath, language);
        case SpeechProvider.whisper:
          return await _transcribeWithWhisper(audioPath, language);
        case SpeechProvider.none:
          debugPrint('Speech-to-Text: No provider configured');
          return null;
      }
    } catch (e) {
      debugPrint('Speech-to-Text error: $e');
      return null;
    }
  }

  /// 使用 Google Cloud Speech-to-Text API
  Future<String?> _transcribeWithGoogle(String audioPath, String language) async {
    if (_googleApiKey == null) {
      throw Exception('Google API key not configured');
    }

    final file = File(audioPath);
    if (!await file.exists()) {
      throw Exception('Audio file not found: $audioPath');
    }

    final bytes = await file.readAsBytes();
    final base64Audio = base64Encode(bytes);

    final response = await _dio.post(
      'https://speech.googleapis.com/v1/speech:recognize?key=$_googleApiKey',
      data: {
        'config': {
          'encoding': 'MP3', // 或 'LINEAR16', 'FLAC' 等
          'sampleRateHertz': 44100,
          'languageCode': language,
          'model': 'default',
          'enableAutomaticPunctuation': true,
        },
        'audio': {
          'content': base64Audio,
        },
      },
    );

    if (response.statusCode == 200) {
      final results = response.data['results'] as List?;
      if (results != null && results.isNotEmpty) {
        final alternatives = results[0]['alternatives'] as List?;
        if (alternatives != null && alternatives.isNotEmpty) {
          return alternatives[0]['transcript'] as String?;
        }
      }
    }

    return null;
  }

  /// 使用 Microsoft Azure Speech Service
  Future<String?> _transcribeWithAzure(String audioPath, String language) async {
    if (_azureApiKey == null || _azureRegion == null) {
      throw Exception('Azure credentials not configured');
    }

    final file = File(audioPath);
    if (!await file.exists()) {
      throw Exception('Audio file not found: $audioPath');
    }

    final bytes = await file.readAsBytes();

    final response = await _dio.post(
      'https://$_azureRegion.stt.speech.microsoft.com/speech/recognition/conversation/cognitiveservices/v1?language=$language',
      data: bytes,
      options: Options(
        headers: {
          'Ocp-Apim-Subscription-Key': _azureApiKey,
          'Content-Type': 'audio/wav', // 或 audio/mpeg
        },
      ),
    );

    if (response.statusCode == 200) {
      return response.data['DisplayText'] as String?;
    }

    return null;
  }

  /// 使用本地 Whisper 服务器
  /// 
  /// Whisper 是 OpenAI 开源的语音识别模型
  /// 可以使用 whisper.cpp 或 faster-whisper 部署本地服务
  Future<String?> _transcribeWithWhisper(String audioPath, String language) async {
    if (_whisperServerUrl == null) {
      throw Exception('Whisper server URL not configured');
    }

    final file = File(audioPath);
    if (!await file.exists()) {
      throw Exception('Audio file not found: $audioPath');
    }

    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(audioPath),
      'language': language.split('-').first, // whisper 使用 'zh', 'en' 等
    });

    final response = await _dio.post(
      '$_whisperServerUrl/transcribe',
      data: formData,
    );

    if (response.statusCode == 200) {
      return response.data['text'] as String?;
    }

    return null;
  }

  /// 检查是否已配置
  bool get isConfigured => _currentProvider != SpeechProvider.none;

  /// 当前使用的服务提供商
  SpeechProvider get currentProvider => _currentProvider;
}

/// 语音识别服务提供商
enum SpeechProvider {
  none,
  google,
  azure,
  whisper,
}

/// 语音识别配置
/// 
/// 使用示例：
/// ```dart
/// // 配置 Google API
/// SpeechToTextService().configureGoogle('your-api-key');
/// 
/// // 配置 Azure
/// SpeechToTextService().configureAzure('your-api-key', 'eastus');
/// 
/// // 配置本地 Whisper 服务器
/// SpeechToTextService().configureWhisper('http://localhost:8000');
/// 
/// // 转文字
/// final text = await SpeechToTextService().transcribe('/path/to/audio.mp3');
/// ```

