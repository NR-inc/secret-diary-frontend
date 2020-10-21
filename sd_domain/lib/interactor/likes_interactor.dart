import 'package:sddomain/export/domain.dart';

class LikesInteractor {
  final LikesRepository _likesRepository;
  final UserRepository _userRepository;

  LikesInteractor({
    LikesRepository likesRepository,
    UserRepository userRepository,
  })  : _likesRepository = likesRepository,
        _userRepository = userRepository;

  Future<List<LikeModel>> getLikes({String postId}) =>
      _likesRepository.getLikes(postId: postId);

  Future<String> removeLike({String postId}) async {
    final profile = await _userRepository.profile();
    return _likesRepository.removeLike(
      userId: profile.uid,
      postId: postId,
    );
  }

  Future<LikeModel> addLike({String postId}) async {
    final profile = await _userRepository.profile();
    return await _likesRepository.addLike(
      userId: profile.uid,
      postId: postId,
    );
  }

  Future<bool> isPostLiked({String postId}) async {
    final profile = await _userRepository.profile();
    return await _likesRepository.isPostLiked(
      userId: profile.uid,
      postId: postId,
    );
  }
}
