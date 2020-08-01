import 'package:flutter/material.dart';
import 'package:sddomain/export/domain.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class PostsListWidget extends StatefulWidget {
  final String searchQuery;
  final FeedSortType feedSortType;
  final List<PostCategoryModel> searchCategories;
  final int userId;

  PostsListWidget({
    this.userId,
    this.feedSortType,
    this.searchCategories,
    this.searchQuery,
  });

  @override
  State<StatefulWidget> createState() => _PostsListState();
}

class _PostsListState extends State<PostsListWidget> {
  final PostsBloc _postsBloc = Injector.getInjector().get<PostsBloc>();

  @override
  void initState() {
    if (widget.userId != null) {
      _postsBloc.loadPostsForUser(userId: widget.userId);
    } else {
      _postsBloc.loadPostsForFeed(searchQuery: widget.searchQuery);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _postsBloc.postsStream,
      builder: (
        BuildContext context,
        AsyncSnapshot<List<PostModel>> snapshot,
      ) {
        return _buildPostsList(snapshot.data);
      },
    );
  }

  Widget _buildPostsList(List<PostModel> posts) {
    if (posts != null && posts.isNotEmpty) {
      return Expanded(
          child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                final postItem = posts[index];
                return Card(
                  child: Column(children: <Widget>[
                    Container(
                      height: 64.0,
                      child: Center(
                        child: Text(
                          postItem.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 64.0,
                      child: Center(
                        child: Text(
                          postItem.description,
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ]),
                );
              }));
    } else {
      return Center(child: Text('No posts'));
    }
  }
}
