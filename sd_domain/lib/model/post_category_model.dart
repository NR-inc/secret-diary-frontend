class PostCategoryModel {
  int id;
  String name;

  PostCategoryModel({
    this.id,
    this.name,
  });

  PostCategoryModel.empty() {
    id = -1;
    name = '';
  }
}
