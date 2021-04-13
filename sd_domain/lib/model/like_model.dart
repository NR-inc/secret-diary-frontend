import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sd_base/sd_base.dart';

@immutable
class LikeModel {
  final String id;
  final String authorId;
  final String postId;
  final bool? isOwner;
  final DateTime? createdAt;

  LikeModel({
    required this.id,
    required this.postId,
    required this.authorId,
    this.isOwner,
    this.createdAt,
  });

  LikeModel.fromJson({
    required String id,
    required Map<String, dynamic> data,
  })  : this.id = id,
        authorId = data[FirestoreKeys.authorIdFieldKey] ?? '',
        postId = data[FirestoreKeys.postIdFieldKey] ?? '',
        isOwner = data[FirestoreKeys.isOwnerFieldKey] ?? false,
        createdAt = data[FirestoreKeys.createdAtFieldKey] != null
            ? DateTime.fromMillisecondsSinceEpoch(
                (data[FirestoreKeys.createdAtFieldKey] as Timestamp)
                    .millisecondsSinceEpoch,
              )
            : null;

  const LikeModel.empty()
      : id = '',
        authorId = '',
        postId = '',
        isOwner = false,
        createdAt = null;

  @override
  String toString() {
    return 'LikeModel('
        'id: $id, '
        'authorId: $authorId, '
        'postId: $postId,  '
        'isOwner: $isOwner,  '
        'createdAt: $createdAt,  '
        ')';
  }
}
