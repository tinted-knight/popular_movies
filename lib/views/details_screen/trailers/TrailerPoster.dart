import 'package:flutter/material.dart';

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
