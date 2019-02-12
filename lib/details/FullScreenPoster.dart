import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:popular_movies/base/poster.dart';

class FullScreenPoster extends StatelessWidget {
  FullScreenPoster(this.posterPath, this.movieId);

  final String posterPath;
  final num movieId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(children: <Widget>[
        Hero(
          tag: "poster_$movieId",
          child: FSPosterImage(posterPath),
        ),
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

class FSPosterImage extends BasePosterImage {
  FSPosterImage(String posterPath) : super(posterPath);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CachedNetworkImage(
        imageUrl: this.posterUrl,
        placeholder: new CircularProgressIndicator(),
        errorWidget: new Icon(Icons.error),
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
