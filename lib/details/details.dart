import 'package:flutter/material.dart';
import 'package:popular_movies/details/overview.dart';
import 'package:popular_movies/details/poster.dart';
import 'package:popular_movies/tmdb.dart';

class Details extends StatelessWidget {
  final Result movie;

  const Details({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black45,
      appBar: new AppBar(
        title: new Text("Details"),
      ),
      body: new ListView(children: <Widget>[
        new PosterWithInfo(movie),
        new OverViewLabel(),
        new OverviewContent(movie.overview)
      ]),
    );
  }
}
