import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:popular_movies/base/poster.dart';
import 'package:popular_movies/model/tmdb.dart';

class PosterWithInfo extends StatelessWidget {
  final AnimationController controller;
  final Result movie;

  final Animation<double> _posAnimation;

  PosterWithInfo({this.movie, this.controller})
      : _posAnimation =
            Tween<double>(begin: -200.0, end: 0.0).animate(controller);

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        Hero(
            tag: "poster_${movie.id}",
            child: new PosterImage(movie.posterPath)),
        _positionedAnimation(
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              RatingWidget(movie.voteAverage),
              ReleaseDateWidget(movie.releaseDate),
            ],
          ),
        ),
      ],
    );
  }

  Widget _positionedAnimation(Widget widget) {
    return AnimatedBuilder(
      animation: _posAnimation,
      builder: (_, child) {
        return Positioned(
          bottom: _posAnimation.value,
          right: 16.0,
          child: widget,
        );
      },
      child: widget,
    );
  }
}

class PosterImage extends BasePosterImage {
  PosterImage(String posterPath) : super(posterPath);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 4.0 / 3.0,
        child: CachedNetworkImage(
          imageUrl: this.posterUrl,
          placeholder: new CircularProgressIndicator(),
          errorWidget: new Icon(Icons.error),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}

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
          style: Theme.of(context).textTheme.subhead,
        ));
  }
}
