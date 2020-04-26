import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PostScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PostState();
}

class _PostState extends State<PostScreen> {
  bool _check = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Creare post')),
        body: Center(
            child: Column(children: <Widget>[
          TextFormField(
              maxLines: 1, decoration: InputDecoration(hintText: 'Title')),
          TextFormField(
              minLines: 5,
              maxLines: 5,
              decoration: InputDecoration(hintText: 'Text')),
          Row(children: <Widget>[
            Text("Show everyone"),
            Checkbox(
              value: _check,
              tristate: false,
              onChanged: (value) {
                setState(() {
                  _check = value;
                });
              },
            )
          ]),
          MaterialButton(
            child: Text('Add to my diary'),
            onPressed: () => Navigator.pop(context),
          )
        ])));
  }
}
