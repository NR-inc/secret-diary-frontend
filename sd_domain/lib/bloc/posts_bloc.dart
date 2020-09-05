import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/subjects.dart';
import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/export/domain.dart';

class PostsBloc extends BaseBloc {
  final PostsInteractor _postsInteractor;
  final PublishSubject<List<PostModel>> _postsResult;
  final PublishSubject<bool> _postCreationResult;
  StreamSubscription _postsResultSubscriber;

  PostsBloc(
    this._postsInteractor,
    this._postsResult,
    this._postCreationResult,
  );

  Stream<List<PostModel>> get postsStream => _postsResult.stream;

  Stream<bool> get postCreationStream => _postCreationResult.stream;

  void createPost(
    String title,
    String description,
    bool visibilityFlag, [
    List<String> categoriesIds,
  ]) {
    loadingProgressResult.add(true);
    _postsInteractor
        .createPost(title, description, visibilityFlag, categoriesIds)
        .then(
      (bool result) {
        _postCreationResult.add(result);
        loadingProgressResult.add(false);
      },
      onError: handleError,
    );
  }

  void loadPostsForUser({
    @required String userUid,
    int fromPostId,
    int limit,
  }) {
    if (userUid == null || userUid.isEmpty) {
      return;
    }
    loadingProgressResult.add(true);
    _postsResultSubscriber?.cancel();
    _postsResultSubscriber = _postsInteractor
        .getPostsOfUser(
          userUid: userUid,
          fromPostId: fromPostId,
          limit: limit,
        )
        .listen(
          _postsResult.add,
          onError: handleError,
          onDone: () => loadingProgressResult.add(false),
        );
  }

  void loadPostsForFeed({
    String searchQuery,
    FeedSortType feedSortType = FeedSortType.byDate,
    List<PostCategoryModel> postCategories,
    int fromPostId,
    int limit,
  }) {
    loadingProgressResult.add(true);
    _postsResultSubscriber?.cancel();
    _postsResultSubscriber = _postsInteractor
        .getFeedPostsBy(
          feedSortType: feedSortType,
          postCategories: postCategories,
          fromPostId: fromPostId,
          limit: limit,
        )
        .listen(
          _postsResult.add,
          onError: handleError,
          onDone: () => loadingProgressResult.add(false),
        );
  }

  Future<bool> removePostById(String id) async {
   return await _postsInteractor.removePost(id: id);
  }

  @override
  void unsubscribe() {
    _postsResultSubscriber?.cancel();
    super.unsubscribe();
  }

  @override
  void dispose() {
    _postsResult.close();
    super.dispose();
  }
}
