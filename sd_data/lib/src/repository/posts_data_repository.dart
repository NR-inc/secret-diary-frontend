import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sd_base/sd_base.dart';
import 'package:sddomain/core/error_handler.dart';
import 'package:sddomain/export/domain.dart';

class PostsDataRepository implements PostsRepository {
  final ErrorHandler _errorHandler;

  PostsDataRepository(this._errorHandler);

  @override
  Stream<List<PostModel>> getFeedPostsBy({
    String searchQuery,
    FeedSortType feedSortType,
    List<PostCategoryModel> postCategories,
    int fromPostId,
    int limit,
  }) async* {
    try {
      final databaseReference = FirebaseFirestore.instance;

      final result = await databaseReference
          .collection(FirestoreKeys.postsCollectionKey)
          .where(FirestoreKeys.visibilityFlagFieldKey, isEqualTo: true)
          .get();
      final data = result.docs
          .map((postData) => PostModel.fromJson(
                id: postData.id,
                data: postData.data(),
              ))
          .toList();
      yield data;
    } on dynamic catch (ex) {
      throw _errorHandler.handleNetworkError(ex);
    }
  }

  @override
  Future<PostModel> getPostById(String postId) {
    // TODO: implement getPostById
    throw UnimplementedError();
  }

  @override
  Stream<List<PostModel>> getPostsOfUser({
    UserModel user,
    int fromPostId,
    int limit,
  }) async* {
    try {
      final databaseReference = FirebaseFirestore.instance;

      final result = await databaseReference
          .collection(FirestoreKeys.postsCollectionKey)
          .where(FieldPath.documentId, whereIn: user.postsIds)
          .get();
      final data = result.docs
          .map((postData) => PostModel.fromJson(
                id: postData.id,
                data: postData.data(),
              ))
          .toList();
      yield data;
    } on dynamic catch (ex) {
      throw _errorHandler.handleNetworkError(ex);
    }
  }

  @override
  Future<bool> removePostById({
    UserModel currentUser,
    String postId,
  }) async {
    try {
      final databaseReference = FirebaseFirestore.instance;

      await databaseReference
          .collection(FirestoreKeys.postsCollectionKey)
          .doc(postId)
          .delete();

      await databaseReference
          .collection(FirestoreKeys.usersCollectionKey)
          .doc(currentUser.uid)
          .update({
        FirestoreKeys.postsIdsFieldKey: currentUser.postsIds..remove(postId)
      });

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
    UserModel currentUser,
    String title,
    String description,
    bool visibilityFlag,
    List<String> categoriesIds,
  }) async {
    try {
      final databaseReference = FirebaseFirestore.instance;

      final result = await databaseReference
          .collection(FirestoreKeys.postsCollectionKey)
          .add({
        FirestoreKeys.titleFieldKey: title,
        FirestoreKeys.descriptionFieldKey: description,
        FirestoreKeys.visibilityFlagFieldKey: visibilityFlag,
        FirestoreKeys.createdAtFieldKey: FieldValue.serverTimestamp(),
      });

      await databaseReference
          .collection(FirestoreKeys.usersCollectionKey)
          .doc(currentUser.uid)
          .update({
        FirestoreKeys.postsIdsFieldKey: currentUser.postsIds..add(result.id)
      });

      return true;
    } on dynamic catch (ex) {
      throw _errorHandler.handleNetworkError(ex);
    }
  }
}
