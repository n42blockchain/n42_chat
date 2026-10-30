/// An opaque, account-bound capability. Never exposes credentials or SDK clients.
class AccountActionOrigin {
  final Object owner;
  final bool Function() _isCurrent;
  AccountActionOrigin(this.owner, this._isCurrent);
  bool get isCurrent => _isCurrent();
}
