import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/subjects.dart';
import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/export/domain.dart';

class PostsBloc extends BaseBloc {
  final PostsInteractor _postsInteractor;
  final BehaviorSubject<List<PostModel>> _postsResult;
  final PublishSubject<bool> _postCreationResult;
  var _postsIsLoaded = false;

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
    showLoading(true);
    _postsInteractor
        .createPost(
      title,
      description,
      visibilityFlag,
      categoriesIds,
    )
        .then(
      (bool result) {
        _postCreationResult.add(result);
        showLoading(false);
      },
      onError: handleError,
    );
  }

  void loadPostsForUser({
    @required String userUid,
    int limit = DomainConstants.limit,
  }) async {
    if (isLoading || _postsIsLoaded) {
      return;
    }

    if (userUid == null || userUid.isEmpty) {
      return;
    }

    showLoading(true);

    List<PostModel> loadedPosts = await _postsResult.first;
    var lastPostId;
    if (loadedPosts != null && loadedPosts.isNotEmpty) {
      lastPostId = loadedPosts.last.id;
    }

    _postsInteractor
        .getPostsOfUser(
      userUid: userUid,
      fromPostId: lastPostId,
      limit: limit,
    )
        .then(
      (List<PostModel> posts) async {
        _postsIsLoaded = posts.length < limit;
        List<PostModel> loadedPosts = await _postsResult.first;
        _postsResult.add(loadedPosts..addAll(posts));
        showLoading(false);
      },
      onError: handleError,
    );
  }

  void loadPostsForFeed({
    String searchQuery,
    FeedSortType feedSortType = FeedSortType.byDate,
    List<PostCategoryModel> postCategories,
    int limit = DomainConstants.limit,
  }) async {
    if (isLoading || _postsIsLoaded) {
      return;
    }

    showLoading(true);

    List<PostModel> loadedPosts = await _postsResult.first;
    var lastPostId;
    if (loadedPosts != null && loadedPosts.isNotEmpty) {
      lastPostId = loadedPosts.last.id;
    }

    _postsInteractor
        .getFeedPostsBy(
      feedSortType: feedSortType,
      postCategories: postCategories,
      fromPostId: lastPostId,
      limit: limit,
    )
        .then(
      (List<PostModel> posts) async {
        _postsIsLoaded = posts.length < limit;
        List<PostModel> loadedPosts = await _postsResult.first;
        _postsResult.add(loadedPosts..addAll(posts));
        showLoading(false);
      },
      onError: handleError,
    );
  }

  Future<bool> removePostById(String id) async {
    return await _postsInteractor.removePost(id: id);
  }

  @override
  void dispose() {
    _postsResult.close();
    super.dispose();
  }
}
