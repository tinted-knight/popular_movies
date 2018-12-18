import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:popular_movies/base/poster.dart';
import 'package:popular_movies/tmdb.dart';

class PosterWithInfo extends StatelessWidget {
  final Result movie;

  PosterWithInfo(this.movie);

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new PosterImage(movie.posterPath),
        new Positioned(
          bottom: 0.0,
          right: 16.0,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              new RatingWidget(movie.voteAverage),
              new MovieTitle(movie.title),
              new ReleaseDateWidget(movie.releaseDate),
            ],
          ),
        ),
      ],
    );
  }
}

class PosterImage extends BasePosterImage {
  PosterImage(String posterPath) : super(posterPath);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: new CachedNetworkImage(
        imageUrl: getPosterUrl(),
        placeholder: new CircularProgressIndicator(),
        errorWidget: new Icon(Icons.error),
        height: 400.0,
      ),
    );
  }
}

class RatingWidget extends StatelessWidget {
  final num voteAverage;

  RatingWidget(this.voteAverage);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(4.0),
      decoration: new BoxDecoration(color: Colors.red),
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
            style: new TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class MovieTitle extends StatelessWidget {
  final String title;

  const MovieTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return new Container(
        constraints: new BoxConstraints.loose(new Size(340.0, 100.0)),
        padding: const EdgeInsets.all(8.0),
        decoration: new BoxDecoration(color: Colors.white),
        child: new Text(
          this.title,
          style: new TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ));
  }
}

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
          style: new TextStyle(
            color: Colors.white,
          ),
        ));
  }
}
