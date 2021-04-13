import 'dart:async';
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
    required Logger logger,
    required PostsInteractor postsInteractor,
    required BehaviorSubject<List<PostModel>> postsResult,
    required PublishSubject<bool> postCreationResult,
    required PublishSubject<PostModel> postDetailsResult,
  })   : _postsInteractor = postsInteractor,
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
    List<String>? categoriesIds,
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

  Future<PostModel> getPost({required String postId}) {
    showLoading(true);
    return _postsInteractor.getPost(id: postId).then(
      (PostModel postModel) {
        logger.i('Post ($postId) loaded: $postModel');
        _postDetailsResult.add(postModel);
        showLoading(false);
        return postModel;
      },
      onError: handleError,
    );
  }

  void loadPostsForUser({
    required String userUid,
    int limit = DomainConstants.limit,
  }) async {
    if (isLoading || _postsIsLoaded) {
      return;
    }

    if (userUid.isEmpty) {
      return;
    }

    showLoading(true);

    List<PostModel> loadedPosts = await _postsResult.first;
    var lastPostId;
    if (loadedPosts.isNotEmpty) {
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
        List<PostModel> loadedPosts = List.from(
          await _postsResult.first,
          growable: true,
        );
        _postsResult.add(
          loadedPosts..addAll(posts),
        );
        showLoading(false);
      },
      onError: handleError,
    );
  }

  void loadPostsForFeed({
    required bool initialLoad,
    String? searchQuery,
    FeedSortType feedSortType = FeedSortType.byDate,
    List<PostCategoryModel>? postCategories,
    int limit = DomainConstants.limit,
  }) async {
    if (isLoading || _postsIsLoaded) {
      return;
    }

    showLoading(true);

    List<PostModel> loadedPosts = await _postsResult.first;
    var lastPostId;

    if (initialLoad && loadedPosts.isNotEmpty) {
      return;
    }

    if (loadedPosts.isNotEmpty) {
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
        _postsIsLoaded = (posts.length) < limit;
        List<PostModel> loadedPosts = List.from(
          await _postsResult.first,
          growable: true,
        );
        _postsResult.add(loadedPosts..addAll(posts));
        showLoading(false);
      },
      onError: handleError,
    );
  }

  Future<bool> removePostById(String id) async {
    showLoading(true);
    return _postsInteractor.removePost(id: id).then(
      (bool isRemoved) {
        logger.i('Post ($id) removed');
        showLoading(false);
        return isRemoved;
      },
      onError: handleError,
    );
  }

  @override
  void dispose() {
    _postsResult.close();
    _postCreationResult.close();
    _postDetailsResult.close();
    super.dispose();
  }
}
