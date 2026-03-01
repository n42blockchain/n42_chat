import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../integration/wallet_bridge.dart';

/// Snapshot Hub datasource for submitting signed votes and proposals.
///
/// Uses EIP-712 typed data signatures for gasless operations.
/// All write operations require a connected wallet via [IWalletBridge].
class SnapshotHubDatasource {
  final String _hubEndpoint;
  final http.Client _httpClient;
  final IWalletBridge _walletBridge;

  SnapshotHubDatasource({
    required IWalletBridge walletBridge,
    String? hubEndpoint,
    http.Client? httpClient,
  })  : _walletBridge = walletBridge,
        _hubEndpoint = hubEndpoint ?? 'https://hub.snapshot.org',
        _httpClient = httpClient ?? http.Client();

  /// Submit a vote via EIP-712 signature (gasless)
  Future<void> submitVote({
    required String spaceId,
    required String proposalId,
    required int choice,
    String? reason,
  }) async {
    final address = _walletBridge.walletAddress;
    if (address == null) throw Exception('Wallet not connected');

    final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final message = {
      'space': spaceId,
      'proposal': proposalId,
      'choice': choice,
      'reason': reason ?? '',
      'app': 'n42-chat',
      'metadata': '{}',
      'from': address,
      'timestamp': timestamp,
    };

    final typedData = _buildVoteTypedData(message);
    final signature = await _signMessage(jsonEncode(typedData));

    final response = await _httpClient
        .post(
          Uri.parse('$_hubEndpoint/api/msg'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'address': address,
            'msg': jsonEncode(message),
            'sig': signature,
          }),
        )
        .timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception(
        'Vote submission failed: ${body['error'] ?? response.statusCode}',
      );
    }

    debugPrint('Vote submitted successfully for proposal $proposalId');
  }

  /// Create a proposal via EIP-712 signature
  Future<String> createProposal({
    required String spaceId,
    required String title,
    required String body,
    required List<String> choices,
    required int start,
    required int end,
    int? snapshot,
  }) async {
    final address = _walletBridge.walletAddress;
    if (address == null) throw Exception('Wallet not connected');

    final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final message = {
      'space': spaceId,
      'type': 'single-choice',
      'title': title,
      'body': body,
      'choices': choices,
      'start': start,
      'end': end,
      'snapshot': snapshot ?? 0,
      'metadata': '{}',
      'from': address,
      'timestamp': timestamp,
    };

    final signature = await _signMessage(jsonEncode(message));

    final response = await _httpClient
        .post(
          Uri.parse('$_hubEndpoint/api/msg'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'address': address,
            'msg': jsonEncode(message),
            'sig': signature,
          }),
        )
        .timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception(
        'Proposal creation failed: '
        '${responseBody['error'] ?? response.statusCode}',
      );
    }

    final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
    final proposalId = responseBody['id'] as String? ?? '';
    debugPrint('Proposal created: $proposalId');
    return proposalId;
  }

  /// Build EIP-712 typed data structure for a vote message
  Map<String, dynamic> _buildVoteTypedData(Map<String, dynamic> message) {
    return {
      'types': {
        'EIP712Domain': [
          {'name': 'name', 'type': 'string'},
          {'name': 'version', 'type': 'string'},
        ],
        'Vote': [
          {'name': 'from', 'type': 'address'},
          {'name': 'space', 'type': 'string'},
          {'name': 'timestamp', 'type': 'uint64'},
          {'name': 'proposal', 'type': 'bytes32'},
          {'name': 'choice', 'type': 'uint32'},
          {'name': 'reason', 'type': 'string'},
          {'name': 'app', 'type': 'string'},
          {'name': 'metadata', 'type': 'string'},
        ],
      },
      'domain': {
        'name': 'snapshot',
        'version': '0.1.4',
      },
      'primaryType': 'Vote',
      'message': message,
    };
  }

  /// Sign a message via the wallet bridge.
  ///
  /// Currently a placeholder that throws [UnimplementedError].
  /// Proper implementation requires adding a `signTypedData` method
  /// to [IWalletBridge] for EIP-712 typed data signing.
  Future<String> _signMessage(String message) async {
    if (!_walletBridge.isWalletConnected) {
      throw StateError('Wallet not connected for signing');
    }
    // TODO: Implement proper EIP-712 signTypedData via IWalletBridge
    // Currently requires IWalletBridge to add a signTypedData method.
    // This is a placeholder that will be replaced when wallet bridge
    // supports typed data signing.
    throw UnimplementedError(
      'EIP-712 signTypedData not yet available in IWalletBridge. '
      'Add signTypedData method to IWalletBridge to enable Snapshot voting.',
    );
  }

  /// Release resources
  void dispose() {
    _httpClient.close();
  }
}
