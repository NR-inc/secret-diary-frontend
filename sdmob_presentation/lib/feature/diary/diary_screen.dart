import 'package:common_ui/common_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssecretdiary/core/navigation/router.dart';
import 'package:sddomain/bloc/user_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sddomain/model/user_model.dart';
import 'package:ssecretdiary/feature/posts_list/posts_list_widget.dart';

class DiaryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DiaryState();
}

class _DiaryState extends State<DiaryScreen> {
  final _userBloc = Injector.getInjector().get<UserBloc>();

  @override
  void initState() {
    _userBloc.profile();
    super.initState();
  }

  @override
  void dispose() {
    _userBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: Key(Locators.diaryScreenLocator),
        appBar: AppBar(
            title: Text('My Diary'),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add, color: Colors.white),
                onPressed: () => Navigator.pushNamed(context, AppRoutes.post),
              )
            ]),
        body: StreamBuilder<UserModel>(
          stream: _userBloc.currentUserSubject.stream,
          builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
            final currentUser = snapshot.data ?? UserModel.empty();
            return Stack(children: <Widget>[
              Center(
                  child: Column(children: <Widget>[
                SizedBox(height: 24),
                Icon(Icons.account_circle, color: Colors.grey, size: 80),
                SizedBox(height: 24),
                Text(currentUser.firstName),
                SizedBox(height: 8),
                Text(currentUser.lastName),
                SizedBox(height: 8),
                Text(currentUser.email),
                SizedBox(height: 24),
                PostsListWidget(userUid: currentUser.uid),
              ])),
              Visibility(
                visible: !snapshot.hasData,
                child: Center(child: CircularProgressIndicator()),
              ),
            ]);
          },
        ));
  }

  Widget _buildPostsList() {
    return Expanded(
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Container(
                  height: 64.0,
                  child: Center(child: Text("Post of the user's diary")),
                ),
              );
            }));
  }
}
