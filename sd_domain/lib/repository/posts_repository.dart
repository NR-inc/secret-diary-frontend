import 'package:flutter/foundation.dart';
import 'package:sddomain/export/models.dart';
import 'package:sddomain/model/feed_sort_type.dart';

abstract class PostsRepository {
  Future<PostModel> getPostById(int postId);

  Future<PostModel> updatePost(PostModel postModel);

  Future<bool> removePostById(int postId);

  Stream<List<PostModel>> getPostsOfUser({
    @required int userId,
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
