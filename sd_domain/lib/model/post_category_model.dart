class PostCategoryModel {
  final int id;
  final String name;

  PostCategoryModel({
    this.id,
    this.name,
  });

  PostCategoryModel.empty()
      : id = -1,
        name = '';
}
