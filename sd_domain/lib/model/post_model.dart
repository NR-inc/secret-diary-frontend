import 'package:sddomain/model/post_category_model.dart';

class PostModel {
  int id;
  String title;
  String description;
  DateTime createdAt;
  List<PostCategoryModel> postCategoryModels;

  PostModel({
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.postCategoryModels,
  });

  PostModel.empty() {
    id = -1;
    title = '';
    description = '';
    createdAt = DateTime.now();
    postCategoryModels = [PostCategoryModel.empty()];
  }
}
