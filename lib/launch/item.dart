import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:popular_movies/base/poster.dart';
import 'package:popular_movies/styles/MovieGridStyle.dart';

class MovieItemWidget extends StatelessWidget {
  final String posterPath;
  final String title;
  final num id;

  MovieItemWidget({this.posterPath, this.title, this.id});

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Hero(tag: "poster_$id", child: PosterImage(this.posterPath)),
      MoviePosterTitle(this.title)
    ]);
  }
}

class PosterImage extends BasePosterImage {
  PosterImage(String posterPath) : super(posterPath);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: gridItemAspectRatio,
        child: CachedNetworkImage(
          imageUrl: this.posterUrl,
          errorWidget: Icon(Icons.error),
          fit: BoxFit.cover,
        ),
      ),
    );
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
