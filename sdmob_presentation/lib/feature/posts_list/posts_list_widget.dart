import 'package:flutter/material.dart';
import 'package:sddomain/export/domain.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:ssecretdiary/feature/widgets/base_state.dart';

class PostsListWidget extends StatefulWidget {
  final String searchQuery;
  final FeedSortType feedSortType;
  final List<PostCategoryModel> searchCategories;
  final String userUid;

  PostsListWidget({
    this.userUid,
    this.feedSortType,
    this.searchCategories,
    this.searchQuery,
  }) : super(key: UniqueKey());

  @override
  State<StatefulWidget> createState() => _PostsListState();
}

class _PostsListState extends BaseState<PostsListWidget> {
  final PostsBloc _postsBloc = Injector.getInjector().get<PostsBloc>();


  void loadPosts() {
    if (widget.userUid != null) {
      _postsBloc.loadPostsForUser(userUid: widget.userUid);
    } else {
      _postsBloc.loadPostsForFeed(searchQuery: widget.searchQuery);
    }
  }

  @override
  void initState() {
    _postsBloc.errorStream.handleError(handleError);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    loadPosts();
    super.didChangeDependencies();
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
          child: NotificationListener(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels ==
              scrollInfo.metrics.maxScrollExtent) {
            loadPosts();
          }
          return false;
        },
        child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              final postItem = posts[index];
              return Dismissible(
                  key: Key(postItem.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                      color: Colors.red,
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      )),
                  onDismissed: (DismissDirection direction) async {
                    await _postsBloc.removePostById(postItem.id);
                    _postsBloc.loadPostsForUser(userUid: widget.userUid);
                  },
                  child: Card(
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
                  ));
            }),
      ));
    } else {
      return Center(child: Text('No posts'));
    }
  }
}
