import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/social/debank_portfolio_model.dart';

/// DeBank Open API datasource for querying user portfolios and token holdings.
///
/// See https://open-api.debank.com/docs for the full API reference.
class DeBankDatasource {
  static const _defaultBaseUrl = 'https://open-api.debank.com/v1';

  final String _baseUrl;
  final String? _apiKey;
  final http.Client _httpClient;

  DeBankDatasource({
    String? baseUrl,
    String? apiKey,
    http.Client? httpClient,
  })  : _baseUrl = baseUrl ?? _defaultBaseUrl,
        _apiKey = apiKey,
        _httpClient = httpClient ?? http.Client();

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        if (_apiKey != null) 'AccessKey': _apiKey,
      };

  /// Perform a GET request and decode the response as a JSON object.
  Future<Map<String, dynamic>> _get(
    String path, {
    Map<String, String>? params,
  }) async {
    final uri = Uri.parse('$_baseUrl$path').replace(queryParameters: params);
    final response = await _httpClient
        .get(uri, headers: _headers)
        .timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      throw Exception('DeBank API error: ${response.statusCode}');
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  /// Perform a GET request and decode the response as a JSON array.
  Future<List<dynamic>> _getList(
    String path, {
    Map<String, String>? params,
  }) async {
    final uri = Uri.parse('$_baseUrl$path').replace(queryParameters: params);
    final response = await _httpClient
        .get(uri, headers: _headers)
        .timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      throw Exception('DeBank API error: ${response.statusCode}');
    }
    return jsonDecode(response.body) as List<dynamic>;
  }

  /// Get user's total portfolio value across all chains.
  Future<DeBankPortfolioModel> getUserPortfolio(String address) async {
    final data = await _get('/user/total_balance', params: {'id': address});
    return DeBankPortfolioModel.fromJson(data);
  }

  /// Get user's token list on a specific chain.
  ///
  /// [chainId] is the DeBank chain identifier (e.g. "eth", "bsc", "matic").
  Future<List<Map<String, dynamic>>> getUserTokenList(
    String address,
    String chainId,
  ) async {
    final data = await _getList('/user/token_list', params: {
      'id': address,
      'chain_id': chainId,
      'is_all': 'false',
    });
    return data.cast<Map<String, dynamic>>();
  }

  /// Get all chains that [address] has interacted with.
  Future<List<String>> getUsedChains(String address) async {
    final data = await _getList(
      '/user/used_chain_list',
      params: {'id': address},
    );
    return data
        .map((chain) {
          if (chain is Map<String, dynamic>) {
            return chain['id'] as String? ?? '';
          }
          return chain.toString();
        })
        .where((id) => id.isNotEmpty)
        .toList();
  }

  /// Release underlying HTTP resources.
  void dispose() {
    _httpClient.close();
  }
}
