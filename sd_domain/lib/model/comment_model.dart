import 'package:flutter/foundation.dart';
import 'package:sd_base/sd_base.dart';

@immutable
class CommentModel {
  final String id;
  final String authorId;
  final String postId;
  final String message;
  final DateTime createdAt;

  CommentModel.fromJson({
    @required String id,
    Map<String, dynamic> data,
  })  : this.id = id,
        authorId = data[FirestoreKeys.authorIdFieldKey] ?? '',
        postId = data[FirestoreKeys.postIdFieldKey] ?? '',
        message = data[FirestoreKeys.messageFieldKey] ?? '',
        createdAt = data[FirestoreKeys.createdAtFieldKey];

  CommentModel.empty()
      : id = '',
        authorId = '',
        postId = '',
        message = '',
        createdAt = null;

  @override
  String toString() {
    return 'CommentModel('
        'id: $id, '
        'authorId: $authorId, '
        'postId: $postId'
        'message: $message'
        'createdAt: $createdAt'
        ')';
  }
}
