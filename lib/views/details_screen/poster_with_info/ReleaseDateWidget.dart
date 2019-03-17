import 'package:flutter/material.dart';

class ReleaseDateWidget extends StatelessWidget {
  final String releaseDate;

  ReleaseDateWidget(this.releaseDate);

  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: const EdgeInsets.all(4.0),
        decoration: new BoxDecoration(color: Colors.black45),
        child: new Text(
          "Released on: ${this.releaseDate}",
          style: Theme.of(context).textTheme.subhead,
        ));
  }
}
