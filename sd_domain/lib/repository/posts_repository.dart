import 'package:flutter/foundation.dart';
import 'package:sddomain/export/models.dart';
import 'package:sddomain/model/feed_sort_type.dart';
import 'package:sddomain/model/like_model.dart';

abstract class PostsRepository {
  Future<PostModel> getPostById({
    String postId,
    String userId,
  });

  Future<PostModel> updatePost(PostModel postModel);

  Future<bool> removePostById({
    String postId,
  });

  Future<bool> createPost({
    String userUid,
    String title,
    String description,
    bool visibilityFlag,
    List<String> categoriesIds,
  });

  Future<List<PostModel>> getPostsOfUser({
    @required String userUid,
    String fromPostId,
    int limit,
  });

  Future<List<PostModel>> getFeedPostsBy({
    @required FeedSortType feedSortType,
    String searchQuery,
    List<PostCategoryModel> postCategories,
    String fromPostId,
    int limit,
  });
}
