import 'package:flutter/material.dart';

class OverViewLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      constraints: new BoxConstraints.loose(new Size(20.0, 100.0)),
      padding:
      const EdgeInsets.only(top: 24.0, right: 8.0, left: 8.0, bottom: 0.0),
      child: new Text(
        "Overview",
        style: new TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
        ),
      ),
    );
  }
}

class OverviewContent extends StatelessWidget {
  final String overview;

  OverviewContent(this.overview);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: new Text(
        this.overview,
        textAlign: TextAlign.start,
        style: new TextStyle(
          color: Colors.white70,
          fontSize: 16.0,
          height: 1.5,
        ),
      ),
    );
  }
}