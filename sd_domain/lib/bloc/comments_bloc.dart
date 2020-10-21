import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/export/domain.dart';

class CommentsBloc extends BaseBloc {
  final BehaviorSubject<List<CommentModel>> _commentsResult;
  final CommentsInteractor _interactor;
  bool _isCommentsLoaded = false;

  CommentsBloc({
    @required Logger logger,
    @required BehaviorSubject<List<CommentModel>> commentsResult,
    @required CommentsInteractor interactor,
  })  : _commentsResult = commentsResult,
        _interactor = interactor,
        super(logger: logger);

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
        logger.i('comments length: ${comments?.length ?? 0}');
        logger.i('comments: $comments');
        _isCommentsLoaded = (comments?.length ?? 0) < limit;
        List<CommentModel> loadedPosts = await _commentsResult.first;
        _commentsResult.add(loadedPosts..addAll(comments));
        showLoading(false);
      },
      onError: handleError,
    );
  }

  void removeComment({String commentId}) async {
    _interactor.removeComment(commentId: commentId).then(
      (isCommentRemoved) {
        logger.i('comment $commentId: removed');
      },
      onError: handleError,
    );
  }

  void updateComment({CommentModel commentModel}) async {
    await _interactor.updateComment(commentModel: commentModel);
  }

  void addComment({String message, String postId}) async {
    _interactor
        .addComment(
      message: message,
      postId: postId,
    )
        .then(
      (CommentModel newComment) async {
        logger.i('comment ${newComment.id}: added');
        logger.i('comment info: $newComment');
        List<CommentModel> loadedComments = await _commentsResult.first;
        _commentsResult.add(loadedComments..insert(0, newComment));
      },
      onError: handleError,
    );
  }
}
