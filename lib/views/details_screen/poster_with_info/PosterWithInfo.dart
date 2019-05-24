import 'package:flutter/material.dart';
import 'package:popular_movies/model/tmdb.dart';
import 'package:popular_movies/views/details_screen/poster_with_info/RatingWidget.dart';
import 'package:popular_movies/views/details_screen/poster_with_info/ReleaseDateWidget.dart';
import 'package:popular_movies/views/widgets/poster.dart';

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
        Positioned(
          bottom: 4.0,
          left: 4.0,
          height: 150.0,
          child: PosterHero(posterPath: movie.posterPath),
        ),
        BackdropPoster(posterPath: movie.backdropPath),
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
