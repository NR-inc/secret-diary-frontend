import 'package:flutter/cupertino.dart';
import 'package:sddomain/export/domain.dart';

abstract class CommentsRepository {
  Future<List<CommentModel>> loadComments({
    @required String postId,
    String fromCommentId,
    int limit,
  });

  Future<bool> removeComment({
    @required String commentId,
  });

  Future<bool> removeComments({
    @required String postId,
  });

  Future<CommentModel> addComment({
    @required String message,
    @required String postId,
    @required String authorId,
  });

  Future<CommentModel> updateComment({
    @required CommentModel commentModel,
  });
}
