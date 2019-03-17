import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

abstract class BasePosterImage extends StatelessWidget {
  final String _baseUrl = "http://image.tmdb.org/t/p/";
  final String _qualifier = "w500";
  final String posterPath;

  BasePosterImage(this.posterPath);

  String get posterUrl => _baseUrl + _qualifier + posterPath;
}

class TrailerPoster extends StatelessWidget {
  final String trailerKey;
  final double height;

  const TrailerPoster({this.trailerKey, this.height});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://img.youtube.com/vi/$trailerKey/0.jpg",
      height: height,
    );
  }
}

class PosterHero extends BasePosterImage {
  PosterHero({String posterPath, this.aspectRatio: 0.0}) : super(posterPath);

  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: aspectRatio == 0.0
          ? _heroImage()
          : AspectRatio(aspectRatio: aspectRatio, child: _heroImage()),
    );
  }

  Widget _heroImage() {
    return Hero(
      tag: posterPath,
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: posterUrl,
        fit: BoxFit.fitWidth,
      ),
//      child: Image.network(this.posterUrl, fit: BoxFit.fitWidth),
    );
  }
}
