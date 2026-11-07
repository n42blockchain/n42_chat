import 'package:flutter_test/flutter_test.dart';

import 'live_media_smoke.dart' as smoke;

/// Explicit live-QA entrypoint; not part of the default test/ suite.
/// Credentials are validated by runLiveMediaSmoke before SDK/network setup.
void main() {
  test(
    'explicit live homeserver media upload and download',
    () => smoke.runLiveMediaSmoke(),
    timeout: const Timeout(Duration(minutes: 15)),
  );
}
