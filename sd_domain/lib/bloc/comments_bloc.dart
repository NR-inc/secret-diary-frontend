import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/export/domain.dart';

class CommentsBloc extends BaseBloc {
  final BehaviorSubject<List<CommentModel>> _commentsResult;
  final BehaviorSubject<int> _commentsCounter;
  final CommentsInteractor _interactor;
  bool _isCommentsLoaded = false;

  CommentsBloc({
    required Logger logger,
    required BehaviorSubject<List<CommentModel>> commentsResult,
    required BehaviorSubject<int> commentsCounter,
    required CommentsInteractor interactor,
  })  : _commentsResult = commentsResult,
        _interactor = interactor,
        _commentsCounter = commentsCounter,
        super(logger: logger);

  Stream<List<CommentModel>> get commentsStream => _commentsResult.stream;

  Stream<int> get countOfCommentsStream => _commentsCounter.stream;

  void loadComments({
    required String postId,
    int limit = DomainConstants.limit,
  }) async {
    if (isLoading || _isCommentsLoaded) {
      return;
    }

    showLoading(true);

    List<CommentModel> loadedComments = await _commentsResult.first;
    var lastCommentId;
    if (loadedComments.isNotEmpty) {
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
        logger.i('comments length: ${comments.length}');
        logger.i('comments: $comments');
        _isCommentsLoaded = (comments.length) < limit;
        List<CommentModel> loadedPosts = await _commentsResult.first;
        _commentsResult.add(loadedPosts..addAll(comments));
        showLoading(false);
      },
      onError: handleError,
    );
  }

  void removeComment({
    required String commentId,
  }) async {
    _interactor.removeComment(commentId: commentId).then(
      (isCommentRemoved) async {
        logger.i('comment $commentId: removed');
        List<CommentModel> loadedComments = await _commentsResult.first;
        int countOfComments = await _commentsCounter.first;
        _commentsResult.add(loadedComments
          ..removeWhere(
            (comment) => comment.id == commentId,
          ));
        _commentsCounter.add(--countOfComments);
      },
      onError: handleError,
    );
  }

  void updateComment({
    required CommentModel commentModel,
  }) =>
      _interactor.updateComment(commentModel: commentModel);

  void addComment({
    required String message,
    required String postId,
  }) async {
    if (message.trim().isEmpty) {
      return;
    }

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
        int countOfComments = await _commentsCounter.first;
        _commentsResult.add(
          loadedComments..insert(0, newComment),
        );
        _commentsCounter.add(++countOfComments);
      },
      onError: handleError,
    );
  }

  void getCountOfComments({
    required String postId,
  }) {
    _interactor.getCountOfComments(postId: postId).then(
      (count) {
        logger.i('count of comments: $count');
        _commentsCounter.add(count);
      },
      onError: handleError,
    );
  }

  @override
  void dispose() {
    _commentsCounter.close();
    _commentsResult.close();
    super.dispose();
  }
}
