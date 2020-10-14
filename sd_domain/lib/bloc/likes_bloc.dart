import 'package:rxdart/rxdart.dart';
import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/export/domain.dart';
import 'package:sddomain/interactor/likes_interactor.dart';

class LikesBloc extends BaseBloc {
  final PublishSubject<List<LikeModel>> _likesResult;
  final LikesInteractor _interactor;

  LikesBloc({
    PublishSubject<List<LikeModel>> likesResult,
    LikesInteractor interactor,
  })  : _likesResult = likesResult,
        _interactor = interactor;

  Stream<List<LikeModel>> get likesStream => _likesResult.stream;

  void getLikes({String postId}) async {
    if (isLoading) {
      return;
    }
    showLoading(true);
    _interactor.getLikes(postId: postId).then(
      (List<LikeModel> likes) async {
        _likesResult.add(likes);
        showLoading(false);
      },
      onError: handleError,
    );
  }

  void removeLike({String postId}) async {
    await _interactor.removeLike(postId: postId);
  }

  void addLike({String postId}) async {
    await _interactor.addLike(postId: postId);
  }
}
