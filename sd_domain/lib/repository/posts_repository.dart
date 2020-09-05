import 'package:flutter/foundation.dart';
import 'package:sddomain/export/models.dart';
import 'package:sddomain/model/feed_sort_type.dart';

abstract class PostsRepository {
  Future<PostModel> getPostById(String postId);

  Future<PostModel> updatePost(PostModel postModel);

  Future<bool> removePostById({
    UserModel currentUser,
    String postId,
  });

  Future<bool> createPost({
    UserModel currentUser,
    String title,
    String description,
    bool visibilityFlag,
    List<String> categoriesIds,
  });

  Stream<List<PostModel>> getPostsOfUser({
    @required UserModel user,
    int fromPostId,
    int limit,
  });

  Stream<List<PostModel>> getFeedPostsBy({
    @required FeedSortType feedSortType,
    String searchQuery,
    List<PostCategoryModel> postCategories,
    int fromPostId,
    int limit,
  });
}
