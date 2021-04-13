import 'package:sddomain/export/domain.dart';

class CommentsInteractor {
  final CommentsRepository _commentsRepository;
  final UserRepository _userRepository;

  CommentsInteractor({
    required CommentsRepository commentsRepository,
    required UserRepository userRepository,
  })   : _commentsRepository = commentsRepository,
        _userRepository = userRepository;

  Future<List<CommentModel>> loadComments({
    required String postId,
    required String fromCommentId,
    required int limit,
  }) =>
      _commentsRepository.loadComments(
        postId: postId,
        fromCommentId: fromCommentId,
        limit: limit,
      );

  Future<bool> removeComment({
    required String commentId,
  }) =>
      _commentsRepository.removeComment(
        commentId: commentId,
      );

  Future<CommentModel> updateComment({
    required CommentModel commentModel,
  }) =>
      _commentsRepository.updateComment(
        commentModel: commentModel,
      );

  Future<CommentModel> addComment({
    required String postId,
    required String message,
  }) async {
    final profile = await _userRepository.profile();
    return await _commentsRepository.addComment(
      message: message,
      postId: postId,
      authorId: profile.uid,
    );
  }

  Future<int> getCountOfComments({
    required String postId,
  }) =>
      _commentsRepository.getCountOfComments(postId: postId);
}
