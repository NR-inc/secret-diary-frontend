import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/export/domain.dart';

class CommentsBloc extends BaseBloc {
  final PublishSubject<List<CommentModel>> _commentsResult;
  final CommentsInteractor _interactor;
  bool _isCommentsLoaded = false;

  CommentsBloc({
    @required PublishSubject<List<CommentModel>> commentsResult,
    @required CommentsInteractor interactor,
  })  : _commentsResult = commentsResult,
        _interactor = interactor;

  Stream<List<CommentModel>> get commentsStream => _commentsResult.stream;

  void loadComments({
    String postId,
    int limit = DomainConstants.limit,
  }) async {
    if (isLoading || _isCommentsLoaded) {
      return;
    }

    showLoading(true);

    List<CommentModel> loadedComments = await _commentsResult.first;
    var lastCommentId;
    if (loadedComments != null && loadedComments.isNotEmpty) {
      lastCommentId = loadedComments.last.id;
    }

    _interactor
        .loadComments(
      postId: postId,
      fromCommentId: lastCommentId,
      limit: limit,
    )
        .then(
      (List<CommentModel> comments) async {
        _isCommentsLoaded = comments.length < limit;
        List<CommentModel> loadedPosts = await _commentsResult.first;
        _commentsResult.add(loadedPosts..addAll(comments));
        showLoading(false);
      },
      onError: handleError,
    );
  }

  void removeComment({String commentId}) async {
    await _interactor.removeComment(commentId: commentId);
  }

  void updateComment({CommentModel commentModel}) async {
    await _interactor.updateComment(commentModel: commentModel);
  }

  void addComment({String message, String postId}) async {
    final newComment = await _interactor.addComment(
      message: message,
      postId: postId,
    );
    List<CommentModel> loadedPosts = await _commentsResult.first;
    _commentsResult.add(loadedPosts..add(newComment));
  }
}
