import 'package:flutter/material.dart';

class ReviewContent extends StatelessWidget {
  final String value;

  ReviewContent(this.value);

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.centerLeft,
      decoration: new BoxDecoration(
          color: new Color(0xff222222),
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
      child: new Text(
        this.value,
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