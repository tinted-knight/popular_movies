import 'package:flutter/material.dart';
import 'package:popular_movies/styles/DetailsScreen.dart';

class SectionLabel extends StatelessWidget {
  final String text;

  const SectionLabel(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
      margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      padding: const EdgeInsets.fromLTRB(32.0, 4.0, 32.0, 4.0),
      child: new Text(
        text,
        style: Theme.of(context).textTheme.caption,
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
          color: kSectionBgColor,
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
      child: new Text(
        this.overview,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.body1.copyWith(height: 1.5),
      ),
    );
  }
}
