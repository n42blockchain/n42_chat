/// The room write succeeded, but its private recovery receipt was not saved.
/// Keep the confirmed link available; never retry the publication automatically.
class StickerPublicationReceiptFailure implements Exception {
  final String shareUrl;
  const StickerPublicationReceiptFailure(this.shareUrl);
  @override
  String toString() => 'Sticker publication receipt could not be saved';
}
