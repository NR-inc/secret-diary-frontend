import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sd_base/sd_base.dart';
import 'package:sddomain/export/domain.dart';

class LikesDataRepository extends LikesRepository {
  final ErrorHandler _errorHandler;
  final FirebaseFirestore _firestore;

  LikesDataRepository({
    ErrorHandler errorHandler,
    FirebaseFirestore firestore,
  })  : _errorHandler = errorHandler,
        _firestore = firestore;

  @override
  Future<LikeModel> addLike({
    String userId,
    String postId,
  }) async {
    try {
      final result = await _firestore
          .collection(
        FirestoreKeys.likesCollectionKey,
      )
          .add({
        FirestoreKeys.authorIdFieldKey: userId,
        FirestoreKeys.postIdFieldKey: postId,
      });

      return LikeModel(
        id: result.id,
        postId: postId,
        authorId: userId,
      );
    } on dynamic catch (ex) {
      throw _errorHandler.handleNetworkError(ex);
    }
  }

  @override
  Future<List<LikeModel>> getLikes({String postId}) async {
    try {
      final result = await _firestore
          .collection(FirestoreKeys.likesCollectionKey)
          .where(FirestoreKeys.postIdFieldKey, isEqualTo: postId)
          .get();

      return result.docs
          .map((likeData) => LikeModel.fromJson(
                id: likeData.id,
                data: likeData.data(),
              ))
          .toList();
    } on dynamic {
      return null;
    }
  }

  @override
  Future<bool> removeLike({
    String userId,
    String postId,
  }) async {
    try {
      final result = await _firestore
          .collection(FirestoreKeys.likesCollectionKey)
          .where(FirestoreKeys.postIdFieldKey, isEqualTo: postId)
          .where(FirestoreKeys.authorIdFieldKey, isEqualTo: userId)
          .get();

      await result.docs.first.reference.delete();

      return true;
    } on dynamic catch (ex) {
      throw _errorHandler.handleNetworkError(ex);
    }
  }

  @override
  Future<bool> removeLikes({String postId}) async {
    try {
      await _firestore
          .collection(FirestoreKeys.likesCollectionKey)
          .where(FirestoreKeys.postIdFieldKey, isEqualTo: postId)
          .get()
          .then(
            (value) => value.docs.forEach(
              (element) async => await element.reference.delete(),
            ),
          );

      return true;
    } on dynamic catch (ex) {
      throw _errorHandler.handleNetworkError(ex);
    }
  }
}
