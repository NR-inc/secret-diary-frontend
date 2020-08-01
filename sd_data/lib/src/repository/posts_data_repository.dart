import 'package:sd_data/sd_data.dart';
import 'package:sddomain/model/feed_sort_type.dart';
import 'package:sddomain/model/post_category_model.dart';
import 'package:sddomain/model/post_model.dart';
import 'package:sddomain/repository/posts_repository.dart';
import 'package:dio/dio.dart';

class PostsDataRepository implements PostsRepository {
  final Dio _dio;
  final NetworkExecutor _networkExecutor;

  PostsDataRepository(this._dio, this._networkExecutor);

  @override
  Stream<List<PostModel>> getFeedPostsBy({
    String searchQuery,
    FeedSortType feedSortType,
    List<PostCategoryModel> postCategories,
    int fromPostId,
    int limit,
  }) {
    // TODO: implement getFeedPostsBy
    throw UnimplementedError();
  }

  @override
  Future<PostModel> getPostById(int postId) {
    // TODO: implement getPostById
    throw UnimplementedError();
  }

  @override
  Stream<List<PostModel>> getPostsOfUser({
    int userId,
    int fromPostId,
    int limit,
  }) {
    // TODO: implement getPostsOfUser
    throw UnimplementedError();
  }

  @override
  Future<bool> removePostById(int postId) {
    // TODO: implement removePostById
    throw UnimplementedError();
  }

  @override
  Future<PostModel> updatePost(PostModel postModel) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
