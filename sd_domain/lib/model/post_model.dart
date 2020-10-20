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

  final List<PostCategoryModel> postCategoryModels;

  PostModel({
    @required this.id,
    @required this.authorId,
    @required this.title,
    @required this.description,
    @required this.createdAt,
    @required this.postCategoryModels,
  });

  PostModel.empty()
      : id = '',
        authorId = '',
        title = '',
        description = '',
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
        postCategoryModels = List();

  @override
  String toString() {
    return 'PostModel('
        'id: $id, '
        'authorId: $authorId, '
        'title: $title,'
        'description: $description,'
        'createdAt: $createdAt,'
        'postCategoryModels: $postCategoryModels,'
        ')';
  }
}
