import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sd_base/sd_base.dart';
import 'package:sd_data/sd_data.dart';
import 'package:sddomain/export/domain.dart';

class PostsDataRepository implements PostsRepository {
  final NetworkExecutor _networkExecutor;
  final ErrorHandler _errorHandler;

  PostsDataRepository(this._networkExecutor, this._errorHandler);

  @override
  Future<List<PostModel>> getFeedPostsBy(
      {String searchQuery,
      FeedSortType feedSortType,
      List<PostCategoryModel> postCategories,
      String fromPostId,
      int limit}) async {
    try {
      final databaseReference = FirebaseFirestore.instance;
      DocumentSnapshot lastDownloadedPostDoc;

      var orderByField;
      switch (feedSortType) {
        case FeedSortType.byDate:
          orderByField = FirestoreKeys.createdAtFieldKey;
          break;
        case FeedSortType.byCategories:
          orderByField = FirestoreKeys.createdAtFieldKey; // todo
          break;
        case FeedSortType.byComments:
          orderByField = FirestoreKeys.commentsFieldKey;
          break;
        case FeedSortType.byLikes:
          orderByField = FirestoreKeys.likesFieldKey;
          break;
      }

      if (fromPostId != null && fromPostId.isNotEmpty) {
        lastDownloadedPostDoc = await databaseReference
            .collection(FirestoreKeys.postsCollectionKey)
            .doc(fromPostId)
            .get();
      }

      var query = databaseReference
          .collection(FirestoreKeys.postsCollectionKey)
          .where(FirestoreKeys.visibilityFlagFieldKey, isEqualTo: true)
          .orderBy(orderByField, descending: true);

      if (lastDownloadedPostDoc != null) {
        query = query.startAfterDocument(lastDownloadedPostDoc);
      }
      final result = await query.limit(limit).get();

      final data = result.docs
          .map((postData) => PostModel.fromJson(
                id: postData.id,
                data: postData.data(),
              ))
          .toList();

      return data;
    } on dynamic catch (ex) {
      throw _errorHandler.handleNetworkError(ex);
    }
  }

  @override
  Future<PostModel> getPostById({
    String postId,
    String userId,
  }) async {
    try {
      final databaseReference = FirebaseFirestore.instance;

      final doc = await databaseReference
          .collection(FirestoreKeys.postsCollectionKey)
          .doc(postId)
          .get();

      final comments = await getCommentsOfPost(postId: postId) ?? [];
      final likes = await getLikesOfPost(postId: postId) ?? [];
      final isLiked = likes.firstWhere(
            (like) => like.authorId == userId,
            orElse: () => null,
          ) != null;

      return PostModel.fromJson(
        id: doc.id,
        data: doc.data()
          ..putIfAbsent(FirestoreKeys.commentsFieldKey, () => comments.length)
          ..putIfAbsent(FirestoreKeys.likesFieldKey, () => likes.length)
          ..putIfAbsent(FirestoreKeys.isLikedFieldKey, () => isLiked),
      );
    } on dynamic catch (ex) {
      throw _errorHandler.handleNetworkError(ex);
    }
  }

  @override
  Future<List<PostModel>> getPostsOfUser({
    String userUid,
    String fromPostId,
    int limit,
  }) async {
    try {
      final databaseReference = FirebaseFirestore.instance;
      DocumentSnapshot lastDownloadedPostDoc;

      if (fromPostId != null && fromPostId.isNotEmpty) {
        lastDownloadedPostDoc = await databaseReference
            .collection(FirestoreKeys.postsCollectionKey)
            .doc(fromPostId)
            .get();
      }

      var query = databaseReference
          .collection(FirestoreKeys.postsCollectionKey)
          .where(FirestoreKeys.authorIdFieldKey, isEqualTo: userUid)
          .orderBy(FirestoreKeys.createdAtFieldKey, descending: true);

      if (lastDownloadedPostDoc != null) {
        query = query.startAfterDocument(lastDownloadedPostDoc);
      }

      final result = await query.limit(limit).get();

      final data = result.docs
          .map((postData) => PostModel.fromJson(
                id: postData.id,
                data: postData.data(),
              ))
          .toList();
      return data;
    } on dynamic catch (ex) {
      throw _errorHandler.handleNetworkError(ex);
    }
  }

  @override
  Future<bool> removePostById({
    String postId,
  }) async {
    try {
      final databaseReference = FirebaseFirestore.instance;

      await databaseReference
          .collection(FirestoreKeys.postsCollectionKey)
          .doc(postId)
          .delete();

      await removeCommentsOfPost(postId: postId);
      await removeLikesOfPost(postId: postId);

      return true;
    } on dynamic catch (ex) {
      throw _errorHandler.handleNetworkError(ex);
    }
  }

  @override
  Future<PostModel> updatePost(PostModel postModel) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }

  @override
  Future<bool> createPost({
    String userUid,
    String title,
    String description,
    bool visibilityFlag,
    List<String> categoriesIds,
  }) async {
    try {
      final databaseReference = FirebaseFirestore.instance;

      await databaseReference
          .collection(
        FirestoreKeys.postsCollectionKey,
      )
          .add({
        FirestoreKeys.titleFieldKey: title,
        FirestoreKeys.descriptionFieldKey: description,
        FirestoreKeys.visibilityFlagFieldKey: visibilityFlag,
        FirestoreKeys.authorIdFieldKey: userUid,
        FirestoreKeys.createdAtFieldKey: FieldValue.serverTimestamp(),
      });

      return true;
    } on dynamic catch (ex) {
      throw _errorHandler.handleNetworkError(ex);
    }
  }

  @override
  Future<LikeModel> likePost({String userId, String postId}) async {
    try {
      final databaseReference = FirebaseFirestore.instance;

      final result = await databaseReference
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
  Future<bool> unlikePost({String userId, String postId}) async {
    try {
      final databaseReference = FirebaseFirestore.instance;

      final result = await databaseReference
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
  Future<bool> removeCommentsOfPost({String postId}) async {
    try {
      final databaseReference = FirebaseFirestore.instance;

      await databaseReference
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

  @override
  Future<bool> removeLikesOfPost({String postId}) async {
    try {
      final databaseReference = FirebaseFirestore.instance;

      await databaseReference
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

  @override
  Future<List<CommentModel>> getCommentsOfPost({
    @required String postId,
    String fromCommentId,
    int limit,
  }) async {
    try {
      final databaseReference = FirebaseFirestore.instance;
      DocumentSnapshot lastDownloadedCommentDoc;

      if (fromCommentId != null && fromCommentId.isNotEmpty) {
        lastDownloadedCommentDoc = await databaseReference
            .collection(FirestoreKeys.commentsCollectionKey)
            .doc(fromCommentId)
            .get();
      }

      var query = databaseReference
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
    } on dynamic catch (ex) {
      return null;
    }
  }

  @override
  Future<List<LikeModel>> getLikesOfPost({
    @required String postId,
  }) async {
    try {
      final databaseReference = FirebaseFirestore.instance;

      final result = await databaseReference
          .collection(FirestoreKeys.likesCollectionKey)
          .where(FirestoreKeys.postIdFieldKey, isEqualTo: postId)
          .get();

      return result.docs
          .map((likeData) => LikeModel.fromJson(
                id: likeData.id,
                data: likeData.data(),
              ))
          .toList();
    } on dynamic catch (ex) {
      return null;
    }
  }
}
