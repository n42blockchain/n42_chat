/// An account-scoped saved queue. Damaged copies remain visible but are never
/// treated as verified recovery input. The original stored value is untouched.
class ScheduledRecoveryCopy {
  final String id;
  final String? raw;
  final bool isIntact;

  const ScheduledRecoveryCopy({
    required this.id,
    required this.raw,
    required this.isIntact,
  });
}
