import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:popular_movies/base/poster.dart';

class ItemWidget extends StatelessWidget {
  final String posterPath;
  final String title;

  ItemWidget({this.posterPath, this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      new PosterImage(this.posterPath),
      new MoviePosterTitle(this.title)
    ]);
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
        fit: BoxFit.fitWidth,
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
        constraints:
            new BoxConstraints.loose(new Size(150.0, double.maxFinite)),
        decoration: new BoxDecoration(color: Colors.black54),
        padding: new EdgeInsets.all(8.0),
        child: new Text(
          this.title,
          style: new TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      ),
    );
  }
}
