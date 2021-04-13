import 'package:flutter/material.dart';
import 'package:sddomain/export/domain.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:ssecretdiary/core/navigation/router.dart';
import 'package:ssecretdiary/feature/widgets/base_state.dart';

class PostsListWidget extends StatefulWidget {
  final String? searchQuery;
  final FeedSortType? feedSortType;
  final List<PostCategoryModel>? searchCategories;
  final String? userUid;

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
  final PostsBloc _postsBloc = Injector().get<PostsBloc>();

  void loadPosts({bool initialLoad = false}) {
    if (widget.userUid != null) {
      _postsBloc.loadPostsForUser(userUid: widget.userUid!);
    } else {
      _postsBloc.loadPostsForFeed(
        searchQuery: widget.searchQuery,
        initialLoad: initialLoad,
      );
    }
  }

  @override
  void initState() {
    _postsBloc.errorStream.handleError(handleError);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    loadPosts(initialLoad: true);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _postsBloc.postsStream,
      initialData: List<PostModel>.empty(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<PostModel>> snapshot,
      ) {
        return _buildPostsList(snapshot.data!);
      },
    );
  }

  Widget _buildPostsList(List<PostModel> posts) {
    if (posts.isNotEmpty) {
      return Expanded(
          child: NotificationListener(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            loadPosts();
          }
          return false;
        },
        child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              final postModel = posts[index];
              return _postItem(postModel);
            }),
      ));
    } else {
      return Center(child: Text('No posts'));
    }
  }

  Widget _postItem(PostModel postModel) => Dismissible(
      key: Key(postModel.id),
      direction: DismissDirection.endToStart,
      background: Container(
          color: Colors.red,
          child: Text(
            'Delete',
            style: TextStyle(color: Colors.white),
          )),
      onDismissed: (DismissDirection direction) async {
        await _postsBloc.removePostById(postModel.id);
        _postsBloc.loadPostsForUser(userUid: widget.userUid!);
      },
      child: GestureDetector(
          onTap: () => Navigator.pushNamed(
                context,
                AppRoutes.postDetails,
                arguments: postModel.id,
              ),
          child: Card(
            child: Column(children: <Widget>[
              Container(
                height: 64.0,
                child: Center(
                  child: Text(
                    postModel.title,
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
                    postModel.description,
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
            ]),
          )));
}
