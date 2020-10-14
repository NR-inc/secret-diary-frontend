import 'package:sddomain/export/domain.dart';

class CommentsInteractor {
  final CommentsRepository _commentsRepository;
  final UserRepository _userRepository;

  CommentsInteractor({
    CommentsRepository commentsRepository,
    UserRepository userRepository,
  })  : _commentsRepository = commentsRepository,
        _userRepository = userRepository;

  Future<List<CommentModel>> loadComments({
    String postId,
    String fromCommentId,
    int limit,
  }) =>
      _commentsRepository.loadComments(
        postId: postId,
        fromCommentId: fromCommentId,
        limit: limit,
      );

  Future<bool> removeComment({
    String commentId,
  }) =>
      _commentsRepository.removeComment(
        commentId: commentId,
      );

  Future<CommentModel> updateComment({
    CommentModel commentModel,
  }) =>
      _commentsRepository.updateComment(
        commentModel: commentModel,
      );

  Future<CommentModel> addComment({String postId, String message}) async {
    final profile = await _userRepository.profile();
    return await _commentsRepository.addComment(
      message: message,
      postId: postId,
      authorId: profile.uid,
    );
  }
}
