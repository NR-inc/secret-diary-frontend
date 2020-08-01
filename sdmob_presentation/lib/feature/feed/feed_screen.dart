import 'package:common_ui/common_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssecretdiary/feature/posts_list/posts_list_widget.dart';

class FeedScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FeedState();
}

class _FeedState extends State<FeedScreen> {
  final _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Feed')),
      body: Center(
        child: Column(children: <Widget>[
          Padding(
              padding: EdgeInsets.all(8),
              child: searchField(
                  key: 'feedSearchField',
                  controller: _searchTextController,
                  hint: 'Search',
                  onFieldSubmitted: (value) {
                    print(value);
                    setState(() {});
                  })),
          PostsListWidget(
            searchQuery: _searchTextController.text,
          ),
        ]),
      ),
    );
  }
}
