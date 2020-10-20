import 'package:flutter/foundation.dart';
import 'package:sd_base/sd_base.dart';

@immutable
class LikeModel {
  final String id;
  final String authorId;
  final String postId;

  LikeModel({
    @required this.id,
    @required this.postId,
    @required this.authorId,
  });

  LikeModel.fromJson({
    @required String id,
    Map<String, dynamic> data,
  })  : this.id = id,
        authorId = data[FirestoreKeys.authorIdFieldKey] ?? '',
        postId = data[FirestoreKeys.postIdFieldKey] ?? '';

  const LikeModel.empty()
      : id = '',
        authorId = '',
        postId = '';

  @override
  String toString() {
    return 'LikeModel('
        'id: $id, '
        'authorId: $authorId, '
        'postId: $postId'
        ')';
  }
}
