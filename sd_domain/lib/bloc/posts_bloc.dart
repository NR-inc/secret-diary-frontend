import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/subjects.dart';
import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/export/domain.dart';

class PostsBloc extends BaseBloc {
  final PostsInteractor _postsInteractor;
  final BehaviorSubject<List<PostModel>> _postsResult;
  final PublishSubject<bool> _postCreationResult;
  final PublishSubject<PostModel> _postDetailsResult;
  var _postsIsLoaded = false;

  PostsBloc({
    Logger logger,
    PostsInteractor postsInteractor,
    BehaviorSubject<List<PostModel>> postsResult,
    PublishSubject<bool> postCreationResult,
    PublishSubject<PostModel> postDetailsResult,
  })  : _postsInteractor = postsInteractor,
        _postsResult = postsResult,
        _postDetailsResult = postDetailsResult,
        _postCreationResult = postCreationResult,
        super(logger: logger);

  Stream<List<PostModel>> get postsStream => _postsResult.stream;

  Stream<bool> get postCreationStream => _postCreationResult.stream;

  Stream<PostModel> get postDetailsStream => _postDetailsResult.stream;

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

  void getPost({String postId}) {
    showLoading(true);
    _postsInteractor.getPost(id: postId).then(
      (PostModel postModel) {
        _postDetailsResult.add(postModel);
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
        _postsIsLoaded = (posts?.length ?? 0) < limit;
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
    _postCreationResult.close();
    _postDetailsResult.close();
    super.dispose();
  }
}
