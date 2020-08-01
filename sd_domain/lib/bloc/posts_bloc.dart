import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/subjects.dart';
import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/export/domain.dart';

class PostsBloc extends BaseBloc {
  final PostsInteractor _postsInteractor;
  final PublishSubject<List<PostModel>> _postsResult;
  StreamSubscription postsResultSubscriber;

  PostsBloc(
    this._postsInteractor,
    this._postsResult,
  );

  Stream<List<PostModel>> get postsStream => _postsResult.stream;

  void loadPostsForUser({
    @required int userId,
    int fromPostId,
    int limit,
  }) {
    loadingProgress.add(true);
    postsResultSubscriber?.cancel();
    postsResultSubscriber = _postsInteractor
        .getPostsOfUser(
          userId: userId,
          fromPostId: fromPostId,
          limit: limit,
        )
        .listen(
          _postsResult.add,
          onError: (error) {
            _postsResult.addError(error);
            loadingProgress.add(false);
          },
          onDone: () => loadingProgress.add(false),
        );
  }

  void loadPostsForFeed({
    String searchQuery,
    FeedSortType feedSortType = FeedSortType.byDate,
    List<PostCategoryModel> postCategories,
    int fromPostId,
    int limit,
  }) {
    loadingProgress.add(true);
    postsResultSubscriber?.cancel();
    postsResultSubscriber = _postsInteractor
        .getFeedPostsBy(
          feedSortType: feedSortType,
          postCategories: postCategories,
          fromPostId: fromPostId,
          limit: limit,
        )
        .listen(
          _postsResult.add,
          onError: (error) {
            _postsResult.addError(error);
            loadingProgress.add(false);
          },
          onDone: () => loadingProgress.add(false),
        );
  }

  @override
  void unsubscribe() {
    postsResultSubscriber?.cancel();
    super.unsubscribe();
  }

  @override
  void dispose() {
    _postsResult.close();
    super.dispose();
  }
}
