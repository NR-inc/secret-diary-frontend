import 'package:sddomain/export/domain.dart';

abstract class CommentsRepository {
  Future<List<CommentModel>> loadComments({
    required String postId,
    String? fromCommentId,
    required int limit,
  });

  Future<bool> removeComment({
    required String commentId,
  });

  Future<bool> removeComments({
    required String postId,
  });

  Future<CommentModel> addComment({
    required String message,
    required String postId,
    required String authorId,
  });

  Future<CommentModel> updateComment({
    required CommentModel commentModel,
  });

  Future<int> getCountOfComments({
    required String postId,
  });
}
