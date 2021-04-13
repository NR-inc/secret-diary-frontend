class PostCategoryModel {
  final int id;
  final String name;

  PostCategoryModel({
    required this.id,
    required this.name,
  });

  PostCategoryModel.empty()
      : id = -1,
        name = '';
}
