// Run only in the isolated vodozemac 0.5.0 / FRB 2.11.1 harness.
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:vodozemac/vodozemac.dart' as vod;

Future<void> main(List<String> args) async {
  await vod.init(libraryPath: args[0]);
  const userId = '@fixture:example.org';
  // Exact Matrix 6 persisted-pickle key derivation: code units padded to 32.
  final key = Uint8List.fromList([
    ...userId.codeUnits,
    ...List.filled(32 - userId.length, 0),
  ]);
  final account = vod.Account()..generateOneTimeKeys(3);
  final outbound = vod.GroupSession();
  final inbound = outbound.toInbound();
  const body = 'Historical Vodozemac 0.5 Megolm message';
  final ciphertext = outbound.encrypt(body);
  final result = {
    'producer':
        'flutter_vodozemac 0.6.0 / vodozemac 0.5.0 / flutter_rust_bridge 2.11.1',
    'user_id': userId,
    'public_pickle_key_base64': base64Encode(key),
    'account_pickle': account.toPickleEncrypted(key),
    'account_ed25519': account.ed25519Key.toBase64(),
    'account_curve25519': account.curve25519Key.toBase64(),
    'signature': account.sign(body).toBase64(),
    'outbound_pickle': outbound.toPickleEncrypted(key),
    'inbound_pickle': inbound.toPickleEncrypted(key),
    'session_id': outbound.sessionId,
    'ciphertext': ciphertext,
    'plaintext': body,
  };
  await File(
    args[1],
  ).writeAsString('${const JsonEncoder.withIndent('  ').convert(result)}\n');
  stdout.writeln(
    'Generated genuine legacy account and Megolm pickles through native FRB 2.11.1',
  );
}
