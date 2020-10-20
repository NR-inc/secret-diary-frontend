import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/export/domain.dart';
import 'package:sddomain/interactor/likes_interactor.dart';

class LikesBloc extends BaseBloc {
  final PublishSubject<List<LikeModel>> _likesResult;
  final PublishSubject<bool> _isPostLikedResult;
  final LikesInteractor _interactor;

  LikesBloc({
    PublishSubject<List<LikeModel>> likesResult,
    PublishSubject<bool> isPostLikedResult,
    LikesInteractor interactor,
    Logger logger,
  })  : _likesResult = likesResult,
        _isPostLikedResult = isPostLikedResult,
        _interactor = interactor,
        super(logger: logger);

  Stream<List<LikeModel>> get likesStream => _likesResult.stream;

  Stream<bool> get isPostLikedStream => _isPostLikedResult.stream;

  void getLikes({String postId}) {
    showLoading(true);
    _interactor.getLikes(postId: postId).then(
      (List<LikeModel> likes) {
        logger.i(
          'getLikes: postId = $postId, '
          'likes = ${likes.toString()}',
        );
        _likesResult.add(likes);
        showLoading(false);
      },
      onError: handleError,
    );
  }

  void removeLike({String postId}) {
    _interactor.removeLike(postId: postId).then(
      (isLikeRemoved) {
        logger.i('postId = $postId, success');
        _isPostLikedResult.add(false);
      },
      onError: handleError,
    );
  }

  void addLike({String postId}) async {
    _interactor.addLike(postId: postId).then(
      (isLikeAdded) {
        logger.i('postId = $postId, success');
        _isPostLikedResult.add(true);
      },
      onError: handleError,
    );
  }

  void isPostLiked({String postId}) {
    showLoading(true);
    _interactor.isPostLiked(postId: postId).then(
      (isLiked) {
        logger.i('postId = $postId, isLiked = $isLiked');
        _isPostLikedResult.add(isLiked);
        showLoading(false);
      },
      onError: handleError,
    );
  }
}
