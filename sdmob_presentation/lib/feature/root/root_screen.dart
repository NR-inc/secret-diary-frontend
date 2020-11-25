import 'package:common_ui/common_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssecretdiary/core/navigation/router.dart';
import 'package:ssecretdiary/feature/feed/feed_screen.dart';
import 'package:ssecretdiary/feature/diary/diary_screen.dart';
import 'package:ssecretdiary/feature/settings/seetings_screen.dart';

class RootScreen extends StatefulWidget {
  final int startPageIndex;

  RootScreen({this.startPageIndex = 0});

  @override
  State<StatefulWidget> createState() {
    return _RootState(startPageIndex);
  }
}

class _RootState extends State<RootScreen> {
  int _currentPageIndex = 0;
  final List<Widget> bottomTabsPages = [
    DiaryScreen(),
    FeedScreen(),
    SettingsScreen()
  ];

  _RootState(int startPageIndex) {
    _currentPageIndex = startPageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomTabsPages[_currentPageIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.post),
        child: Icon(Icons.add),
        elevation: 0,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.book),
                color: _currentPageIndex == 0 ? SdColors.secondaryColor : SdColors.greyColor,
                onPressed: () {
                  _tabsNavigationManager(0);
                },
              ),
              IconButton(
                icon: Icon(Icons.view_list),
                color: _currentPageIndex == 1 ? SdColors.secondaryColor : SdColors.greyColor,
                onPressed: () {
                  _tabsNavigationManager(1);
                },
              ),
              IconButton(
                icon: Icon(Icons.settings),
                color: _currentPageIndex == 2 ? SdColors.secondaryColor : SdColors.greyColor,
                onPressed: () {
                  _tabsNavigationManager(2);
                },
              ),
              SizedBox(),
            ]),
      ),
    );
  }

  void _tabsNavigationManager(int pageIndex) {
    setState(() {
      _currentPageIndex = pageIndex;
    });
  }
}
