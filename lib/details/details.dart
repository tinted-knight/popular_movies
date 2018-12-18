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
      backgroundColor: new Color(0xff111111),
      appBar: new AppBar(
        title: new Text("Details"),
        backgroundColor: Colors.black45,
      ),
      body: new ListView(children: <Widget>[
        new PosterWithInfo(movie),
        new OverViewLabel(),
        new OverviewContent(movie.overview)
      ]),
    );
  }
}
