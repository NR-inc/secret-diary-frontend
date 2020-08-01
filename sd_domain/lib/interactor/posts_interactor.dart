import 'package:flutter/foundation.dart';
import 'package:sddomain/export/domain.dart';

class PostsInteractor {
  final PostsRepository _postsRepository;

  PostsInteractor(this._postsRepository);

  Stream<List<PostModel>> getPostsOfUser({
    @required int userId,
    int fromPostId,
    int limit,
  }) =>
      _postsRepository.getPostsOfUser(
        userId: userId,
        fromPostId: fromPostId,
        limit: limit,
      );

  Stream<List<PostModel>> getFeedPostsBy({
    @required FeedSortType feedSortType,
    String searchQuery,
    List<PostCategoryModel> postCategories,
    int fromPostId,
    int limit,
  }) =>
      _postsRepository.getFeedPostsBy(
        feedSortType: feedSortType,
        postCategories: postCategories,
        fromPostId: fromPostId,
        limit: limit,
      );
}
