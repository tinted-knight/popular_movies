import 'package:flutter/material.dart';

class OverViewLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.fromLTRB(32.0, 4.0, 32.0, 4.0),
      child: new Text(
        "Overview",
        style: new TextStyle(
          color: Colors.black87,
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
    return new Container(
      decoration: new BoxDecoration(
          color: new Color(0xff222222),
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
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
