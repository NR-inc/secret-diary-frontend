import 'package:flutter/foundation.dart';
import 'package:sddomain/export/domain.dart';

class PostsInteractor {
  final PostsRepository _postsRepository;
  final UserRepository _userRepository;

  PostsInteractor(
    this._postsRepository,
    this._userRepository,
  );

  Stream<List<PostModel>> getPostsOfUser({
    @required String userUid,
    int fromPostId,
    int limit,
  }) async* {
    final user = await _userRepository.getUserById(userUid);
    yield* _postsRepository.getPostsOfUser(
      user: user,
      fromPostId: fromPostId,
      limit: limit,
    );
  }

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

  Future<bool> createPost(
    String title,
    String description,
    bool visibilityFlag, [
    List<String> categoriesIds,
  ]) async {
    final currentUser = await _userRepository.profile();
    return await _postsRepository.createPost(
      currentUser: currentUser,
      title: title,
      description: description,
      visibilityFlag: visibilityFlag,
      categoriesIds: categoriesIds,
    );
  }

  Future<bool> removePost({@required String id}) async {
    final currentUser = await _userRepository.profile();
    return await _postsRepository.removePostById(
      currentUser: currentUser,
      postId: id,
    );
  }
}
