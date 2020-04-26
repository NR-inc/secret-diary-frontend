import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssecretdiary/core/navigation/router.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text('Profile'), centerTitle: true, actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.post),
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.login, (route) => false),
          )
        ]),
        body: Center(
            child: Column(children: <Widget>[
          SizedBox(height: 24),
          Icon(Icons.account_circle, color: Colors.grey, size: 80),
          SizedBox(height: 24),
          Text('First name'),
          SizedBox(height: 8),
          Text('Last name'),
          SizedBox(height: 24),
          Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Container(
                        height: 64.0,
                        child: Center(child: Text("Post of the user's diary")),
                      ),
                    );
                  }))
        ])));
  }
}
