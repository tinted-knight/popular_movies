import 'package:flutter/material.dart';

class AuthorLabel extends StatelessWidget {
  final String author;

  const AuthorLabel({Key key, this.author}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
      padding: const EdgeInsets.fromLTRB(8.0, 4.0, 16.0, 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Text(
            author,
            style: new TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          )
        ],
      ),
    );
  }
}