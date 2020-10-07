import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sd_base/sd_base.dart';
import 'package:sddomain/model/post_category_model.dart';

@immutable
class PostModel {
  final String id;
  final String authorId;
  final String title;
  final String description;
  final DateTime createdAt;
  final int likes;
  final int comments;
  final bool isLiked;
  final List<PostCategoryModel> postCategoryModels;

  PostModel({
    @required this.id,
    @required this.authorId,
    @required this.title,
    @required this.description,
    @required this.createdAt,
    @required this.likes,
    @required this.isLiked,
    @required this.comments,
    @required this.postCategoryModels,
  });

  PostModel.empty()
      : id = '',
        authorId = '',
        title = '',
        description = '',
        likes = 0,
        isLiked = false,
        comments = 0,
        createdAt = DateTime.now(),
        postCategoryModels = [PostCategoryModel.empty()];

  PostModel.fromJson({
    @required String id,
    Map<String, dynamic> data,
  })  : this.id = id,
        authorId = data[FirestoreKeys.authorIdFieldKey] ?? '',
        title = data[FirestoreKeys.titleFieldKey] ?? '',
        description = data[FirestoreKeys.descriptionFieldKey] ?? '',
        createdAt = data[FirestoreKeys.createdAtFieldKey] != null
            ? DateTime.fromMillisecondsSinceEpoch(
                (data[FirestoreKeys.createdAtFieldKey] as Timestamp)
                    .millisecondsSinceEpoch,
              )
            : null,
        likes = data[FirestoreKeys.likesFieldKey] ?? 0,
        comments = data[FirestoreKeys.commentsFieldKey] ?? 0,
        isLiked = data[FirestoreKeys.isLikedFieldKey] ?? false,
        postCategoryModels = List();
}
