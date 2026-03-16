import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/services/ai_service.dart';
import 'package:n42_chat/src/data/datasources/ai_datasource.dart';

class MockDio extends Mock implements Dio {
  final BaseOptions _options = BaseOptions();

  @override
  BaseOptions get options => _options;

  @override
  set options(BaseOptions value) {}
}

void main() {
  setUpAll(() {
    registerFallbackValue(Options());
    registerFallbackValue(<String, dynamic>{});
  });

  group('AiDatasource', () {
    late MockDio mockDio;
    late AiDatasource datasource;

    setUp(() {
      mockDio = MockDio();
      datasource = AiDatasource(
        baseUrl: 'https://api.openai.com',
        apiKey: 'test-api-key',
        defaultModel: 'gpt-4o-mini',
        dio: mockDio,
      );
    });

    group('isAvailable', () {
      test('should return true when apiKey and baseUrl are non-empty', () {
        expect(datasource.isAvailable, isTrue);
      });

      test('should return false when apiKey is empty', () {
        final ds = AiDatasource(
          baseUrl: 'https://api.openai.com',
          apiKey: '',
          dio: mockDio,
        );
        expect(ds.isAvailable, isFalse);
      });

      test('should return false when baseUrl is empty', () {
        final ds = AiDatasource(
          baseUrl: '',
          apiKey: 'test-api-key',
          dio: mockDio,
        );
        expect(ds.isAvailable, isFalse);
      });

      test('should allow proxy endpoint mode without apiKey', () {
        final ds = AiDatasource(
          baseUrl: 'https://api.n42.ai/proxy/v1/ai/chat',
          apiKey: '',
          useProxyEndpoint: true,
          dio: mockDio,
        );

        expect(ds.isAvailable, isTrue);
      });
    });

    group('completion', () {
      test('should throw AiServiceException when response data is null',
          () async {
        when(() => mockDio.post<Map<String, dynamic>>(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            )).thenAnswer((_) async => Response<Map<String, dynamic>>(
              data: null,
              statusCode: 200,
              requestOptions: RequestOptions(path: '/v1/chat/completions'),
            ));

        expect(
          () => datasource.completion(
            [const AiMessage(role: AiRole.user, content: 'Hello')],
          ),
          throwsA(isA<AiServiceException>().having(
            (e) => e.message,
            'message',
            'Empty response from server',
          )),
        );
      });

      test('should throw AiServiceException when choices is empty', () async {
        when(() => mockDio.post<Map<String, dynamic>>(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            )).thenAnswer((_) async => Response<Map<String, dynamic>>(
              data: {
                'choices': <dynamic>[],
                'usage': {'prompt_tokens': 0, 'completion_tokens': 0},
              },
              statusCode: 200,
              requestOptions: RequestOptions(path: '/v1/chat/completions'),
            ));

        expect(
          () => datasource.completion(
            [const AiMessage(role: AiRole.user, content: 'Hello')],
          ),
          throwsA(isA<AiServiceException>().having(
            (e) => e.message,
            'message',
            'No choices in response',
          )),
        );
      });

      test('should return AiCompletionResult on success', () async {
        when(() => mockDio.post<Map<String, dynamic>>(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            )).thenAnswer((_) async => Response<Map<String, dynamic>>(
              data: {
                'choices': [
                  {
                    'message': {
                      'role': 'assistant',
                      'content': 'Hello! How can I help you?',
                    },
                  },
                ],
                'usage': {
                  'prompt_tokens': 10,
                  'completion_tokens': 8,
                },
                'model': 'gpt-4o-mini',
              },
              statusCode: 200,
              requestOptions: RequestOptions(path: '/v1/chat/completions'),
            ));

        final result = await datasource.completion(
          [const AiMessage(role: AiRole.user, content: 'Hello')],
        );

        expect(result.text, equals('Hello! How can I help you?'));
        expect(result.promptTokens, equals(10));
        expect(result.completionTokens, equals(8));
        expect(result.model, equals('gpt-4o-mini'));
      });

      test('should throw AiServiceException on DioException', () async {
        when(() => mockDio.post<Map<String, dynamic>>(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            )).thenThrow(DioException(
          type: DioExceptionType.connectionTimeout,
          requestOptions: RequestOptions(path: '/v1/chat/completions'),
          message: 'Connection timeout',
        ));

        expect(
          () => datasource.completion(
            [const AiMessage(role: AiRole.user, content: 'Hello')],
          ),
          throwsA(isA<AiServiceException>().having(
            (e) => e.message,
            'message',
            'Connection timeout',
          )),
        );
      });

      test('should throw AiServiceException when choices is null', () async {
        when(() => mockDio.post<Map<String, dynamic>>(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            )).thenAnswer((_) async => Response<Map<String, dynamic>>(
              data: {
                'usage': {'prompt_tokens': 0, 'completion_tokens': 0},
              },
              statusCode: 200,
              requestOptions: RequestOptions(path: '/v1/chat/completions'),
            ));

        expect(
          () => datasource.completion(
            [const AiMessage(role: AiRole.user, content: 'Hello')],
          ),
          throwsA(isA<AiServiceException>().having(
            (e) => e.message,
            'message',
            'No choices in response',
          )),
        );
      });
    });

    group('streamCompletion', () {
      test('should throw AiServiceException when messages exceed length limit',
          () {
        // Create a message that exceeds 128000 characters
        final longContent = 'A' * 130000;
        final messages = [
          AiMessage(role: AiRole.user, content: longContent),
        ];

        expect(
          () => datasource.streamCompletion(messages).toList(),
          throwsA(isA<AiServiceException>().having(
            (e) => e.message,
            'message',
            contains('exceeds limit'),
          )),
        );
      });

      test('should validate message length including systemPrompt', () {
        // systemPrompt (64000) + message (65000) = 129000 > 128000
        final systemPrompt = 'S' * 64000;
        final messages = [
          AiMessage(role: AiRole.user, content: 'U' * 65000),
        ];

        expect(
          () => datasource.streamCompletion(
            messages,
            systemPrompt: systemPrompt,
          ).toList(),
          throwsA(isA<AiServiceException>().having(
            (e) => e.message,
            'message',
            contains('exceeds limit'),
          )),
        );
      });
    });

    group('summarizeUrl', () {
      test('should handle content truncation for long page content', () async {
        // Setup: mock the Dio post call for the underlying completion
        final longContent = 'B' * 5000; // Exceeds 4000 char truncation limit

        when(() => mockDio.post<Map<String, dynamic>>(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            )).thenAnswer((invocation) async {
          // Verify the content was truncated in the request payload
          final data =
              invocation.namedArguments[#data] as Map<String, dynamic>;
          final messages = data['messages'] as List<dynamic>;
          // The last message (user message) should contain the truncated content
          final userMessage = messages.last as Map<String, String>;
          final content = userMessage['content']!;
          // URL prefix + truncated content should be less than original
          expect(content.length, lessThan(longContent.length + 50));

          return Response<Map<String, dynamic>>(
            data: {
              'choices': [
                {
                  'message': {
                    'role': 'assistant',
                    'content': 'This is a summary.',
                  },
                },
              ],
              'usage': {'prompt_tokens': 100, 'completion_tokens': 20},
              'model': 'gpt-4o-mini',
            },
            statusCode: 200,
            requestOptions: RequestOptions(path: '/v1/chat/completions'),
          );
        });

        final result = await datasource.summarizeUrl(
          'https://example.com',
          longContent,
        );

        expect(result, equals('This is a summary.'));
        verify(() => mockDio.post<Map<String, dynamic>>(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            )).called(1);
      });

      test('should not truncate short content', () async {
        const shortContent = 'Short page content';

        when(() => mockDio.post<Map<String, dynamic>>(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            )).thenAnswer((invocation) async {
          final data =
              invocation.namedArguments[#data] as Map<String, dynamic>;
          final messages = data['messages'] as List<dynamic>;
          final userMessage = messages.last as Map<String, String>;
          final content = userMessage['content']!;
          // Short content should be fully included
          expect(content, contains(shortContent));

          return Response<Map<String, dynamic>>(
            data: {
              'choices': [
                {
                  'message': {
                    'role': 'assistant',
                    'content': 'Brief summary.',
                  },
                },
              ],
              'usage': {'prompt_tokens': 50, 'completion_tokens': 10},
              'model': 'gpt-4o-mini',
            },
            statusCode: 200,
            requestOptions: RequestOptions(path: '/v1/chat/completions'),
          );
        });

        final result = await datasource.summarizeUrl(
          'https://example.com',
          shortContent,
        );

        expect(result, equals('Brief summary.'));
      });
    });

    group('dispose', () {
      test('should close Dio', () {
        when(() => mockDio.close(force: any(named: 'force')))
            .thenAnswer((_) {});

        datasource.dispose();

        verify(() => mockDio.close()).called(1);
      });
    });

    group('message length validation', () {
      test('should accept messages within length limit', () async {
        // Total length just under limit: should not throw
        final messages = [
          AiMessage(role: AiRole.user, content: 'A' * 127999),
        ];

        when(() => mockDio.post<Map<String, dynamic>>(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            )).thenAnswer((_) async => Response<Map<String, dynamic>>(
              data: {
                'choices': [
                  {
                    'message': {
                      'role': 'assistant',
                      'content': 'OK',
                    },
                  },
                ],
                'usage': {'prompt_tokens': 0, 'completion_tokens': 0},
                'model': 'gpt-4o-mini',
              },
              statusCode: 200,
              requestOptions: RequestOptions(path: '/v1/chat/completions'),
            ));

        final result = await datasource.completion(messages);
        expect(result.text, equals('OK'));
      });

      test('should throw when total of multiple messages exceeds limit',
          () async {
        final messages = [
          AiMessage(role: AiRole.user, content: 'A' * 65000),
          AiMessage(role: AiRole.assistant, content: 'B' * 65000),
        ];

        expect(
          () => datasource.completion(messages),
          throwsA(isA<AiServiceException>().having(
            (e) => e.message,
            'message',
            contains('exceeds limit'),
          )),
        );
      });
    });

    group('constructor', () {
      test('should strip trailing slash from baseUrl', () {
        final ds = AiDatasource(
          baseUrl: 'https://api.openai.com/',
          apiKey: 'key',
          dio: mockDio,
        );
        // The datasource should still be available (baseUrl becomes
        // 'https://api.openai.com' which is non-empty)
        expect(ds.isAvailable, isTrue);
      });

      test('should use default model gpt-4o-mini', () async {
        when(() => mockDio.post<Map<String, dynamic>>(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            )).thenAnswer((invocation) async {
          final data =
              invocation.namedArguments[#data] as Map<String, dynamic>;
          expect(data['model'], equals('gpt-4o-mini'));

          return Response<Map<String, dynamic>>(
            data: {
              'choices': [
                {
                  'message': {'role': 'assistant', 'content': 'test'},
                },
              ],
              'usage': {'prompt_tokens': 0, 'completion_tokens': 0},
              'model': 'gpt-4o-mini',
            },
            statusCode: 200,
            requestOptions: RequestOptions(path: '/v1/chat/completions'),
          );
        });

        await datasource.completion(
          [const AiMessage(role: AiRole.user, content: 'Hi')],
        );

        verify(() => mockDio.post<Map<String, dynamic>>(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            )).called(1);
      });

      test('should post directly to proxy endpoint in proxy mode', () async {
        final ds = AiDatasource(
          baseUrl: 'https://api.n42.ai/proxy/v1/ai/chat',
          apiKey: '',
          useProxyEndpoint: true,
          dio: mockDio,
        );

        when(() => mockDio.post<Map<String, dynamic>>(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            )).thenAnswer((_) async => Response<Map<String, dynamic>>(
              data: {
                'choices': [
                  {
                    'message': {'role': 'assistant', 'content': 'proxy-ok'},
                  },
                ],
                'usage': {'prompt_tokens': 0, 'completion_tokens': 0},
                'model': 'proxy-model',
              },
              statusCode: 200,
              requestOptions: RequestOptions(path: 'https://api.n42.ai/proxy/v1/ai/chat'),
            ));

        final result = await ds.completion(
          [const AiMessage(role: AiRole.user, content: 'Hi')],
        );

        expect(result.text, 'proxy-ok');
        verify(() => mockDio.post<Map<String, dynamic>>(
              'https://api.n42.ai/proxy/v1/ai/chat',
              data: any(named: 'data'),
              options: any(named: 'options'),
            )).called(1);
      });
    });
  });

  group('AiServiceException', () {
    test('should store message', () {
      const exception = AiServiceException('Something went wrong');
      expect(exception.message, equals('Something went wrong'));
    });

    test('toString should include class name and message', () {
      const exception = AiServiceException('API rate limited');
      expect(
        exception.toString(),
        equals('AiServiceException: API rate limited'),
      );
    });

    test('should implement Exception', () {
      const exception = AiServiceException('error');
      expect(exception, isA<Exception>());
    });
  });
}
