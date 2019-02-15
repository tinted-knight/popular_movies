import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

abstract class BasePosterImage extends StatelessWidget {
  final String _baseUrl = "http://image.tmdb.org/t/p/";
  final String _qualifier = "w500";
  final String posterPath;

  BasePosterImage(this.posterPath);

  String get posterUrl => _baseUrl + _qualifier + posterPath;
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
      child: CachedNetworkImage(
        imageUrl: this.posterUrl,
        errorWidget: Icon(Icons.error),
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
