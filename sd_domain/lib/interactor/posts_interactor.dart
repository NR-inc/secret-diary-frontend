import 'package:sddomain/export/domain.dart';

class PostsInteractor {
  final PostsRepository _postsRepository;
  final UserRepository _userRepository;
  final CommentsRepository _commentsRepository;
  final LikesRepository _likesRepository;

  PostsInteractor({
    required PostsRepository postsRepository,
    required UserRepository userRepository,
    required CommentsRepository commentsRepository,
    required LikesRepository likesRepository,
  })   : _postsRepository = postsRepository,
        _userRepository = userRepository,
        _likesRepository = likesRepository,
        _commentsRepository = commentsRepository;

  Future<List<PostModel>> getPostsOfUser({
    required String userUid,
    required String fromPostId,
    required int limit,
  }) =>
      _postsRepository.getPostsOfUser(
        userUid: userUid,
        fromPostId: fromPostId,
        limit: limit,
      );

  Future<List<PostModel>> getFeedPostsBy({
    required FeedSortType feedSortType,
    String? searchQuery,
    List<PostCategoryModel>? postCategories,
    required String fromPostId,
    required int limit,
  }) async {
    final user = await _userRepository.profile();
    return _postsRepository.getFeedPostsBy(
      userId: user.uid,
      feedSortType: feedSortType,
      postCategories: postCategories,
      fromPostId: fromPostId,
      limit: limit,
    );
  }

  Future<bool> createPost(
    String title,
    String description,
    bool visibilityFlag, [
    List<String>? categoriesIds,
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

  Future<bool> removePost({required String id}) async {
    await _postsRepository.removePostById(postId: id);
    await _commentsRepository.removeComments(postId: id);
    await _likesRepository.removeLikes(postId: id);
    return true;
  }

  Future<PostModel> getPost({required String id}) async {
    final currentUser = await _userRepository.profile();
    return _postsRepository.getPostById(
      postId: id,
      userId: currentUser.uid,
    );
  }
}
