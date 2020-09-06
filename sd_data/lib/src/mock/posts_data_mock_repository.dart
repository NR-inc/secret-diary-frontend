import 'package:sddomain/export/domain.dart';
import 'package:sddomain/model/feed_sort_type.dart';
import 'package:sddomain/model/post_category_model.dart';
import 'package:sddomain/model/post_model.dart';
import 'package:sddomain/repository/posts_repository.dart';

class PostsDataMockRepository implements PostsRepository {
  @override
  Future<List<PostModel>> getFeedPostsBy({
    FeedSortType feedSortType,
    String searchQuery,
    List<PostCategoryModel> postCategories,
    String fromPostId,
    int limit,
  }) async {
    var posts = List<PostModel>.from(_posts);
    if (searchQuery != null) {
      posts = posts.where(
        (post) =>
            post.title.contains(searchQuery) ||
            post.description.contains(searchQuery),
      );
    }

    if ((posts != null && posts.isNotEmpty) &&
        (postCategories != null && postCategories.isNotEmpty)) {
      posts = posts.where((post) {
        final categoryFound = _categories.firstWhere(
          (category) => post.postCategoryModels.first.id == category.id,
          orElse: () => PostCategoryModel.empty(),
        );
        return categoryFound.id != -1;
      });
    } else {
      return posts ?? List();
    }
  }

  @override
  Future<PostModel> getPostById(String postId) async {
    return _posts.firstWhere((post) => post.id == postId);
  }

  @override
  Future<List<PostModel>> getPostsOfUser({
    String userUid,
    String fromPostId,
    int limit,
  }) async {
    return _posts;
  }

  @override
  Future<bool> removePostById({
    UserModel currentUser,
    String postId,
  }) async {
    return true;
  }

  @override
  Future<PostModel> updatePost(PostModel newPostModel) async {
    bool isUpdated = false;
    for (var i = 0; i < _posts.length; i++) {
      final post = _posts[i];
      if (newPostModel.id == post.id) {
        isUpdated = true;
        _posts[i] = newPostModel;
      }
    }
    if (!isUpdated) {
      _posts.add(newPostModel);
    }
    return newPostModel;
  }

  @override
  Future<bool> createPost({
    String userUid,
    String title,
    String description,
    bool visibilityFlag,
    List<String> categoriesIds,
  }) {
    // TODO: implement createPost
    throw UnimplementedError();
  }
}

var _posts = [
  PostModel(
    id: '1',
    postCategoryModels: [_categories[0]],
    title: 'My first flight',
    description:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
  ),
  PostModel(
    id: '2',
    postCategoryModels: [_categories[1]],
    title: 'I cooked scrambled eggs',
    description:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
  ),
  PostModel(
    id: '3',
    postCategoryModels: [_categories[2]],
    title: 'I met a girl',
    description:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
  ),
  PostModel(
    id: '4',
    postCategoryModels: [_categories[3]],
    title: 'I fired from my favorite job',
    description:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
  ),
];

final _categories = [
  PostCategoryModel(id: 1, name: 'TRAVEL'),
  PostCategoryModel(id: 2, name: 'COOKING'),
  PostCategoryModel(id: 3, name: 'RELATIONSHIPS'),
  PostCategoryModel(id: 4, name: 'WORK'),
];
