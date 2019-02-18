import 'package:flutter/material.dart';
import 'package:popular_movies/details/SectionLabel.dart';
import 'package:popular_movies/strings.dart';
import 'package:popular_movies/styles/DetailsScreen.dart';

class OverviewContent extends StatelessWidget {
  final String overview;

  OverviewContent(this.overview);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SectionLabel(StrRes.overview),
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
