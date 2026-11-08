import 'package:equatable/equatable.dart';

import 'message_entity.dart';

/// A saved message and its account-local annotations from one storage snapshot.
class SavedMessageFavorite extends Equatable {
  final MessageEntity message;
  final List<String> tags;
  final String remark;

  SavedMessageFavorite({
    required this.message,
    List<String> tags = const [],
    this.remark = '',
  }) : tags = List.unmodifiable(tags);

  @override
  List<Object?> get props => [message, tags, remark];
}
