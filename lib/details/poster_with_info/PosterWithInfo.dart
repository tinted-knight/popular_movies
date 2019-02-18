import 'package:flutter/material.dart';
import 'package:popular_movies/base/poster.dart';
import 'package:popular_movies/details/poster_with_info/RatingWidget.dart';
import 'package:popular_movies/details/poster_with_info/ReleaseDateWidget.dart';
import 'package:popular_movies/model/tmdb.dart';
import 'package:popular_movies/styles/DetailsScreen.dart';

class PosterWithInfo extends StatelessWidget {
  final AnimationController controller;
  final Result movie;

  final Animation<double> positionAnimation;

  PosterWithInfo({this.movie, this.controller})
      : positionAnimation =
            Tween<double>(begin: -200.0, end: 0.0).animate(controller);

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        PosterHero(
          posterPath: movie.posterPath,
          aspectRatio: kPosterAppBarRatio,
        ),
        _ratingAndDate(),
      ],
    );
  }

  Widget _ratingAndDate() {
    Widget widget = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        RatingWidget(movie.voteAverage),
        ReleaseDateWidget(movie.releaseDate),
      ],
    );

    return AnimatedBuilder(
      animation: positionAnimation,
      builder: (_, child) {
        return Positioned(
          bottom: positionAnimation.value,
          right: 16.0,
          child: widget,
        );
      },
      child: widget,
    );
  }
}
