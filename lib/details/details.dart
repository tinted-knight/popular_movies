import 'package:flutter/material.dart';
import 'package:popular_movies/base/BaseScafold.dart';
import 'package:popular_movies/details/overview.dart';
import 'package:popular_movies/details/poster.dart';
import 'package:popular_movies/details/reviews.dart';
import 'package:popular_movies/model/tmdb.dart';

class Details extends StatelessWidget {
  final Result movie;

  const Details({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: bgColor,
      appBar: new AppBar(
        title: new Text("Details"),
        centerTitle: true,
        backgroundColor: bgColor,
      ),
      body: new ListView(children: <Widget>[
        new PosterWithInfo(movie),
        new Column(
          children: <Widget>[
            new SectionLabel("Overview"),
            new OverviewContent(movie.overview),
            new SectionLabel("Reviews"),
            new Reviews(movieId: movie.id,),
          ],
        )
      ]),
    );
  }
}
