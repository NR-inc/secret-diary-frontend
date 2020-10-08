import 'package:flutter/foundation.dart';
import 'package:sddomain/export/domain.dart';

class PostsInteractor {
  final PostsRepository _postsRepository;
  final UserRepository _userRepository;

  PostsInteractor(
    this._postsRepository,
    this._userRepository,
  );

  Future<List<PostModel>> getPostsOfUser({
    @required String userUid,
    String fromPostId,
    int limit,
  }) =>
      _postsRepository.getPostsOfUser(
        userUid: userUid,
        fromPostId: fromPostId,
        limit: limit,
      );

  Future<List<PostModel>> getFeedPostsBy({
    @required FeedSortType feedSortType,
    String searchQuery,
    List<PostCategoryModel> postCategories,
    String fromPostId,
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
      userUid: currentUser.uid,
      title: title,
      description: description,
      visibilityFlag: visibilityFlag,
      categoriesIds: categoriesIds,
    );
  }

  Future<bool> removePost({@required String id}) =>
      _postsRepository.removePostById(postId: id);

  Future<PostModel> getPost({@required String id}) async {
    final currentUser = await _userRepository.profile();
    return _postsRepository.getPostById(
      postId: id,
      userId: currentUser.uid,
    );
  }

  Future<LikeModel> likePost({
    String postId,
  }) async {
    final currentUser = await _userRepository.profile();
    return await _postsRepository.likePost(
      postId: postId,
      userId: currentUser.uid,
    );
  }

  Future<bool> unlikePost({
    String postId,
  }) async {
    final currentUser = await _userRepository.profile();
    return await _postsRepository.unlikePost(
      postId: postId,
      userId: currentUser.uid,
    );
  }
}
