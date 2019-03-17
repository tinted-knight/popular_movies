import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final num voteAverage;
  final double _borderRadius = 12.0;

  RatingWidget(this.voteAverage);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(4.0),
      margin: const EdgeInsets.only(bottom: 2.0),
      decoration: new BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(_borderRadius),
            topRight: Radius.circular(_borderRadius),
            bottomLeft: Radius.circular(_borderRadius),
          )),
      child: new Row(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(4.0),
            child: new Icon(
              Icons.star,
              color: Colors.white,
            ),
          ),
          new Text(
            voteAverage.toString(),
            style: Theme.of(context).textTheme.headline,
          ),
        ],
      ),
    );
  }
}