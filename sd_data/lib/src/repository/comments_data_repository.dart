import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sd_base/sd_base.dart';
import 'package:sddomain/export/domain.dart';

class CommentsDataRepository implements CommentsRepository {
  final ErrorHandler _errorHandler;
  final FirebaseFirestore _firestore;

  CommentsDataRepository({
    ErrorHandler errorHandler,
    FirebaseFirestore firestore,
  })  : _errorHandler = errorHandler,
        _firestore = firestore;

  @override
  Future<CommentModel> addComment({
    String message,
    String postId,
    String authorId,
  }) async {
    try {
      final result = await _firestore
          .collection(
        FirestoreKeys.commentsCollectionKey,
      )
          .add({
        FirestoreKeys.messageFieldKey: message,
        FirestoreKeys.postIdFieldKey: postId,
        FirestoreKeys.authorIdFieldKey: authorId,
        FirestoreKeys.createdAtFieldKey: FieldValue.serverTimestamp(),
      });
      final comment = await result.get();
      return CommentModel.fromJson(
        id: comment.id,
        data: comment.data(),
      );
    } on dynamic catch (ex) {
      throw _errorHandler.handleNetworkError(ex);
    }
  }

  @override
  Future<List<CommentModel>> loadComments({
    String postId,
    String fromCommentId,
    int limit,
  }) async {
    try {
      DocumentSnapshot lastDownloadedCommentDoc;

      if (fromCommentId != null && fromCommentId.isNotEmpty) {
        lastDownloadedCommentDoc = await _firestore
            .collection(FirestoreKeys.commentsCollectionKey)
            .doc(fromCommentId)
            .get();
      }

      var query = _firestore
          .collection(FirestoreKeys.commentsCollectionKey)
          .where(FirestoreKeys.postIdFieldKey, isEqualTo: postId)
          .orderBy(FirestoreKeys.createdAtFieldKey, descending: true);

      if (lastDownloadedCommentDoc != null) {
        query = query.startAfterDocument(lastDownloadedCommentDoc);
      }

      final result = await query.limit(limit).get();

      final data = result.docs
          .map((comment) => CommentModel.fromJson(
                id: comment.id,
                data: comment.data(),
              ))
          .toList();
      return data;
    } on dynamic {
      return null;
    }
  }

  @override
  Future<bool> removeComment({String commentId}) async {
    try {
      await _firestore
          .collection(FirestoreKeys.commentsFieldKey)
          .doc(commentId)
          .delete();
      return true;
    } on dynamic catch (ex) {
      throw _errorHandler.handleNetworkError(ex);
    }
  }

  @override
  Future<CommentModel> updateComment({CommentModel commentModel}) async {
    try {
      await _firestore
          .collection(FirestoreKeys.commentsCollectionKey)
          .doc(commentModel.id)
          .update({
        FirestoreKeys.messageFieldKey: commentModel.message,
      });
      return commentModel;
    } on dynamic catch (ex) {
      throw _errorHandler.handleNetworkError(ex);
    }
  }

  @override
  Future<bool> removeComments({String postId}) async {
    try {
      await _firestore
          .collection(FirestoreKeys.commentsCollectionKey)
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
