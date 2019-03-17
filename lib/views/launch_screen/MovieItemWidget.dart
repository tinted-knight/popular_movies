import 'package:flutter/material.dart';
import 'package:popular_movies/views/widgets/poster.dart';
import 'package:popular_movies/views/styles/MovieGridStyle.dart';

class MovieItemWidget extends StatelessWidget {
  final String posterPath;
  final String title;
  final num id;

  MovieItemWidget({this.posterPath, this.title, this.id});

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      PosterHero(
        posterPath: this.posterPath,
        aspectRatio: kGridItemAspectRatio,
      ),
      MoviePosterTitle(this.title)
    ]);
  }
}

class MoviePosterTitle extends StatelessWidget {
  final String title;

  const MoviePosterTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0.0,
      child: Container(
        constraints: BoxConstraints.loose(new Size(150.0, double.maxFinite)),
        decoration: BoxDecoration(color: Colors.black54),
        padding: EdgeInsets.all(8.0),
        child: Text(
          this.title,
          style: Theme.of(context).textTheme.subhead,
        ),
      ),
    );
  }
}
