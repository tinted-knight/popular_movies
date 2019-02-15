import 'package:flutter/material.dart';
import 'package:popular_movies/details/SectionLabel.dart';
import 'package:popular_movies/styles/DetailsScreen.dart';

class OverviewContent extends StatelessWidget {
  final String overview;

  OverviewContent(this.overview);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SectionLabel("Overview"),
        Container(
          decoration: new BoxDecoration(
              color: kSectionBgColor,
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
          child: Text(
            this.overview,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.body1.copyWith(height: 1.5),
          ),
        ),
      ],
    );
  }
}

//class OverviewContentAnimated extends StatelessWidget {
//  const OverviewContentAnimated({this.animation, this.child});
//
//  final Animation<double> animation;
//  final Widget child;
//
//  @override
//  Widget build(BuildContext context) {
//    return AnimatedBuilder(
//      animation: animation,
//      builder: (_, child) => Opacity(
//            opacity: animation.value,
//            child: child,
//          ),
//      child: child,
//    );
//  }
//}
