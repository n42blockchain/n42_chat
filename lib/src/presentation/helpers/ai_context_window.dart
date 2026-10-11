/// A short-lived authorization window. Monotonic time prevents clock changes
/// from extending consent. It starts before the message selection dialog.
class AiContextWindow {
  AiContextWindow({Duration Function()? elapsed})
    : _elapsed = elapsed ?? (Stopwatch()..start()).elapsedDuration;

  final Duration Function() _elapsed;
  bool _revoked = false;

  void revoke() => _revoked = true;

  bool get isValid => !_revoked && _elapsed() < const Duration(minutes: 2);
}

extension on Stopwatch {
  Duration elapsedDuration() => elapsed;
}
