import 'package:flutter/material.dart';
import 'package:popular_movies/views/widgets/poster.dart';

class FullScreenPoster extends StatelessWidget {
  FullScreenPoster(this.posterPath, this.movieId);

  final String posterPath;
  final num movieId;

  @override
  Widget build(BuildContext context) {
    // Transparent AppBar https://stackoverflow.com/a/53666091/8460732
    return Scaffold(
      appBar: null,
      body: Stack(children: <Widget>[
        PosterHero(posterPath: posterPath),
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
        ),
      ]),
    );
  }
}
