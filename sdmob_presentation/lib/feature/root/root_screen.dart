import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      bottomNavigationBar: BottomNavigationBar(
        onTap: _tabsNavigationManager,
        currentIndex: _currentPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.book), title: Text('My diary')),
          BottomNavigationBarItem(
              icon: Icon(Icons.view_list), title: Text('Feed')),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text('Settings')),
        ],
      ),
    );
  }

  void _tabsNavigationManager(int pageIndex) {
    setState(() {
      _currentPageIndex = pageIndex;
    });
  }
}
