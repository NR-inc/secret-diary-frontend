import 'package:sddomain/export/models.dart';
import 'package:sddomain/model/feed_sort_type.dart';

abstract class PostsRepository {
  Future<PostModel> getPostById({
    required String postId,
    required String userId,
  });

  Future<PostModel> updatePost(PostModel postModel);

  Future<bool> removePostById({
    required String postId,
  });

  Future<bool> createPost({
    required String userUid,
    required String title,
    required String description,
    required bool visibilityFlag,
    List<String>? categoriesIds,
  });

  Future<List<PostModel>> getPostsOfUser({
    required String userUid,
    String? fromPostId,
    required int limit,
  });

  Future<List<PostModel>> getFeedPostsBy({
    String? userId,
    FeedSortType? feedSortType,
    String? searchQuery,
    List<PostCategoryModel>? postCategories,
    String? fromPostId,
    required int limit,
  });
}
