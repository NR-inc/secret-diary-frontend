import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sd_base/sd_base.dart';
import 'package:sddomain/model/post_category_model.dart';

class PostModel {
  String id;
  String title;
  String description;
  DateTime createdAt;
  int likes;
  int comments;
  List<PostCategoryModel> postCategoryModels;

  PostModel({
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.likes,
    this.postCategoryModels,
  });

  PostModel.empty() {
    id = '';
    title = '';
    description = '';
    likes = 0;
    comments = 0;
    createdAt = DateTime.now();
    postCategoryModels = [PostCategoryModel.empty()];
  }

  PostModel.fromJson({
    @required String id,
    Map<String, dynamic> data,
  }) {
    this.id = id;
    title = data[FirestoreKeys.titleFieldKey] ?? '';
    description = data[FirestoreKeys.descriptionFieldKey] ?? '';
    createdAt = data[FirestoreKeys.createdAtFieldKey] != null
        ? DateTime.fromMillisecondsSinceEpoch(
            (data[FirestoreKeys.createdAtFieldKey] as Timestamp)
                .millisecondsSinceEpoch,
          )
        : null;
    likes = data[FirestoreKeys.likesFieldKey] ?? 0;
    comments = data[FirestoreKeys.commentsFieldKey] ?? 0;
    postCategoryModels = List();
  }
}
